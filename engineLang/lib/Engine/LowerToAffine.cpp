// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"
#include "Engine/EnginePasses.h"

#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/ADT/Sequence.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/STLExtras.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Location.h"
#include "mlir/IR/Value.h"
#include "mlir/IR/Types.h"
#include "mlir/IR/PatternMatch.h"

#include "mlir/Dialect/Bufferization/IR/Bufferization.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"

static mlir::MemRefType convertTensorToMemRef(mlir::TensorType type) {
  assert(type.hasRank() && "expected only ranked shapes");
  return mlir::MemRefType::get(type.getShape(), type.getElementType());
}

static mlir::Value insertAllocAndDealloc(mlir::MemRefType type,
                                         mlir::Location loc,
                                         mlir::PatternRewriter &rewriter) {
  auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, type);

  // Make sure to allocate at the beginning of the block.
  auto *parentBlock = alloc->getBlock();
  alloc->moveBefore(&parentBlock->front());

  // Make sure to deallocate this alloc at the end of the block. This is fine
  // as toy functions have no control flow.
  auto dealloc = rewriter.create<mlir::memref::DeallocOp>(loc, alloc);
  dealloc->moveBefore(&parentBlock->back());
  return alloc;
}

class ConstantOpLowering : public mlir::OpRewritePattern<engine::ConstantOp> {
  using OpRewritePattern<engine::ConstantOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::ConstantOp op,
                  mlir::PatternRewriter &rewriter) const final {
    mlir::DenseElementsAttr constantValue = op.getValue();
    mlir::Location loc = op.getLoc();

    // When lowering the constant operation, we allocate and assign the constant
    // values to a corresponding memref allocation.
    auto memRefType = op.getType().dyn_cast<mlir::MemRefType>();
    if (!memRefType) {
      return rewriter.notifyMatchFailure(op, "expected memref result");
    }
    auto alloc = insertAllocAndDealloc(memRefType, loc, rewriter);

    // We will be generating constant indices up-to the largest dimension.
    // Create these constants up-front to avoid large amounts of redundant
    // operations.
    auto valueShape = memRefType.getShape();
    mlir::SmallVector<mlir::Value, 8> constantIndices;

    if (!valueShape.empty()) {
      for (auto i : llvm::seq<int64_t>(
               0, *std::max_element(valueShape.begin(), valueShape.end())))
        constantIndices.push_back(
            rewriter.create<mlir::arith::ConstantIndexOp>(loc, i));
    } else {
      // This is the case of a tensor of rank 0.
      constantIndices.push_back(
          rewriter.create<mlir::arith::ConstantIndexOp>(loc, 0));
    }
    // The constant operation represents a multi-dimensional constant, so we
    // will need to generate a store for each of the elements. The following
    // functor recursively walks the dimensions of the constant shape,
    // generating a store when the recursion hits the base case.

    // [4, 3] (1, 2, 3, 4, 5, 6, 7, 8)
    // storeElements(0)
    //   indices = [0]
    //   storeElements(1)
    //     indices = [0, 0]
    //     storeElements(2)
    //       store (const 1) [0, 0]
    //     indices = [0]
    //     indices = [0, 1]
    //     storeElements(2)
    //       store (const 2) [0, 1]
    //  ...
    //
    mlir::SmallVector<mlir::Value, 2> indices;
    auto valueIt = constantValue.getValues<mlir::FloatAttr>().begin();
    std::function<void(uint64_t)> storeElements = [&](uint64_t dimension) {
      // The last dimension is the base case of the recursion, at this point
      // we store the element at the given index.
      if (dimension == valueShape.size()) {
        rewriter.create<mlir::affine::AffineStoreOp>(
            loc, rewriter.create<mlir::arith::ConstantOp>(loc, *valueIt++),
            alloc, llvm::ArrayRef(indices));
        return;
      }

      // Otherwise, iterate over the current dimension and add the indices to
      // the list.
      for (uint64_t i = 0, e = valueShape[dimension]; i != e; ++i) {
        indices.push_back(constantIndices[i]);
        storeElements(dimension + 1);
        indices.pop_back();
      }
    };

    // Start the element storing recursion from the first dimension.
    storeElements(/*dimension=*/0);

    // Replace this operation with the generated alloc.
    rewriter.replaceOp(op, alloc);
    return mlir::success();
  }
};

