

module {

 // test
  func.func @add() -> memref<3xf64> {
    // defining two tensors
    %t1 = memref.alloc() : memref<3xf64>
    %t2 = memref.alloc() : memref<3xf64>

    %1 = arith.constant 1.0 : f64
    %2 = arith.constant 2.0 : f64
    %3 = arith.constant 3.0 : f64

    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index

    // setting tensor 1
    memref.store %1, %t1[%c0] : memref<3xf64>  
    memref.store %2, %t1[%c1] : memref<3xf64>  
    memref.store %3, %t1[%c2] : memref<3xf64> 

    // setting tensor 2
    memref.store %1, %t2[%c0] : memref<3xf64>  
    memref.store %2, %t2[%c1] : memref<3xf64>  
    memref.store %3, %t2[%c2] : memref<3xf64> 


    %output = memref.alloc() : memref<3xf64>
    linalg.add ins(%t1,%t2 : memref<3xf64>, memref<3xf64>) outs(%output : memref<3xf64>)

    return %output : memref<3xf64>
  }

  func.func @main() {
    %result = call @add() : () -> memref<3xf64>
    "engine.print"(%result) : (memref<3xf64>) -> ()
    return
  }
  
}