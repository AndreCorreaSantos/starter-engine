#ifndef ENGINE_OPS_H
#define ENGINE_OPS_H

#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpDefinition.h"

namespace mlir {
namespace engine {

#include "EngineOps.h.inc"

} // namespace engine
} // namespace mlir

#endif // ENGINE_OPS_H