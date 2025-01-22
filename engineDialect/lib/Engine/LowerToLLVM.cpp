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

#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/ArithToLLVM/ArithToLLVM.h"
#include "mlir/Conversion/LinalgToStandard/LinalgToStandard.h"
#include "mlir/Conversion/ControlFlowToLLVM/ControlFlowToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVMPass.h"
#include "mlir/Conversion/LLVMCommon/ConversionTarget.h"
#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Conversion/MemRefToLLVM/MemRefToLLVM.h"
#include "mlir/Conversion/SCFToControlFlow/SCFToControlFlow.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/ADT/Sequence.h"
#include "mlir/Dialect/MemRef/Transforms/Transforms.h"

#include <iostream>

namespace engine {
 
class PrintOpLowering : public mlir::ConversionPattern {
public:
  explicit PrintOpLowering(mlir::MLIRContext *context)
      : mlir::ConversionPattern(engine::PrintOp::getOperationName(), 1,
                                context) {}

  mlir::LogicalResult
  matchAndRewrite(mlir::Operation *op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    auto *context = rewriter.getContext();                
    auto memRefType = mlir::cast<mlir::MemRefType>(*op->operand_type_begin());
    auto memRefShape = memRefType.getShape();
    auto loc = op->getLoc();

    mlir::ModuleOp parentModule = op->getParentOfType<mlir::ModuleOp>();

    // Get a symbol reference to the printf function, inserting it if necessary.
    auto printfRef = getOrInsertPrintf(rewriter, parentModule);
    mlir::Value formatSpecifierCst = getOrCreateGlobalString(
        loc, rewriter, "frmt_spec", mlir::StringRef("%f \0", 4), parentModule); // CHECK IF INPUT IS FLOAT OR INT HERE AND CHANGE FORMAT
    mlir::Value newLineCst = getOrCreateGlobalString(
        loc, rewriter, "nl", mlir::StringRef("\n\0", 2), parentModule);

    // Create a loop for each of the dimensions within the shape.
    mlir::SmallVector<mlir::Value, 4> loopIvs;
    for (unsigned i = 0, e = memRefShape.size(); i != e; ++i) {
      auto lowerBound = rewriter.create<mlir::arith::ConstantIndexOp>(loc, 0);
      auto upperBound =
          rewriter.create<mlir::arith::ConstantIndexOp>(loc, memRefShape[i]);
      auto step = rewriter.create<mlir::arith::ConstantIndexOp>(loc, 1);
      auto loop =
          rewriter.create<mlir::scf::ForOp>(loc, lowerBound, upperBound, step);
      for (mlir::Operation &nested : *loop.getBody()) {
        rewriter.eraseOp(&nested);
      }
      loopIvs.push_back(loop.getInductionVar());

      // Terminate the loop body.
      rewriter.setInsertionPointToEnd(loop.getBody());

      // Insert a newline after each of the inner dimensions of the shape.
      if (i != e - 1) {
        rewriter.create<mlir::LLVM::CallOp>(loc, getPrintfType(context),
                                            printfRef, newLineCst);
      }
      rewriter.create<mlir::scf::YieldOp>(loc);
      rewriter.setInsertionPointToStart(loop.getBody());
    }

    // Generate a call to printf for the current element of the loop.
    auto printOp = mlir::cast<engine::PrintOp>(op);
    auto elementLoad =
        rewriter.create<mlir::memref::LoadOp>(loc, printOp.getInput(), loopIvs);
    rewriter.create<mlir::LLVM::CallOp>(
        loc, getPrintfType(context), printfRef,
        mlir::ArrayRef<mlir::Value>({formatSpecifierCst, elementLoad}));

    // Notify the rewriter that this operation has been removed.
    rewriter.eraseOp(op);
    return mlir::success();
  }

private:
  static mlir::LLVM::LLVMFunctionType
  getPrintfType(mlir::MLIRContext *context) {
    auto llvmI32Ty = mlir::IntegerType::get(context, 32);
    auto llvmPtrTy = mlir::LLVM::LLVMPointerType::get(context);
    auto llvmFnType = mlir::LLVM::LLVMFunctionType::get(llvmI32Ty, llvmPtrTy,
                                                        /*isVarArg=*/true);
    return llvmFnType;
  }

  static mlir::FlatSymbolRefAttr
  getOrInsertPrintf(mlir::PatternRewriter &rewriter, mlir::ModuleOp module) {
    auto *context = module.getContext();
    if (module.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf")) {
      return mlir::SymbolRefAttr::get(context, "printf");
    }

    mlir::PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    rewriter.create<mlir::LLVM::LLVMFuncOp>(module.getLoc(), "printf",
                                            getPrintfType(context));
    return mlir::SymbolRefAttr::get(context, "printf");
  }

