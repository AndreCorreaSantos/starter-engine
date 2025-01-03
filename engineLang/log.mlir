// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    %1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    %2 = "engine.dot"(%0, %1) : (memref<2x3xf64>, memref<2x3xf64>) -> memref<f64>
    "engine.print"(%0) : (memref<2x3xf64>) -> ()
    return
}
loc("./test/Engine/dot.mlir":7:10): error: 'linalg.dot' op expected operand rank (2) to match the result rank of indexing_map #0 (1)
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass Failed () //----- //
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x3xf64>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x3xf64>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    "affine.store"(%5, %1, %2, %2) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %6 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    "affine.store"(%6, %1, %2, %3) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %7 = "arith.constant"() <{value = 3.000000e+00 : f64}> : () -> f64
    "affine.store"(%7, %1, %2, %4) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %8 = "arith.constant"() <{value = 4.000000e+00 : f64}> : () -> f64
    "affine.store"(%8, %1, %3, %2) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %9 = "arith.constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    "affine.store"(%9, %1, %3, %3) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %10 = "arith.constant"() <{value = 6.000000e+00 : f64}> : () -> f64
    "affine.store"(%10, %1, %3, %4) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 2 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    "affine.store"(%14, %0, %11, %11) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %15 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    "affine.store"(%15, %0, %11, %12) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %16 = "arith.constant"() <{value = 3.000000e+00 : f64}> : () -> f64
    "affine.store"(%16, %0, %11, %13) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %17 = "arith.constant"() <{value = 4.000000e+00 : f64}> : () -> f64
    "affine.store"(%17, %0, %12, %11) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %18 = "arith.constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    "affine.store"(%18, %0, %12, %12) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %19 = "arith.constant"() <{value = 6.000000e+00 : f64}> : () -> f64
    "affine.store"(%19, %0, %12, %13) <{map = #map}> : (f64, memref<2x3xf64>, index, index) -> ()
    %20 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    "linalg.dot"(%1, %0, %20) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):
      %21 = "arith.mulf"(%arg0, %arg1) <{denormal = #arith.denormal<ieee>, fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %22 = "arith.addf"(%arg2, %21) <{denormal = #arith.denormal<ieee>, fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "linalg.yield"(%22) : (f64) -> ()
    }) {linalg.memoized_indexing_maps = [#map1, #map1, #map2]} : (memref<2x3xf64>, memref<2x3xf64>, memref<f64>) -> ()
    "engine.print"(%1) : (memref<2x3xf64>) -> ()
    "memref.dealloc"(%1) : (memref<2x3xf64>) -> ()
    "memref.dealloc"(%0) : (memref<2x3xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


lli: Symbols not found: [ main ]
