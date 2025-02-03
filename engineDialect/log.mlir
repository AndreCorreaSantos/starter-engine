// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()

"engine.settings"() { value = 2 : i32, type = 0 } : () -> ()
%0 = "engine.constant"() {value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>} : () -> memref<3x1xf64>
%1 = "engine.constant"() {value = dense<[2.000000e+00]> : tensor<1xf64>} : () -> memref<1xf64>
%2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>

// "engine.print"(%2) : (memref<f64>) -> ()


//===-------------------------------------------===//
Legalizing operation : 'builtin.module'(0x56f3286f09d0) {
  * Fold {
  } -> FAILURE : unable to fold
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.settings'(0x56f3286f4770) {
  "engine.settings"() <{value = 2 : i32}> {type = 0 : i64} : () -> ()

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.settings -> ()' {
    ** Erase   : 'engine.settings'(0x56f3286f4770)
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.constant'(0x56f3286f1520) {
  %0 = "engine.constant"() <{value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>}> : () -> memref<3x1xf64>

  * Fold {
  } -> FAILURE : unable to fold
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.constant'(0x56f3286fcd20) {
  %1 = "engine.constant"() <{value = dense<2.000000e+00> : tensor<1xf64>}> : () -> memref<1xf64>

  * Fold {
  } -> FAILURE : unable to fold
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.matmul'(0x56f3286fdfc0) {
  %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>

  * Fold {
  } -> FAILURE : unable to fold
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//
// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  %0 = "engine.constant"() <{value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>}> : () -> memref<3x1xf64>
  %1 = "engine.constant"() <{value = dense<2.000000e+00> : tensor<1xf64>}> : () -> memref<1xf64>
  %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>
}


lowerSettings: 2