  static mlir::Value getOrCreateGlobalString(mlir::Location loc,
                                             mlir::OpBuilder &builder,
                                             mlir::StringRef name,
                                             mlir::StringRef value,
                                             mlir::ModuleOp module) {
    // Create the global at the entry of the module.
    mlir::LLVM::GlobalOp global;
    if (!(global = module.lookupSymbol<mlir::LLVM::GlobalOp>(name))) {
      mlir::OpBuilder::InsertionGuard insertGuard(builder);
      builder.setInsertionPointToStart(module.getBody());
      auto type = mlir::LLVM::LLVMArrayType::get(
          mlir::IntegerType::get(builder.getContext(), 8), value.size());
      global = builder.create<mlir::LLVM::GlobalOp>(
          loc, type, /*isConstant=*/true, mlir::LLVM::Linkage::Internal, name,
          builder.getStringAttr(value));
    }

    // Get the pointer to the first character in the global string.
    mlir::Value globalPtr =
        builder.create<mlir::LLVM::AddressOfOp>(loc, global);
    mlir::Value cst0 = builder.create<mlir::LLVM::ConstantOp>(
        loc, mlir::IntegerType::get(builder.getContext(), 64),
        builder.getIntegerAttr(builder.getIndexType(), 0));

    return builder.create<mlir::LLVM::GEPOp>(
        loc, mlir::LLVM::LLVMPointerType::get(builder.getContext()),
        global.getType(), globalPtr, mlir::ArrayRef<mlir::Value>({cst0, cst0}));
  }
};


class ReadOpLowering : public mlir::ConversionPattern {
public:
    explicit ReadOpLowering(mlir::MLIRContext *context)
        : mlir::ConversionPattern(engine::ReadOp::getOperationName(), 1, context) {}

    mlir::LogicalResult
    matchAndRewrite(mlir::Operation *op, mlir::ArrayRef<mlir::Value> operands,
                    mlir::ConversionPatternRewriter &rewriter) const override {
        auto readOp = mlir::cast<engine::ReadOp>(op);
        auto loc = op->getLoc();
        auto *context = rewriter.getContext();
        
        // Get the memref type
        auto memRefType = mlir::cast<mlir::MemRefType>(readOp.getType());
        auto memRefShape = memRefType.getShape();
        
        // Get module
        mlir::ModuleOp parentModule = op->getParentOfType<mlir::ModuleOp>();
            
        // Allocate result memref
        auto resultMemRef = rewriter.create<mlir::memref::AllocOp>(loc, memRefType);
        
        // Get scanf reference
        auto scanfRef = getOrInsertScanf(rewriter, parentModule);
        
        // Create format string with null terminator
        mlir::Value formatSpecifierCst = getOrCreateGlobalString(
            loc, rewriter, "scanf_fmt", mlir::StringRef("%lf\0", 4), parentModule); // CHECK IF RESULT TYPE IS FLOAT OR INT AND CHANGE FORMAT HERE 
        
        // Create loop for reading values
        auto lowerBound = rewriter.create<mlir::arith::ConstantIndexOp>(loc, 0);
        auto upperBound = 
            rewriter.create<mlir::arith::ConstantIndexOp>(loc, memRefShape[0]);
        auto step = rewriter.create<mlir::arith::ConstantIndexOp>(loc, 1);
        
        auto loop =
            rewriter.create<mlir::scf::ForOp>(loc, lowerBound, upperBound, step);
        
        // Clear any existing operations in the loop body
        for (mlir::Operation &nested : *loop.getBody()) {
            rewriter.eraseOp(&nested);
        }
        
        // Set insertion point to start of loop body
        rewriter.setInsertionPointToStart(loop.getBody());
        
        // Create buffer for scanf
        auto doubleType = mlir::MemRefType::get({}, rewriter.getF64Type());
        auto tempLoc = rewriter.create<mlir::memref::AllocaOp>(loc, doubleType);
        
        // Get the raw pointer to the buffer
        auto basePtr = rewriter.create<mlir::memref::ExtractAlignedPointerAsIndexOp>(
            loc, rewriter.getIndexType(), tempLoc);
            
        // Convert index to integer
        auto ptrAsInt = rewriter.create<mlir::arith::IndexCastOp>(
            loc, rewriter.getIntegerType(64), basePtr);
            
        // Convert integer to pointer
        auto llvmPtrType = mlir::LLVM::LLVMPointerType::get(context);
        auto castedPtr = rewriter.create<mlir::LLVM::IntToPtrOp>(
            loc, llvmPtrType, ptrAsInt);
        
        // Call scanf
        rewriter.create<mlir::LLVM::CallOp>(
            loc, getScanfType(context), scanfRef,
            mlir::ValueRange{formatSpecifierCst, castedPtr});
        
        // Load scanned value
        auto loadedVal = rewriter.create<mlir::memref::LoadOp>(
            loc, tempLoc, mlir::ValueRange{});
        
        // Store into result memref
        rewriter.create<mlir::memref::StoreOp>(
            loc, loadedVal, resultMemRef, loop.getInductionVar());
        
        // Explicitly set insertion point to end of loop body and create yield
        rewriter.setInsertionPointToEnd(loop.getBody());
        rewriter.create<mlir::scf::YieldOp>(loc);
        
        // Replace original op
        rewriter.replaceOp(op, resultMemRef);
        return mlir::success();
    }
private:
  static mlir::LLVM::LLVMFunctionType
  getScanfType(mlir::MLIRContext *context) {
    auto llvmI32Ty = mlir::IntegerType::get(context, 32);
    auto llvmPtrTy = mlir::LLVM::LLVMPointerType::get(context);
    return mlir::LLVM::LLVMFunctionType::get(llvmI32Ty, llvmPtrTy,
                                            true);
  }

