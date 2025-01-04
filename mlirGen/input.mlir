module {
  func.func @main() {
    %tensor1 = arith.constant dense<[[1.0, 2.0], [3.0, 4.0]]> : tensor<2x2xf64>
    %tensor2 = arith.constant dense<[[5.0, 6.0], [7.0, 8.0]]> : tensor<2x2xf64>
    
    %init = tensor.empty() : tensor<2x2xf64>
    %zero = arith.constant 0.0 : f64
    %filled = linalg.fill ins(%zero : f64) outs(%init : tensor<2x2xf64>) -> tensor<2x2xf64>
    
    %result = linalg.generic {
      indexing_maps = [
        affine_map<(i, j, k) -> (i, k)>,
        affine_map<(i, j, k) -> (k, j)>,
        affine_map<(i, j, k) -> (i, j)>
      ],
      iterator_types = ["parallel", "parallel", "reduction"]
    } ins(%tensor1, %tensor2 : tensor<2x2xf64>, tensor<2x2xf64>)
    outs(%filled : tensor<2x2xf64>) {
      ^bb0(%a: f64, %b: f64, %c: f64):
        %mul = arith.mulf %a, %b : f64
        %add = arith.addf %c, %mul : f64
        linalg.yield %add : f64
    } -> tensor<2x2xf64>
    
    return
  }
}
