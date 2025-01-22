module{

    func.func @main(){
        %t1 = "engine.constant"() {value = dense<[1]> : tensor<1xi32>} : () -> memref<1xi32>
        func.return
    }
}