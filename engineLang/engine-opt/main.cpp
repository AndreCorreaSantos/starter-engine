#include "mlir/IR/Dialect.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/MlirOptMain.h"

#include "EngineDialect.h"

using namespace mlir;
using namespace mlir::engine;

int main(int argc, char **argv) {
  DialectRegistry registry;
  registry.insert<EngineDialect>();
  return failed(MlirOptMain(argc, argv, "Engine Dialect Driver", registry));
}
