// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
  %0 = "engine.constant"() {value = dense<[[1.0], [2.0], [3.0]]> : tensor<3x1xf64>} : () -> memref<3x1xf64>
  %1 = "engine.constant"() {value = dense<[[1.0, 2.0, 3.0]]> : tensor<1x3xf64>} : () -> memref<1x3xf64>
  %2 = "engine.matmul"(%0, %1) : (memref<3x1xf64>, memref<1x3xf64>) -> memref<3x3xf64>

  "engine.print"(%2) : (memref<3x3xf64>) -> ()
  return
}