  static mlir::FlatSymbolRefAttr
  getOrInsertScanf(mlir::PatternRewriter &rewriter, mlir::ModuleOp module) {
    auto *context = module.getContext();
    if (module.lookupSymbol<mlir::LLVM::LLVMFuncOp>("scanf"))
      return mlir::SymbolRefAttr::get(context, "scanf");

    mlir::PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    rewriter.create<mlir::LLVM::LLVMFuncOp>(module.getLoc(), "scanf",
                                           getScanfType(context));
    return mlir::SymbolRefAttr::get(context, "scanf");
  }
  static mlir::Value getOrCreateGlobalString(mlir::Location loc,
                                              mlir::OpBuilder &builder,
                                              mlir::StringRef name,
                                              mlir::StringRef value,
                                              mlir::ModuleOp module) {
      // Create the global at the entry of the module.
      mlir::LLVM::GlobalOp global;
      if (!(global = module.lookupSymbol<mlir::LLVM::GlobalOp>(name))) {
        mlir::OpBuilder::InsertionGuard insertGuard(builder);
        builder.setInsertionPointToStart(module.getBody());
        auto type = mlir::LLVM::LLVMArrayType::get(
            mlir::IntegerType::get(builder.getContext(), 8), value.size());
        global = builder.create<mlir::LLVM::GlobalOp>(
            loc, type, /*isConstant=*/true, mlir::LLVM::Linkage::Internal, name,
            builder.getStringAttr(value));
      }

      // Get the pointer to the first character in the global string.
      mlir::Value globalPtr =
          builder.create<mlir::LLVM::AddressOfOp>(loc, global);
      mlir::Value cst0 = builder.create<mlir::LLVM::ConstantOp>(
          loc, mlir::IntegerType::get(builder.getContext(), 64),
          builder.getIntegerAttr(builder.getIndexType(), 0));

      return builder.create<mlir::LLVM::GEPOp>(
          loc, mlir::LLVM::LLVMPointerType::get(builder.getContext()),
          global.getType(), globalPtr, mlir::ArrayRef<mlir::Value>({cst0, cst0}));
    }
};

class WorldOpLowering : public mlir::ConversionPattern {
public:
  explicit WorldOpLowering(mlir::MLIRContext *context)
      : mlir::ConversionPattern(engine::WorldOp::getOperationName(), 1,
                                context) {}

