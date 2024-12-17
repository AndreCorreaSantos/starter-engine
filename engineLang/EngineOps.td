// EngineOps.td
#ifndef ENGINE_OPS
#define ENGINE_OPS

include "mlir/IR/OpBase.td"
// include "EngineDialect.td"

def Engine_Dialect : Dialect {
  let name = "engine";
  let cppNamespace = "::mlir::engine";
}

class Engine_Op<string mnemonic, list<Trait> traits = []> :
    Op<Engine_Dialect, mnemonic, traits>;


def AddOp : Engine_Op<"add"> {
  let summary = "element-wise addition operation";
  let description = [{
    The "add" operation performs element-wise addition between two tensors.
    The shapes of the tensor operands are expected to match.
  }];

  let arguments = (ins F64Tensor:$lhs, F64Tensor:$rhs);
  let results = (outs F64Tensor);

  // Indicate that the operation has a custom parser and printer method.
  let hasCustomAssemblyFormat = 1;

  // Allow building an AddOp with from the two input operands.
  let builders = [
    OpBuilder<(ins "Value":$lhs, "Value":$rhs)>
  ];
}
#endif // ENGINE_OPS