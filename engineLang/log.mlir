// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()

func.func @const() -> memref<2x3xf64>{
    %t1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    return %t1 : memref<2x3xf64>
}

func.func @main() {
    %0 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    %1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    
    %2 = "engine.add"(%0,%1) : (memref<2x3xf64>,memref<2x3xf64>) -> memref<2x3xf64>
    
    "engine.print"(%0) : (memref<2x3xf64>) -> ()
    return
}
LHS_Shape: [2 3 ]
RHS_Shape: [2 3 ]
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @const() -> memref<2x3xf64> {
    %alloc = memref.alloc() : memref<2x3xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc[%c0, %c0] : memref<2x3xf64>
    %cst_0 = arith.constant 2.000000e+00 : f64
    affine.store %cst_0, %alloc[%c0, %c1] : memref<2x3xf64>
    %cst_1 = arith.constant 3.000000e+00 : f64
    affine.store %cst_1, %alloc[%c0, %c2] : memref<2x3xf64>
    %cst_2 = arith.constant 4.000000e+00 : f64
    affine.store %cst_2, %alloc[%c1, %c0] : memref<2x3xf64>
    %cst_3 = arith.constant 5.000000e+00 : f64
    affine.store %cst_3, %alloc[%c1, %c1] : memref<2x3xf64>
    %cst_4 = arith.constant 6.000000e+00 : f64
    affine.store %cst_4, %alloc[%c1, %c2] : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return %alloc : memref<2x3xf64>
  }
  func.func @main() {
    %alloc = memref.alloc() : memref<2x3xf64>
    %alloc_0 = memref.alloc() : memref<2x3xf64>
    %alloc_1 = memref.alloc() : memref<2x3xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc_1[%c0, %c0] : memref<2x3xf64>
    %cst_2 = arith.constant 2.000000e+00 : f64
    affine.store %cst_2, %alloc_1[%c0, %c1] : memref<2x3xf64>
    %cst_3 = arith.constant 3.000000e+00 : f64
    affine.store %cst_3, %alloc_1[%c0, %c2] : memref<2x3xf64>
    %cst_4 = arith.constant 4.000000e+00 : f64
    affine.store %cst_4, %alloc_1[%c1, %c0] : memref<2x3xf64>
    %cst_5 = arith.constant 5.000000e+00 : f64
    affine.store %cst_5, %alloc_1[%c1, %c1] : memref<2x3xf64>
    %cst_6 = arith.constant 6.000000e+00 : f64
    affine.store %cst_6, %alloc_1[%c1, %c2] : memref<2x3xf64>
    %c0_7 = arith.constant 0 : index
    %c1_8 = arith.constant 1 : index
    %c2_9 = arith.constant 2 : index
    %cst_10 = arith.constant 1.000000e+00 : f64
    affine.store %cst_10, %alloc_0[%c0_7, %c0_7] : memref<2x3xf64>
    %cst_11 = arith.constant 2.000000e+00 : f64
    affine.store %cst_11, %alloc_0[%c0_7, %c1_8] : memref<2x3xf64>
    %cst_12 = arith.constant 3.000000e+00 : f64
    affine.store %cst_12, %alloc_0[%c0_7, %c2_9] : memref<2x3xf64>
    %cst_13 = arith.constant 4.000000e+00 : f64
    affine.store %cst_13, %alloc_0[%c1_8, %c0_7] : memref<2x3xf64>
    %cst_14 = arith.constant 5.000000e+00 : f64
    affine.store %cst_14, %alloc_0[%c1_8, %c1_8] : memref<2x3xf64>
    %cst_15 = arith.constant 6.000000e+00 : f64
    affine.store %cst_15, %alloc_0[%c1_8, %c2_9] : memref<2x3xf64>
    linalg.add ins(%alloc_1, %alloc_0 : memref<2x3xf64>, memref<2x3xf64>) outs(%alloc : memref<2x3xf64>)
    engine.print %alloc_1 : memref<2x3xf64>
    memref.dealloc %alloc_1 : memref<2x3xf64>
    memref.dealloc %alloc_0 : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @const() -> memref<2x3xf64> {
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
    affine.store %cst_4, %alloc[%c0, %c0] : memref<2x3xf64>
    affine.store %cst_3, %alloc[%c0, %c1] : memref<2x3xf64>
    affine.store %cst_2, %alloc[%c0, %c2] : memref<2x3xf64>
    affine.store %cst_1, %alloc[%c1, %c0] : memref<2x3xf64>
    affine.store %cst_0, %alloc[%c1, %c1] : memref<2x3xf64>
    affine.store %cst, %alloc[%c1, %c2] : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return %alloc : memref<2x3xf64>
  }
  func.func @main() {
    %c3 = arith.constant 3 : index
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
    %alloc_6 = memref.alloc() : memref<2x3xf64>
    affine.store %cst_4, %alloc_6[%c0, %c0] : memref<2x3xf64>
    affine.store %cst_3, %alloc_6[%c0, %c1] : memref<2x3xf64>
    affine.store %cst_2, %alloc_6[%c0, %c2] : memref<2x3xf64>
    affine.store %cst_1, %alloc_6[%c1, %c0] : memref<2x3xf64>
    affine.store %cst_0, %alloc_6[%c1, %c1] : memref<2x3xf64>
    affine.store %cst, %alloc_6[%c1, %c2] : memref<2x3xf64>
    affine.store %cst_4, %alloc_5[%c0, %c0] : memref<2x3xf64>
    affine.store %cst_3, %alloc_5[%c0, %c1] : memref<2x3xf64>
    affine.store %cst_2, %alloc_5[%c0, %c2] : memref<2x3xf64>
    affine.store %cst_1, %alloc_5[%c1, %c0] : memref<2x3xf64>
    affine.store %cst_0, %alloc_5[%c1, %c1] : memref<2x3xf64>
    affine.store %cst, %alloc_5[%c1, %c2] : memref<2x3xf64>
    scf.for %arg0 = %c0 to %c2 step %c1 {
      scf.for %arg1 = %c0 to %c3 step %c1 {
        %0 = memref.load %alloc_6[%arg0, %arg1] : memref<2x3xf64>
        %1 = memref.load %alloc_5[%arg0, %arg1] : memref<2x3xf64>
        %2 = arith.addf %0, %1 : f64
        memref.store %2, %alloc[%arg0, %arg1] : memref<2x3xf64>
      }
    }
    engine.print %alloc_6 : memref<2x3xf64>
    memref.dealloc %alloc_6 : memref<2x3xf64>
    memref.dealloc %alloc_5 : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return
  }
}


// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass () //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @const() -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
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
    %26 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.constant(3 : index) : i64
    %28 = llvm.mul %8, %27 : i64
    %29 = llvm.add %28, %8 : i64
    %30 = llvm.getelementptr %26[%29] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %30 : f64, !llvm.ptr
    %31 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.mlir.constant(3 : index) : i64
    %33 = llvm.mul %8, %32 : i64
    %34 = llvm.add %33, %7 : i64
    %35 = llvm.getelementptr %31[%34] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %35 : f64, !llvm.ptr
    %36 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.mlir.constant(3 : index) : i64
    %38 = llvm.mul %8, %37 : i64
    %39 = llvm.add %38, %6 : i64
    %40 = llvm.getelementptr %36[%39] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %40 : f64, !llvm.ptr
    %41 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.mlir.constant(3 : index) : i64
    %43 = llvm.mul %7, %42 : i64
    %44 = llvm.add %43, %8 : i64
    %45 = llvm.getelementptr %41[%44] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %45 : f64, !llvm.ptr
    %46 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %47 = llvm.mlir.constant(3 : index) : i64
    %48 = llvm.mul %7, %47 : i64
    %49 = llvm.add %48, %7 : i64
    %50 = llvm.getelementptr %46[%49] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %50 : f64, !llvm.ptr
    %51 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mlir.constant(3 : index) : i64
    %53 = llvm.mul %7, %52 : i64
    %54 = llvm.add %53, %6 : i64
    %55 = llvm.getelementptr %51[%54] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %55 : f64, !llvm.ptr
    %56 = llvm.extractvalue %25[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%56) : (!llvm.ptr) -> ()
    llvm.return %25 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(2 : index) : i64
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.mlir.constant(2 : index) : i64
    %11 = llvm.mlir.constant(3 : index) : i64
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.mlir.constant(6 : index) : i64
    %14 = llvm.mlir.zero : !llvm.ptr
    %15 = llvm.getelementptr %14[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %16 = llvm.ptrtoint %15 : !llvm.ptr to i64
    %17 = llvm.call @malloc(%16) : (i64) -> !llvm.ptr
    %18 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = llvm.insertvalue %17, %18[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %17, %19[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.mlir.constant(0 : index) : i64
    %22 = llvm.insertvalue %21, %20[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %10, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %11, %23[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %11, %24[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %12, %25[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.constant(2 : index) : i64
    %28 = llvm.mlir.constant(3 : index) : i64
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.mlir.constant(6 : index) : i64
    %31 = llvm.mlir.zero : !llvm.ptr
    %32 = llvm.getelementptr %31[%30] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %33 = llvm.ptrtoint %32 : !llvm.ptr to i64
    %34 = llvm.call @malloc(%33) : (i64) -> !llvm.ptr
    %35 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %36 = llvm.insertvalue %34, %35[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %34, %36[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.mlir.constant(0 : index) : i64
    %39 = llvm.insertvalue %38, %37[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.insertvalue %27, %39[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.insertvalue %28, %40[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.insertvalue %28, %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.insertvalue %29, %42[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.mlir.constant(2 : index) : i64
    %45 = llvm.mlir.constant(3 : index) : i64
    %46 = llvm.mlir.constant(1 : index) : i64
    %47 = llvm.mlir.constant(6 : index) : i64
    %48 = llvm.mlir.zero : !llvm.ptr
    %49 = llvm.getelementptr %48[%47] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %50 = llvm.ptrtoint %49 : !llvm.ptr to i64
    %51 = llvm.call @malloc(%50) : (i64) -> !llvm.ptr
    %52 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %53 = llvm.insertvalue %51, %52[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %51, %53[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.mlir.constant(0 : index) : i64
    %56 = llvm.insertvalue %55, %54[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %44, %56[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %45, %57[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.insertvalue %45, %58[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.insertvalue %46, %59[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.mlir.constant(3 : index) : i64
    %63 = llvm.mul %9, %62 : i64
    %64 = llvm.add %63, %9 : i64
    %65 = llvm.getelementptr %61[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %6, %65 : f64, !llvm.ptr
    %66 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %67 = llvm.mlir.constant(3 : index) : i64
    %68 = llvm.mul %9, %67 : i64
    %69 = llvm.add %68, %8 : i64
    %70 = llvm.getelementptr %66[%69] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %70 : f64, !llvm.ptr
    %71 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.mlir.constant(3 : index) : i64
    %73 = llvm.mul %9, %72 : i64
    %74 = llvm.add %73, %7 : i64
    %75 = llvm.getelementptr %71[%74] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %75 : f64, !llvm.ptr
    %76 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %77 = llvm.mlir.constant(3 : index) : i64
    %78 = llvm.mul %8, %77 : i64
    %79 = llvm.add %78, %9 : i64
    %80 = llvm.getelementptr %76[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %80 : f64, !llvm.ptr
    %81 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %82 = llvm.mlir.constant(3 : index) : i64
    %83 = llvm.mul %8, %82 : i64
    %84 = llvm.add %83, %8 : i64
    %85 = llvm.getelementptr %81[%84] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %85 : f64, !llvm.ptr
    %86 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %87 = llvm.mlir.constant(3 : index) : i64
    %88 = llvm.mul %8, %87 : i64
    %89 = llvm.add %88, %7 : i64
    %90 = llvm.getelementptr %86[%89] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %90 : f64, !llvm.ptr
    %91 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %92 = llvm.mlir.constant(3 : index) : i64
    %93 = llvm.mul %9, %92 : i64
    %94 = llvm.add %93, %9 : i64
    %95 = llvm.getelementptr %91[%94] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %6, %95 : f64, !llvm.ptr
    %96 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %97 = llvm.mlir.constant(3 : index) : i64
    %98 = llvm.mul %9, %97 : i64
    %99 = llvm.add %98, %8 : i64
    %100 = llvm.getelementptr %96[%99] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %100 : f64, !llvm.ptr
    %101 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %102 = llvm.mlir.constant(3 : index) : i64
    %103 = llvm.mul %9, %102 : i64
    %104 = llvm.add %103, %7 : i64
    %105 = llvm.getelementptr %101[%104] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %105 : f64, !llvm.ptr
    %106 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.mlir.constant(3 : index) : i64
    %108 = llvm.mul %8, %107 : i64
    %109 = llvm.add %108, %9 : i64
    %110 = llvm.getelementptr %106[%109] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %110 : f64, !llvm.ptr
    %111 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.mlir.constant(3 : index) : i64
    %113 = llvm.mul %8, %112 : i64
    %114 = llvm.add %113, %8 : i64
    %115 = llvm.getelementptr %111[%114] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %115 : f64, !llvm.ptr
    %116 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %117 = llvm.mlir.constant(3 : index) : i64
    %118 = llvm.mul %8, %117 : i64
    %119 = llvm.add %118, %7 : i64
    %120 = llvm.getelementptr %116[%119] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %120 : f64, !llvm.ptr
    llvm.br ^bb1(%9 : i64)
  ^bb1(%121: i64):  // 2 preds: ^bb0, ^bb5
    %122 = llvm.icmp "slt" %121, %7 : i64
    llvm.cond_br %122, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%9 : i64)
  ^bb3(%123: i64):  // 2 preds: ^bb2, ^bb4
    %124 = llvm.icmp "slt" %123, %0 : i64
    llvm.cond_br %124, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %125 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %126 = llvm.mlir.constant(3 : index) : i64
    %127 = llvm.mul %121, %126 : i64
    %128 = llvm.add %127, %123 : i64
    %129 = llvm.getelementptr %125[%128] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %130 = llvm.load %129 : !llvm.ptr -> f64
    %131 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %132 = llvm.mlir.constant(3 : index) : i64
    %133 = llvm.mul %121, %132 : i64
    %134 = llvm.add %133, %123 : i64
    %135 = llvm.getelementptr %131[%134] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %136 = llvm.load %135 : !llvm.ptr -> f64
    %137 = llvm.fadd %130, %136 : f64
    %138 = llvm.extractvalue %26[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %139 = llvm.mlir.constant(3 : index) : i64
    %140 = llvm.mul %121, %139 : i64
    %141 = llvm.add %140, %123 : i64
    %142 = llvm.getelementptr %138[%141] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %137, %142 : f64, !llvm.ptr
    %143 = llvm.add %123, %8 : i64
    llvm.br ^bb3(%143 : i64)
  ^bb5:  // pred: ^bb3
    %144 = llvm.add %121, %8 : i64
    llvm.br ^bb1(%144 : i64)
  ^bb6:  // pred: ^bb1
    %145 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %146 = llvm.mlir.constant(0 : index) : i64
    %147 = llvm.getelementptr %145[%146, %146] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %148 = llvm.mlir.addressof @nl : !llvm.ptr
    %149 = llvm.mlir.constant(0 : index) : i64
    %150 = llvm.getelementptr %148[%149, %149] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %151 = llvm.mlir.constant(0 : index) : i64
    %152 = llvm.mlir.constant(2 : index) : i64
    %153 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%151 : i64)
  ^bb7(%154: i64):  // 2 preds: ^bb6, ^bb11
    %155 = llvm.icmp "slt" %154, %152 : i64
    llvm.cond_br %155, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    %156 = llvm.mlir.constant(0 : index) : i64
    %157 = llvm.mlir.constant(3 : index) : i64
    %158 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb9(%156 : i64)
  ^bb9(%159: i64):  // 2 preds: ^bb8, ^bb10
    %160 = llvm.icmp "slt" %159, %157 : i64
    llvm.cond_br %160, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %161 = llvm.extractvalue %60[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %162 = llvm.mlir.constant(3 : index) : i64
    %163 = llvm.mul %154, %162 : i64
    %164 = llvm.add %163, %159 : i64
    %165 = llvm.getelementptr %161[%164] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %166 = llvm.load %165 : !llvm.ptr -> f64
    %167 = llvm.call @printf(%147, %166) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %168 = llvm.add %159, %158 : i64
    llvm.br ^bb9(%168 : i64)
  ^bb11:  // pred: ^bb9
    %169 = llvm.call @printf(%150) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %170 = llvm.add %154, %153 : i64
    llvm.br ^bb7(%170 : i64)
  ^bb12:  // pred: ^bb7
    %171 = llvm.extractvalue %60[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%171) : (!llvm.ptr) -> ()
    %172 = llvm.extractvalue %43[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%172) : (!llvm.ptr) -> ()
    %173 = llvm.extractvalue %26[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%173) : (!llvm.ptr) -> ()
    llvm.return
  }
}


1.000000 2.000000 3.000000 
4.000000 5.000000 6.000000 
