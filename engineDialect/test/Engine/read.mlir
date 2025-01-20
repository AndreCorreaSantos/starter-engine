module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32 } : () -> ()
  %0 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%0) : (memref<3xf64>) -> ()
  
  func.return
  }
}