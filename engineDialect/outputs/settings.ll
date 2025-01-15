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