class PrintOpLowering : public mlir::OpConversionPattern<engine::PrintOp> {
  using OpConversionPattern<engine::PrintOp>::OpConversionPattern;

  mlir::LogicalResult
  matchAndRewrite(engine::PrintOp op, OpAdaptor adaptor,
                  mlir::ConversionPatternRewriter &rewriter) const final {
    // We don't lower "engine.print" in this pass, but we need to update its
    // operands.
    rewriter.modifyOpInPlace(op,
                               [&] { op->setOperands(adaptor.getOperands()); });
    return mlir::success();
  }
};




/// This defines the function type used to process an iteration of a lowered
/// loop. It takes as input an OpBuilder, an range of memRefOperands
/// corresponding to the operands of the input operation, and the range of loop
/// induction variables for the iteration. It returns a value to store at the
/// current index of the iteration.
using LoopIterationFn = llvm::function_ref<mlir::Value(
    mlir::OpBuilder &rewriter, mlir::ValueRange memRefOperands, mlir::ValueRange loopIvs)>;

static void lowerOpToLoops(mlir::Operation *op, mlir::ValueRange operands,
                           mlir::PatternRewriter &rewriter,
                           LoopIterationFn processIteration) {
  auto tensorType = llvm::cast<mlir::RankedTensorType>(*op->result_type_begin());
  mlir::Location loc = op->getLoc();

  auto memRefType = convertTensorToMemRef(tensorType); 
  mlir::Value alloc = insertAllocAndDealloc(memRefType, loc, rewriter); 

  llvm::SmallVector<int64_t, 4> lowerBounds(tensorType.getRank(), /*Value=*/0);
  llvm::SmallVector<int64_t, 4> steps(tensorType.getRank(), /*Value=*/1);

  mlir::affine::buildAffineLoopNest(
      rewriter, loc, lowerBounds, tensorType.getShape(), steps,
      [&](mlir::OpBuilder &nestedBuilder, mlir::Location nestedLoc, mlir::ValueRange ivs) {
        mlir::Value valueToStore = processIteration(nestedBuilder, operands, ivs);
        nestedBuilder.create<mlir::affine::AffineStoreOp>(nestedLoc, valueToStore, alloc, ivs);
      });

  rewriter.replaceOp(op, alloc);
}

namespace {

template <typename BinaryOp, typename LoweredBinaryOp> // CHECK IF THIS CONVERTS THE TENSORS TO MEMREF
struct BinaryOpLowering : public mlir::ConversionPattern {
  BinaryOpLowering(mlir::MLIRContext *ctx)
      : mlir::ConversionPattern(BinaryOp::getOperationName(), 1, ctx) {}

  mlir::LogicalResult
  matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const final {
    mlir::Location loc = op->getLoc();
    lowerOpToLoops(op, operands, rewriter,
                   [loc](mlir::OpBuilder &builder, mlir::ValueRange memRefOperands,
                         mlir::ValueRange loopIvs) {
                     typename BinaryOp::Adaptor binaryAdaptor(memRefOperands);
                     mlir::Value loadedLhs = builder.create<mlir::affine::AffineLoadOp>(
                         loc, binaryAdaptor.getLhs(), loopIvs);
                     mlir::Value loadedRhs = builder.create<mlir::affine::AffineLoadOp>(
                         loc, binaryAdaptor.getRhs(), loopIvs);

                     return builder.create<LoweredBinaryOp>(loc, loadedLhs, loadedRhs).getResult();
                   });
    return mlir::success();
  }
};

using AddOpLowering = BinaryOpLowering<engine::AddOp, mlir::arith::AddFOp>;
using MulOpLowering = BinaryOpLowering<engine::MulOp, mlir::arith::MulFOp>;
} 