//===-------------------------------------------===//
Legalizing operation : 'builtin.module'(0x56f3286f09d0) {
} -> SUCCESS : operation marked legal by the target
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.constant'(0x56f3286f1520) {
  %0 = "engine.constant"() <{value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>}> : () -> memref<3x1xf64>

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.constant -> ()' {
    ** Insert  : 'memref.alloc'(0x56f32878fc80)
    ** Insert  : 'arith.constant'(0x56f32878fbc0)
    ** Insert  : 'arith.constant'(0x56f328790160)
    ** Insert  : 'arith.constant'(0x56f328790200)
    ** Insert  : 'arith.constant'(0x56f3287903c0)
    ** Insert  : 'affine.store'(0x56f32872b150)
    ** Insert  : 'arith.constant'(0x56f32878f690)
    ** Insert  : 'affine.store'(0x56f328721f30)
    ** Insert  : 'arith.constant'(0x56f32878f840)
    ** Insert  : 'affine.store'(0x56f32870ce70)
    ** Replace : 'engine.constant'(0x56f3286f1520)

    //===-------------------------------------------===//
    Legalizing operation : 'memref.alloc'(0x56f32878fc80) {
      %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x1xf64>

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f32878fbc0) {
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f328790160) {
      %2 = "arith.constant"() <{value = 1 : index}> : () -> index

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f328790200) {
      %3 = "arith.constant"() <{value = 2 : index}> : () -> index

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f3287903c0) {
      %4 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'affine.store'(0x56f32872b150) {
      "affine.store"(%4, %0, %1, %1) <{map = affine_map<(d0, d1) -> (d0, d1)>}> : (f64, memref<3x1xf64>, index, index) -> ()

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f32878f690) {
      %5 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'affine.store'(0x56f328721f30) {
      "affine.store"(%5, %0, %2, %1) <{map = affine_map<(d0, d1) -> (d0, d1)>}> : (f64, memref<3x1xf64>, index, index) -> ()

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f32878f840) {
      %6 = "arith.constant"() <{value = 3.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'affine.store'(0x56f32870ce70) {
      "affine.store"(%6, %0, %3, %1) <{map = affine_map<(d0, d1) -> (d0, d1)>}> : (f64, memref<3x1xf64>, index, index) -> ()

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.constant'(0x56f3286fcd20) {
  %8 = "engine.constant"() <{value = dense<2.000000e+00> : tensor<1xf64>}> : () -> memref<1xf64>

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.constant -> ()' {
    ** Insert  : 'memref.alloc'(0x56f32878f940)
    ** Insert  : 'arith.constant'(0x56f328792af0)
    ** Insert  : 'arith.constant'(0x56f328792b90)
    ** Insert  : 'affine.store'(0x56f328792c20)
    ** Replace : 'engine.constant'(0x56f3286fcd20)

    //===-------------------------------------------===//
    Legalizing operation : 'memref.alloc'(0x56f32878f940) {
      %8 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf64>

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f328792af0) {
      %9 = "arith.constant"() <{value = 0 : index}> : () -> index

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x56f328792b90) {
      %10 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'affine.store'(0x56f328792c20) {
      "affine.store"(%10, %8, %9) <{map = affine_map<(d0) -> (d0)>}> : (f64, memref<1xf64>, index) -> ()

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.matmul'(0x56f3286fdfc0) {
  %12 = "engine.matmul"(%7, %11) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.matmul -> ()' {
    ** Insert  : 'memref.alloc'(0x56f328792d50)
    ** Insert Block into detached Region (nullptr parent op)'    ** Insert  : 'arith.mulf'(0x56f328794000)
    ** Insert  : 'arith.addf'(0x56f3287940f0)
    ** Insert  : 'linalg.yield'(0x56f3287941d0)
    ** Insert  : 'linalg.matvec'(0x56f3286e7110)
    ** Replace : 'engine.matmul'(0x56f3286fdfc0)

    //===-------------------------------------------===//
    Legalizing operation : 'memref.alloc'(0x56f328792d50) {
      %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.mulf'(0x56f328794000) {
      %14 = "arith.mulf"(%arg0, %arg1) <{denormal = #arith.denormal<ieee>, fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.addf'(0x56f3287940f0) {
      %15 = "arith.addf"(%arg2, %14) <{denormal = #arith.denormal<ieee>, fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'linalg.yield'(0x56f3287941d0) {
      "linalg.yield"(%15) : (f64) -> ()

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'linalg.matvec'(0x56f3286e7110) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  %alloc = memref.alloc() : memref<3x1xf64>
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %cst = arith.constant 1.000000e+00 : f64
  affine.store %cst, %alloc[%c0, %c0] : memref<3x1xf64>
  %cst_0 = arith.constant 2.000000e+00 : f64
  affine.store %cst_0, %alloc[%c1, %c0] : memref<3x1xf64>
  %cst_1 = arith.constant 3.000000e+00 : f64
  affine.store %cst_1, %alloc[%c2, %c0] : memref<3x1xf64>
  %alloc_2 = memref.alloc() : memref<1xf64>
  %c0_3 = arith.constant 0 : index
  %cst_4 = arith.constant 2.000000e+00 : f64
  affine.store %cst_4, %alloc_2[%c0_3] : memref<1xf64>
  %alloc_5 = memref.alloc() : memref<3xf64>
  linalg.matvec ins(%alloc, %alloc_2 : memref<3x1xf64>, memref<1xf64>) outs(%alloc_5 : memref<3xf64>)
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  %c3 = arith.constant 3 : index
  %cst = arith.constant 3.000000e+00 : f64
  %cst_0 = arith.constant 2.000000e+00 : f64
  %cst_1 = arith.constant 1.000000e+00 : f64
  %c2 = arith.constant 2 : index
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %alloc = memref.alloc() : memref<3x1xf64>
  affine.store %cst_1, %alloc[%c0, %c0] : memref<3x1xf64>
  affine.store %cst_0, %alloc[%c1, %c0] : memref<3x1xf64>
  affine.store %cst, %alloc[%c2, %c0] : memref<3x1xf64>
  %alloc_2 = memref.alloc() : memref<1xf64>
  affine.store %cst_0, %alloc_2[%c0] : memref<1xf64>
  %alloc_3 = memref.alloc() : memref<3xf64>
  scf.for %arg0 = %c0 to %c3 step %c1 {
    scf.for %arg1 = %c0 to %c1 step %c1 {
      %0 = memref.load %alloc[%arg0, %arg1] : memref<3x1xf64>
      %1 = memref.load %alloc_2[%arg1] : memref<1xf64>
      %2 = memref.load %alloc_3[%arg0] : memref<3xf64>
      %3 = arith.mulf %0, %1 : f64
      %4 = arith.addf %2, %3 : f64
      memref.store %4, %alloc_3[%arg0] : memref<3xf64>
    }
  }
}



//===-------------------------------------------===//
Legalizing operation : 'builtin.module'(0x56f3286f09d0) {
} -> SUCCESS : operation marked legal by the target
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f328792af0) {
  %0 = "arith.constant"() <{value = 3 : index}> : () -> index

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f32870e380)
    ** Replace : 'arith.constant'(0x56f328792af0)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f32870e380) {
      %0 = "spirv.Constant"() <{value = 3 : i64}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f32878f840) {
  %2 = "arith.constant"() <{value = 3.000000e+00 : f64}> : () -> f64

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f32870e1b0)
    ** Replace : 'arith.constant'(0x56f32878f840)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f32870e1b0) {
      %2 = "spirv.Constant"() <{value = 3.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f32878f690) {
  %4 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f32870b3a0)
    ** Replace : 'arith.constant'(0x56f32878f690)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f32870b3a0) {
      %4 = "spirv.Constant"() <{value = 2.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f3287903c0) {
  %6 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f3286ff470)
    ** Replace : 'arith.constant'(0x56f3287903c0)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f3286ff470) {
      %6 = "spirv.Constant"() <{value = 1.000000e+00 : f64}> : () -> f64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f328790200) {
  %8 = "arith.constant"() <{value = 2 : index}> : () -> index

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f3286fed20)
    ** Replace : 'arith.constant'(0x56f328790200)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f3286fed20) {
      %8 = "spirv.Constant"() <{value = 2 : i64}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f328790160) {
  %10 = "arith.constant"() <{value = 1 : index}> : () -> index

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f3287a23f0)
    ** Replace : 'arith.constant'(0x56f328790160)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f3287a23f0) {
      %10 = "spirv.Constant"() <{value = 1 : i64}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'arith.constant'(0x56f32878fbc0) {
  %12 = "arith.constant"() <{value = 0 : index}> : () -> index

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'arith.constant -> ()' {
    ** Insert  : 'spirv.Constant'(0x56f3287a2480)
    ** Replace : 'arith.constant'(0x56f32878fbc0)

    //===-------------------------------------------===//
    Legalizing operation : 'spirv.Constant'(0x56f3287a2480) {
      %12 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'memref.alloc'(0x56f32878fc80) {
  %14 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x1xf64>

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'memref.alloc -> ()' {
    ** Failure : unhandled allocation type
  } -> FAILURE : pattern failed to match
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//
loc("./test/Engine/dot.mlir":6:6): error: failed to legalize operation 'memref.alloc'
// -----// IR Dump After {anonymous}::LowerToSPIRPass Failed () //----- //
module {
  %c3 = arith.constant 3 : index
  %cst = arith.constant 3.000000e+00 : f64
  %cst_0 = arith.constant 2.000000e+00 : f64
  %cst_1 = arith.constant 1.000000e+00 : f64
  %c2 = arith.constant 2 : index
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %alloc = memref.alloc() : memref<3x1xf64>
  affine.store %cst_1, %alloc[%c0, %c0] : memref<3x1xf64>
  affine.store %cst_0, %alloc[%c1, %c0] : memref<3x1xf64>
  affine.store %cst, %alloc[%c2, %c0] : memref<3x1xf64>
  %alloc_2 = memref.alloc() : memref<1xf64>
  affine.store %cst_0, %alloc_2[%c0] : memref<1xf64>
  %alloc_3 = memref.alloc() : memref<3xf64>
  scf.for %arg0 = %c0 to %c3 step %c1 {
    scf.for %arg1 = %c0 to %c1 step %c1 {
      %0 = memref.load %alloc[%arg0, %arg1] : memref<3x1xf64>
      %1 = memref.load %alloc_2[%arg1] : memref<1xf64>
      %2 = memref.load %alloc_3[%arg0] : memref<3xf64>
      %3 = arith.mulf %0, %1 : f64
      %4 = arith.addf %2, %3 : f64
      memref.store %4, %alloc_3[%arg0] : memref<3xf64>
    }
  }
}


lli: Symbols not found: [ main ]
