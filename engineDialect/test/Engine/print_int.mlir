// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %fc3.bias = "engine.constant"() {value=dense<[-2, 3, 1, -1, -1, 1, 0, 0, -1, 0]>:tensor<10xi32>} : () -> memref<10xi32>
    // "engine.print"(%fc3.bias) : (memref<10xi32>) -> ()
    return
}
