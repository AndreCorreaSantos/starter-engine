#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"
#include "Engine/EnginePasses.h"
#include "mlir/Dialect/Linalg/Transforms/Transforms.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Linalg/Passes.h"
#include "mlir/Transforms/DialectConversion.h"

#include "mlir/Pass/PassManager.h"


namespace{
class LowerLinalgPass
    : public mlir::PassWrapper<LowerLinalgPass, mlir::OperationPass<mlir::ModuleOp>> {
public:
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerLinalgPass)

  void getDependentDialects(mlir::DialectRegistry &registry) const override {
    registry.insert<mlir::affine::AffineDialect,
                    mlir::func::FuncDialect,
                    mlir::memref::MemRefDialect,
                    mlir::arith::ArithDialect,
                    mlir::linalg::LinalgDialect,
                    mlir::scf::SCFDialect,
                    mlir::bufferization::BufferizationDialect>();
  }


    void runOnOperation() final;
};
}//namespace

  void LowerLinalgPass::runOnOperation() {
    mlir::ConversionTarget target(getContext());
    target.addLegalDialect<mlir::affine::AffineDialect,
                           mlir::func::FuncDialect,
                           mlir::memref::MemRefDialect,
                           mlir::arith::ArithDialect,
                           mlir::scf::SCFDialect>();
    target.addLegalDialect<engine::EngineDialect>();
    target.addIllegalDialect<mlir::linalg::LinalgDialect>();

    mlir::OpPassManager pm("builtin.module"); // Revise this, gpt spewed it seems very wrong
    pm.addPass(mlir::createConvertLinalgToLoopsPass());

    if (mlir::failed(runPipeline(pm, getOperation()))) {
      signalPassFailure();
    }
  }

std::unique_ptr<mlir::Pass> engine::createLowerLinalgPass() {
  return std::make_unique<LowerLinalgPass>();
}

