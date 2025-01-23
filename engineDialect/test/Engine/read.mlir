module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32, type = 0 : i32} : () -> ()
  %0 = "engine.read"() : () -> memref<3xi32>
  "engine.print"(%0) : (memref<3xi32>) -> ()
  
  func.return
  }
}