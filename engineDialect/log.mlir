
%0 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
%1 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
%2 = "engine.add"(%0, %1) : (memref<3xf64>, memref<3xf64>) -> memref<3xf64>
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  %alloc = memref.alloc() : memref<3xf64>
  %alloc_0 = memref.alloc() : memref<3xf64>
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %cst = arith.constant 1.000000e+00 : f64
  affine.store %cst, %alloc_0[%c0] : memref<3xf64>
  %cst_1 = arith.constant 2.000000e+00 : f64
  affine.store %cst_1, %alloc_0[%c1] : memref<3xf64>
  %cst_2 = arith.constant 3.000000e+00 : f64
  affine.store %cst_2, %alloc_0[%c2] : memref<3xf64>
  %c0_3 = arith.constant 0 : index
  %c1_4 = arith.constant 1 : index
  %c2_5 = arith.constant 2 : index
  %cst_6 = arith.constant 1.000000e+00 : f64
  affine.store %cst_6, %alloc[%c0_3] : memref<3xf64>
  %cst_7 = arith.constant 2.000000e+00 : f64
  affine.store %cst_7, %alloc[%c1_4] : memref<3xf64>
  %cst_8 = arith.constant 3.000000e+00 : f64
  affine.store %cst_8, %alloc[%c2_5] : memref<3xf64>
  memref.dealloc %alloc_0 : memref<3xf64>
  memref.dealloc %alloc : memref<3xf64>
  %alloc_9 = memref.alloc() : memref<3xf64>
  linalg.add ins(%alloc_0, %alloc : memref<3xf64>, memref<3xf64>) outs(%alloc_9 : memref<3xf64>)
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  %c3 = arith.constant 3 : index
  %cst = arith.constant 3.000000e+00 : f64
  %cst_0 = arith.constant 2.000000e+00 : f64
  %cst_1 = arith.constant 1.000000e+00 : f64
  %c2 = arith.constant 2 : index
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %alloc = memref.alloc() : memref<3xf64>
  %alloc_2 = memref.alloc() : memref<3xf64>
  affine.store %cst_1, %alloc_2[%c0] : memref<3xf64>
  affine.store %cst_0, %alloc_2[%c1] : memref<3xf64>
  affine.store %cst, %alloc_2[%c2] : memref<3xf64>
  affine.store %cst_1, %alloc[%c0] : memref<3xf64>
  affine.store %cst_0, %alloc[%c1] : memref<3xf64>
  affine.store %cst, %alloc[%c2] : memref<3xf64>
  memref.dealloc %alloc_2 : memref<3xf64>
  memref.dealloc %alloc : memref<3xf64>
  %alloc_3 = memref.alloc() : memref<3xf64>
  scf.for %arg0 = %c0 to %c3 step %c1 {
    %0 = memref.load %alloc_2[%arg0] : memref<3xf64>
    %1 = memref.load %alloc[%arg0] : memref<3xf64>
    %2 = arith.addf %0, %1 : f64
    memref.store %2, %alloc_3[%arg0] : memref<3xf64>
  }
}


lli: lli: outputs/verilog_convert.ll:1:8: error: expected 'module asm'
module {
       ^