class DotOpLowering : public mlir::OpRewritePattern<engine::DotOp> {
public:
  using OpRewritePattern<engine::DotOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::DotOp op, mlir::PatternRewriter &rewriter) const override {
    // Get location
    auto loc = op.getLoc();

    // Get input operands
    mlir::Value lhs = op.getOperand(0);
    mlir::Value rhs = op.getOperand(1);

    // Validate input types
    auto lhsType = mlir::dyn_cast<mlir::MemRefType>(lhs.getType());
    auto rhsType = mlir::dyn_cast<mlir::MemRefType>(rhs.getType());
    if (!lhsType || !rhsType) {
      return rewriter.notifyMatchFailure(op, "expected memref types for lhs and rhs");
    }

    // Validate output type
    auto resultType = mlir::dyn_cast<mlir::MemRefType>(op.getResult().getType());
    if (!resultType) {
      return rewriter.notifyMatchFailure(op, "expected memref result type");
    } 

  //debug printing shapes
    auto lhsShape = lhsType.getShape();
    llvm::errs() << "LHS_Shape: [";
    for (auto dim : lhsShape) {
      llvm::errs() << dim << " ";
    }
    llvm::errs() << "]\n";

    auto rhsShape = rhsType.getShape();
    llvm::errs() << "RHS_Shape: [";
    for (auto dim : rhsShape) {
      llvm::errs() << dim << " ";
    }
    llvm::errs() << "]\n";

    // Allocate output memref
    auto alloc = insertAllocAndDealloc(resultType, loc, rewriter);

    // Create the linalg.dot operation
    rewriter.create<mlir::linalg::DotOp>(
        loc,
        mlir::ValueRange{lhs, rhs},
        mlir::ValueRange{alloc}
    );

    // Replace the original operation with the allocated output memref
    rewriter.replaceOp(op, alloc);

    return mlir::success();
  }
};

class MatmulOpLowering : public mlir::OpRewritePattern<engine::MatmulOp> {
public:
  using OpRewritePattern<engine::MatmulOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::MatmulOp op, mlir::PatternRewriter &rewriter) const override {
    // Get location
    auto loc = op.getLoc();

    // Get input operands
    mlir::Value lhs = op.getOperand(0);
    mlir::Value rhs = op.getOperand(1);

    // Validate input types
    auto lhsType = mlir::dyn_cast<mlir::MemRefType>(lhs.getType());
    auto rhsType = mlir::dyn_cast<mlir::MemRefType>(rhs.getType());
    if (!lhsType || !rhsType) {
      return rewriter.notifyMatchFailure(op, "expected memref types for lhs and rhs");
    }

    // Validate output type
    auto resultType = mlir::dyn_cast<mlir::MemRefType>(op.getResult().getType());
    if (!resultType) {
      return rewriter.notifyMatchFailure(op, "expected memref result type");
    } 

  //debug printing shapes
    auto lhsShape = lhsType.getShape();
    llvm::errs() << "LHS_Shape: [";
    for (auto dim : lhsShape) {
      llvm::errs() << dim << " ";
    }
    llvm::errs() << "]\n";

    auto rhsShape = rhsType.getShape();
    llvm::errs() << "RHS_Shape: [";
    for (auto dim : rhsShape) {
      llvm::errs() << dim << " ";
    }
    llvm::errs() << "]\n";

    // Allocate output memref
    auto alloc = insertAllocAndDealloc(resultType, loc, rewriter);

    // Create the linalg.Matmul operation
    rewriter.create<mlir::linalg::MatmulOp>(
        loc,
        mlir::ValueRange{lhs, rhs},
        mlir::ValueRange{alloc}
    );

    // Replace the original operation with the allocated output memref
    rewriter.replaceOp(op, alloc);

    return mlir::success();
  }
};


