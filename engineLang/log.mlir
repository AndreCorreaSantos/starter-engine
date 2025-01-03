// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
  %0 = "engine.constant"() {value = dense<[[1.0], [2.0], [3.0]]> : tensor<3x1xf64>} : () -> memref<3x1xf64>
  %1 = "engine.constant"() {value = dense<[[1.0, 2.0, 3.0]]> : tensor<1x3xf64>} : () -> memref<1x3xf64>
  %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1x3xf64>) -> memref<3x3xf64>

  "engine.print"(%2) : (memref<3x3xf64>) -> ()
  return
}
LHS_Shape: [3 1 ]
RHS_Shape: [1 3 ]
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<3x3xf64>
    %alloc_0 = memref.alloc() : memref<1x3xf64>
    %alloc_1 = memref.alloc() : memref<3x1xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc_1[%c0, %c0] : memref<3x1xf64>
    %cst_2 = arith.constant 2.000000e+00 : f64
    affine.store %cst_2, %alloc_1[%c1, %c0] : memref<3x1xf64>
    %cst_3 = arith.constant 3.000000e+00 : f64
    affine.store %cst_3, %alloc_1[%c2, %c0] : memref<3x1xf64>
    %c0_4 = arith.constant 0 : index
    %c1_5 = arith.constant 1 : index
    %c2_6 = arith.constant 2 : index
    %cst_7 = arith.constant 1.000000e+00 : f64
    affine.store %cst_7, %alloc_0[%c0_4, %c0_4] : memref<1x3xf64>
    %cst_8 = arith.constant 2.000000e+00 : f64
    affine.store %cst_8, %alloc_0[%c0_4, %c1_5] : memref<1x3xf64>
    %cst_9 = arith.constant 3.000000e+00 : f64
    affine.store %cst_9, %alloc_0[%c0_4, %c2_6] : memref<1x3xf64>
    linalg.matmul ins(%alloc_1, %alloc_0 : memref<3x1xf64>, memref<1x3xf64>) outs(%alloc : memref<3x3xf64>)
    engine.print %alloc : memref<3x3xf64>
    memref.dealloc %alloc_1 : memref<3x1xf64>
    memref.dealloc %alloc_0 : memref<1x3xf64>
    memref.dealloc %alloc : memref<3x3xf64>
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
    %alloc = memref.alloc() : memref<3x3xf64>
    %alloc_2 = memref.alloc() : memref<1x3xf64>
    %alloc_3 = memref.alloc() : memref<3x1xf64>
    affine.store %cst_1, %alloc_3[%c0, %c0] : memref<3x1xf64>
    affine.store %cst_0, %alloc_3[%c1, %c0] : memref<3x1xf64>
    affine.store %cst, %alloc_3[%c2, %c0] : memref<3x1xf64>
    affine.store %cst_1, %alloc_2[%c0, %c0] : memref<1x3xf64>
    affine.store %cst_0, %alloc_2[%c0, %c1] : memref<1x3xf64>
    affine.store %cst, %alloc_2[%c0, %c2] : memref<1x3xf64>
    scf.for %arg0 = %c0 to %c3 step %c1 {
      scf.for %arg1 = %c0 to %c3 step %c1 {
        scf.for %arg2 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_3[%arg0, %arg2] : memref<3x1xf64>
          %1 = memref.load %alloc_2[%arg2, %arg1] : memref<1x3xf64>
          %2 = memref.load %alloc[%arg0, %arg1] : memref<3x3xf64>
          %3 = arith.mulf %0, %1 : f64
          %4 = arith.addf %2, %3 : f64
          memref.store %4, %alloc[%arg0, %arg1] : memref<3x3xf64>
        }
      }
    }
    engine.print %alloc : memref<3x3xf64>
    memref.dealloc %alloc_3 : memref<3x1xf64>
    memref.dealloc %alloc_2 : memref<1x3xf64>
    memref.dealloc %alloc : memref<3x3xf64>
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
    %7 = llvm.mlir.constant(3 : index) : i64
    %8 = llvm.mlir.constant(3 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(9 : index) : i64
    %11 = llvm.mlir.zero : !llvm.ptr
    %12 = llvm.getelementptr %11[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.call @malloc(%13) : (i64) -> !llvm.ptr
    %15 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = llvm.insertvalue %14, %15[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %14, %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.mlir.constant(0 : index) : i64
    %19 = llvm.insertvalue %18, %17[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %7, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %8, %20[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %8, %21[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %9, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.mlir.constant(3 : index) : i64
    %26 = llvm.mlir.constant(1 : index) : i64
    %27 = llvm.mlir.constant(3 : index) : i64
    %28 = llvm.mlir.zero : !llvm.ptr
    %29 = llvm.getelementptr %28[%27] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %30 = llvm.ptrtoint %29 : !llvm.ptr to i64
    %31 = llvm.call @malloc(%30) : (i64) -> !llvm.ptr
    %32 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %33 = llvm.insertvalue %31, %32[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %31, %33[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.mlir.constant(0 : index) : i64
    %36 = llvm.insertvalue %35, %34[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %24, %36[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.insertvalue %25, %37[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.insertvalue %25, %38[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.insertvalue %26, %39[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.mlir.constant(3 : index) : i64
    %42 = llvm.mlir.constant(1 : index) : i64
    %43 = llvm.mlir.constant(1 : index) : i64
    %44 = llvm.mlir.zero : !llvm.ptr
    %45 = llvm.getelementptr %44[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %46 = llvm.ptrtoint %45 : !llvm.ptr to i64
    %47 = llvm.call @malloc(%46) : (i64) -> !llvm.ptr
    %48 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %49 = llvm.insertvalue %47, %48[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.insertvalue %47, %49[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.mlir.constant(0 : index) : i64
    %52 = llvm.insertvalue %51, %50[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %41, %52[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %42, %53[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %42, %54[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %43, %55[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.extractvalue %56[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.add %6, %6 : i64
    %59 = llvm.getelementptr %57[%58] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %59 : f64, !llvm.ptr
    %60 = llvm.extractvalue %56[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.add %5, %6 : i64
    %62 = llvm.getelementptr %60[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %62 : f64, !llvm.ptr
    %63 = llvm.extractvalue %56[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %64 = llvm.add %4, %6 : i64
    %65 = llvm.getelementptr %63[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %65 : f64, !llvm.ptr
    %66 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %67 = llvm.mlir.constant(3 : index) : i64
    %68 = llvm.mul %6, %67 : i64
    %69 = llvm.add %68, %6 : i64
    %70 = llvm.getelementptr %66[%69] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %70 : f64, !llvm.ptr
    %71 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.mlir.constant(3 : index) : i64
    %73 = llvm.mul %6, %72 : i64
    %74 = llvm.add %73, %5 : i64
    %75 = llvm.getelementptr %71[%74] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %75 : f64, !llvm.ptr
    %76 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %77 = llvm.mlir.constant(3 : index) : i64
    %78 = llvm.mul %6, %77 : i64
    %79 = llvm.add %78, %4 : i64
    %80 = llvm.getelementptr %76[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %80 : f64, !llvm.ptr
    llvm.br ^bb1(%6 : i64)
  ^bb1(%81: i64):  // 2 preds: ^bb0, ^bb8
    %82 = llvm.icmp "slt" %81, %0 : i64
    llvm.cond_br %82, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%6 : i64)
  ^bb3(%83: i64):  // 2 preds: ^bb2, ^bb7
    %84 = llvm.icmp "slt" %83, %0 : i64
    llvm.cond_br %84, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%6 : i64)
  ^bb5(%85: i64):  // 2 preds: ^bb4, ^bb6
    %86 = llvm.icmp "slt" %85, %5 : i64
    llvm.cond_br %86, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %87 = llvm.extractvalue %56[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %88 = llvm.add %81, %85 : i64
    %89 = llvm.getelementptr %87[%88] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %90 = llvm.load %89 : !llvm.ptr -> f64
    %91 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %92 = llvm.mlir.constant(3 : index) : i64
    %93 = llvm.mul %85, %92 : i64
    %94 = llvm.add %93, %83 : i64
    %95 = llvm.getelementptr %91[%94] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %96 = llvm.load %95 : !llvm.ptr -> f64
    %97 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %98 = llvm.mlir.constant(3 : index) : i64
    %99 = llvm.mul %81, %98 : i64
    %100 = llvm.add %99, %83 : i64
    %101 = llvm.getelementptr %97[%100] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %102 = llvm.load %101 : !llvm.ptr -> f64
    %103 = llvm.fmul %90, %96 : f64
    %104 = llvm.fadd %102, %103 : f64
    %105 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.mlir.constant(3 : index) : i64
    %107 = llvm.mul %81, %106 : i64
    %108 = llvm.add %107, %83 : i64
    %109 = llvm.getelementptr %105[%108] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %104, %109 : f64, !llvm.ptr
    %110 = llvm.add %85, %5 : i64
    llvm.br ^bb5(%110 : i64)
  ^bb7:  // pred: ^bb5
    %111 = llvm.add %83, %5 : i64
    llvm.br ^bb3(%111 : i64)
  ^bb8:  // pred: ^bb3
    %112 = llvm.add %81, %5 : i64
    llvm.br ^bb1(%112 : i64)
  ^bb9:  // pred: ^bb1
    %113 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %114 = llvm.mlir.constant(0 : index) : i64
    %115 = llvm.getelementptr %113[%114, %114] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %116 = llvm.mlir.addressof @nl : !llvm.ptr
    %117 = llvm.mlir.constant(0 : index) : i64
    %118 = llvm.getelementptr %116[%117, %117] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %119 = llvm.mlir.constant(0 : index) : i64
    %120 = llvm.mlir.constant(3 : index) : i64
    %121 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb10(%119 : i64)
  ^bb10(%122: i64):  // 2 preds: ^bb9, ^bb14
    %123 = llvm.icmp "slt" %122, %120 : i64
    llvm.cond_br %123, ^bb11, ^bb15
  ^bb11:  // pred: ^bb10
    %124 = llvm.mlir.constant(0 : index) : i64
    %125 = llvm.mlir.constant(3 : index) : i64
    %126 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb12(%124 : i64)
  ^bb12(%127: i64):  // 2 preds: ^bb11, ^bb13
    %128 = llvm.icmp "slt" %127, %125 : i64
    llvm.cond_br %128, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %129 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %130 = llvm.mlir.constant(3 : index) : i64
    %131 = llvm.mul %122, %130 : i64
    %132 = llvm.add %131, %127 : i64
    %133 = llvm.getelementptr %129[%132] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %134 = llvm.load %133 : !llvm.ptr -> f64
    %135 = llvm.call @printf(%115, %134) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %136 = llvm.add %127, %126 : i64
    llvm.br ^bb12(%136 : i64)
  ^bb14:  // pred: ^bb12
    %137 = llvm.call @printf(%118) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %138 = llvm.add %122, %121 : i64
    llvm.br ^bb10(%138 : i64)
  ^bb15:  // pred: ^bb10
    %139 = llvm.extractvalue %56[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%139) : (!llvm.ptr) -> ()
    %140 = llvm.extractvalue %40[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%140) : (!llvm.ptr) -> ()
    %141 = llvm.extractvalue %23[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%141) : (!llvm.ptr) -> ()
    llvm.return
  }
}


1.000000 2.000000 3.000000 
2.000000 4.000000 6.000000 
3.000000 6.000000 9.000000 
