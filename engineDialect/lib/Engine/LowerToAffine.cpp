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
#include "mlir/Dialect/SCF/IR/SCF.h"
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

mlir::LogicalResult matchAndRewrite(engine::ConstantOp op,
                                  mlir::PatternRewriter &rewriter) const final {
  mlir::ElementsAttr constantValue = op.getValue();
  mlir::Location loc = op.getLoc();

  // When lowering the constant operation, we allocate and assign the constant
  // values to a corresponding memref allocation.
  auto memRefType = op.getType().dyn_cast<mlir::MemRefType>();
  if (!memRefType) {
    return rewriter.notifyMatchFailure(op, "expected memref result");
  }

  auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, memRefType);

  // We will be generating constant indices up-to the largest dimension.
  auto valueShape = memRefType.getShape();
  mlir::SmallVector<mlir::Value, 8> constantIndices;
  if (!valueShape.empty()) {
    for (auto i : llvm::seq<int64_t>(
         0, *std::max_element(valueShape.begin(), valueShape.end())))
      constantIndices.push_back(
          rewriter.create<mlir::arith::ConstantIndexOp>(loc, i));
  } else {
    constantIndices.push_back(
        rewriter.create<mlir::arith::ConstantIndexOp>(loc, 0));
  }

  mlir::SmallVector<mlir::Value, 2> indices;

  if (memRefType.getElementType().isa<mlir::FloatType>()) { // REFACTOR THIS MESS LATER

    auto valueIt = constantValue.getValues<mlir::FloatAttr>().begin();
    std::function<void(uint64_t)> storeElements = [&](uint64_t dimension) {
      if (dimension == valueShape.size()) {
        rewriter.create<mlir::affine::AffineStoreOp>(
            loc, rewriter.create<mlir::arith::ConstantOp>(loc, *valueIt++),
            alloc, llvm::ArrayRef(indices));
        return;
      }
      for (uint64_t i = 0, e = valueShape[dimension]; i != e; ++i) {
        indices.push_back(constantIndices[i]);
        storeElements(dimension + 1);
        indices.pop_back();
      }
    };
    storeElements(0);
  } 
  else if (memRefType.getElementType().isa<mlir::IntegerType>()) {
    // Handle integer case
    auto valueIt = constantValue.getValues<mlir::IntegerAttr>().begin();
    std::function<void(uint64_t)> storeElements = [&](uint64_t dimension) {
      if (dimension == valueShape.size()) {
        rewriter.create<mlir::affine::AffineStoreOp>(
            loc, rewriter.create<mlir::arith::ConstantOp>(loc, *valueIt++),
            alloc, llvm::ArrayRef(indices));
        return;
      }
      for (uint64_t i = 0, e = valueShape[dimension]; i != e; ++i) {
        indices.push_back(constantIndices[i]);
        storeElements(dimension + 1);
        indices.pop_back();
      }
    };
    storeElements(0);
  }
  else {
    return rewriter.notifyMatchFailure(op, "unsupported element type");
  }

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
  // mlir::Value alloc = insertAllocAndDealloc(memRefType, loc, rewriter); 
  auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, memRefType);

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

    // // Allocate output memref
    // auto alloc = insertAllocAndDealloc(resultType, loc, rewriter);
    auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, resultType);
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

class MatmulOpLowering : public mlir::OpRewritePattern<engine::MatmulOp> { // MAYBE NEED TO INITIALIZE OUTPUT BUFFER TO 0 - test this
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

    auto isFloat = resultType.getElementType().isa<mlir::FloatType>();

