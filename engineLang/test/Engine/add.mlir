// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()

func.func @const() -> memref<2x3xf64>{
    %t1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    return %t1 : memref<2x3xf64>
}

func.func @main() {
    %0 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    %1 = "engine.constant"() {value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf64>} : () -> memref<2x3xf64>
    
    %res = memref.alloc() : memref<f64>
    linalg.dot ins(%0,%t1 : memref<2x3xf64>, memref<2x3xf64>) outs(%: memref<f64>)
    
    "engine.print"(%0) : (memref<2x3xf64>) -> ()
    return
}
