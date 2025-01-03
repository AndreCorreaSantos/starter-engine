// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[[1.000000e+00, -2.000000e+00, 3.000000e+00],[1.000000e+00, -2.000000e+00, 3.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    %2 = "engine.relu"(%0) : (memref<2x3xf64>) -> memref<2x3xf64>
    "engine.print"(%2) : (memref<2x3xf64>) -> ()
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
    %cst_1 = arith.constant -2.000000e+00 : f64
    affine.store %cst_1, %alloc_0[%c0, %c1] : memref<2x3xf64>
    %cst_2 = arith.constant 3.000000e+00 : f64
    affine.store %cst_2, %alloc_0[%c0, %c2] : memref<2x3xf64>
    %cst_3 = arith.constant 1.000000e+00 : f64
    affine.store %cst_3, %alloc_0[%c1, %c0] : memref<2x3xf64>
    %cst_4 = arith.constant -2.000000e+00 : f64
    affine.store %cst_4, %alloc_0[%c1, %c1] : memref<2x3xf64>
    %cst_5 = arith.constant 3.000000e+00 : f64
    affine.store %cst_5, %alloc_0[%c1, %c2] : memref<2x3xf64>
    %c0_6 = arith.constant 0 : index
    %c1_7 = arith.constant 1 : index
    %c2_8 = arith.constant 2 : index
    %cst_9 = arith.constant 0.000000e+00 : f64
    %0 = affine.load %alloc_0[%c0_6, %c0_6] : memref<2x3xf64>
    %1 = arith.cmpf ogt, %0, %cst_9 : f64
    %2 = arith.select %1, %0, %cst_9 : f64
    affine.store %2, %alloc[%c0_6, %c0_6] : memref<2x3xf64>
    %3 = affine.load %alloc_0[%c0_6, %c1_7] : memref<2x3xf64>
    %4 = arith.cmpf ogt, %3, %cst_9 : f64
    %5 = arith.select %4, %3, %cst_9 : f64
    affine.store %5, %alloc[%c0_6, %c1_7] : memref<2x3xf64>
    %6 = affine.load %alloc_0[%c0_6, %c2_8] : memref<2x3xf64>
    %7 = arith.cmpf ogt, %6, %cst_9 : f64
    %8 = arith.select %7, %6, %cst_9 : f64
    affine.store %8, %alloc[%c0_6, %c2_8] : memref<2x3xf64>
    %9 = affine.load %alloc_0[%c1_7, %c0_6] : memref<2x3xf64>
    %10 = arith.cmpf ogt, %9, %cst_9 : f64
    %11 = arith.select %10, %9, %cst_9 : f64
    affine.store %11, %alloc[%c1_7, %c0_6] : memref<2x3xf64>
    %12 = affine.load %alloc_0[%c1_7, %c1_7] : memref<2x3xf64>
    %13 = arith.cmpf ogt, %12, %cst_9 : f64
    %14 = arith.select %13, %12, %cst_9 : f64
    affine.store %14, %alloc[%c1_7, %c1_7] : memref<2x3xf64>
    %15 = affine.load %alloc_0[%c1_7, %c2_8] : memref<2x3xf64>
    %16 = arith.cmpf ogt, %15, %cst_9 : f64
    %17 = arith.select %16, %15, %cst_9 : f64
    affine.store %17, %alloc[%c1_7, %c2_8] : memref<2x3xf64>
    engine.print %alloc : memref<2x3xf64>
    memref.dealloc %alloc_0 : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 3.000000e+00 : f64
    %cst_1 = arith.constant -2.000000e+00 : f64
    %cst_2 = arith.constant 1.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<2x3xf64>
    %alloc_3 = memref.alloc() : memref<2x3xf64>
    affine.store %cst_2, %alloc_3[%c0, %c0] : memref<2x3xf64>
    affine.store %cst_1, %alloc_3[%c0, %c1] : memref<2x3xf64>
    affine.store %cst_0, %alloc_3[%c0, %c2] : memref<2x3xf64>
    affine.store %cst_2, %alloc_3[%c1, %c0] : memref<2x3xf64>
    affine.store %cst_1, %alloc_3[%c1, %c1] : memref<2x3xf64>
    affine.store %cst_0, %alloc_3[%c1, %c2] : memref<2x3xf64>
    %0 = affine.load %alloc_3[%c0, %c0] : memref<2x3xf64>
    %1 = arith.cmpf ogt, %0, %cst : f64
    %2 = arith.select %1, %0, %cst : f64
    affine.store %2, %alloc[%c0, %c0] : memref<2x3xf64>
    %3 = affine.load %alloc_3[%c0, %c1] : memref<2x3xf64>
    %4 = arith.cmpf ogt, %3, %cst : f64
    %5 = arith.select %4, %3, %cst : f64
    affine.store %5, %alloc[%c0, %c1] : memref<2x3xf64>
    %6 = affine.load %alloc_3[%c0, %c2] : memref<2x3xf64>
    %7 = arith.cmpf ogt, %6, %cst : f64
    %8 = arith.select %7, %6, %cst : f64
    affine.store %8, %alloc[%c0, %c2] : memref<2x3xf64>
    %9 = affine.load %alloc_3[%c1, %c0] : memref<2x3xf64>
    %10 = arith.cmpf ogt, %9, %cst : f64
    %11 = arith.select %10, %9, %cst : f64
    affine.store %11, %alloc[%c1, %c0] : memref<2x3xf64>
    %12 = affine.load %alloc_3[%c1, %c1] : memref<2x3xf64>
    %13 = arith.cmpf ogt, %12, %cst : f64
    %14 = arith.select %13, %12, %cst : f64
    affine.store %14, %alloc[%c1, %c1] : memref<2x3xf64>
    %15 = affine.load %alloc_3[%c1, %c2] : memref<2x3xf64>
    %16 = arith.cmpf ogt, %15, %cst : f64
    %17 = arith.select %16, %15, %cst : f64
    affine.store %17, %alloc[%c1, %c2] : memref<2x3xf64>
    engine.print %alloc : memref<2x3xf64>
    memref.dealloc %alloc_3 : memref<2x3xf64>
    memref.dealloc %alloc : memref<2x3xf64>
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
    %1 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(-2.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(2 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.mlir.constant(2 : index) : i64
    %8 = llvm.mlir.constant(3 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(6 : index) : i64
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
    %24 = llvm.mlir.constant(2 : index) : i64
    %25 = llvm.mlir.constant(3 : index) : i64
    %26 = llvm.mlir.constant(1 : index) : i64
    %27 = llvm.mlir.constant(6 : index) : i64
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
    %41 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.mlir.constant(3 : index) : i64
    %43 = llvm.mul %6, %42 : i64
    %44 = llvm.add %43, %6 : i64
    %45 = llvm.getelementptr %41[%44] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %45 : f64, !llvm.ptr
    %46 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %47 = llvm.mlir.constant(3 : index) : i64
    %48 = llvm.mul %6, %47 : i64
    %49 = llvm.add %48, %5 : i64
    %50 = llvm.getelementptr %46[%49] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %50 : f64, !llvm.ptr
    %51 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mlir.constant(3 : index) : i64
    %53 = llvm.mul %6, %52 : i64
    %54 = llvm.add %53, %4 : i64
    %55 = llvm.getelementptr %51[%54] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %55 : f64, !llvm.ptr
    %56 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.mlir.constant(3 : index) : i64
    %58 = llvm.mul %5, %57 : i64
    %59 = llvm.add %58, %6 : i64
    %60 = llvm.getelementptr %56[%59] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %60 : f64, !llvm.ptr
    %61 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.mlir.constant(3 : index) : i64
    %63 = llvm.mul %5, %62 : i64
    %64 = llvm.add %63, %5 : i64
    %65 = llvm.getelementptr %61[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %65 : f64, !llvm.ptr
    %66 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %67 = llvm.mlir.constant(3 : index) : i64
    %68 = llvm.mul %5, %67 : i64
    %69 = llvm.add %68, %4 : i64
    %70 = llvm.getelementptr %66[%69] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %70 : f64, !llvm.ptr
    %71 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.mlir.constant(3 : index) : i64
    %73 = llvm.mul %6, %72 : i64
    %74 = llvm.add %73, %6 : i64
    %75 = llvm.getelementptr %71[%74] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %76 = llvm.load %75 : !llvm.ptr -> f64
    %77 = llvm.fcmp "ogt" %76, %0 : f64
    %78 = llvm.select %77, %76, %0 : i1, f64
    %79 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %80 = llvm.mlir.constant(3 : index) : i64
    %81 = llvm.mul %6, %80 : i64
    %82 = llvm.add %81, %6 : i64
    %83 = llvm.getelementptr %79[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %78, %83 : f64, !llvm.ptr
    %84 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %85 = llvm.mlir.constant(3 : index) : i64
    %86 = llvm.mul %6, %85 : i64
    %87 = llvm.add %86, %5 : i64
    %88 = llvm.getelementptr %84[%87] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %89 = llvm.load %88 : !llvm.ptr -> f64
    %90 = llvm.fcmp "ogt" %89, %0 : f64
    %91 = llvm.select %90, %89, %0 : i1, f64
    %92 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %93 = llvm.mlir.constant(3 : index) : i64
    %94 = llvm.mul %6, %93 : i64
    %95 = llvm.add %94, %5 : i64
    %96 = llvm.getelementptr %92[%95] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %91, %96 : f64, !llvm.ptr
    %97 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %98 = llvm.mlir.constant(3 : index) : i64
    %99 = llvm.mul %6, %98 : i64
    %100 = llvm.add %99, %4 : i64
    %101 = llvm.getelementptr %97[%100] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %102 = llvm.load %101 : !llvm.ptr -> f64
    %103 = llvm.fcmp "ogt" %102, %0 : f64
    %104 = llvm.select %103, %102, %0 : i1, f64
    %105 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.mlir.constant(3 : index) : i64
    %107 = llvm.mul %6, %106 : i64
    %108 = llvm.add %107, %4 : i64
    %109 = llvm.getelementptr %105[%108] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %104, %109 : f64, !llvm.ptr
    %110 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.mlir.constant(3 : index) : i64
    %112 = llvm.mul %5, %111 : i64
    %113 = llvm.add %112, %6 : i64
    %114 = llvm.getelementptr %110[%113] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %115 = llvm.load %114 : !llvm.ptr -> f64
    %116 = llvm.fcmp "ogt" %115, %0 : f64
    %117 = llvm.select %116, %115, %0 : i1, f64
    %118 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %119 = llvm.mlir.constant(3 : index) : i64
    %120 = llvm.mul %5, %119 : i64
    %121 = llvm.add %120, %6 : i64
    %122 = llvm.getelementptr %118[%121] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %117, %122 : f64, !llvm.ptr
    %123 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %124 = llvm.mlir.constant(3 : index) : i64
    %125 = llvm.mul %5, %124 : i64
    %126 = llvm.add %125, %5 : i64
    %127 = llvm.getelementptr %123[%126] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %128 = llvm.load %127 : !llvm.ptr -> f64
    %129 = llvm.fcmp "ogt" %128, %0 : f64
    %130 = llvm.select %129, %128, %0 : i1, f64
    %131 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %132 = llvm.mlir.constant(3 : index) : i64
    %133 = llvm.mul %5, %132 : i64
    %134 = llvm.add %133, %5 : i64
    %135 = llvm.getelementptr %131[%134] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %130, %135 : f64, !llvm.ptr
    %136 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %137 = llvm.mlir.constant(3 : index) : i64
    %138 = llvm.mul %5, %137 : i64
    %139 = llvm.add %138, %4 : i64
    %140 = llvm.getelementptr %136[%139] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %141 = llvm.load %140 : !llvm.ptr -> f64
    %142 = llvm.fcmp "ogt" %141, %0 : f64
    %143 = llvm.select %142, %141, %0 : i1, f64
    %144 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %145 = llvm.mlir.constant(3 : index) : i64
    %146 = llvm.mul %5, %145 : i64
    %147 = llvm.add %146, %4 : i64
    %148 = llvm.getelementptr %144[%147] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %143, %148 : f64, !llvm.ptr
    %149 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %150 = llvm.mlir.constant(0 : index) : i64
    %151 = llvm.getelementptr %149[%150, %150] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %152 = llvm.mlir.addressof @nl : !llvm.ptr
    %153 = llvm.mlir.constant(0 : index) : i64
    %154 = llvm.getelementptr %152[%153, %153] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %155 = llvm.mlir.constant(0 : index) : i64
    %156 = llvm.mlir.constant(2 : index) : i64
    %157 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%155 : i64)
  ^bb1(%158: i64):  // 2 preds: ^bb0, ^bb5
    %159 = llvm.icmp "slt" %158, %156 : i64
    llvm.cond_br %159, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %160 = llvm.mlir.constant(0 : index) : i64
    %161 = llvm.mlir.constant(3 : index) : i64
    %162 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%160 : i64)
  ^bb3(%163: i64):  // 2 preds: ^bb2, ^bb4
    %164 = llvm.icmp "slt" %163, %161 : i64
    llvm.cond_br %164, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %165 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %166 = llvm.mlir.constant(3 : index) : i64
    %167 = llvm.mul %158, %166 : i64
    %168 = llvm.add %167, %163 : i64
    %169 = llvm.getelementptr %165[%168] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %170 = llvm.load %169 : !llvm.ptr -> f64
    %171 = llvm.call @printf(%151, %170) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %172 = llvm.add %163, %162 : i64
    llvm.br ^bb3(%172 : i64)
  ^bb5:  // pred: ^bb3
    %173 = llvm.call @printf(%154) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %174 = llvm.add %158, %157 : i64
    llvm.br ^bb1(%174 : i64)
  ^bb6:  // pred: ^bb1
    %175 = llvm.extractvalue %40[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%175) : (!llvm.ptr) -> ()
    %176 = llvm.extractvalue %23[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%176) : (!llvm.ptr) -> ()
    llvm.return
  }
}


1.000000 0.000000 3.000000 
1.000000 0.000000 3.000000 
