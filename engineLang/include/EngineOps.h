#ifndef ENGINE_OPS_H
#define ENGINE_OPS_H

// Include necessary MLIR headers
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Builders.h"

// Forward declaration of the EngineDialect
#include "EngineDialect.h"

// Include TableGen-generated operation declarations
#define GET_OP_DECLS
#include "EngineOps.h.inc"

#endif // ENGINE_OPS_H