  mlir::LogicalResult
  matchAndRewrite(mlir::Operation *op, mlir::ArrayRef<mlir::Value> operands,
                  mlir::ConversionPatternRewriter &rewriter) const override {
    auto *context = rewriter.getContext();
    mlir::ModuleOp parentModule = op->getParentOfType<mlir::ModuleOp>();
    auto printfRef = getOrInsertPrintf(rewriter, parentModule);
    auto loc = op->getLoc();
    mlir::Value engineWorld = getOrCreateGlobalString(
        loc, rewriter, "engine_word_string",
        mlir::StringRef("Engine, World! \n\0", 16), parentModule);

    rewriter.create<mlir::LLVM::CallOp>(loc, getPrintfType(context),
                                        printfRef, engineWorld);
    rewriter.eraseOp(op);
    return mlir::success();
  }

private:
  static mlir::LLVM::LLVMFunctionType
  getPrintfType(mlir::MLIRContext *context) {
    auto llvmI32Ty = mlir::IntegerType::get(context, 32);
    auto llvmPtrTy = mlir::LLVM::LLVMPointerType::get(context);
    auto llvmFnType = mlir::LLVM::LLVMFunctionType::get(llvmI32Ty, llvmPtrTy,
                                                        /*isVarArg=*/true);
    return llvmFnType;
  }

  static mlir::FlatSymbolRefAttr
  getOrInsertPrintf(mlir::PatternRewriter &rewriter, mlir::ModuleOp module) {
    auto *context = module.getContext();
    if (module.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf")) {
      return mlir::SymbolRefAttr::get(context, "printf");
    }

    mlir::PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    rewriter.create<mlir::LLVM::LLVMFuncOp>(module.getLoc(), "printf",
                                            getPrintfType(context));
    return mlir::SymbolRefAttr::get(context, "printf");
  }

  static mlir::Value getOrCreateGlobalString(mlir::Location loc,
                                             mlir::OpBuilder &builder,
                                             mlir::StringRef name,
                                             mlir::StringRef value,
                                             mlir::ModuleOp module) {
    // Create the global at the entry of the module.
    mlir::LLVM::GlobalOp global;
    if (!(global = module.lookupSymbol<mlir::LLVM::GlobalOp>(name))) {
      mlir::OpBuilder::InsertionGuard insertGuard(builder);
      builder.setInsertionPointToStart(module.getBody());
      auto type = mlir::LLVM::LLVMArrayType::get(
          mlir::IntegerType::get(builder.getContext(), 8), value.size());
      global = builder.create<mlir::LLVM::GlobalOp>(
          loc, type, /*isConstant=*/true, mlir::LLVM::Linkage::Internal, name,
          builder.getStringAttr(value));
    }

    // Get the pointer to the first character in the global string.
    mlir::Value globalPtr =
        builder.create<mlir::LLVM::AddressOfOp>(loc, global);
    mlir::Value cst0 = builder.create<mlir::LLVM::ConstantOp>(
        loc, mlir::IntegerType::get(builder.getContext(), 64),
        builder.getIntegerAttr(builder.getIndexType(), 0));

    return builder.create<mlir::LLVM::GEPOp>(
        loc, mlir::LLVM::LLVMPointerType::get(builder.getContext()),
        global.getType(), globalPtr, mlir::ArrayRef<mlir::Value>({cst0, cst0}));
  }
};
} // namespace engine

namespace {
class EngineToLLVMLoweringPass
    : public mlir::PassWrapper<EngineToLLVMLoweringPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(EngineToLLVMLoweringPass)
  void getDependentDialects(mlir::DialectRegistry &registry) const override {
    registry.insert<mlir::LLVM::LLVMDialect, mlir::scf::SCFDialect,
                    mlir::cf::ControlFlowDialect>();
  }

  void runOnOperation() final;
};
} // namespace

void EngineToLLVMLoweringPass::runOnOperation() {

  // mlir::enableIRPrinting();
  // llvm::DebugFlag = true;
  mlir::LLVMConversionTarget target(getContext());
  target.addLegalOp<mlir::ModuleOp>();

  mlir::LLVMTypeConverter typeConverter(&getContext());
  mlir::RewritePatternSet patterns(&getContext());

  populateAffineToStdConversionPatterns(patterns);
  populateSCFToControlFlowConversionPatterns(patterns);
  mlir::arith::populateArithToLLVMConversionPatterns(typeConverter, patterns);

  mlir::memref::populateExpandStridedMetadataPatterns(patterns);
  mlir::populateFinalizeMemRefToLLVMConversionPatterns(typeConverter, patterns);
  mlir::cf::populateControlFlowToLLVMConversionPatterns(typeConverter,
                                                        patterns);
  populateFuncToLLVMConversionPatterns(typeConverter, patterns);

  patterns.add<engine::PrintOpLowering, engine::ReadOpLowering>(&getContext());

  auto module = getOperation();
  if (failed(applyFullConversion(module, target, std::move(patterns)))) {
    signalPassFailure();
  }
}



std::unique_ptr<mlir::Pass> engine::createLowerToLLVMPass() {
  return std::make_unique<EngineToLLVMLoweringPass>();
}
