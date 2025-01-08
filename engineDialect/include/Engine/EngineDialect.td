#ifndef ENGINE_DIALECT
#define ENGINE_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Engine dialect definition.
//===----------------------------------------------------------------------===//

def Engine_Dialect : Dialect {
    let name = "engine";
    let summary = "basic out-of-tree MLIR dialect.";
    let description = [{
        This dialect is minimal example to implement hello-world kind of sample code
        for MLIR.
    }];
    let cppNamespace = "::engine";
    let hasConstantMaterializer = 1;
}

//===----------------------------------------------------------------------===//
// Base engine operation definition.
//===----------------------------------------------------------------------===//

class Engine_Op<string mnemonic, list<Trait> traits = []> :
        Op<Engine_Dialect, mnemonic, traits>;

#endif // ENGINE_DIALECT
