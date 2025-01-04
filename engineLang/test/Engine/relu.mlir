// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[[[[-1.0,2.0]]]]> : tensor<1x1x1x2xf64>} : () -> memref<1x1x1x2xf64>
    %2 = "engine.relu"(%0) : (memref<1x1x1x2xf64>) -> memref<1x1x1x2xf64>
    "engine.print"(%2) : (memref<1x1x1x2xf64>) -> ()
    return
}
