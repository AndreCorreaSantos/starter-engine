module {
  func.func @main() {
    %cst = arith.constant 3.000000e+00 : f64
    %cst_0 = arith.constant 2.000000e+00 : f64
    %cst_1 = arith.constant 1.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<3xf64>
    affine.store %cst_1, %alloc[%c0] : memref<3xf64>
    affine.store %cst_0, %alloc[%c1] : memref<3xf64>
    affine.store %cst, %alloc[%c2] : memref<3xf64>
    return
  }
}

