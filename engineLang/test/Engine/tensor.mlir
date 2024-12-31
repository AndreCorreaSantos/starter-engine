

module {


  func.func @main() -> tensor<3xf64>{
    %result = tensor.empty() : tensor<3xf64>
    // "engine.print"(%result) : (tensor<3xf64>) -> ()
    return %result : tensor<3xf64>
  }
  
}