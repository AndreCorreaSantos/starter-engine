#ifndef ENGINE_OPS
#define ENGINE_OPS

include "EngineDialect.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def ConstantOp : Engine_Op<"constant"> {
  let summary = "constant";
  let description = [{
    Constant operation turns a literal into an SSA value. The data is attached
    to the operation as an attribute. For example:
    ```mlir
    // Float example
    %0 = "engine.constant"()
    { value = dense<[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]> : tensor<2x3xf64> }
    : () -> memref<2x3xf64>
    
    // Integer example
    %1 = "engine.constant"()
    { value = dense<[[1, 2, 3], [4, 5, 6]]> : tensor<2x3xi64> }
    : () -> memref<2x3xi64>
    ```
  }];

  let builders = [
    // For dense tensors (both float and int)
    OpBuilder<(ins "mlir::DenseElementsAttr":$value), [{
      build($_builder, $_state, value.getType(), value);
    }]>,
    // For single float value
    OpBuilder<(ins "double":$value)>,
    // For single integer value
    OpBuilder<(ins "int32_t":$value)>
  ];

  // Use ElementsAttr which can handle both types
  let arguments = (ins ElementsAttr:$value);
  
  // Use AnyMemRef or you might want to be more specific with a constraint
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
  
}

def PrintOp : Engine_Op<"print"> {
    let summary = "print operation";
    let description = [{
        The "print" builtin operation prints a given input tensor, and produces
        no results.
    }];

    // The print operation takes an input tensor to print.
    let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$input);

    let assemblyFormat = "$input attr-dict `:` type($input)";
}

def ReadOp : Engine_Op<"read"> {
  let summary = "read operation";
  let description = [{
    The "read" operation reads a tensor from stdin.
  }];
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>:$output);
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
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$lhs, AnyTypeOf<[F64MemRef, I32MemRef]>:$rhs);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}

def MulOp : Engine_Op<"mul">{
  let summary = "multiplies two tensors";
  let description = [{
    The "mul" operation multiplies two tensors.
  }];
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$lhs, AnyTypeOf<[F64MemRef, I32MemRef]>:$rhs);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}

def DotOp : Engine_Op<"dot">{
  let summary = "returns the dot product of two tensors";
  let description = [{
    the dot operation calculates the dot product between two tensors, it is a wrapper on the linalg dialect.
  }];
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$lhs, AnyTypeOf<[F64MemRef, I32MemRef]>:$rhs);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}


def MatmulOp : Engine_Op<"matmul">{
  let summary = "returns the matrix multiplication of two tensors";
  let description = [{
    the matmul operation calculates the matrix multiplication between two tensors, it is a wrapper on the linalg dialect.
  }];
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$lhs, AnyTypeOf<[F64MemRef, I32MemRef]>:$rhs);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}

def ReLUOp : Engine_Op<"relu">{
  let summary = "Applies the ReLU function to a tensor";
  let description = [{
    The ReLU operation applies the ReLU function to a tensor.
  }];
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$value);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}


def FlattenOp : Engine_Op<"flatten">{
  let summary = "Flattens a tensor";
  let description = [{
    The Flatten operation flattens a tensor.
  }];
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$value);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}

def ArgMaxOp : Engine_Op<"argmax">{
  let summary = "Returns the index of the maximum value in a tensor";
  let description = [{
    The ArgMax operation returns the index of the maximum value in a tensor.
  }];
  let arguments = (ins AnyTypeOf<[F64MemRef, I32MemRef]>:$value);
  let results = (outs AnyTypeOf<[F64MemRef, I32MemRef]>);
}

def SettingsOp: Engine_Op<"settings"> {
  let summary = "sets engine lowering settings";
  let description = [{
    The "set" operation sets engine lowering settings.
    Binary, 0 = lowers to llvm,
    1 = lowers to fpga.
  }];
  let arguments = (ins I32Attr:$value, I32Attr:$type);
}




#endif // HELLO_OPS
