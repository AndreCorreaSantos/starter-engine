module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32 } : () -> ()
  %1 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
  %2 = "engine.argmax"(%1) : (memref<3xf64>) -> memref<f64>
  "engine.print"(%2) : (memref<f64>) -> ()
  
  func.return
  }
}// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>}> : () -> memref<3xf64>
    %1 = "engine.argmax"(%0) : (memref<3xf64>) -> memref<f64>
    engine.print %1 : memref<f64>
    return
  }
}


lowerSettings: 0
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<3xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 1.000000e+00 : f64
    affine.store %cst, %alloc[%c0] : memref<3xf64>
    %cst_0 = arith.constant 2.000000e+00 : f64
    affine.store %cst_0, %alloc[%c1] : memref<3xf64>
    %cst_1 = arith.constant 3.000000e+00 : f64
    affine.store %cst_1, %alloc[%c2] : memref<3xf64>
    %c0_2 = arith.constant 0 : index
    %0 = memref.load %alloc[%c0_2] : memref<3xf64>
    %c1_3 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %1 = scf.for %arg0 = %c0_2 to %c3 step %c1_3 iter_args(%arg1 = %0) -> (f64) {
      %2 = memref.load %alloc[%arg0] : memref<3xf64>
      %3 = arith.cmpf ogt, %2, %arg1 : f64
      %4 = arith.select %3, %2, %arg1 : f64
      scf.yield %4 : f64
    }
    %alloc_4 = memref.alloc() : memref<f64>
    %c0_5 = arith.constant 0 : index
    memref.store %1, %alloc_4[] : memref<f64>
    engine.print %alloc_4 : memref<f64>
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
    %alloc = memref.alloc() : memref<3xf64>
    affine.store %cst_1, %alloc[%c0] : memref<3xf64>
    affine.store %cst_0, %alloc[%c1] : memref<3xf64>
    affine.store %cst, %alloc[%c2] : memref<3xf64>
    %0 = memref.load %alloc[%c0] : memref<3xf64>
    %1 = scf.for %arg0 = %c0 to %c3 step %c1 iter_args(%arg1 = %0) -> (f64) {
      %2 = memref.load %alloc[%arg0] : memref<3xf64>
      %3 = arith.cmpf ogt, %2, %arg1 : f64
      %4 = arith.select %3, %2, %arg1 : f64
      scf.yield %4 : f64
    }
    %alloc_2 = memref.alloc() : memref<f64>
    memref.store %1, %alloc_2[] : memref<f64>
    engine.print %alloc_2 : memref<f64>
    return
  }
}


// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass () //----- //
module {
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
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mlir.zero : !llvm.ptr
    %10 = llvm.getelementptr %9[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.call @malloc(%11) : (i64) -> !llvm.ptr
    %13 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %7, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %8, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.getelementptr %20[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %21 : f64, !llvm.ptr
    %22 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.getelementptr %22[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %23 : f64, !llvm.ptr
    %24 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.getelementptr %24[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %25 : f64, !llvm.ptr
    %26 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.getelementptr %26[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %28 = llvm.load %27 : !llvm.ptr -> f64
    llvm.br ^bb1(%6, %28 : i64, f64)
  ^bb1(%29: i64, %30: f64):  // 2 preds: ^bb0, ^bb2
    %31 = llvm.icmp "slt" %29, %0 : i64
    llvm.cond_br %31, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %32 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.getelementptr %32[%29] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %34 = llvm.load %33 : !llvm.ptr -> f64
    %35 = llvm.fcmp "ogt" %34, %30 : f64
    %36 = llvm.select %35, %34, %30 : i1, f64
    %37 = llvm.add %29, %5 : i64
    llvm.br ^bb1(%37, %36 : i64, f64)
  ^bb3:  // pred: ^bb1
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.mlir.zero : !llvm.ptr
    %40 = llvm.getelementptr %39[%38] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %41 = llvm.ptrtoint %40 : !llvm.ptr to i64
    %42 = llvm.call @malloc(%41) : (i64) -> !llvm.ptr
    %43 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64)>
    %44 = llvm.insertvalue %42, %43[0] : !llvm.struct<(ptr, ptr, i64)> 
    %45 = llvm.insertvalue %42, %44[1] : !llvm.struct<(ptr, ptr, i64)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr, ptr, i64)> 
    %48 = llvm.extractvalue %47[1] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %30, %48 : f64, !llvm.ptr
    %49 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %50 = llvm.mlir.constant(0 : index) : i64
    %51 = llvm.getelementptr %49[%50, %50] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %52 = llvm.mlir.addressof @nl : !llvm.ptr
    %53 = llvm.mlir.constant(0 : index) : i64
    %54 = llvm.getelementptr %52[%53, %53] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %55 = llvm.extractvalue %47[1] : !llvm.struct<(ptr, ptr, i64)> 
    %56 = llvm.load %55 : !llvm.ptr -> f64
    %57 = llvm.call @printf(%51, %56) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }
}


3.000000 