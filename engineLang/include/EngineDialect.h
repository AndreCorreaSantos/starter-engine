#ifndef ENGINE_DIALECT_H
#define ENGINE_DIALECT_H

#include "mlir/IR/Dialect.h"

namespace mlir {
namespace engine {

class EngineDialect : public Dialect {
public:
  explicit EngineDialect(MLIRContext *context);
  static StringRef getDialectNamespace() { return "engine"; }
};

#define GET_OP_DECLS
#include "EngineOps.h.inc"

} // namespace engine
} // namespace mlir

#endif // ENGINE_DIALECT_H
