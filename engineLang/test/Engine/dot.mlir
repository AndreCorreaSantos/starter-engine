// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    %1 = "engine.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    %2 = "engine.dot"(%0, %1) : (memref<3xf64>, memref<3xf64>) -> memref<f64>
    
    "engine.print"(%2) : (memref<f64>) -> ()
    return
}
