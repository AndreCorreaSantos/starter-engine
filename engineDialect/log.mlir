// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[[[[-1,2]]]]> : tensor<1x1x1x2xi32>} : () -> memref<1x1x1x2xi32>
    %2 = "engine.relu"(%0) : (memref<1x1x1x2xi32>) -> memref<1x1x1x2xi32>
    "engine.print"(%2) : (memref<1x1x1x2xi32>) -> ()
    return
}
// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.constant"() <{value = dense<[[[[-1, 2]]]]> : tensor<1x1x1x2xi32>}> : () -> memref<1x1x1x2xi32>
    %1 = "engine.relu"(%0) : (memref<1x1x1x2xi32>) -> memref<1x1x1x2xi32>
    engine.print %1 : memref<1x1x1x2xi32>
    return
  }
}


lowerSettings: 0
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<1x1x1x2xi32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c-1_i32 = arith.constant -1 : i32
    affine.store %c-1_i32, %alloc[%c0, %c0, %c0, %c0] : memref<1x1x1x2xi32>
    %c2_i32 = arith.constant 2 : i32
    affine.store %c2_i32, %alloc[%c0, %c0, %c0, %c1] : memref<1x1x1x2xi32>
    %alloc_0 = memref.alloc() : memref<1x1x1x2xi32>
    %c0_1 = arith.constant 0 : index
    %c1_2 = arith.constant 1 : index
    %c0_i32 = arith.constant 0 : i32
    %0 = affine.load %alloc[%c0_1, %c0_1, %c0_1, %c0_1] : memref<1x1x1x2xi32>
    %1 = arith.cmpi sgt, %0, %c0_i32 : i32
    %2 = arith.select %1, %0, %c0_i32 : i32
    affine.store %2, %alloc_0[%c0_1, %c0_1, %c0_1, %c0_1] : memref<1x1x1x2xi32>
    %3 = affine.load %alloc[%c0_1, %c0_1, %c0_1, %c1_2] : memref<1x1x1x2xi32>
    %4 = arith.cmpi sgt, %3, %c0_i32 : i32
    %5 = arith.select %4, %3, %c0_i32 : i32
    affine.store %5, %alloc_0[%c0_1, %c0_1, %c0_1, %c1_2] : memref<1x1x1x2xi32>
    engine.print %alloc_0 : memref<1x1x1x2xi32>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %c0_i32 = arith.constant 0 : i32
    %c2_i32 = arith.constant 2 : i32
    %c-1_i32 = arith.constant -1 : i32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<1x1x1x2xi32>
    affine.store %c-1_i32, %alloc[%c0, %c0, %c0, %c0] : memref<1x1x1x2xi32>
    affine.store %c2_i32, %alloc[%c0, %c0, %c0, %c1] : memref<1x1x1x2xi32>
    %alloc_0 = memref.alloc() : memref<1x1x1x2xi32>
    %0 = affine.load %alloc[%c0, %c0, %c0, %c0] : memref<1x1x1x2xi32>
    %1 = arith.cmpi sgt, %0, %c0_i32 : i32
    %2 = arith.select %1, %0, %c0_i32 : i32
    affine.store %2, %alloc_0[%c0, %c0, %c0, %c0] : memref<1x1x1x2xi32>
    %3 = affine.load %alloc[%c0, %c0, %c0, %c1] : memref<1x1x1x2xi32>
    %4 = arith.cmpi sgt, %3, %c0_i32 : i32
    %5 = arith.select %4, %3, %c0_i32 : i32
    affine.store %5, %alloc_0[%c0, %c0, %c0, %c1] : memref<1x1x1x2xi32>
    engine.print %alloc_0 : memref<1x1x1x2xi32>
    return
  }
}


// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass () //----- //
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%d \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @main() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(2 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(2 : index) : i64
    %11 = llvm.mlir.constant(2 : index) : i64
    %12 = llvm.mlir.constant(2 : index) : i64
    %13 = llvm.mlir.zero : !llvm.ptr
    %14 = llvm.getelementptr %13[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %15 = llvm.ptrtoint %14 : !llvm.ptr to i64
    %16 = llvm.call @malloc(%15) : (i64) -> !llvm.ptr
    %17 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %22 = llvm.insertvalue %5, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %23 = llvm.insertvalue %6, %22[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.insertvalue %7, %23[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %25 = llvm.insertvalue %8, %24[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %26 = llvm.insertvalue %11, %25[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %27 = llvm.insertvalue %10, %26[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %28 = llvm.insertvalue %8, %27[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %29 = llvm.insertvalue %9, %28[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %30 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %31 = llvm.mlir.constant(2 : index) : i64
    %32 = llvm.mul %4, %31 : i64
    %33 = llvm.mlir.constant(2 : index) : i64
    %34 = llvm.mul %4, %33 : i64
    %35 = llvm.add %32, %34 : i64
    %36 = llvm.mlir.constant(2 : index) : i64
    %37 = llvm.mul %4, %36 : i64
    %38 = llvm.add %35, %37 : i64
    %39 = llvm.add %38, %4 : i64
    %40 = llvm.getelementptr %30[%39] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %40 : i32, !llvm.ptr
    %41 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %42 = llvm.mlir.constant(2 : index) : i64
    %43 = llvm.mul %4, %42 : i64
    %44 = llvm.mlir.constant(2 : index) : i64
    %45 = llvm.mul %4, %44 : i64
    %46 = llvm.add %43, %45 : i64
    %47 = llvm.mlir.constant(2 : index) : i64
    %48 = llvm.mul %4, %47 : i64
    %49 = llvm.add %46, %48 : i64
    %50 = llvm.add %49, %3 : i64
    %51 = llvm.getelementptr %41[%50] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %51 : i32, !llvm.ptr
    %52 = llvm.mlir.constant(1 : index) : i64
    %53 = llvm.mlir.constant(1 : index) : i64
    %54 = llvm.mlir.constant(1 : index) : i64
    %55 = llvm.mlir.constant(2 : index) : i64
    %56 = llvm.mlir.constant(1 : index) : i64
    %57 = llvm.mlir.constant(2 : index) : i64
    %58 = llvm.mlir.constant(2 : index) : i64
    %59 = llvm.mlir.constant(2 : index) : i64
    %60 = llvm.mlir.zero : !llvm.ptr
    %61 = llvm.getelementptr %60[%59] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %62 = llvm.ptrtoint %61 : !llvm.ptr to i64
    %63 = llvm.call @malloc(%62) : (i64) -> !llvm.ptr
    %64 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %65 = llvm.insertvalue %63, %64[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %66 = llvm.insertvalue %63, %65[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %67 = llvm.mlir.constant(0 : index) : i64
    %68 = llvm.insertvalue %67, %66[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %69 = llvm.insertvalue %52, %68[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %70 = llvm.insertvalue %53, %69[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %71 = llvm.insertvalue %54, %70[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %72 = llvm.insertvalue %55, %71[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %73 = llvm.insertvalue %58, %72[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %74 = llvm.insertvalue %57, %73[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %75 = llvm.insertvalue %55, %74[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %76 = llvm.insertvalue %56, %75[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %77 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %78 = llvm.mlir.constant(2 : index) : i64
    %79 = llvm.mul %4, %78 : i64
    %80 = llvm.mlir.constant(2 : index) : i64
    %81 = llvm.mul %4, %80 : i64
    %82 = llvm.add %79, %81 : i64
    %83 = llvm.mlir.constant(2 : index) : i64
    %84 = llvm.mul %4, %83 : i64
    %85 = llvm.add %82, %84 : i64
    %86 = llvm.add %85, %4 : i64
    %87 = llvm.getelementptr %77[%86] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %88 = llvm.load %87 : !llvm.ptr -> i32
    %89 = llvm.icmp "sgt" %88, %0 : i32
    %90 = llvm.select %89, %88, %0 : i1, i32
    %91 = llvm.extractvalue %76[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %92 = llvm.mlir.constant(2 : index) : i64
    %93 = llvm.mul %4, %92 : i64
    %94 = llvm.mlir.constant(2 : index) : i64
    %95 = llvm.mul %4, %94 : i64
    %96 = llvm.add %93, %95 : i64
    %97 = llvm.mlir.constant(2 : index) : i64
    %98 = llvm.mul %4, %97 : i64
    %99 = llvm.add %96, %98 : i64
    %100 = llvm.add %99, %4 : i64
    %101 = llvm.getelementptr %91[%100] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %90, %101 : i32, !llvm.ptr
    %102 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %103 = llvm.mlir.constant(2 : index) : i64
    %104 = llvm.mul %4, %103 : i64
    %105 = llvm.mlir.constant(2 : index) : i64
    %106 = llvm.mul %4, %105 : i64
    %107 = llvm.add %104, %106 : i64
    %108 = llvm.mlir.constant(2 : index) : i64
    %109 = llvm.mul %4, %108 : i64
    %110 = llvm.add %107, %109 : i64
    %111 = llvm.add %110, %3 : i64
    %112 = llvm.getelementptr %102[%111] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %113 = llvm.load %112 : !llvm.ptr -> i32
    %114 = llvm.icmp "sgt" %113, %0 : i32
    %115 = llvm.select %114, %113, %0 : i1, i32
    %116 = llvm.extractvalue %76[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %117 = llvm.mlir.constant(2 : index) : i64
    %118 = llvm.mul %4, %117 : i64
    %119 = llvm.mlir.constant(2 : index) : i64
    %120 = llvm.mul %4, %119 : i64
    %121 = llvm.add %118, %120 : i64
    %122 = llvm.mlir.constant(2 : index) : i64
    %123 = llvm.mul %4, %122 : i64
    %124 = llvm.add %121, %123 : i64
    %125 = llvm.add %124, %3 : i64
    %126 = llvm.getelementptr %116[%125] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %115, %126 : i32, !llvm.ptr
    %127 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %128 = llvm.mlir.constant(0 : index) : i64
    %129 = llvm.getelementptr %127[%128, %128] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %130 = llvm.mlir.addressof @nl : !llvm.ptr
    %131 = llvm.mlir.constant(0 : index) : i64
    %132 = llvm.getelementptr %130[%131, %131] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %133 = llvm.mlir.constant(0 : index) : i64
    %134 = llvm.mlir.constant(1 : index) : i64
    %135 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%133 : i64)
  ^bb1(%136: i64):  // 2 preds: ^bb0, ^bb11
    %137 = llvm.icmp "slt" %136, %134 : i64
    llvm.cond_br %137, ^bb2, ^bb12
  ^bb2:  // pred: ^bb1
    %138 = llvm.mlir.constant(0 : index) : i64
    %139 = llvm.mlir.constant(1 : index) : i64
    %140 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%138 : i64)
  ^bb3(%141: i64):  // 2 preds: ^bb2, ^bb10
    %142 = llvm.icmp "slt" %141, %139 : i64
    llvm.cond_br %142, ^bb4, ^bb11
  ^bb4:  // pred: ^bb3
    %143 = llvm.mlir.constant(0 : index) : i64
    %144 = llvm.mlir.constant(1 : index) : i64
    %145 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb5(%143 : i64)
  ^bb5(%146: i64):  // 2 preds: ^bb4, ^bb9
    %147 = llvm.icmp "slt" %146, %144 : i64
    llvm.cond_br %147, ^bb6, ^bb10
  ^bb6:  // pred: ^bb5
    %148 = llvm.mlir.constant(0 : index) : i64
    %149 = llvm.mlir.constant(2 : index) : i64
    %150 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%148 : i64)
  ^bb7(%151: i64):  // 2 preds: ^bb6, ^bb8
    %152 = llvm.icmp "slt" %151, %149 : i64
    llvm.cond_br %152, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %153 = llvm.extractvalue %76[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %154 = llvm.mlir.constant(2 : index) : i64
    %155 = llvm.mul %136, %154 : i64
    %156 = llvm.mlir.constant(2 : index) : i64
    %157 = llvm.mul %141, %156 : i64
    %158 = llvm.add %155, %157 : i64
    %159 = llvm.mlir.constant(2 : index) : i64
    %160 = llvm.mul %146, %159 : i64
    %161 = llvm.add %158, %160 : i64
    %162 = llvm.add %161, %151 : i64
    %163 = llvm.getelementptr %153[%162] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %164 = llvm.load %163 : !llvm.ptr -> i32
    %165 = llvm.call @printf(%129, %164) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    %166 = llvm.add %151, %150 : i64
    llvm.br ^bb7(%166 : i64)
  ^bb9:  // pred: ^bb7
    %167 = llvm.call @printf(%132) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %168 = llvm.add %146, %145 : i64
    llvm.br ^bb5(%168 : i64)
  ^bb10:  // pred: ^bb5
    %169 = llvm.call @printf(%132) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %170 = llvm.add %141, %140 : i64
    llvm.br ^bb3(%170 : i64)
  ^bb11:  // pred: ^bb3
    %171 = llvm.call @printf(%132) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %172 = llvm.add %136, %135 : i64
    llvm.br ^bb1(%172 : i64)
  ^bb12:  // pred: ^bb1
    llvm.return
  }
}


0 2 


