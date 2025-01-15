module {
  func.func @main() {

  "engine.settings"() { value = 1 : i32 } : () -> ()
  %0 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
  %1 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
  %2 = "engine.add"(%0, %1) : (memref<3xf64>, memref<3xf64>) -> memref<3xf64>
  
  func.return
  }
}