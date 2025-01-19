// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    "engine.settings"() { value = 1 : i32 } : () -> ()
    %0 = "engine.constant"() {value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>} : () -> memref<3x1xf64>
    %1 = "engine.constant"() {value = dense<[2.000000e+00]> : tensor<1xf64>} : () -> memref<1xf64>
    %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>
    
    // "engine.print"(%2) : (memref<f64>) -> ()
    return
}
// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.constant"() <{value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>}> : () -> memref<3x1xf64>
    %1 = "engine.constant"() <{value = dense<2.000000e+00> : tensor<1xf64>}> : () -> memref<1xf64>
    %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>
    return
  }
}


lowerSettings: 1
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<3x1xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc[%c0, %c0] : memref<3x1xf64>
    %cst_0 = arith.constant 2.000000e+00 : f64
    affine.store %cst_0, %alloc[%c1, %c0] : memref<3x1xf64>
    %cst_1 = arith.constant 3.000000e+00 : f64
    affine.store %cst_1, %alloc[%c2, %c0] : memref<3x1xf64>
    %alloc_2 = memref.alloc() : memref<1xf64>
    %c0_3 = arith.constant 0 : index
    %cst_4 = arith.constant 2.000000e+00 : f64
    affine.store %cst_4, %alloc_2[%c0_3] : memref<1xf64>
    %alloc_5 = memref.alloc() : memref<3xf64>
    linalg.matvec ins(%alloc, %alloc_2 : memref<3x1xf64>, memref<1xf64>) outs(%alloc_5 : memref<3xf64>)
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %c3 = arith.constant 3 : index
    %cst = arith.constant 3.000000e+00 : f64
    %cst_0 = arith.constant 2.000000e+00 : f64
    %cst_1 = arith.constant 1.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<3x1xf64>
    affine.store %cst_1, %alloc[%c0, %c0] : memref<3x1xf64>
    affine.store %cst_0, %alloc[%c1, %c0] : memref<3x1xf64>
    affine.store %cst, %alloc[%c2, %c0] : memref<3x1xf64>
    %alloc_2 = memref.alloc() : memref<1xf64>
    affine.store %cst_0, %alloc_2[%c0] : memref<1xf64>
    %alloc_3 = memref.alloc() : memref<3xf64>
    scf.for %arg0 = %c0 to %c3 step %c1 {
      scf.for %arg1 = %c0 to %c1 step %c1 {
        %0 = memref.load %alloc[%arg0, %arg1] : memref<3x1xf64>
        %1 = memref.load %alloc_2[%arg1] : memref<1xf64>
        %2 = memref.load %alloc_3[%arg0] : memref<3xf64>
        %3 = arith.mulf %0, %1 : f64
        %4 = arith.addf %2, %3 : f64
        memref.store %4, %alloc_3[%arg0] : memref<3xf64>
      }
    }
    return
  }
}


lli: lli: outputs/dot.ll:1:8: error: expected 'module asm'
module {
       ^

