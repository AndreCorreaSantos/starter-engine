include "mlir/IR/DialectBase.td"

def EngineDialect : Dialect {
    let name = "engine";
    let cppNamespace = "mlir::engine";
    let summary = "A custom dialect for inference engine operations.";
    let description = [{
        This dialect is designed to handle specific operations and types related to neural network inference computations.
    }];
}