#ifndef ENGINE_OPS
#define ENGINE_OPS

include "EngineDialect.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def ConstantOp : Engine_Op<"constant"> { // NEED TO FIND OUT HOW TO CREATE ONE OF THESE FOR INTEGERS.
  let summary = "constant";
  let description = [{
    Constant operation turns a literal into an SSA value. The data is attached
    to the operation as an attribute. For example:

    ```mlir
      %0 = "engine.constant"()
      { value = dense<[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]> : tensor<2x3xf64> }
      : () -> memref<2x3xf64> 
    ```
  }];

  let builders = [
    OpBuilder<(ins "mlir::DenseElementsAttr":$value), [{
      build($_builder, $_state, value.getType(), value);
    }]>,
    OpBuilder<(ins "double":$value)>
  ];

  let arguments = (ins F64ElementsAttr:$value);
  let results = (outs F64MemRef);
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


def StoreOp : Engine_Op<"store"> {
  let summary = "stores a tensor under a name in the cache";
  let description = [{
    The "store" operation stores a tensor under a name in the cache.
    
    Example:
      %0 = ... : tensor<4x4xf64>
      engine.store %0, "matrix_a" : tensor<4x4xf64>
  }];
  
  let arguments = (ins 
    AnyTypeOf<[F64Tensor, F64MemRef, I32MemRef]>:$value,
    StrAttr:$name
  );
  
  let results = (outs);
  
  // Assembly format showing both the value and name
  let assemblyFormat = "$value `,` $name attr-dict `:` type($value)";
}



def LoadOp : Engine_Op<"load"> {
  let summary = "loads a tensor from the cache";
  let description = [{
    The "load" operation loads a tensor from the cache.
  }];

  let arguments = (ins StrAttr:$name);
  let results = (outs AnyTypeOf<[F64Tensor, F64MemRef]>:$result);

  // Corrected assembly format
  let assemblyFormat = "$name attr-dict `:` type($result)";
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
