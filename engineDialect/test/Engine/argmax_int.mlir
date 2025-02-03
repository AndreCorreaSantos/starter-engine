module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32, type = 0 : i32 } : () -> ()
  %1 = "engine.constant"() {value = dense<[-12, 4, 0, 0, -1, -4, -2, 0, 0, -3 ]> : tensor<10xi32>} : () -> memref<10xi32>
  %2 = "engine.argmax"(%1) : (memref<10xi32>) -> memref<i32>
  "engine.print"(%2) : (memref<i32>) -> ()
  
  func.return
  }
}