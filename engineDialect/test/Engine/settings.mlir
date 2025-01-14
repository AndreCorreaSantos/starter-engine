func.func @main() {
    "engine.settings"() { value = 1 : i32 } : () -> ()
    %fc3.bias = "engine.constant"() {value=dense<[-0.2, 0.3, 0.1, -0.1, -0.1, 0.1, -0.0, -0.0, -0.1, 0.0]>:tensor<10xf64>} : () -> memref<10xf64>
    return
}
