#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"
#include "Engine/EnginePasses.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

class SettingsOpLowering : public mlir::OpRewritePattern<engine::SettingsOp> {
public:
  // Add constructor that takes the reference
  SettingsOpLowering(mlir::MLIRContext *ctx, engine::settingsInfo &settings) 
    : OpRewritePattern<engine::SettingsOp>(ctx), settings(settings) {}

  mlir::LogicalResult
  matchAndRewrite(engine::SettingsOp op,
                 mlir::PatternRewriter &rewriter) const final {
    auto attr = op.getValueAttr();
    if (!attr)
      return mlir::failure();
    settings.lowerSettings = attr.getInt();  // Now this will work because we have the reference
    rewriter.eraseOp(op);
    return mlir::success();
  }
private:
  engine::settingsInfo &settings;  // Store the reference
};

namespace {
class LowerSettingsPass
    : public mlir::PassWrapper<LowerSettingsPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:
  explicit LowerSettingsPass(engine::settingsInfo &settings) : settings(settings) {} // creating a reference to the passed variable
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerSettingsPass)
  
  void runOnOperation() final;
private:
  engine::settingsInfo &settings;
};

} // namespace

void LowerSettingsPass::runOnOperation() {
  mlir::ConversionTarget target(getContext());

  target.addIllegalOp<engine::SettingsOp>();

  mlir::RewritePatternSet patterns(&getContext());
  patterns.add<SettingsOpLowering>(&getContext(), settings);
  if (mlir::failed(mlir::applyPartialConversion(getOperation(), target,
                                                std::move(patterns)))) {
    signalPassFailure();
  }
}

namespace engine {
std::unique_ptr<mlir::Pass> createLowerSettingsPass (settingsInfo &settings) {
  return std::make_unique<LowerSettingsPass>(settings);
}
}