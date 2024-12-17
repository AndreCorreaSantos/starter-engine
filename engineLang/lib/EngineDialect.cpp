#include "EngineDialect.h"
#include "EngineOps.h.inc"

using namespace mlir;
using namespace mlir::engine;

EngineDialect::EngineDialect(MLIRContext *context) : Dialect(getDialectNamespace(), context) {
  addOperations<
#define GET_OP_LIST
#include "EngineOps.cpp.inc"
  >();
}
