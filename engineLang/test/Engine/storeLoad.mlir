func.func @main() {
  // Create a tensor via "engine.constant"
  %tensor = "engine.constant"() 
            { value = dense<[[1.0, 2.0], [3.0, 4.0]]> : tensor<2x2xf64> } 
            : () -> tensor<2x2xf64>

//   // Print the tensor (the PrintOp can accept either tensor or memref)
//   "engine.print"(%tensor) : (tensor<2x2xf64>) -> ()

  // Store the tensor in a global memref
  "engine.store"(%tensor) { name = "my_tensor" } : (tensor<2x2xf64>) -> ()

  // Now load it back as a memref, rather than a tensor
  %loaded_memref = "engine.load"() { name = "my_tensor" }
                   : () -> memref<2x2xf64>

  // You can still print it directly, because the PrintOp definition
  // accepts "AnyTypeOf<[F64Tensor, F64MemRef]>" as input.
  "engine.print"(%loaded_memref) : (memref<2x2xf64>) -> ()

  return
}