class ReLUOpLowering : public mlir::OpRewritePattern<engine::ReLUOp> {
public:
  using OpRewritePattern<engine::ReLUOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::ReLUOp op, mlir::PatternRewriter &rewriter) const override {
    auto loc = op.getLoc();
    mlir::Value input = op.getValue();

    auto inputType = input.getType().dyn_cast<mlir::MemRefType>();
    if (!inputType) {
      return rewriter.notifyMatchFailure(op, "expected memref type for input");
    }

    auto resultType = op.getResult().getType().dyn_cast<mlir::MemRefType>();
    if (!resultType) {
      return rewriter.notifyMatchFailure(op, "expected memref type for result");
    }

    auto alloc = insertAllocAndDealloc(resultType, loc, rewriter);
    
    // Create constant indices for dimensions
    auto valueShape = inputType.getShape();

    mlir::SmallVector<mlir::Value, 8> constantIndices; // creates 
    for (auto i : llvm::seq<int64_t>(0, *std::max_element(valueShape.begin(), valueShape.end()))) {
      constantIndices.push_back(rewriter.create<mlir::arith::ConstantIndexOp>(loc, i));
    }
    // creates:
    // %c0 = arith.constant 0 : index
    // %c1 = arith.constant 1 : index
    // %c2 = arith.constant 2 : index ...

    // Create constant 1.0 for addition
    auto zeroAttr = rewriter.getZeroAttr(inputType.getElementType());
    auto zeroValue = rewriter.create<mlir::arith::ConstantOp>(loc, zeroAttr);

    // Iterate and store
    mlir::SmallVector<mlir::Value, 2> indices;
    std::function<void(uint64_t)> processElements = [&](uint64_t dimension) {
      if (dimension == valueShape.size()) {
        // Load input value
        auto loadedValue = rewriter.create<mlir::affine::AffineLoadOp>(loc, input, llvm::ArrayRef(indices));
      
        auto cmp = rewriter.create<mlir::arith::CmpFOp>(
            loc,
            mlir::arith::CmpFPredicate::OGT,
            loadedValue,    // x
            zeroValue       // 0.0
        );

        // relu(x) = select (x>0), x, 0
        auto reluValue = rewriter.create<mlir::arith::SelectOp>(loc, cmp, loadedValue, zeroValue);

        // Then store reluValue
        rewriter.create<mlir::affine::AffineStoreOp>(loc, reluValue, alloc, indices);
        return;
      }

      for (uint64_t i = 0, e = valueShape[dimension]; i != e; ++i) {
        indices.push_back(constantIndices[i]);
        processElements(dimension + 1);
        indices.pop_back();
      }
    };

    processElements(0);
    rewriter.replaceOp(op, alloc);
    return mlir::success();
  }
};

// class FlattenOpLowering : public mlir::OpRewritePattern<engine::FlattenOp> {
// public:
//   using OpRewritePattern<engine::FlattenOp>::OpRewritePattern;

//   mlir::LogicalResult
// }


// class StoreOpLowering : public mlir::OpConversionPattern<engine::StoreOp> {
// public:
//   using OpConversionPattern<engine::StoreOp>::OpConversionPattern;

//   mlir::LogicalResult
//   matchAndRewrite(engine::StoreOp op, OpAdaptor adaptor,
//                   mlir::ConversionPatternRewriter &rewriter) const final {
//     mlir::Location loc = op->getLoc();
//     mlir::Value input = adaptor.getValue(); // The tensor value
//     llvm::StringRef symbolName = adaptor.getName(); // The name for the global
//     mlir::Type inputType = input.getType();

//     // Ensure input is a MemRef
//     if (auto tensorType = mlir::dyn_cast<mlir::TensorType>(inputType)) {
//       mlir::MemRefType memrefType = mlir::MemRefType::get(
//           tensorType.getShape(), tensorType.getElementType());
//       input = rewriter.create<mlir::bufferization::ToMemrefOp>(
//           loc, memrefType, input);
//     }

//     // Get the MemRef type of the input
//     mlir::MemRefType memrefType = mlir::cast<mlir::MemRefType>(input.getType());

//     // Get the parent module
//     mlir::ModuleOp moduleOp = op->getParentOfType<mlir::ModuleOp>();

//     // Check if a global with the same name already exists
//     if (!moduleOp.lookupSymbol<mlir::memref::GlobalOp>(symbolName)) {
//       // Create a zero-initialized DenseElementsAttr
//       mlir::DenseElementsAttr initialValue = mlir::DenseElementsAttr::get(
//           mlir::RankedTensorType::get(
//               memrefType.getShape(), memrefType.getElementType()),
//           rewriter.getZeroAttr(memrefType.getElementType()));

//       // Create a global if it does not exist
//       mlir::OpBuilder::InsertionGuard guard(rewriter);
//       rewriter.setInsertionPointToStart(moduleOp.getBody());
//       rewriter.create<mlir::memref::GlobalOp>(
//           loc,                                // Location
//           symbolName,                         // Symbol name
//           rewriter.getStringAttr("private"),  // Visibility ("private" or "public")
//           memrefType,                         // MemRef type
//           initialValue,                       // Initial value (zero initializer)
//           false,                              // Is constant (false for mutable)
//           nullptr                             // Alignment (nullptr for default)
//       );
//     }

