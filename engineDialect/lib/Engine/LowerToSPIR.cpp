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
    : public mlir::PassWrapper<LowerToSPIRPass, mlir::OperationPass<mlir::ModuleOp>> {
public:
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerToSPIRPass)

  void getDependentDialects(mlir::DialectRegistry &registry) const override {
    registry.insert<mlir::spirv::SPIRVDialect, mlir::scf::SCFDialect,
                   mlir::cf::ControlFlowDialect, mlir::memref::MemRefDialect,
                   mlir::func::FuncDialect>();
  }

  void runOnOperation() final;
};
} // namespace

void LowerToSPIRPass::runOnOperation() {
  mlir::MLIRContext* context = &getContext();
  mlir::ModuleOp module = getOperation();

  // Configure SPIR-V conversion target
  mlir::ConversionTarget target(*context);
  mlir::spirv::Version version = mlir::spirv::Version::V_1_3;
  
  // Add required capabilities for memory operations
  llvm::SmallVector<mlir::spirv::Capability, 6> caps{
    mlir::spirv::Capability::Shader,
    mlir::spirv::Capability::Float64,
    mlir::spirv::Capability::Int64,
    mlir::spirv::Capability::Addresses,
    mlir::spirv::Capability::PhysicalStorageBufferAddresses,
    mlir::spirv::Capability::VariablePointers
  };

  llvm::SmallVector<mlir::spirv::Extension> exts;
  auto verCapExt = mlir::spirv::VerCapExtAttr::get(version, caps, exts, context);
  auto resourceLimits = mlir::spirv::getDefaultResourceLimits(context);
  
  auto spirvTarget = mlir::spirv::TargetEnvAttr::get(
    verCapExt,
    resourceLimits,
    mlir::spirv::ClientAPI::Vulkan,
    mlir::spirv::Vendor::NVIDIA,
    mlir::spirv::DeviceType::DiscreteGPU,
    0x10DE
  );

  // Configure conversion options
  mlir::SPIRVConversionOptions options;
  options.use64bitIndex = true;
  options.emulateLT32BitScalarTypes = true;
  
  // Set up type converter
  mlir::SPIRVTypeConverter typeConverter(spirvTarget, options);

  // Set up conversion target
  target.addLegalOp<mlir::ModuleOp>();
  target.addLegalDialect<mlir::spirv::SPIRVDialect>();
  
  // Mark all other dialects as illegal to ensure full conversion
  target.addIllegalDialect<mlir::arith::ArithDialect,
                          mlir::memref::MemRefDialect,
                          mlir::scf::SCFDialect,
                          mlir::func::FuncDialect>();

  // Set up conversion patterns
  mlir::RewritePatternSet patterns(context);

  // Add all necessary conversion patterns
  mlir::populateAffineToStdConversionPatterns(patterns);
  mlir::populateMemRefToSPIRVPatterns(typeConverter, patterns);
  mlir::arith::populateArithToSPIRVPatterns(typeConverter, patterns);
  mlir::populateFuncToSPIRVPatterns(typeConverter, patterns);
  
  mlir::ScfToSPIRVContext scfContext;
  mlir::populateSCFToSPIRVPatterns(typeConverter, scfContext, patterns);

  // Apply the conversion
  if (mlir::failed(mlir::applyFullConversion(getOperation(), target, std::move(patterns)))) {
    signalPassFailure();
  }
}

namespace engine {
std::unique_ptr<mlir::Pass> createLowerToSPIRPass() {
  return std::make_unique<LowerToSPIRPass>();
}
}