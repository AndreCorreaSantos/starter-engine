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


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module {
  func.func @main() {
    %c0_i32 = arith.constant 0 : i32
    %c2_i32 = arith.constant 2 : i32
    %c-1_i32 = arith.constant -1 : i32
    %alloc = memref.alloc() : memref<1x1x1x2xi32>
    affine.store %c-1_i32, %alloc[0, 0, 0, 0] : memref<1x1x1x2xi32>
    affine.store %c2_i32, %alloc[0, 0, 0, 1] : memref<1x1x1x2xi32>
    %alloc_0 = memref.alloc() : memref<1x1x1x2xi32>
    %0 = affine.load %alloc[0, 0, 0, 0] : memref<1x1x1x2xi32>
    %1 = arith.cmpi sgt, %0, %c0_i32 : i32
    %2 = arith.select %1, %0, %c0_i32 : i32
    affine.store %2, %alloc_0[0, 0, 0, 0] : memref<1x1x1x2xi32>
    %3 = affine.load %alloc[0, 0, 0, 1] : memref<1x1x1x2xi32>
    %4 = arith.cmpi sgt, %3, %c0_i32 : i32
    %5 = arith.select %4, %3, %c0_i32 : i32
    affine.store %5, %alloc_0[0, 0, 0, 1] : memref<1x1x1x2xi32>
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
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(2 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(2 : index) : i64
    %9 = llvm.mlir.constant(2 : index) : i64
    %10 = llvm.mlir.constant(2 : index) : i64
    %11 = llvm.mlir.zero : !llvm.ptr
    %12 = llvm.getelementptr %11[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.call @malloc(%13) : (i64) -> !llvm.ptr
    %15 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %16 = llvm.insertvalue %14, %15[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.insertvalue %14, %16[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %18 = llvm.mlir.constant(0 : index) : i64
    %19 = llvm.insertvalue %18, %17[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %20 = llvm.insertvalue %3, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = llvm.insertvalue %4, %20[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %22 = llvm.insertvalue %5, %21[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %23 = llvm.insertvalue %6, %22[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.insertvalue %9, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %25 = llvm.insertvalue %8, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %26 = llvm.insertvalue %6, %25[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %27 = llvm.insertvalue %7, %26[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = llvm.mlir.constant(0 : index) : i64
    %32 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %33 = llvm.mlir.constant(2 : index) : i64
    %34 = llvm.mul %28, %33 : i64
    %35 = llvm.mlir.constant(2 : index) : i64
    %36 = llvm.mul %29, %35 : i64
    %37 = llvm.add %34, %36 : i64
    %38 = llvm.mlir.constant(2 : index) : i64
    %39 = llvm.mul %30, %38 : i64
    %40 = llvm.add %37, %39 : i64
    %41 = llvm.add %40, %31 : i64
    %42 = llvm.getelementptr %32[%41] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %42 : i32, !llvm.ptr
    %43 = llvm.mlir.constant(0 : index) : i64
    %44 = llvm.mlir.constant(0 : index) : i64
    %45 = llvm.mlir.constant(0 : index) : i64
    %46 = llvm.mlir.constant(1 : index) : i64
    %47 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %48 = llvm.mlir.constant(2 : index) : i64
    %49 = llvm.mul %43, %48 : i64
    %50 = llvm.mlir.constant(2 : index) : i64
    %51 = llvm.mul %44, %50 : i64
    %52 = llvm.add %49, %51 : i64
    %53 = llvm.mlir.constant(2 : index) : i64
    %54 = llvm.mul %45, %53 : i64
    %55 = llvm.add %52, %54 : i64
    %56 = llvm.add %55, %46 : i64
    %57 = llvm.getelementptr %47[%56] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %57 : i32, !llvm.ptr
    %58 = llvm.mlir.constant(1 : index) : i64
    %59 = llvm.mlir.constant(1 : index) : i64
    %60 = llvm.mlir.constant(1 : index) : i64
    %61 = llvm.mlir.constant(2 : index) : i64
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(2 : index) : i64
    %64 = llvm.mlir.constant(2 : index) : i64
    %65 = llvm.mlir.constant(2 : index) : i64
    %66 = llvm.mlir.zero : !llvm.ptr
    %67 = llvm.getelementptr %66[%65] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %68 = llvm.ptrtoint %67 : !llvm.ptr to i64
    %69 = llvm.call @malloc(%68) : (i64) -> !llvm.ptr
    %70 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %71 = llvm.insertvalue %69, %70[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %72 = llvm.insertvalue %69, %71[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %73 = llvm.mlir.constant(0 : index) : i64
    %74 = llvm.insertvalue %73, %72[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %75 = llvm.insertvalue %58, %74[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %76 = llvm.insertvalue %59, %75[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %77 = llvm.insertvalue %60, %76[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %78 = llvm.insertvalue %61, %77[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %79 = llvm.insertvalue %64, %78[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %80 = llvm.insertvalue %63, %79[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %81 = llvm.insertvalue %61, %80[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %82 = llvm.insertvalue %62, %81[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %83 = llvm.mlir.constant(0 : index) : i64
    %84 = llvm.mlir.constant(0 : index) : i64
    %85 = llvm.mlir.constant(0 : index) : i64
    %86 = llvm.mlir.constant(0 : index) : i64
    %87 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %88 = llvm.mlir.constant(2 : index) : i64
    %89 = llvm.mul %83, %88 : i64
    %90 = llvm.mlir.constant(2 : index) : i64
    %91 = llvm.mul %84, %90 : i64
    %92 = llvm.add %89, %91 : i64
    %93 = llvm.mlir.constant(2 : index) : i64
    %94 = llvm.mul %85, %93 : i64
    %95 = llvm.add %92, %94 : i64
    %96 = llvm.add %95, %86 : i64
    %97 = llvm.getelementptr %87[%96] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %98 = llvm.load %97 : !llvm.ptr -> i32
    %99 = llvm.icmp "sgt" %98, %0 : i32
    %100 = llvm.select %99, %98, %0 : i1, i32
    %101 = llvm.mlir.constant(0 : index) : i64
    %102 = llvm.mlir.constant(0 : index) : i64
    %103 = llvm.mlir.constant(0 : index) : i64
    %104 = llvm.mlir.constant(0 : index) : i64
    %105 = llvm.extractvalue %82[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %106 = llvm.mlir.constant(2 : index) : i64
    %107 = llvm.mul %101, %106 : i64
    %108 = llvm.mlir.constant(2 : index) : i64
    %109 = llvm.mul %102, %108 : i64
    %110 = llvm.add %107, %109 : i64
    %111 = llvm.mlir.constant(2 : index) : i64
    %112 = llvm.mul %103, %111 : i64
    %113 = llvm.add %110, %112 : i64
    %114 = llvm.add %113, %104 : i64
    %115 = llvm.getelementptr %105[%114] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %100, %115 : i32, !llvm.ptr
    %116 = llvm.mlir.constant(0 : index) : i64
    %117 = llvm.mlir.constant(0 : index) : i64
    %118 = llvm.mlir.constant(0 : index) : i64
    %119 = llvm.mlir.constant(1 : index) : i64
    %120 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %121 = llvm.mlir.constant(2 : index) : i64
    %122 = llvm.mul %116, %121 : i64
    %123 = llvm.mlir.constant(2 : index) : i64
    %124 = llvm.mul %117, %123 : i64
    %125 = llvm.add %122, %124 : i64
    %126 = llvm.mlir.constant(2 : index) : i64
    %127 = llvm.mul %118, %126 : i64
    %128 = llvm.add %125, %127 : i64
    %129 = llvm.add %128, %119 : i64
    %130 = llvm.getelementptr %120[%129] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %131 = llvm.load %130 : !llvm.ptr -> i32
    %132 = llvm.icmp "sgt" %131, %0 : i32
    %133 = llvm.select %132, %131, %0 : i1, i32
    %134 = llvm.mlir.constant(0 : index) : i64
    %135 = llvm.mlir.constant(0 : index) : i64
    %136 = llvm.mlir.constant(0 : index) : i64
    %137 = llvm.mlir.constant(1 : index) : i64
    %138 = llvm.extractvalue %82[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %139 = llvm.mlir.constant(2 : index) : i64
    %140 = llvm.mul %134, %139 : i64
    %141 = llvm.mlir.constant(2 : index) : i64
    %142 = llvm.mul %135, %141 : i64
    %143 = llvm.add %140, %142 : i64
    %144 = llvm.mlir.constant(2 : index) : i64
    %145 = llvm.mul %136, %144 : i64
    %146 = llvm.add %143, %145 : i64
    %147 = llvm.add %146, %137 : i64
    %148 = llvm.getelementptr %138[%147] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %133, %148 : i32, !llvm.ptr
    %149 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %150 = llvm.mlir.constant(0 : index) : i64
    %151 = llvm.getelementptr %149[%150, %150] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %152 = llvm.mlir.addressof @nl : !llvm.ptr
    %153 = llvm.mlir.constant(0 : index) : i64
    %154 = llvm.getelementptr %152[%153, %153] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %155 = llvm.mlir.constant(0 : index) : i64
    %156 = llvm.mlir.constant(1 : index) : i64
    %157 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%155 : i64)
  ^bb1(%158: i64):  // 2 preds: ^bb0, ^bb11
    %159 = llvm.icmp "slt" %158, %156 : i64
    llvm.cond_br %159, ^bb2, ^bb12
  ^bb2:  // pred: ^bb1
    %160 = llvm.mlir.constant(0 : index) : i64
    %161 = llvm.mlir.constant(1 : index) : i64
    %162 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%160 : i64)
  ^bb3(%163: i64):  // 2 preds: ^bb2, ^bb10
    %164 = llvm.icmp "slt" %163, %161 : i64
    llvm.cond_br %164, ^bb4, ^bb11
  ^bb4:  // pred: ^bb3
    %165 = llvm.mlir.constant(0 : index) : i64
    %166 = llvm.mlir.constant(1 : index) : i64
    %167 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb5(%165 : i64)
  ^bb5(%168: i64):  // 2 preds: ^bb4, ^bb9
    %169 = llvm.icmp "slt" %168, %166 : i64
    llvm.cond_br %169, ^bb6, ^bb10
  ^bb6:  // pred: ^bb5
    %170 = llvm.mlir.constant(0 : index) : i64
    %171 = llvm.mlir.constant(2 : index) : i64
    %172 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%170 : i64)
  ^bb7(%173: i64):  // 2 preds: ^bb6, ^bb8
    %174 = llvm.icmp "slt" %173, %171 : i64
    llvm.cond_br %174, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %175 = llvm.extractvalue %82[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %176 = llvm.mlir.constant(2 : index) : i64
    %177 = llvm.mul %158, %176 : i64
    %178 = llvm.mlir.constant(2 : index) : i64
    %179 = llvm.mul %163, %178 : i64
    %180 = llvm.add %177, %179 : i64
    %181 = llvm.mlir.constant(2 : index) : i64
    %182 = llvm.mul %168, %181 : i64
    %183 = llvm.add %180, %182 : i64
    %184 = llvm.add %183, %173 : i64
    %185 = llvm.getelementptr %175[%184] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %186 = llvm.load %185 : !llvm.ptr -> i32
    %187 = llvm.call @printf(%151, %186) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    %188 = llvm.add %173, %172 : i64
    llvm.br ^bb7(%188 : i64)
  ^bb9:  // pred: ^bb7
    %189 = llvm.call @printf(%154) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %190 = llvm.add %168, %167 : i64
    llvm.br ^bb5(%190 : i64)
  ^bb10:  // pred: ^bb5
    %191 = llvm.call @printf(%154) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %192 = llvm.add %163, %162 : i64
    llvm.br ^bb3(%192 : i64)
  ^bb11:  // pred: ^bb3
    %193 = llvm.call @printf(%154) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %194 = llvm.add %158, %157 : i64
    llvm.br ^bb1(%194 : i64)
  ^bb12:  // pred: ^bb1
    llvm.return
  }
}


0 2 


