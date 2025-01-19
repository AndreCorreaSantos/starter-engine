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

