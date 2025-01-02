// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()

// func.func @const() -> tensor<2x3xf64>{
//     %t1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> tensor<2x3xf64>
//     return %t1 : tensor<2x3xf64>
// }

func.func @main() {
    // call const
    // %0 = func.call @const() : () -> tensor<2x3xf64>
    %0 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> tensor<2x3xf64>
    %1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> tensor<2x3xf64>
    // %2 = "engine.add"(%0, %1) : (memref<2x3xf64>, tensor<2x3xf64>) -> tensor<2x3xf64>
    // "engine.print"(%2) : (tensor<2x3xf64>) -> ()
    return
}
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<2x3xf64>
    %alloc_0 = memref.alloc() : memref<2x3xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc_0[%c0, %c0] : memref<2x3xf64>
    %cst_1 = arith.constant 2.000000e+00 : f64
    affine.store %cst_1, %alloc_0[%c0, %c1] : memref<2x3xf64>
    %cst_2 = arith.constant 3.000000e+00 : f64
    affine.store %cst_2, %alloc_0[%c0, %c2] : memref<2x3xf64>
    %cst_3 = arith.constant 4.000000e+00 : f64
    affine.store %cst_3, %alloc_0[%c1, %c0] : memref<2x3xf64>
    %cst_4 = arith.constant 5.000000e+00 : f64
    affine.store %cst_4, %alloc_0[%c1, %c1] : memref<2x3xf64>
    %cst_5 = arith.constant 6.000000e+00 : f64
    affine.store %cst_5, %alloc_0[%c1, %c2] : memref<2x3xf64>
    %c0_6 = arith.constant 0 : index
    %c1_7 = arith.constant 1 : index
    %c2_8 = arith.constant 2 : index
    %cst_9 = arith.constant 1.000000e+00 : f64
    affine.store %cst_9, %alloc[%c0_6, %c0_6] : memref<2x3xf64>
    %cst_10 = arith.constant 2.000000e+00 : f64
    affine.store %cst_10, %alloc[%c0_6, %c1_7] : memref<2x3xf64>
    %cst_11 = arith.constant 3.000000e+00 : f64
    affine.store %cst_11, %alloc[%c0_6, %c2_8] : memref<2x3xf64>
    %cst_12 = arith.constant 4.000000e+00 : f64
    affine.store %cst_12, %alloc[%c1_7, %c0_6] : memref<2x3xf64>
    %cst_13 = arith.constant 5.000000e+00 : f64
    affine.store %cst_13, %alloc[%c1_7, %c1_7] : memref<2x3xf64>
    %cst_14 = arith.constant 6.000000e+00 : f64
    affine.store %cst_14, %alloc[%c1_7, %c2_8] : memref<2x3xf64>
    memref.dealloc %alloc_0 : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %cst = arith.constant 6.000000e+00 : f64
    %cst_0 = arith.constant 5.000000e+00 : f64
    %cst_1 = arith.constant 4.000000e+00 : f64
    %cst_2 = arith.constant 3.000000e+00 : f64
    %cst_3 = arith.constant 2.000000e+00 : f64
    %cst_4 = arith.constant 1.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<2x3xf64>
    %alloc_5 = memref.alloc() : memref<2x3xf64>
    affine.store %cst_4, %alloc_5[%c0, %c0] : memref<2x3xf64>
    affine.store %cst_3, %alloc_5[%c0, %c1] : memref<2x3xf64>
    affine.store %cst_2, %alloc_5[%c0, %c2] : memref<2x3xf64>
    affine.store %cst_1, %alloc_5[%c1, %c0] : memref<2x3xf64>
    affine.store %cst_0, %alloc_5[%c1, %c1] : memref<2x3xf64>
    affine.store %cst, %alloc_5[%c1, %c2] : memref<2x3xf64>
    affine.store %cst_4, %alloc[%c0, %c0] : memref<2x3xf64>
    affine.store %cst_3, %alloc[%c0, %c1] : memref<2x3xf64>
    affine.store %cst_2, %alloc[%c0, %c2] : memref<2x3xf64>
    affine.store %cst_1, %alloc[%c1, %c0] : memref<2x3xf64>
    affine.store %cst_0, %alloc[%c1, %c1] : memref<2x3xf64>
    affine.store %cst, %alloc[%c1, %c2] : memref<2x3xf64>
    memref.dealloc %alloc_5 : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return
  }
}


// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass () //----- //
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @main() {
    %0 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(2 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.mlir.constant(2 : index) : i64
    %10 = llvm.mlir.constant(3 : index) : i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.mlir.constant(6 : index) : i64
    %13 = llvm.mlir.zero : !llvm.ptr
    %14 = llvm.getelementptr %13[%12] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %15 = llvm.ptrtoint %14 : !llvm.ptr to i64
    %16 = llvm.call @malloc(%15) : (i64) -> !llvm.ptr
    %17 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %9, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %10, %22[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %10, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %11, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.mlir.constant(2 : index) : i64
    %27 = llvm.mlir.constant(3 : index) : i64
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.mlir.constant(6 : index) : i64
    %30 = llvm.mlir.zero : !llvm.ptr
    %31 = llvm.getelementptr %30[%29] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %32 = llvm.ptrtoint %31 : !llvm.ptr to i64
    %33 = llvm.call @malloc(%32) : (i64) -> !llvm.ptr
    %34 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %35 = llvm.insertvalue %33, %34[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.insertvalue %33, %35[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.mlir.constant(0 : index) : i64
    %38 = llvm.insertvalue %37, %36[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.insertvalue %26, %38[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.insertvalue %27, %39[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.insertvalue %27, %40[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.insertvalue %28, %41[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.mlir.constant(3 : index) : i64
    %45 = llvm.mul %8, %44 : i64
    %46 = llvm.add %45, %8 : i64
    %47 = llvm.getelementptr %43[%46] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %47 : f64, !llvm.ptr
    %48 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.mlir.constant(3 : index) : i64
    %50 = llvm.mul %8, %49 : i64
    %51 = llvm.add %50, %7 : i64
    %52 = llvm.getelementptr %48[%51] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %52 : f64, !llvm.ptr
    %53 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.mlir.constant(3 : index) : i64
    %55 = llvm.mul %8, %54 : i64
    %56 = llvm.add %55, %6 : i64
    %57 = llvm.getelementptr %53[%56] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %57 : f64, !llvm.ptr
    %58 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.mlir.constant(3 : index) : i64
    %60 = llvm.mul %7, %59 : i64
    %61 = llvm.add %60, %8 : i64
    %62 = llvm.getelementptr %58[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %62 : f64, !llvm.ptr
    %63 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %64 = llvm.mlir.constant(3 : index) : i64
    %65 = llvm.mul %7, %64 : i64
    %66 = llvm.add %65, %7 : i64
    %67 = llvm.getelementptr %63[%66] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %67 : f64, !llvm.ptr
    %68 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %69 = llvm.mlir.constant(3 : index) : i64
    %70 = llvm.mul %7, %69 : i64
    %71 = llvm.add %70, %6 : i64
    %72 = llvm.getelementptr %68[%71] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %72 : f64, !llvm.ptr
    %73 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %74 = llvm.mlir.constant(3 : index) : i64
    %75 = llvm.mul %8, %74 : i64
    %76 = llvm.add %75, %8 : i64
    %77 = llvm.getelementptr %73[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %77 : f64, !llvm.ptr
    %78 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.mlir.constant(3 : index) : i64
    %80 = llvm.mul %8, %79 : i64
    %81 = llvm.add %80, %7 : i64
    %82 = llvm.getelementptr %78[%81] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %82 : f64, !llvm.ptr
    %83 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %84 = llvm.mlir.constant(3 : index) : i64
    %85 = llvm.mul %8, %84 : i64
    %86 = llvm.add %85, %6 : i64
    %87 = llvm.getelementptr %83[%86] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %87 : f64, !llvm.ptr
    %88 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.mlir.constant(3 : index) : i64
    %90 = llvm.mul %7, %89 : i64
    %91 = llvm.add %90, %8 : i64
    %92 = llvm.getelementptr %88[%91] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %92 : f64, !llvm.ptr
    %93 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %94 = llvm.mlir.constant(3 : index) : i64
    %95 = llvm.mul %7, %94 : i64
    %96 = llvm.add %95, %7 : i64
    %97 = llvm.getelementptr %93[%96] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %97 : f64, !llvm.ptr
    %98 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %99 = llvm.mlir.constant(3 : index) : i64
    %100 = llvm.mul %7, %99 : i64
    %101 = llvm.add %100, %6 : i64
    %102 = llvm.getelementptr %98[%101] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %102 : f64, !llvm.ptr
    %103 = llvm.extractvalue %42[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%103) : (!llvm.ptr) -> ()
    %104 = llvm.extractvalue %25[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%104) : (!llvm.ptr) -> ()
    llvm.return
  }
}


