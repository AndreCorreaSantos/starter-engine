// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    %2 = "engine.relu"(%0) : (memref<3xf64>) -> memref<3xf64>
    "engine.print"(%2) : (memref<3xf64>) -> ()
    return
}
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
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
    %0 = affine.load %alloc_0[%c0_3] : memref<3xf64>
    %1 = arith.addf %0, %cst_6 : f64
    affine.store %1, %alloc[%c0_3] : memref<3xf64>
    %2 = affine.load %alloc_0[%c1_4] : memref<3xf64>
    %3 = arith.addf %2, %cst_6 : f64
    affine.store %3, %alloc[%c1_4] : memref<3xf64>
    %4 = affine.load %alloc_0[%c2_5] : memref<3xf64>
    %5 = arith.addf %4, %cst_6 : f64
    affine.store %5, %alloc[%c2_5] : memref<3xf64>
    engine.print %alloc : memref<3xf64>
    memref.dealloc %alloc_0 : memref<3xf64>
    memref.dealloc %alloc : memref<3xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
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
    %0 = affine.load %alloc_2[%c0] : memref<3xf64>
    %1 = arith.addf %0, %cst_1 : f64
    affine.store %1, %alloc[%c0] : memref<3xf64>
    %2 = affine.load %alloc_2[%c1] : memref<3xf64>
    %3 = arith.addf %2, %cst_1 : f64
    affine.store %3, %alloc[%c1] : memref<3xf64>
    %4 = affine.load %alloc_2[%c2] : memref<3xf64>
    %5 = arith.addf %4, %cst_1 : f64
    affine.store %5, %alloc[%c2] : memref<3xf64>
    engine.print %alloc : memref<3xf64>
    memref.dealloc %alloc_2 : memref<3xf64>
    memref.dealloc %alloc : memref<3xf64>
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
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.mlir.constant(3 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr
    %12 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %6, %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %7, %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.mlir.constant(3 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mlir.zero : !llvm.ptr
    %22 = llvm.getelementptr %21[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.call @malloc(%23) : (i64) -> !llvm.ptr
    %25 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %19, %29[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.insertvalue %20, %30[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.getelementptr %32[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %33 : f64, !llvm.ptr
    %34 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.getelementptr %34[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %35 : f64, !llvm.ptr
    %36 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.getelementptr %36[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %37 : f64, !llvm.ptr
    %38 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.getelementptr %38[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %40 = llvm.load %39 : !llvm.ptr -> f64
    %41 = llvm.fadd %40, %2 : f64
    %42 = llvm.extractvalue %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.getelementptr %42[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %41, %43 : f64, !llvm.ptr
    %44 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.getelementptr %44[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %46 = llvm.load %45 : !llvm.ptr -> f64
    %47 = llvm.fadd %46, %2 : f64
    %48 = llvm.extractvalue %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.getelementptr %48[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %47, %49 : f64, !llvm.ptr
    %50 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %51 = llvm.getelementptr %50[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %52 = llvm.load %51 : !llvm.ptr -> f64
    %53 = llvm.fadd %52, %2 : f64
    %54 = llvm.extractvalue %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %55 = llvm.getelementptr %54[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %53, %55 : f64, !llvm.ptr
    %56 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %57 = llvm.mlir.constant(0 : index) : i64
    %58 = llvm.getelementptr %56[%57, %57] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %59 = llvm.mlir.addressof @nl : !llvm.ptr
    %60 = llvm.mlir.constant(0 : index) : i64
    %61 = llvm.getelementptr %59[%60, %60] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %62 = llvm.mlir.constant(0 : index) : i64
    %63 = llvm.mlir.constant(3 : index) : i64
    %64 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%62 : i64)
  ^bb1(%65: i64):  // 2 preds: ^bb0, ^bb2
    %66 = llvm.icmp "slt" %65, %63 : i64
    llvm.cond_br %66, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %67 = llvm.extractvalue %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %68 = llvm.getelementptr %67[%65] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %69 = llvm.load %68 : !llvm.ptr -> f64
    %70 = llvm.call @printf(%58, %69) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %71 = llvm.add %65, %64 : i64
    llvm.br ^bb1(%71 : i64)
  ^bb3:  // pred: ^bb1
    %72 = llvm.extractvalue %31[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @free(%72) : (!llvm.ptr) -> ()
    %73 = llvm.extractvalue %18[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @free(%73) : (!llvm.ptr) -> ()
    llvm.return
  }
}


2.000000 3.000000 4.000000 