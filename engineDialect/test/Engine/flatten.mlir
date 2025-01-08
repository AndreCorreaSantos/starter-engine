// RUN: engine-opt %s | FileCheck %s

// CHECK: define void @main()
func.func @main() {
  %0 = "engine.constant"() {value = dense<[[1.0,2.0], [2.0,2.0], [3.0,2.0]]> : tensor<3x2xf64>} : () -> memref<3x2xf64>
  %1 = "engine.flatten"(%0) : (memref<3x2xf64>) -> memref<6xf64>

  "engine.print"(%1) : (memref<6xf64>) -> ()
  return
}
