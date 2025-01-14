#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"
#include "Engine/EnginePasses.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

class SettingsOpLowering : public mlir::OpRewritePattern<engine::SettingsOp> { // must read the declared value, set it in some sort of context/global variable and then delete the operation
  using OpRewritePattern<engine::SettingsOp>::OpRewritePattern;

  mlir::LogicalResult
  matchAndRewrite(engine::SettingsOp op,
                  mlir::PatternRewriter &rewriter) const final {
    auto attr = op.getValueAttr();
    if (!attr)
      return mlir::failure(); 

    int64_t intValue = attr.getInt();
    rewriter.eraseOp(op);
    return mlir::success();
  }
};

namespace {
class LowerSettingsPass
    : public mlir::PassWrapper<LowerSettingsPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:

  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerSettingsPass)
  
  void runOnOperation() final;
};
} // namespace

void LowerSettingsPass::runOnOperation() {
  mlir::ConversionTarget target(getContext());

  target.addIllegalOp<engine::SettingsOp>();

  mlir::RewritePatternSet patterns(&getContext());
  patterns.add<SettingsOpLowering>(&getContext());

  if (mlir::failed(mlir::applyPartialConversion(getOperation(), target,
                                                std::move(patterns)))) {
    signalPassFailure();
  }
}

std::unique_ptr<mlir::Pass> engine::createLowerSettingsPass () {
  return std::make_unique<LowerSettingsPass>();
}