func.func @main() {
    // Define %tensor before using it in the store operation
    %tensor = "engine.constant"() {value = dense<[[1.0, 2.0], [3.0, 4.0]]> : tensor<2x2xf64>} : () -> tensor<2x2xf64>
    // print the tensor
    "engine.print"(%tensor) : (tensor<2x2xf64>) -> ()

    // Store the tensor in a variable
    "engine.store"(%tensor) {name = "my_tensor"} : (tensor<2x2xf64>) -> ()
    return
}