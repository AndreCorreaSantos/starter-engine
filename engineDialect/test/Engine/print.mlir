// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %fc3.bias = "engine.constant"() {value=dense<[-0.2, 0.3, 0.1, -0.1, -0.1, 0.1, -0.0, -0.0, -0.1, 0.0]>:tensor<10xf64>} : () -> memref<10xf64>
    "engine.print"(%fc3.bias) : (memref<10xf64>) -> ()
    return
}
