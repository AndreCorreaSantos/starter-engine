// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
    %0 = "engine.constant"() {value = dense<[[1.000000e+00]]> : tensor<1x1xf64>} : () -> tensor<1x1xf64>
    "engine.print"(%0) : (tensor<1x1xf64>) -> ()
    return
}
