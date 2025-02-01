// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    "engine.settings"() { value = 2 : i32, type = 0 } : () -> ()
    %0 = "engine.constant"() {value = dense<[[1.000000e+00], [2.000000e+00], [3.000000e+00]]> : tensor<3x1xf64>} : () -> memref<3x1xf64>
    %1 = "engine.constant"() {value = dense<[2.000000e+00]> : tensor<1xf64>} : () -> memref<1xf64>
    %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1xf64>) -> memref<3xf64>
    
    // "engine.print"(%2) : (memref<f64>) -> ()
    return
}
