// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<1x1xf64>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc[%c0, %c0] : memref<1x1xf64>
    engine.print %alloc : memref<1x1xf64>
    memref.dealloc %alloc : memref<1x1xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %cst = arith.constant 1.000000e+00 : f64
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<1x1xf64>
    affine.store %cst, %alloc[%c0, %c0] : memref<1x1xf64>
    engine.print %alloc : memref<1x1xf64>
    memref.dealloc %alloc : memref<1x1xf64>
    return
  }
}


// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass () //----- //
module {
  llvm.func @free(!llvm.ptr)
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @main() {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.call @malloc(%7) : (i64) -> !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %2, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %3, %14[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %3, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %4, %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.add %1, %1 : i64
    %20 = llvm.getelementptr %18[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %20 : f64, !llvm.ptr
    %21 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.getelementptr %21[%22, %22] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %24 = llvm.mlir.addressof @nl : !llvm.ptr
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.getelementptr %24[%25, %25] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%27 : i64)
  ^bb1(%30: i64):  // 2 preds: ^bb0, ^bb5
    %31 = llvm.icmp "slt" %30, %28 : i64
    llvm.cond_br %31, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %32 = llvm.mlir.constant(0 : index) : i64
    %33 = llvm.mlir.constant(1 : index) : i64
    %34 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%32 : i64)
  ^bb3(%35: i64):  // 2 preds: ^bb2, ^bb4
    %36 = llvm.icmp "slt" %35, %33 : i64
    llvm.cond_br %36, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %37 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.add %30, %35 : i64
    %39 = llvm.getelementptr %37[%38] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %40 = llvm.load %39 : !llvm.ptr -> f64
    %41 = llvm.call @printf(%23, %40) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %42 = llvm.add %35, %34 : i64
    llvm.br ^bb3(%42 : i64)
  ^bb5:  // pred: ^bb3
    %43 = llvm.call @printf(%26) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %44 = llvm.add %30, %29 : i64
    llvm.br ^bb1(%44 : i64)
  ^bb6:  // pred: ^bb1
    %45 = llvm.extractvalue %17[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%45) : (!llvm.ptr) -> ()
    llvm.return
  }
}


1.000000 
