// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    "engine.settings"() { value = 0 : i32, type = 0 : i32 } : () -> ()
    %0 = "engine.constant"() {value = dense<[[1], [2], [3]]> : tensor<3x1xi32>} : () -> memref<3x1xi32>
    %1 = "engine.constant"() {value = dense<[2]> : tensor<1xi32>} : () -> memref<1xi32>
    %2 = "engine.matmul"(%0, %1) : (memref<3x1xi32>, memref<1xi32>) -> memref<3xi32>
    
    "engine.print"(%2) : (memref<3xi32>) -> ()
    return
}
