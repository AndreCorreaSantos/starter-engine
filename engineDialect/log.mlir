module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32 } : () -> ()
  %0 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%0) : (memref<3xf64>) -> ()
  
  func.return
  }
}// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


lowerSettings: 0
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


loc("./test/Engine/read.mlir":5:8): error: failed to legalize operation 'engine.read'
// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass Failed () //----- //
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


lli: Symbols not found: [ main ]
