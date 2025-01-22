module{

    func.func @main(){
        %t1 = "engine.constant"() {value = dense<[-1,2]> : tensor<2xi32>} : () -> memref<2xi32>
        func.return
    }
}