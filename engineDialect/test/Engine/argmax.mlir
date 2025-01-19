module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32 } : () -> ()
  %1 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
  %2 = "engine.argmax"(%1) : (memref<3xf64>) -> memref<f64>
  "engine.print"(%2) : (memref<f64>) -> ()
  
  func.return
  }
}