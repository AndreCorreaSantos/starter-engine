module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32, type = 0 : i32 } : () -> ()
  %1 = "engine.constant"() {value = dense<[-12.922800, 4.829700, -0.579300, -0.766400, -1.762400, -4.013700, -2.125800, -0.255400, -0.505000, -3.928800 ]> : tensor<10xf64>} : () -> memref<10xf64>
  %2 = "engine.argmax"(%1) : (memref<10xf64>) -> memref<i32>
  "engine.print"(%2) : (memref<i32>) -> ()
  
  func.return
  }
}