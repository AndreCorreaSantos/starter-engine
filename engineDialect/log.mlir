func.func @main() {
    "engine.settings"() { value = 1 : i32 } : () -> ()
    %fc3.bias = "engine.constant"() {value=dense<[-0.2, 0.3, 0.1, -0.1, -0.1, 0.1, -0.0, -0.0, -0.1, 0.0]>:tensor<10xf64>} : () -> memref<10xf64>
    return
}
// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.constant"() <{value = dense<[-2.000000e-01, 3.000000e-01, 1.000000e-01, -1.000000e-01, -1.000000e-01, 1.000000e-01, -0.000000e+00, -0.000000e+00, -1.000000e-01, 0.000000e+00]> : tensor<10xf64>}> : () -> memref<10xf64>
    return
  }
}


// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<10xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %c5 = arith.constant 5 : index
    %c6 = arith.constant 6 : index
    %c7 = arith.constant 7 : index
    %c8 = arith.constant 8 : index
    %c9 = arith.constant 9 : index
    %cst = arith.constant -2.000000e-01 : f64
    affine.store %cst, %alloc[%c0] : memref<10xf64>
    %cst_0 = arith.constant 3.000000e-01 : f64
    affine.store %cst_0, %alloc[%c1] : memref<10xf64>
    %cst_1 = arith.constant 1.000000e-01 : f64
    affine.store %cst_1, %alloc[%c2] : memref<10xf64>
    %cst_2 = arith.constant -1.000000e-01 : f64
    affine.store %cst_2, %alloc[%c3] : memref<10xf64>
    %cst_3 = arith.constant -1.000000e-01 : f64
    affine.store %cst_3, %alloc[%c4] : memref<10xf64>
    %cst_4 = arith.constant 1.000000e-01 : f64
    affine.store %cst_4, %alloc[%c5] : memref<10xf64>
    %cst_5 = arith.constant -0.000000e+00 : f64
    affine.store %cst_5, %alloc[%c6] : memref<10xf64>
    %cst_6 = arith.constant -0.000000e+00 : f64
    affine.store %cst_6, %alloc[%c7] : memref<10xf64>
    %cst_7 = arith.constant -1.000000e-01 : f64
    affine.store %cst_7, %alloc[%c8] : memref<10xf64>
    %cst_8 = arith.constant 0.000000e+00 : f64
    affine.store %cst_8, %alloc[%c9] : memref<10xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant -0.000000e+00 : f64
    %cst_1 = arith.constant -1.000000e-01 : f64
    %cst_2 = arith.constant 1.000000e-01 : f64
    %cst_3 = arith.constant 3.000000e-01 : f64
    %cst_4 = arith.constant -2.000000e-01 : f64
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<10xf64>
    affine.store %cst_4, %alloc[%c0] : memref<10xf64>
    affine.store %cst_3, %alloc[%c1] : memref<10xf64>
    affine.store %cst_2, %alloc[%c2] : memref<10xf64>
    affine.store %cst_1, %alloc[%c3] : memref<10xf64>
    affine.store %cst_1, %alloc[%c4] : memref<10xf64>
    affine.store %cst_2, %alloc[%c5] : memref<10xf64>
    affine.store %cst_0, %alloc[%c6] : memref<10xf64>
    affine.store %cst_0, %alloc[%c7] : memref<10xf64>
    affine.store %cst_1, %alloc[%c8] : memref<10xf64>
    affine.store %cst, %alloc[%c9] : memref<10xf64>
    return
  }
}


lli: lli: outputs/settings.ll:1:8: error: expected 'module asm'
module {
       ^

