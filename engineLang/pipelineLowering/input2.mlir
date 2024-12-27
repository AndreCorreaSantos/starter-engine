

module {
 // test
  func.func @sqrt() -> memref<3xf32> {
    %0 = memref.alloc() : memref<3xf32>
    %1 = arith.constant 1.0 : f32
    %2 = arith.constant 2.0 : f32
    %3 = arith.constant 3.0 : f32

    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index

    memref.store %1, %0[%c0] : memref<3xf32>  
    memref.store %2, %0[%c1] : memref<3xf32>  
    memref.store %3, %0[%c2] : memref<3xf32> 

    %output = memref.alloc() : memref<3xf32>
    linalg.sqrt ins(%0 : memref<3xf32>) outs(%output : memref<3xf32>)

    return %output : memref<3xf32>
  }

  func.func @main() {
    %result = call @sqrt() : () -> memref<3xf32>
    return
  }
  
}