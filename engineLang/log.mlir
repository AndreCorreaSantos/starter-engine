// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
  %0 = "engine.constant"() {value = dense<[[1.0], [2.0], [3.0]]> : tensor<3x1xf64>} : () -> memref<3x1xf64>
  %1 = "engine.constant"() {value = dense<[[1.0, 2.0, 3.0]]> : tensor<1x3xf64>} : () -> memref<1x3xf64>
  %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1x3xf64>) -> memref<?xf64>

  "engine.print"(%2) : (memref<?xf64>) -> ()
  return
}
LHS_Shape: [3 1 ]
RHS_Shape: [1 3 ]
loc("./test/Engine/matmul.mlir":7:8): error: 'memref.alloc' op dimension operand count does not equal memref dynamic dimension count
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass Failed () //----- //
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<?xf64>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x3xf64>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x1xf64>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    "affine.store"(%6, %2, %3, %3) <{map = #map}> : (f64, memref<3x1xf64>, index, index) -> ()
    %7 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    "affine.store"(%7, %2, %4, %3) <{map = #map}> : (f64, memref<3x1xf64>, index, index) -> ()
    %8 = "arith.constant"() <{value = 3.000000e+00 : f64}> : () -> f64
    "affine.store"(%8, %2, %5, %3) <{map = #map}> : (f64, memref<3x1xf64>, index, index) -> ()
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    "affine.store"(%12, %1, %9, %9) <{map = #map}> : (f64, memref<1x3xf64>, index, index) -> ()
    %13 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    "affine.store"(%13, %1, %9, %10) <{map = #map}> : (f64, memref<1x3xf64>, index, index) -> ()
    %14 = "arith.constant"() <{value = 3.000000e+00 : f64}> : () -> f64
    "affine.store"(%14, %1, %9, %11) <{map = #map}> : (f64, memref<1x3xf64>, index, index) -> ()
    "linalg.matmul"(%2, %1, %0) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):
      %15 = "arith.mulf"(%arg0, %arg1) <{denormal = #arith.denormal<ieee>, fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %16 = "arith.addf"(%arg2, %15) <{denormal = #arith.denormal<ieee>, fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "linalg.yield"(%16) : (f64) -> ()
    }) : (memref<3x1xf64>, memref<1x3xf64>, memref<?xf64>) -> ()
    "engine.print"(%0) : (memref<?xf64>) -> ()
    "memref.dealloc"(%2) : (memref<3x1xf64>) -> ()
    "memref.dealloc"(%1) : (memref<1x3xf64>) -> ()
    "memref.dealloc"(%0) : (memref<?xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


lli: Symbols not found: [ main ]
