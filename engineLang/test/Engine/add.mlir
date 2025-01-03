// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()

func.func @main() {
    %0 = "engine.constant"() {value = dense<[4.000000e+00, 5.000000e+00, 6.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    %1 = "engine.constant"() {value = dense<[4.000000e+00, 5.000000e+00, 6.000000e+00]> : tensor<3xf64>} : () -> memref<3xf64>
    
    %res = memref.alloc() : memref<f64>
    linalg.dot ins(%0,%1 : memref<3xf64>, memref<3xf64>) outs(%res: memref<f64>)
    
    "engine.print"(%res) : (memref<f64>) -> ()
    return
}
