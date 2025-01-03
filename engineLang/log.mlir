// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    %1 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    %2 = "engine.dot"(%0, %1) : (memref<3xf64>, memref<3xf64>) -> memref<f64>
    
    "engine.print"(%2) : (memref<f64>) -> ()
    return
}
LHS_Shape: [3 ]
RHS_Shape: [3 ]
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<f64>
    %alloc_0 = memref.alloc() : memref<3xf64>
    %alloc_1 = memref.alloc() : memref<3xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc_1[%c0] : memref<3xf64>
    %cst_2 = arith.constant 2.000000e+00 : f64
    affine.store %cst_2, %alloc_1[%c1] : memref<3xf64>
    %cst_3 = arith.constant 3.000000e+00 : f64
    affine.store %cst_3, %alloc_1[%c2] : memref<3xf64>
    %c0_4 = arith.constant 0 : index
    %c1_5 = arith.constant 1 : index
    %c2_6 = arith.constant 2 : index
    %cst_7 = arith.constant 1.000000e+00 : f64
    affine.store %cst_7, %alloc_0[%c0_4] : memref<3xf64>
    %cst_8 = arith.constant 2.000000e+00 : f64
    affine.store %cst_8, %alloc_0[%c1_5] : memref<3xf64>
    %cst_9 = arith.constant 3.000000e+00 : f64
    affine.store %cst_9, %alloc_0[%c2_6] : memref<3xf64>
    linalg.dot ins(%alloc_1, %alloc_0 : memref<3xf64>, memref<3xf64>) outs(%alloc : memref<f64>)
    engine.print %alloc : memref<f64>
    memref.dealloc %alloc_1 : memref<3xf64>
    memref.dealloc %alloc_0 : memref<3xf64>
    memref.dealloc %alloc : memref<f64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %c3 = arith.constant 3 : index
    %cst = arith.constant 3.000000e+00 : f64
    %cst_0 = arith.constant 2.000000e+00 : f64
    %cst_1 = arith.constant 1.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<f64>
    %alloc_2 = memref.alloc() : memref<3xf64>
    %alloc_3 = memref.alloc() : memref<3xf64>
    affine.store %cst_1, %alloc_3[%c0] : memref<3xf64>
    affine.store %cst_0, %alloc_3[%c1] : memref<3xf64>
    affine.store %cst, %alloc_3[%c2] : memref<3xf64>
    affine.store %cst_1, %alloc_2[%c0] : memref<3xf64>
    affine.store %cst_0, %alloc_2[%c1] : memref<3xf64>
    affine.store %cst, %alloc_2[%c2] : memref<3xf64>
    scf.for %arg0 = %c0 to %c3 step %c1 {
      %0 = memref.load %alloc_3[%arg0] : memref<3xf64>
      %1 = memref.load %alloc_2[%arg0] : memref<3xf64>
      %2 = memref.load %alloc[] : memref<f64>
      %3 = arith.mulf %0, %1 : f64
      %4 = arith.addf %2, %3 : f64
      memref.store %4, %alloc[] : memref<f64>
    }
    engine.print %alloc : memref<f64>
    memref.dealloc %alloc_3 : memref<3xf64>
    memref.dealloc %alloc_2 : memref<3xf64>
    memref.dealloc %alloc : memref<f64>
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
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(2 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.getelementptr %8[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr
    %12 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr, ptr, i64)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr, ptr, i64)> 
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr, ptr, i64)> 
    %17 = llvm.mlir.constant(3 : index) : i64
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.getelementptr %19[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %21 = llvm.ptrtoint %20 : !llvm.ptr to i64
    %22 = llvm.call @malloc(%21) : (i64) -> !llvm.ptr
    %23 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = llvm.insertvalue %22, %23[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.insertvalue %22, %24[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.mlir.constant(0 : index) : i64
    %27 = llvm.insertvalue %26, %25[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %17, %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.insertvalue %18, %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.mlir.constant(3 : index) : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.mlir.zero : !llvm.ptr
    %33 = llvm.getelementptr %32[%30] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %34 = llvm.ptrtoint %33 : !llvm.ptr to i64
    %35 = llvm.call @malloc(%34) : (i64) -> !llvm.ptr
    %36 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %37 = llvm.insertvalue %35, %36[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.insertvalue %35, %37[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.mlir.constant(0 : index) : i64
    %40 = llvm.insertvalue %39, %38[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %41 = llvm.insertvalue %30, %40[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %42 = llvm.insertvalue %31, %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.getelementptr %43[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %44 : f64, !llvm.ptr
    %45 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.getelementptr %45[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %46 : f64, !llvm.ptr
    %47 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.getelementptr %47[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %48 : f64, !llvm.ptr
    %49 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %50 = llvm.getelementptr %49[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %50 : f64, !llvm.ptr
    %51 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %52 = llvm.getelementptr %51[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %52 : f64, !llvm.ptr
    %53 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %54 = llvm.getelementptr %53[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %54 : f64, !llvm.ptr
    llvm.br ^bb1(%6 : i64)
  ^bb1(%55: i64):  // 2 preds: ^bb0, ^bb2
    %56 = llvm.icmp "slt" %55, %0 : i64
    llvm.cond_br %56, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %57 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %58 = llvm.getelementptr %57[%55] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %59 = llvm.load %58 : !llvm.ptr -> f64
    %60 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.getelementptr %60[%55] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %62 = llvm.load %61 : !llvm.ptr -> f64
    %63 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64)> 
    %64 = llvm.load %63 : !llvm.ptr -> f64
    %65 = llvm.fmul %59, %62 : f64
    %66 = llvm.fadd %64, %65 : f64
    %67 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %66, %67 : f64, !llvm.ptr
    %68 = llvm.add %55, %5 : i64
    llvm.br ^bb1(%68 : i64)
  ^bb3:  // pred: ^bb1
    %69 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %70 = llvm.mlir.constant(0 : index) : i64
    %71 = llvm.getelementptr %69[%70, %70] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %72 = llvm.mlir.addressof @nl : !llvm.ptr
    %73 = llvm.mlir.constant(0 : index) : i64
    %74 = llvm.getelementptr %72[%73, %73] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %75 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64)> 
    %76 = llvm.load %75 : !llvm.ptr -> f64
    %77 = llvm.call @printf(%71, %76) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %78 = llvm.extractvalue %42[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @free(%78) : (!llvm.ptr) -> ()
    %79 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @free(%79) : (!llvm.ptr) -> ()
    %80 = llvm.extractvalue %16[0] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.call @free(%80) : (!llvm.ptr) -> ()
    llvm.return
  }
}


14.000000 