    // // Allocate output memref
    // auto alloc = insertAllocAndDealloc(resultType, loc, rewriter);
    // Allocate output memref
    auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, resultType);

    // // Zero-initialize the output buffer
    mlir::Value zero = isFloat ? 
      rewriter.create<mlir::arith::ConstantFloatOp>(
          loc, 
          llvm::APFloat(0.0),
          rewriter.getF64Type()
      ).getResult() :  // For floats
      rewriter.create<mlir::arith::ConstantIntOp>(
          loc, 
          0, 
          32
      ).getResult();   // For integers

    mlir::Value allocMemref = alloc.getResult(); // Get the memref value
    
    for (int64_t i = 0; i < resultType.getShape()[0]; ++i) {
      // Create index value (not operation)
      mlir::Value idx = rewriter.create<mlir::arith::ConstantIndexOp>(loc, i).getResult();
      
      // Store using VALUES, not operations
      rewriter.create<mlir::memref::StoreOp>(loc, zero, allocMemref, idx);
    }

    // Create the linalg.Matmul operation
    rewriter.create<mlir::linalg::MatvecOp>(
        loc,
        mlir::ValueRange{lhs, rhs},
        mlir::ValueRange{alloc}
    );

    // Replace the original operation with the allocated output memref
    rewriter.replaceOp(op, alloc);

    return mlir::success();
  }
};

