#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"
#include "Engine/EnginePasses.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

class SettingsOpLowering : public mlir::OpRewritePattern<engine::SettingsOp> {
public:
  // Add constructor that takes the reference
  SettingsOpLowering(mlir::MLIRContext *ctx, int64_t &settings) 
    : OpRewritePattern<engine::SettingsOp>(ctx), lowerSettings(settings) {}

  mlir::LogicalResult
  matchAndRewrite(engine::SettingsOp op,
                 mlir::PatternRewriter &rewriter) const final {
    auto attr = op.getValueAttr();
    if (!attr)
      return mlir::failure();
    lowerSettings = attr.getInt();  // Now this will work because we have the reference
    rewriter.eraseOp(op);
    return mlir::success();
  }
private:
  int64_t &lowerSettings;  // Store the reference
};

namespace {
class LowerSettingsPass
    : public mlir::PassWrapper<LowerSettingsPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:
  explicit LowerSettingsPass(int64_t &lowerSettings) : lowerSettings(lowerSettings) {} // creating a reference to the passed variable
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerSettingsPass)
  
  void runOnOperation() final;
private:
  int64_t &lowerSettings;
};

} // namespace

void LowerSettingsPass::runOnOperation() {
  mlir::ConversionTarget target(getContext());

  target.addIllegalOp<engine::SettingsOp>();

  mlir::RewritePatternSet patterns(&getContext());
  patterns.add<SettingsOpLowering>(&getContext(), lowerSettings);
  if (mlir::failed(mlir::applyPartialConversion(getOperation(), target,
                                                std::move(patterns)))) {
    signalPassFailure();
  }
}

std::unique_ptr<mlir::Pass> engine::createLowerSettingsPass (int64_t &lowerSettings) {
  return std::make_unique<LowerSettingsPass>(lowerSettings);
}