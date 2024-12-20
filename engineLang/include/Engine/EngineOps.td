#ifndef ENGINE_OPS
#define ENGINE_OPS

include "EngineDialect.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def ConstantOp : Engine_Op<"constant", [Pure]> {
  let summary = "constant";
  let description = [{
    Constant operation turns a literal into an SSA value. The data is attached
    to the operation as an attribute. For example:

    ```mlir
      %0 = "engine.constant"()
      { value = dense<[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]> : tensor<2x3xf64> }
      : () -> tensor<2x3xf64> 
    ```
  }];

  let builders = [
    OpBuilder<(ins "mlir::DenseElementsAttr":$value), [{
      build($_builder, $_state, value.getType(), value);
    }]>,
    OpBuilder<(ins "double":$value)>
  ];

//  let parser = [{ return ::parseConstantOp(parser, result); }];
  let arguments = (ins F64ElementsAttr:$value);
  let results = (outs F64Tensor);
}

def PrintOp : Engine_Op<"print", [Pure]> {
    let summary = "print operation";
    let description = [{
        The "print" builtin operation prints a given input tensor, and produces
        no results.
    }];

    // The print operation takes an input tensor to print.
    let arguments = (ins AnyTypeOf<[F64Tensor, F64MemRef]>:$input);

    let assemblyFormat = "$input attr-dict `:` type($input)";
}

def WorldOp : Engine_Op<"world", [Pure]> {
    let summary = "print Hello, World";
    let description = [{
        The "world" operation prints "Hello, World", and produces
        no results.
    }];
}

def AddOp : Engine_Op<"add"> {
  let summary = "adds two tensors";
  let description = [{
    The "add" operation adds two tensors element-wise.
  }];
  let arguments = (ins AnyTypeOf<[F64Tensor, F64MemRef]>:$lhs, AnyTypeOf<[F64Tensor, F64MemRef]>:$rhs);
  let results = (outs F64Tensor);
}

def MulOp : Engine_Op<"mul">{
  let summary = "multiplies two tensors";
  let description = [{
    The "mul" operation multiplies two tensors.
  }];
  let arguments = (ins AnyTypeOf<[F64Tensor, F64MemRef]>:$lhs, AnyTypeOf<[F64Tensor, F64MemRef]>:$rhs);
  let results = (outs F64Tensor);
}

#endif // HELLO_OPS
