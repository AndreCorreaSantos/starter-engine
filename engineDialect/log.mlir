module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32, type = 0 : i32 } : () -> ()
  %1 = "engine.constant"() {value = dense<[-12.922800, 4.829700, -0.579300, -0.766400, -1.762400, -4.013700, -2.125800, -0.255400, -0.505000, -3.928800 ]> : tensor<10xf64>} : () -> memref<10xf64>
  %2 = "engine.argmax"(%1) : (memref<10xf64>) -> memref<i32>
  "engine.print"(%2) : (memref<i32>) -> ()
  
  func.return
  }
}// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.constant"() <{value = dense<[-1.292280e+01, 4.829700e+00, -5.793000e-01, -7.664000e-01, -1.762400e+00, -4.013700e+00, -2.125800e+00, -2.554000e-01, -5.050000e-01, -3.928800e+00]> : tensor<10xf64>}> : () -> memref<10xf64>
    %1 = "engine.argmax"(%0) : (memref<10xf64>) -> memref<i32>
    engine.print %1 : memref<i32>
    return
  }
}


lowerSettings: 0
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %alloc = memref.alloc() : memref<10xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %c5 = arith.constant 5 : index
    %c6 = arith.constant 6 : index
    %c7 = arith.constant 7 : index
    %c8 = arith.constant 8 : index
    %c9 = arith.constant 9 : index
    %cst = arith.constant -1.292280e+01 : f64
    affine.store %cst, %alloc[%c0] : memref<10xf64>
    %cst_0 = arith.constant 4.829700e+00 : f64
    affine.store %cst_0, %alloc[%c1] : memref<10xf64>
    %cst_1 = arith.constant -5.793000e-01 : f64
    affine.store %cst_1, %alloc[%c2] : memref<10xf64>
    %cst_2 = arith.constant -7.664000e-01 : f64
    affine.store %cst_2, %alloc[%c3] : memref<10xf64>
    %cst_3 = arith.constant -1.762400e+00 : f64
    affine.store %cst_3, %alloc[%c4] : memref<10xf64>
    %cst_4 = arith.constant -4.013700e+00 : f64
    affine.store %cst_4, %alloc[%c5] : memref<10xf64>
    %cst_5 = arith.constant -2.125800e+00 : f64
    affine.store %cst_5, %alloc[%c6] : memref<10xf64>
    %cst_6 = arith.constant -2.554000e-01 : f64
    affine.store %cst_6, %alloc[%c7] : memref<10xf64>
    %cst_7 = arith.constant -5.050000e-01 : f64
    affine.store %cst_7, %alloc[%c8] : memref<10xf64>
    %cst_8 = arith.constant -3.928800e+00 : f64
    affine.store %cst_8, %alloc[%c9] : memref<10xf64>
    %c0_9 = arith.constant 0 : index
    %0 = memref.load %alloc[%c0_9] : memref<10xf64>
    %c1_10 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    %1:2 = scf.for %arg0 = %c0_9 to %c10 step %c1_10 iter_args(%arg1 = %0, %arg2 = %c0_9) -> (f64, index) {
      %3 = memref.load %alloc[%arg0] : memref<10xf64>
      %4 = arith.cmpf ogt, %3, %arg1 : f64
      %5 = arith.select %4, %3, %arg1 : f64
      %6 = arith.select %4, %arg0, %arg2 : index
      scf.yield %5, %6 : f64, index
    }
    %2 = arith.index_cast %1#1 : index to i32
    %alloc_11 = memref.alloc() : memref<i32>
    memref.store %2, %alloc_11[] : memref<i32>
    engine.print %alloc_11 : memref<i32>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %c10 = arith.constant 10 : index
    %cst = arith.constant -3.928800e+00 : f64
    %cst_0 = arith.constant -5.050000e-01 : f64
    %cst_1 = arith.constant -2.554000e-01 : f64
    %cst_2 = arith.constant -2.125800e+00 : f64
    %cst_3 = arith.constant -4.013700e+00 : f64
    %cst_4 = arith.constant -1.762400e+00 : f64
    %cst_5 = arith.constant -7.664000e-01 : f64
    %cst_6 = arith.constant -5.793000e-01 : f64
    %cst_7 = arith.constant 4.829700e+00 : f64
    %cst_8 = arith.constant -1.292280e+01 : f64
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<10xf64>
    affine.store %cst_8, %alloc[%c0] : memref<10xf64>
    affine.store %cst_7, %alloc[%c1] : memref<10xf64>
    affine.store %cst_6, %alloc[%c2] : memref<10xf64>
    affine.store %cst_5, %alloc[%c3] : memref<10xf64>
    affine.store %cst_4, %alloc[%c4] : memref<10xf64>
    affine.store %cst_3, %alloc[%c5] : memref<10xf64>
    affine.store %cst_2, %alloc[%c6] : memref<10xf64>
    affine.store %cst_1, %alloc[%c7] : memref<10xf64>
    affine.store %cst_0, %alloc[%c8] : memref<10xf64>
    affine.store %cst, %alloc[%c9] : memref<10xf64>
    %0 = memref.load %alloc[%c0] : memref<10xf64>
    %1:2 = scf.for %arg0 = %c0 to %c10 step %c1 iter_args(%arg1 = %0, %arg2 = %c0) -> (f64, index) {
      %3 = memref.load %alloc[%arg0] : memref<10xf64>
      %4 = arith.cmpf ogt, %3, %arg1 : f64
      %5 = arith.select %4, %3, %arg1 : f64
      %6 = arith.select %4, %arg0, %arg2 : index
      scf.yield %5, %6 : f64, index
    }
    %2 = arith.index_cast %1#1 : index to i32
    %alloc_9 = memref.alloc() : memref<i32>
    memref.store %2, %alloc_9[] : memref<i32>
    engine.print %alloc_9 : memref<i32>
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
    %0 = llvm.mlir.constant(10 : index) : i64
    %1 = llvm.mlir.constant(-3.928800e+00 : f64) : f64
    %2 = llvm.mlir.constant(-5.050000e-01 : f64) : f64
    %3 = llvm.mlir.constant(-2.554000e-01 : f64) : f64
    %4 = llvm.mlir.constant(-2.125800e+00 : f64) : f64
    %5 = llvm.mlir.constant(-4.013700e+00 : f64) : f64
    %6 = llvm.mlir.constant(-1.762400e+00 : f64) : f64
    %7 = llvm.mlir.constant(-7.664000e-01 : f64) : f64
    %8 = llvm.mlir.constant(-5.793000e-01 : f64) : f64
    %9 = llvm.mlir.constant(4.829700e+00 : f64) : f64
    %10 = llvm.mlir.constant(-1.292280e+01 : f64) : f64
    %11 = llvm.mlir.constant(9 : index) : i64
    %12 = llvm.mlir.constant(8 : index) : i64
    %13 = llvm.mlir.constant(7 : index) : i64
    %14 = llvm.mlir.constant(6 : index) : i64
    %15 = llvm.mlir.constant(5 : index) : i64
    %16 = llvm.mlir.constant(4 : index) : i64
    %17 = llvm.mlir.constant(3 : index) : i64
    %18 = llvm.mlir.constant(2 : index) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.mlir.constant(10 : index) : i64
    %22 = llvm.mlir.constant(1 : index) : i64
    %23 = llvm.mlir.zero : !llvm.ptr
    %24 = llvm.getelementptr %23[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.call @malloc(%25) : (i64) -> !llvm.ptr
    %27 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.insertvalue %26, %27[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.insertvalue %26, %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = llvm.insertvalue %30, %29[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.insertvalue %21, %31[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %22, %32[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.getelementptr %34[%20] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %10, %35 : f64, !llvm.ptr
    %36 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.getelementptr %36[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %9, %37 : f64, !llvm.ptr
    %38 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.getelementptr %38[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %8, %39 : f64, !llvm.ptr
    %40 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %41 = llvm.getelementptr %40[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %7, %41 : f64, !llvm.ptr
    %42 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.getelementptr %42[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %6, %43 : f64, !llvm.ptr
    %44 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.getelementptr %44[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %45 : f64, !llvm.ptr
    %46 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.getelementptr %46[%14] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %47 : f64, !llvm.ptr
    %48 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.getelementptr %48[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %49 : f64, !llvm.ptr
    %50 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %51 = llvm.getelementptr %50[%12] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %2, %51 : f64, !llvm.ptr
    %52 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %53 = llvm.getelementptr %52[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %53 : f64, !llvm.ptr
    %54 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %55 = llvm.getelementptr %54[%20] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %56 = llvm.load %55 : !llvm.ptr -> f64
    llvm.br ^bb1(%20, %56, %20 : i64, f64, i64)
  ^bb1(%57: i64, %58: f64, %59: i64):  // 2 preds: ^bb0, ^bb2
    %60 = llvm.icmp "slt" %57, %0 : i64
    llvm.cond_br %60, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %61 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %62 = llvm.getelementptr %61[%57] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %63 = llvm.load %62 : !llvm.ptr -> f64
    %64 = llvm.fcmp "ogt" %63, %58 : f64
    %65 = llvm.select %64, %63, %58 : i1, f64
    %66 = llvm.select %64, %57, %59 : i1, i64
    %67 = llvm.add %57, %19 : i64
    llvm.br ^bb1(%67, %65, %66 : i64, f64, i64)
  ^bb3:  // pred: ^bb1
    %68 = llvm.trunc %59 : i64 to i32
    %69 = llvm.mlir.constant(1 : index) : i64
    %70 = llvm.mlir.zero : !llvm.ptr
    %71 = llvm.getelementptr %70[%69] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %72 = llvm.ptrtoint %71 : !llvm.ptr to i64
    %73 = llvm.call @malloc(%72) : (i64) -> !llvm.ptr
    %74 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64)>
    %75 = llvm.insertvalue %73, %74[0] : !llvm.struct<(ptr, ptr, i64)> 
    %76 = llvm.insertvalue %73, %75[1] : !llvm.struct<(ptr, ptr, i64)> 
    %77 = llvm.mlir.constant(0 : index) : i64
    %78 = llvm.insertvalue %77, %76[2] : !llvm.struct<(ptr, ptr, i64)> 
    %79 = llvm.extractvalue %78[1] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %68, %79 : i32, !llvm.ptr
    %80 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %81 = llvm.mlir.constant(0 : index) : i64
    %82 = llvm.getelementptr %80[%81, %81] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %83 = llvm.mlir.addressof @nl : !llvm.ptr
    %84 = llvm.mlir.constant(0 : index) : i64
    %85 = llvm.getelementptr %83[%84, %84] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %86 = llvm.extractvalue %78[1] : !llvm.struct<(ptr, ptr, i64)> 
    %87 = llvm.load %86 : !llvm.ptr -> i32
    %88 = llvm.call @printf(%82, %87) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    llvm.return
  }
}


1 