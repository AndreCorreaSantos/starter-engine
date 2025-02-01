#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"
#include "Engine/EnginePasses.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

#include "mlir/Conversion/ArithToSPIRV/ArithToSPIRV.h"
#include "mlir/Conversion/SCFToSPIRV/SCFToSPIRV.h"
#include "mlir/Conversion/FuncToSPIRV/FuncToSPIRV.h"
#include "mlir/Conversion/MemRefToSPIRV/MemRefToSPIRV.h"

#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"

#include "mlir/Dialect/SPIRV/IR/SPIRVDialect.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/SPIRV/IR/SPIRVTypes.h"
#include "mlir/Dialect/SPIRV/Transforms/SPIRVConversion.h"




namespace {
class LowerToSPIRPass
    : public mlir::PassWrapper<LowerToSPIRPass,
                               mlir::OperationPass<mlir::ModuleOp>> {
public:
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerToSPIRPass)
  void getDependentDialects(mlir::DialectRegistry &registry) const override {
    registry.insert<mlir::spirv::SPIRVDialect, mlir::scf::SCFDialect,
                    mlir::cf::ControlFlowDialect>();
  }
  
  void runOnOperation() final;
};

} // namespace

void LowerToSPIRPass::runOnOperation() {
    mlir::MLIRContext* context = &getContext();
    mlir::ConversionTarget target(*context);

    mlir::spirv::Version version = mlir::spirv::Version::V_1_3; // COME BACK HERE LATER, NEED TO FIND OUT HOW TO WRITE THIS TO RUN ON IREE.
    llvm::SmallVector<mlir::spirv::Capability> caps = {
        mlir::spirv::Capability::Shader,
        mlir::spirv::Capability::Float64,
        mlir::spirv::Capability::Int64,
        mlir::spirv::Capability::Addresses
    };
    llvm::SmallVector<mlir::spirv::Extension> exts;
    
    auto verCapExt = mlir::spirv::VerCapExtAttr::get(
        version, caps, exts, context
    );
    auto resourceLimits = mlir::spirv::getDefaultResourceLimits(context);

    auto spirvTarget = mlir::spirv::TargetEnvAttr::get(
            verCapExt,                      
            resourceLimits,                
            mlir::spirv::ClientAPI::Vulkan, // HARDCODED FOR NOW, SHOULD BE DETECTED OR SET LATER 
            mlir::spirv::Vendor::NVIDIA,    
            mlir::spirv::DeviceType::DiscreteGPU, 
            0x10DE                          
        );

    mlir::SPIRVConversionOptions options;
    options.use64bitIndex = sizeof(size_t) == 8;
    mlir::SPIRVTypeConverter typeConverter(spirvTarget, options);
    target.addLegalOp<mlir::ModuleOp>();
    target.addLegalDialect<mlir::spirv::SPIRVDialect>();

    target.addIllegalDialect<mlir::arith::ArithDialect>();
    target.addIllegalDialect<mlir::memref::MemRefDialect>();
    target.addIllegalDialect<mlir::scf::SCFDialect>();

    mlir::RewritePatternSet patterns(context);
    
    mlir::populateAffineToStdConversionPatterns(patterns);
    mlir::populateFuncToSPIRVPatterns(typeConverter, patterns);
    mlir::arith::populateArithToSPIRVPatterns(typeConverter, patterns);
    mlir::populateMemRefToSPIRVPatterns(typeConverter, patterns);
    
    mlir::ScfToSPIRVContext scfContext;
    mlir::populateSCFToSPIRVPatterns(typeConverter, scfContext, patterns);

    if (mlir::failed(mlir::applyFullConversion(getOperation(), target, std::move(patterns)))) {
        signalPassFailure();
    }
}

namespace engine {
std::unique_ptr<mlir::Pass> createLowerToSPIRPass () {
  return std::make_unique<LowerToSPIRPass>();
}
}