class AddOpLowering : public mlir::OpRewritePattern<engine::AddOp> {
public:
  using OpRewritePattern<engine::AddOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::AddOp op, mlir::PatternRewriter &rewriter) const override {
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

    // Allocate output memref
    auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, resultType);

    rewriter.create<mlir::linalg::AddOp>(
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
    auto isFloat = inputType.getElementType().isa<mlir::FloatType>();

    auto resultType = op.getResult().getType().dyn_cast<mlir::MemRefType>();
    if (!resultType) {
      return rewriter.notifyMatchFailure(op, "expected memref type for result");
    }

    // auto alloc = insertAllocAndDealloc(resultType, loc, rewriter);
    auto alloc = rewriter.create<mlir::memref::AllocOp>(loc, resultType);
    
    // Create constant indices for dimensions
    auto valueShape = inputType.getShape();

    mlir::SmallVector<mlir::Value, 8> constantIndices; // creates 
    for (auto i : llvm::seq<int64_t>(0, *std::max_element(valueShape.begin(), valueShape.end()))) {
      constantIndices.push_back(rewriter.create<mlir::arith::ConstantIndexOp>(loc, i));
    }


    auto zeroAttr = rewriter.getZeroAttr(inputType.getElementType());
    auto zeroValue = rewriter.create<mlir::arith::ConstantOp>(loc, zeroAttr);

    // Iterate and store
    mlir::SmallVector<mlir::Value, 2> indices;
    std::function<void(uint64_t)> processElements = [&](uint64_t dimension) {
      if (dimension == valueShape.size()) {
        // Load input value
        auto loadedValue = rewriter.create<mlir::affine::AffineLoadOp>(loc, input, llvm::ArrayRef(indices));

        mlir::Value cmp;
        if(isFloat){
          cmp = rewriter.create<mlir::arith::CmpFOp>(loc,mlir::arith::CmpFPredicate::OGT,
                loadedValue,    // x
                zeroValue       // 0.0
            );
        }
        else{
          cmp = rewriter.create<mlir::arith::CmpIOp>(loc,mlir::arith::CmpIPredicate::sgt,
              loadedValue,    // x
              zeroValue       // 0.0
          );
        }
 

        // relu(x) = select (x>0), x, 0
        auto reluValue = rewriter.create<mlir::arith::SelectOp>(loc, cmp, loadedValue, zeroValue);

        // Then store reluValue CHECK THIS OUT LATER.
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

class FlattenOpLowering : public mlir::OpRewritePattern<engine::FlattenOp> {
public:
  using OpRewritePattern<engine::FlattenOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::FlattenOp op, mlir::PatternRewriter &rewriter) const override {
    auto loc = op.getLoc();
    mlir::Value input = op.getValue();
    
    auto inputType = input.getType().dyn_cast<mlir::MemRefType>();
    if (!inputType) {
      return rewriter.notifyMatchFailure(op, "expected memref type for input");
    }

    // Calculate flattened size
    auto shape = inputType.getShape();
    int64_t flattenedSize = 1;
    for (auto dim : shape) {
      if (dim == mlir::ShapedType::kDynamic)
        return rewriter.notifyMatchFailure(op, "dynamic shapes not supported");
      flattenedSize *= dim;
    }

    // Create shape tensor with flattened dimension
    auto shapeTy = mlir::MemRefType::get({1}, rewriter.getIndexType());
    auto shapeAlloc = rewriter.create<mlir::memref::AllocOp>(loc, shapeTy);
    auto idx0 = rewriter.create<mlir::arith::ConstantIndexOp>(loc, 0);
    auto flatSize = rewriter.create<mlir::arith::ConstantIndexOp>(loc, flattenedSize);
    
    auto storeOp = rewriter.create<mlir::memref::StoreOp>(
        loc, 
        flatSize.getResult(),  // Use getResult() to get the Value
        shapeAlloc.getResult(),  // Use getResult() to get the Value
        mlir::ValueRange{idx0.getResult()}  // Wrap index in ValueRange
    );

    auto elementType = inputType.getElementType();
    auto flattenedType = mlir::MemRefType::get({flattenedSize}, elementType);
    auto reshapeOp = rewriter.create<mlir::memref::ReshapeOp>(loc, flattenedType, input, shapeAlloc);
    
    rewriter.replaceOp(op, reshapeOp.getResult());
    return mlir::success();
  }
};

class ArgMaxOpLowering : public mlir::OpRewritePattern<engine::ArgMaxOp> {
public:
    using OpRewritePattern<engine::ArgMaxOp>::OpRewritePattern;

    mlir::LogicalResult
    matchAndRewrite(engine::ArgMaxOp op, mlir::PatternRewriter &rewriter) const override {
        auto loc = op.getLoc();
        auto value = op.getValue();
        auto inputType = value.getType().dyn_cast<mlir::MemRefType>();
        
        if (!inputType) {
            return rewriter.notifyMatchFailure(op, "expected memref type for input");
        }
        auto isFloat = inputType.getElementType().isa<mlir::FloatType>();

        // Get input shape
        auto shape = inputType.getShape();
        int64_t totalElements = 1;
        for (auto dim : shape) {
            totalElements *= dim;
        }

        // Index variable for loop
        auto indexType = rewriter.getIndexType();
        mlir::Value index = rewriter.create<mlir::arith::ConstantIndexOp>(loc, 0);

        // Initialize maxValue and maxIndex
        auto maxValue = rewriter.create<mlir::memref::LoadOp>(loc, value, 
            mlir::ValueRange{index});
        auto maxIndex = index;  // Start with index 0

        // Loop with both maxValue and maxIndex as region arguments
        auto loop = rewriter.create<mlir::scf::ForOp>(
            loc,
            index, // lower bound
            rewriter.create<mlir::arith::ConstantIndexOp>(loc, totalElements), // upper bound
            rewriter.create<mlir::arith::ConstantIndexOp>(loc, 1), // step
            mlir::ValueRange{maxValue, maxIndex} // initial values
        );

        // Create the loop body
        rewriter.setInsertionPointToStart(loop.getBody());

        // Load current element
        auto currentValue = rewriter.create<mlir::memref::LoadOp>(
            loc, value, loop.getInductionVar());

        // Compare with max val
        mlir::Value cmp;
        if (isFloat){
          cmp = rewriter.create<mlir::arith::CmpFOp>(loc,mlir::arith::CmpFPredicate::OGT,currentValue,loop.getRegionIterArgs()[0]);
        }
        else{ // if integer
          cmp = rewriter.create<mlir::arith::CmpIOp>(loc,mlir::arith::CmpIPredicate::sgt,currentValue,loop.getRegionIterArgs()[0]); // not sure about the predicate
        }
        

        // Select the larger value and corresponding index
        auto newMax = rewriter.create<mlir::arith::SelectOp>(
            loc, cmp, currentValue, loop.getRegionIterArgs()[0]
        );
        auto newMaxIndex = rewriter.create<mlir::arith::SelectOp>(
            loc, cmp, loop.getInductionVar(), loop.getRegionIterArgs()[1]
        );

        // Yield both the new max value and index
        rewriter.create<mlir::scf::YieldOp>(loc, 
            mlir::ValueRange{newMax.getResult(), newMaxIndex.getResult()});

        // Reset insertion point
        rewriter.setInsertionPointAfter(loop);

        // Convert index to i32
        auto maxIndexInt = rewriter.create<mlir::arith::IndexCastOp>(
            loc,
            rewriter.getI32Type(),
            loop.getResult(1)
        );


        // Create output memref for float
        auto resultType = mlir::MemRefType::get({},rewriter.getI32Type());
        auto result = rewriter.create<mlir::memref::AllocOp>(loc, resultType);

        // Store the float value
        rewriter.create<mlir::memref::StoreOp>(
            loc,
            maxIndexInt,
            result.getResult(),
            mlir::ValueRange{}
        );

        // Replace the original op with our result
        rewriter.replaceOp(op, result);
        return mlir::success();
    }
};

namespace {
class EngineToAffineLowerPass
    : public mlir::PassWrapper<EngineToAffineLowerPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:
  explicit EngineToAffineLowerPass(engine::settingsInfo &settings) : settings(settings) {}
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(EngineToAffineLowerPass)

  void getDependentDialects(mlir::DialectRegistry &registry) const override { // shouldnt need this, check it later.
    registry.insert<mlir::affine::AffineDialect, mlir::func::FuncDialect,
                    mlir::memref::MemRefDialect,mlir::arith::ArithDialect,mlir::bufferization::BufferizationDialect>();
  }

  void runOnOperation() final;
private:
  engine::settingsInfo &settings;
};
} // namespace

void EngineToAffineLowerPass::runOnOperation() { // Only engine:: opertions need to be lowered here.
  mlir::ConversionTarget target(getContext());

  target.addIllegalDialect<engine::EngineDialect>();
  target.addLegalDialect<mlir::affine::AffineDialect, mlir::BuiltinDialect,
                         mlir::func::FuncDialect, mlir::arith::ArithDialect,mlir::scf::SCFDialect,
                         mlir::memref::MemRefDialect,mlir::bufferization::BufferizationDialect,mlir::linalg::LinalgDialect>();
                         
  target.addDynamicallyLegalOp<engine::PrintOp>([](engine::PrintOp op) {
    return llvm::none_of(op->getOperandTypes(), [](mlir::Type type) {
      return mlir::isa<mlir::TensorType>(type);
    });
  });
  target.addLegalOp<engine::WorldOp>();
  target.addLegalOp<engine::ReadOp>();
  mlir::RewritePatternSet patterns(&getContext());
  patterns.add<ConstantOpLowering>(&getContext());
  patterns.add<PrintOpLowering>(&getContext());
  patterns.add<AddOpLowering>(&getContext());
  // patterns.add<MulOpLowering>(&getContext());
  patterns.add<DotOpLowering>(&getContext());
  patterns.add<MatmulOpLowering>(&getContext());
  patterns.add<ReLUOpLowering>(&getContext());
  patterns.add<FlattenOpLowering>(&getContext());
  patterns.add<ArgMaxOpLowering>(&getContext());

  if (mlir::failed(mlir::applyPartialConversion(getOperation(), target,
                                                std::move(patterns)))) {
    signalPassFailure();
  }
}
namespace engine{
std::unique_ptr<mlir::Pass> createLowerToAffinePass(settingsInfo &settings) {
  return std::make_unique<EngineToAffineLowerPass>(settings);
}
}
