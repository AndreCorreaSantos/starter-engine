// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %fc3.bias = "engine.constant"() {value=dense<[-0.2, 0.3, 0.1, -0.1, -0.1, 0.1, -0.0, -0.0, -0.1, 0.0]>:tensor<10xf64>} : () -> memref<10xf64>
    "engine.print"(%fc3.bias) : (memref<10xf64>) -> ()
    return
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
    engine.print %alloc : memref<10xf64>
    memref.dealloc %alloc : memref<10xf64>
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
    engine.print %alloc : memref<10xf64>
    memref.dealloc %alloc : memref<10xf64>
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
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %4 = llvm.mlir.constant(3.000000e-01 : f64) : f64
    %5 = llvm.mlir.constant(-2.000000e-01 : f64) : f64
    %6 = llvm.mlir.constant(9 : index) : i64
    %7 = llvm.mlir.constant(8 : index) : i64
    %8 = llvm.mlir.constant(7 : index) : i64
    %9 = llvm.mlir.constant(6 : index) : i64
    %10 = llvm.mlir.constant(5 : index) : i64
    %11 = llvm.mlir.constant(4 : index) : i64
    %12 = llvm.mlir.constant(3 : index) : i64
    %13 = llvm.mlir.constant(2 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.mlir.constant(10 : index) : i64
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.mlir.zero : !llvm.ptr
    %19 = llvm.getelementptr %18[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %20 = llvm.ptrtoint %19 : !llvm.ptr to i64
    %21 = llvm.call @malloc(%20) : (i64) -> !llvm.ptr
    %22 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %16, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %17, %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.getelementptr %29[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %30 : f64, !llvm.ptr
    %31 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.getelementptr %31[%14] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %32 : f64, !llvm.ptr
    %33 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.getelementptr %33[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %34 : f64, !llvm.ptr
    %35 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.getelementptr %35[%12] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %36 : f64, !llvm.ptr
    %37 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.getelementptr %37[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %38 : f64, !llvm.ptr
    %39 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %40 = llvm.getelementptr %39[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %40 : f64, !llvm.ptr
    %41 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %42 = llvm.getelementptr %41[%9] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %42 : f64, !llvm.ptr
    %43 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.getelementptr %43[%8] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %44 : f64, !llvm.ptr
    %45 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.getelementptr %45[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %46 : f64, !llvm.ptr
    %47 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.getelementptr %47[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %48 : f64, !llvm.ptr
    %49 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %50 = llvm.mlir.constant(0 : index) : i64
    %51 = llvm.getelementptr %49[%50, %50] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %52 = llvm.mlir.addressof @nl : !llvm.ptr
    %53 = llvm.mlir.constant(0 : index) : i64
    %54 = llvm.getelementptr %52[%53, %53] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %55 = llvm.mlir.constant(0 : index) : i64
    %56 = llvm.mlir.constant(10 : index) : i64
    %57 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%55 : i64)
  ^bb1(%58: i64):  // 2 preds: ^bb0, ^bb2
    %59 = llvm.icmp "slt" %58, %56 : i64
    llvm.cond_br %59, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %60 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.getelementptr %60[%58] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %62 = llvm.load %61 : !llvm.ptr -> f64
    %63 = llvm.call @printf(%51, %62) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %64 = llvm.add %58, %57 : i64
    llvm.br ^bb1(%64 : i64)
  ^bb3:  // pred: ^bb1
    %65 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @free(%65) : (!llvm.ptr) -> ()
    llvm.return
  }
}


-0.200000 0.300000 0.100000 -0.100000 -0.100000 0.100000 -0.000000 -0.000000 -0.100000 0.000000 