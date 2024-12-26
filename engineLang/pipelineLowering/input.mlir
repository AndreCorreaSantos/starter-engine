module {
  func.func @main() -> tensor<3xf32> {
    %cst = arith.constant 1.0 : f32
    %tensor = tensor.from_elements %cst, %cst, %cst : tensor<3xf32>
    %result_tensor = tensor.empty() : tensor<3xf32>
    
    linalg.sqrt ins(%tensor : tensor<3xf32>) outs(%result_tensor : tensor<3xf32>)
    return %result_tensor : tensor<3xf32>
  }
}
