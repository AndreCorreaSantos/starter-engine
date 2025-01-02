// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
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
    affine.for %arg0 = 0 to 2 {
      affine.for %arg1 = 0 to 3 {
        %0 = affine.load %alloc_1[%arg0, %arg1] : memref<2x3xf64>
        %1 = affine.load %alloc_0[%arg0, %arg1] : memref<2x3xf64>
        %2 = arith.divf %0, %1 : f64
        affine.store %2, %alloc[%arg0, %arg1] : memref<2x3xf64>
      }
    }
    engine.print %alloc : memref<2x3xf64>
    memref.dealloc %alloc_1 : memref<2x3xf64>
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
    affine.for %arg0 = 0 to 2 {
      affine.for %arg1 = 0 to 3 {
        %0 = affine.load %alloc_6[%arg0, %arg1] : memref<2x3xf64>
        %1 = affine.load %alloc_5[%arg0, %arg1] : memref<2x3xf64>
        %2 = arith.divf %0, %1 : f64
        affine.store %2, %alloc[%arg0, %arg1] : memref<2x3xf64>
      }
    }
    engine.print %alloc : memref<2x3xf64>
    memref.dealloc %alloc_6 : memref<2x3xf64>
    memref.dealloc %alloc_5 : memref<2x3xf64>
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
    %43 = llvm.mlir.constant(2 : index) : i64
    %44 = llvm.mlir.constant(3 : index) : i64
    %45 = llvm.mlir.constant(1 : index) : i64
    %46 = llvm.mlir.constant(6 : index) : i64
    %47 = llvm.mlir.zero : !llvm.ptr
    %48 = llvm.getelementptr %47[%46] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %49 = llvm.ptrtoint %48 : !llvm.ptr to i64
    %50 = llvm.call @malloc(%49) : (i64) -> !llvm.ptr
    %51 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %52 = llvm.insertvalue %50, %51[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %50, %52[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.mlir.constant(0 : index) : i64
    %55 = llvm.insertvalue %54, %53[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %43, %55[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %44, %56[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %44, %57[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.insertvalue %45, %58[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.mlir.constant(3 : index) : i64
    %62 = llvm.mul %8, %61 : i64
    %63 = llvm.add %62, %8 : i64
    %64 = llvm.getelementptr %60[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %64 : f64, !llvm.ptr
    %65 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %66 = llvm.mlir.constant(3 : index) : i64
    %67 = llvm.mul %8, %66 : i64
    %68 = llvm.add %67, %7 : i64
    %69 = llvm.getelementptr %65[%68] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %69 : f64, !llvm.ptr
    %70 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %71 = llvm.mlir.constant(3 : index) : i64
    %72 = llvm.mul %8, %71 : i64
    %73 = llvm.add %72, %6 : i64
    %74 = llvm.getelementptr %70[%73] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %74 : f64, !llvm.ptr
    %75 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %76 = llvm.mlir.constant(3 : index) : i64
    %77 = llvm.mul %7, %76 : i64
    %78 = llvm.add %77, %8 : i64
    %79 = llvm.getelementptr %75[%78] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %79 : f64, !llvm.ptr
    %80 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %81 = llvm.mlir.constant(3 : index) : i64
    %82 = llvm.mul %7, %81 : i64
    %83 = llvm.add %82, %7 : i64
    %84 = llvm.getelementptr %80[%83] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %84 : f64, !llvm.ptr
    %85 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %86 = llvm.mlir.constant(3 : index) : i64
    %87 = llvm.mul %7, %86 : i64
    %88 = llvm.add %87, %6 : i64
    %89 = llvm.getelementptr %85[%88] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %89 : f64, !llvm.ptr
    %90 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %91 = llvm.mlir.constant(3 : index) : i64
    %92 = llvm.mul %8, %91 : i64
    %93 = llvm.add %92, %8 : i64
    %94 = llvm.getelementptr %90[%93] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %94 : f64, !llvm.ptr
    %95 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %96 = llvm.mlir.constant(3 : index) : i64
    %97 = llvm.mul %8, %96 : i64
    %98 = llvm.add %97, %7 : i64
    %99 = llvm.getelementptr %95[%98] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %99 : f64, !llvm.ptr
    %100 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %101 = llvm.mlir.constant(3 : index) : i64
    %102 = llvm.mul %8, %101 : i64
    %103 = llvm.add %102, %6 : i64
    %104 = llvm.getelementptr %100[%103] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %104 : f64, !llvm.ptr
    %105 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.mlir.constant(3 : index) : i64
    %107 = llvm.mul %7, %106 : i64
    %108 = llvm.add %107, %8 : i64
    %109 = llvm.getelementptr %105[%108] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %109 : f64, !llvm.ptr
    %110 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.mlir.constant(3 : index) : i64
    %112 = llvm.mul %7, %111 : i64
    %113 = llvm.add %112, %7 : i64
    %114 = llvm.getelementptr %110[%113] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %114 : f64, !llvm.ptr
    %115 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %116 = llvm.mlir.constant(3 : index) : i64
    %117 = llvm.mul %7, %116 : i64
    %118 = llvm.add %117, %6 : i64
    %119 = llvm.getelementptr %115[%118] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %119 : f64, !llvm.ptr
    %120 = llvm.mlir.constant(0 : index) : i64
    %121 = llvm.mlir.constant(2 : index) : i64
    %122 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%120 : i64)
  ^bb1(%123: i64):  // 2 preds: ^bb0, ^bb5
    %124 = llvm.icmp "slt" %123, %121 : i64
    llvm.cond_br %124, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %125 = llvm.mlir.constant(0 : index) : i64
    %126 = llvm.mlir.constant(3 : index) : i64
    %127 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%125 : i64)
  ^bb3(%128: i64):  // 2 preds: ^bb2, ^bb4
    %129 = llvm.icmp "slt" %128, %126 : i64
    llvm.cond_br %129, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %130 = llvm.extractvalue %59[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %131 = llvm.mlir.constant(3 : index) : i64
    %132 = llvm.mul %123, %131 : i64
    %133 = llvm.add %132, %128 : i64
    %134 = llvm.getelementptr %130[%133] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %135 = llvm.load %134 : !llvm.ptr -> f64
    %136 = llvm.extractvalue %42[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %137 = llvm.mlir.constant(3 : index) : i64
    %138 = llvm.mul %123, %137 : i64
    %139 = llvm.add %138, %128 : i64
    %140 = llvm.getelementptr %136[%139] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %141 = llvm.load %140 : !llvm.ptr -> f64
    %142 = llvm.fdiv %135, %141 : f64
    %143 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %144 = llvm.mlir.constant(3 : index) : i64
    %145 = llvm.mul %123, %144 : i64
    %146 = llvm.add %145, %128 : i64
    %147 = llvm.getelementptr %143[%146] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %142, %147 : f64, !llvm.ptr
    %148 = llvm.add %128, %127 : i64
    llvm.br ^bb3(%148 : i64)
  ^bb5:  // pred: ^bb3
    %149 = llvm.add %123, %122 : i64
    llvm.br ^bb1(%149 : i64)
  ^bb6:  // pred: ^bb1
    %150 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %151 = llvm.mlir.constant(0 : index) : i64
    %152 = llvm.getelementptr %150[%151, %151] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %153 = llvm.mlir.addressof @nl : !llvm.ptr
    %154 = llvm.mlir.constant(0 : index) : i64
    %155 = llvm.getelementptr %153[%154, %154] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %156 = llvm.mlir.constant(0 : index) : i64
    %157 = llvm.mlir.constant(2 : index) : i64
    %158 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%156 : i64)
  ^bb7(%159: i64):  // 2 preds: ^bb6, ^bb11
    %160 = llvm.icmp "slt" %159, %157 : i64
    llvm.cond_br %160, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    %161 = llvm.mlir.constant(0 : index) : i64
    %162 = llvm.mlir.constant(3 : index) : i64
    %163 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb9(%161 : i64)
  ^bb9(%164: i64):  // 2 preds: ^bb8, ^bb10
    %165 = llvm.icmp "slt" %164, %162 : i64
    llvm.cond_br %165, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %166 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %167 = llvm.mlir.constant(3 : index) : i64
    %168 = llvm.mul %159, %167 : i64
    %169 = llvm.add %168, %164 : i64
    %170 = llvm.getelementptr %166[%169] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %171 = llvm.load %170 : !llvm.ptr -> f64
    %172 = llvm.call @printf(%152, %171) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %173 = llvm.add %164, %163 : i64
    llvm.br ^bb9(%173 : i64)
  ^bb11:  // pred: ^bb9
    %174 = llvm.call @printf(%155) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %175 = llvm.add %159, %158 : i64
    llvm.br ^bb7(%175 : i64)
  ^bb12:  // pred: ^bb7
    %176 = llvm.extractvalue %59[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%176) : (!llvm.ptr) -> ()
    %177 = llvm.extractvalue %42[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%177) : (!llvm.ptr) -> ()
    %178 = llvm.extractvalue %25[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%178) : (!llvm.ptr) -> ()
    llvm.return
  }
}


1.000000 1.000000 1.000000 
1.000000 1.000000 1.000000 
