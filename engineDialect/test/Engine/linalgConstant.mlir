

func.func @constant() -> tensor<1x1xf64>{
 %0 = "engine.constant"() {value = dense<[[1.000000e+00]]> : tensor<1x1xf64>} : () -> tensor<1x1xf64>
 return %0 : tensor<1x1xf64>
}

func.func @main() {
   
    %1 = call @constant() : () -> tensor<1x1xf64>
    return
}