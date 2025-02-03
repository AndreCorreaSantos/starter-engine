module {
  func.func @main() {

  "engine.settings"() { value = 1 : i32, type = 0 : i32 } : () -> ()
  %0 = "engine.constant"() {value = dense<[1, 2, 3]> : tensor<3xi32>} : () -> memref<3xi32>
  %1 = "engine.constant"() {value = dense<[1, 2, 3]> : tensor<3xi32>} : () -> memref<3xi32>
  %2 = "engine.add"(%0, %1) : (memref<3xi32>, memref<3xi32>) -> memref<3xi32>
  
  func.return
  }
}