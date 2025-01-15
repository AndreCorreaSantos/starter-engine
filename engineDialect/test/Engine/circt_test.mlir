module {
  func.func @main() -> f64 {
    %0 = arith.constant 1.0 : f64
    %1 = arith.constant 1.0 : f64
    %2 = arith.addf %0, %1 : f64
    return %2 : f64
  }
}
