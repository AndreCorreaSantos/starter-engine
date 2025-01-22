// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[[[[-1,2]]]]> : tensor<1x1x1x2xi32>} : () -> memref<1x1x1x2xi32>
    %2 = "engine.relu"(%0) : (memref<1x1x1x2xi32>) -> memref<1x1x1x2xi32>
    "engine.print"(%2) : (memref<1x1x1x2xi32>) -> ()
    return
}
