  %53 = llvm.insertvalue %51, %52[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %54 = llvm.insertvalue %51, %53[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %55 = llvm.mlir.constant(0 : index) : i64
    %56 = llvm.insertvalue %55, %54[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %57 = llvm.insertvalue %46, %56[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %58 = llvm.insertvalue %47, %57[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %59 = builtin.unrealized_conversion_cast %58 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    linalg.add ins(%13, %27 : memref<3xf64>, memref<3xf64>) outs(%59 : memref<3xf64>)
    llvm.return %58 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.call @add() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @nl : !llvm.ptr
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.getelementptr %4[%5, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.mlir.constant(3 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%7 : i64)
  ^bb1(%10: i64):  // 2 preds: ^bb0, ^bb2
    %11 = llvm.icmp "slt" %10, %8 : i64
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %12 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.getelementptr %12[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %14 = llvm.load %13 : !llvm.ptr -> f64
    %15 = llvm.call @printf(%3, %14) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %16 = llvm.add %10, %9 : i64
    llvm.br ^bb1(%16 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @add() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.mlir.constant(3 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %10 = llvm.call @malloc(%9) : (i64) -> !llvm.ptr
    %11 = llvm.insertvalue %10, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %3, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %5, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %6, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    %17 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.call @malloc(%18) : (i64) -> !llvm.ptr
    %20 = llvm.insertvalue %19, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %19, %20[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %3, %21[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %5, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %6, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    llvm.store %2, %10 : f64, !llvm.ptr
    %26 = llvm.getelementptr %10[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %26 : f64, !llvm.ptr
    %27 = llvm.getelementptr %10[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %27 : f64, !llvm.ptr
    llvm.store %2, %19 : f64, !llvm.ptr
    %28 = llvm.getelementptr %19[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %28 : f64, !llvm.ptr
    %29 = llvm.getelementptr %19[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %29 : f64, !llvm.ptr
    %30 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr
    %33 = llvm.insertvalue %32, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %32, %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %3, %34[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %5, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %6, %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = builtin.unrealized_conversion_cast %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    scf.for %arg0 = %c0 to %c3 step %c1 {
      %39 = memref.load %16[%arg0] : memref<3xf64>
      %40 = memref.load %25[%arg0] : memref<3xf64>
      %41 = llvm.fadd %39, %40 : f64
      memref.store %41, %38[%arg0] : memref<3xf64>
    }
    llvm.return %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %4 = llvm.call @add() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = llvm.icmp "slt" %6, %1 : i64
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %8 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.load %9 : !llvm.ptr -> f64
    %11 = llvm.call @printf(%5, %10) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %12 = llvm.add %6, %0 : i64
    llvm.br ^bb1(%12 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ConvertAffineToStandard (lower-affine) //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @add() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.mlir.constant(3 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %10 = llvm.call @malloc(%9) : (i64) -> !llvm.ptr
    %11 = llvm.insertvalue %10, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %3, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %5, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %6, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    %17 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.call @malloc(%18) : (i64) -> !llvm.ptr
    %20 = llvm.insertvalue %19, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %19, %20[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %3, %21[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %5, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %6, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    llvm.store %2, %10 : f64, !llvm.ptr
    %26 = llvm.getelementptr %10[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %26 : f64, !llvm.ptr
    %27 = llvm.getelementptr %10[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %27 : f64, !llvm.ptr
    llvm.store %2, %19 : f64, !llvm.ptr
    %28 = llvm.getelementptr %19[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %28 : f64, !llvm.ptr
    %29 = llvm.getelementptr %19[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %29 : f64, !llvm.ptr
    %30 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr
    %33 = llvm.insertvalue %32, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %32, %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %3, %34[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %5, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %6, %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = builtin.unrealized_conversion_cast %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    scf.for %arg0 = %c0 to %c3 step %c1 {
      %39 = memref.load %16[%arg0] : memref<3xf64>
      %40 = memref.load %25[%arg0] : memref<3xf64>
      %41 = llvm.fadd %39, %40 : f64
      memref.store %41, %38[%arg0] : memref<3xf64>
    }
    llvm.return %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %4 = llvm.call @add() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = llvm.icmp "slt" %6, %1 : i64
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %8 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.load %9 : !llvm.ptr -> f64
    %11 = llvm.call @printf(%5, %10) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %12 = llvm.add %6, %0 : i64
    llvm.br ^bb1(%12 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After SCFToControlFlow (convert-scf-to-cf) //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @add() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.mlir.constant(3 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %10 = llvm.call @malloc(%9) : (i64) -> !llvm.ptr
    %11 = llvm.insertvalue %10, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %3, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %5, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %6, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    %17 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.call @malloc(%18) : (i64) -> !llvm.ptr
    %20 = llvm.insertvalue %19, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %19, %20[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %3, %21[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %5, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %6, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    llvm.store %2, %10 : f64, !llvm.ptr
    %26 = llvm.getelementptr %10[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %26 : f64, !llvm.ptr
    %27 = llvm.getelementptr %10[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %27 : f64, !llvm.ptr
    llvm.store %2, %19 : f64, !llvm.ptr
    %28 = llvm.getelementptr %19[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %28 : f64, !llvm.ptr
    %29 = llvm.getelementptr %19[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %29 : f64, !llvm.ptr
    %30 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr
    %33 = llvm.insertvalue %32, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %32, %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %3, %34[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %5, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %6, %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = builtin.unrealized_conversion_cast %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    cf.br ^bb1(%c0 : index)
  ^bb1(%39: index):  // 2 preds: ^bb0, ^bb2
    %40 = arith.cmpi slt, %39, %c3 : index
    cf.cond_br %40, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %41 = memref.load %16[%39] : memref<3xf64>
    %42 = memref.load %25[%39] : memref<3xf64>
    %43 = llvm.fadd %41, %42 : f64
    memref.store %43, %38[%39] : memref<3xf64>
    %44 = arith.addi %39, %c1 : index
    cf.br ^bb1(%44 : index)
  ^bb3:  // pred: ^bb1
    llvm.return %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %4 = llvm.call @add() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = llvm.icmp "slt" %6, %1 : i64
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %8 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.load %9 : !llvm.ptr -> f64
    %11 = llvm.call @printf(%5, %10) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %12 = llvm.add %6, %0 : i64
    llvm.br ^bb1(%12 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ReconcileUnrealizedCasts (reconcile-unrealized-casts) //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @add() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.mlir.constant(3 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %10 = llvm.call @malloc(%9) : (i64) -> !llvm.ptr
    %11 = llvm.insertvalue %10, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %3, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %5, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %6, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    %17 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.call @malloc(%18) : (i64) -> !llvm.ptr
    %20 = llvm.insertvalue %19, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %19, %20[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %3, %21[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %5, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %6, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    llvm.store %2, %10 : f64, !llvm.ptr
    %26 = llvm.getelementptr %10[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %26 : f64, !llvm.ptr
    %27 = llvm.getelementptr %10[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %27 : f64, !llvm.ptr
    llvm.store %2, %19 : f64, !llvm.ptr
    %28 = llvm.getelementptr %19[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %1, %28 : f64, !llvm.ptr
    %29 = llvm.getelementptr %19[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %0, %29 : f64, !llvm.ptr
    %30 = llvm.getelementptr %7[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr
    %33 = llvm.insertvalue %32, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %32, %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %3, %34[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %5, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %6, %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = builtin.unrealized_conversion_cast %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<3xf64>
    cf.br ^bb1(%c0 : index)
  ^bb1(%39: index):  // 2 preds: ^bb0, ^bb2
    %40 = arith.cmpi slt, %39, %c3 : index
    cf.cond_br %40, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %41 = memref.load %16[%39] : memref<3xf64>
    %42 = memref.load %25[%39] : memref<3xf64>
    %43 = llvm.fadd %41, %42 : f64
    memref.store %43, %38[%39] : memref<3xf64>
    %44 = arith.addi %39, %c1 : index
    cf.br ^bb1(%44 : index)
  ^bb3:  // pred: ^bb1
    llvm.return %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %4 = llvm.call @add() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = llvm.icmp "slt" %6, %1 : i64
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %8 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.load %9 : !llvm.ptr -> f64
    %11 = llvm.call @printf(%5, %10) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %12 = llvm.add %6, %0 : i64
    llvm.br ^bb1(%12 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ConvertToLLVMPass (convert-to-llvm) //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @add() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.mlir.constant(3 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.zero : !llvm.ptr
    %12 = llvm.getelementptr %11[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.call @malloc(%13) : (i64) -> !llvm.ptr
    %15 = llvm.insertvalue %14, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %14, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %7, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %9, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %10, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.getelementptr %11[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %21 = llvm.ptrtoint %20 : !llvm.ptr to i64
    %22 = llvm.call @malloc(%21) : (i64) -> !llvm.ptr
    %23 = llvm.insertvalue %22, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %22, %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.insertvalue %7, %24[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.insertvalue %9, %25[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %10, %26[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.store %6, %14 : f64, !llvm.ptr
    %28 = llvm.getelementptr %14[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %5, %28 : f64, !llvm.ptr
    %29 = llvm.getelementptr %14[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %4, %29 : f64, !llvm.ptr
    llvm.store %6, %22 : f64, !llvm.ptr
    %30 = llvm.getelementptr %22[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %5, %30 : f64, !llvm.ptr
    %31 = llvm.getelementptr %22[2] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %4, %31 : f64, !llvm.ptr
    %32 = llvm.getelementptr %11[3] : (!llvm.ptr) -> !llvm.ptr, f64
    %33 = llvm.ptrtoint %32 : !llvm.ptr to i64
    %34 = llvm.call @malloc(%33) : (i64) -> !llvm.ptr
    %35 = llvm.insertvalue %34, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %34, %35[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %7, %36[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.insertvalue %9, %37[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.insertvalue %10, %38[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    cf.br ^bb1(%3 : index)
  ^bb1(%40: index):  // 2 preds: ^bb0, ^bb2
    %41 = builtin.unrealized_conversion_cast %40 : index to i64
    %42 = llvm.icmp "slt" %41, %1 : i64
    llvm.cond_br %42, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %43 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.getelementptr %43[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %45 = llvm.load %44 : !llvm.ptr -> f64
    %46 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.getelementptr %46[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %48 = llvm.load %47 : !llvm.ptr -> f64
    %49 = llvm.fadd %45, %48 : f64
    %50 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %51 = llvm.getelementptr %50[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %49, %51 : f64, !llvm.ptr
    %52 = llvm.add %41, %0 : i64
    %53 = builtin.unrealized_conversion_cast %52 : i64 to index
    cf.br ^bb1(%53 : index)
  ^bb3:  // pred: ^bb1
    llvm.return %39 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %4 = llvm.call @add() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = llvm.icmp "slt" %6, %1 : i64
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %8 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.load %9 : !llvm.ptr -> f64
    %11 = llvm.call @printf(%5, %10) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %12 = llvm.add %6, %0 : i64
    llvm.br ^bb1(%12 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


error: LLVM Translation failed for operation: builtin.unrealized_conversion_cast
Failed to emit LLVM IR
