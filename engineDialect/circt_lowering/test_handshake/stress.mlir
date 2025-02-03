
            module {
            func.func @main() {
                "engine.settings"() { value = 1 : i32, type = 0 : i32 } : () -> ()
                %_model.fc1.weight = "engine.constant"() {value=dense<[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]>:tensor<70xi32>} : () -> memref<70xi32>

                func.return 
            }
            }
        