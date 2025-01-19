module {
  func.func @main() {
    %c3 = arith.constant 3 : index
    %cst = arith.constant 3 : i64
    %cst_0 = arith.constant 2 : i64
    %cst_1 = arith.constant 1 : i64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<3xi64>
    affine.store %cst_1, %alloc[%c0] : memref<3xi64>
    affine.store %cst_0, %alloc[%c1] : memref<3xi64>
    affine.store %cst, %alloc[%c2] : memref<3xi64>
    %alloc_2 = memref.alloc() : memref<3xi64>
    affine.store %cst_1, %alloc_2[%c0] : memref<3xi64>
    affine.store %cst_0, %alloc_2[%c1] : memref<3xi64>
    affine.store %cst, %alloc_2[%c2] : memref<3xi64>
    %alloc_3 = memref.alloc() : memref<3xi64>
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c3 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %2 = memref.load %alloc[%0] : memref<3xi64>
    %3 = memref.load %alloc_2[%0] : memref<3xi64>
    %4 = arith.addi %2, %3 : i64
    memref.store %4, %alloc_3[%0] : memref<3xi64>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
}