//     // Create a GetGlobalOp to get a reference to the global
//     mlir::Value globalRef =
//         rewriter.create<mlir::memref::GetGlobalOp>(loc, memrefType, symbolName);

//     // Copy the tensor data into the global
//     rewriter.create<mlir::memref::CopyOp>(loc, input, globalRef);

//     // Erase the original operation
//     rewriter.eraseOp(op);
//     return mlir::success();
//   }
// };


// class LoadOpLowering : public mlir::OpConversionPattern<engine::LoadOp> {
// public:
//   using OpConversionPattern<engine::LoadOp>::OpConversionPattern;

//   mlir::LogicalResult
//   matchAndRewrite(engine::LoadOp op, OpAdaptor adaptor,
//                   mlir::ConversionPatternRewriter &rewriter) const final {
//     mlir::Location loc = op.getLoc();
//     llvm::StringRef symbolName = adaptor.getName();

//     // Our op now says its result is already a memref type.
//     auto resultType = op.getResult().getType().cast<mlir::MemRefType>();

//     // Verify the global exists
//     mlir::ModuleOp moduleOp = op->getParentOfType<mlir::ModuleOp>();
//     auto globalOp = moduleOp.lookupSymbol<mlir::memref::GlobalOp>(symbolName);
//     if (!globalOp) {
//       llvm::errs() << "Error: Global variable '" << symbolName
//                    << "' does not exist.\n";
//       return rewriter.notifyMatchFailure(op, "global variable does not exist");
//     }

//     // Create memref.get_global
//     mlir::Value globalRef = rewriter.create<mlir::memref::GetGlobalOp>(
//         loc, resultType, symbolName);

//     // Directly replace the LoadOp with the memref (no to_tensor!)
//     rewriter.replaceOp(op, globalRef);

//     return mlir::success();
//   }
// };






namespace {
class EngineToAffineLowerPass
    : public mlir::PassWrapper<EngineToAffineLowerPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(EngineToAffineLowerPass)

  void getDependentDialects(mlir::DialectRegistry &registry) const override { // shouldnt need this, check it later.
    registry.insert<mlir::affine::AffineDialect, mlir::func::FuncDialect,
                    mlir::memref::MemRefDialect,mlir::arith::ArithDialect,mlir::bufferization::BufferizationDialect>();
  }

  void runOnOperation() final;
};
} // namespace

void EngineToAffineLowerPass::runOnOperation() { // Only engine:: opertions need to be lowered here.
  mlir::ConversionTarget target(getContext());

  target.addIllegalDialect<engine::EngineDialect>();
  target.addLegalDialect<mlir::affine::AffineDialect, mlir::BuiltinDialect,
                         mlir::func::FuncDialect, mlir::arith::ArithDialect,
                         mlir::memref::MemRefDialect,mlir::bufferization::BufferizationDialect,mlir::linalg::LinalgDialect>();
  // target.addLegalOp<mlir::bufferization::ToTensorOp>();
  // target.addLegalOp<mlir::bufferization::ToMemrefOp>();
  target.addDynamicallyLegalOp<engine::PrintOp>([](engine::PrintOp op) {
    return llvm::none_of(op->getOperandTypes(), [](mlir::Type type) {
      return mlir::isa<mlir::TensorType>(type);
    });
  });
  target.addLegalOp<engine::WorldOp>();
  mlir::RewritePatternSet patterns(&getContext());
  patterns.add<ConstantOpLowering>(&getContext());
  patterns.add<PrintOpLowering>(&getContext());
  patterns.add<AddOpLowering>(&getContext());
  patterns.add<MulOpLowering>(&getContext());
  patterns.add<DotOpLowering>(&getContext());
  patterns.add<MatmulOpLowering>(&getContext());
  patterns.add<ReLUOpLowering>(&getContext());
  // patterns.add<StoreOpLowering>(&getContext());
  // patterns.add<LoadOpLowering>(&getContext());

  if (mlir::failed(mlir::applyPartialConversion(getOperation(), target,
                                                std::move(patterns)))) {
    signalPassFailure();
  }
}

std::unique_ptr<mlir::Pass> engine::createLowerToAffinePass() {
  return std::make_unique<EngineToAffineLowerPass>();
}
