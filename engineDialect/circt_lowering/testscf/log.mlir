// -----// IR Dump After AffineToLoopSchedule (convert-affine-to-loopschedule) //----- //
func.func @main() {
  %c3 = arith.constant 3 : index
  %cst = arith.constant 3.000000e+00 : f64
  %cst_0 = arith.constant 2.000000e+00 : f64
  %cst_1 = arith.constant 1.000000e+00 : f64
  %c2 = arith.constant 2 : index
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %alloc = memref.alloc() : memref<3xf64>
  memref.store %cst_1, %alloc[%c0] : memref<3xf64>
  memref.store %cst_0, %alloc[%c1] : memref<3xf64>
  memref.store %cst, %alloc[%c2] : memref<3xf64>
  %alloc_2 = memref.alloc() : memref<3xf64>
  memref.store %cst_1, %alloc_2[%c0] : memref<3xf64>
  memref.store %cst_0, %alloc_2[%c1] : memref<3xf64>
  memref.store %cst, %alloc_2[%c2] : memref<3xf64>
  %alloc_3 = memref.alloc() : memref<3xf64>
  cf.br ^bb1(%c0 : index)
^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
  %1 = arith.cmpi slt, %0, %c3 : index
  cf.cond_br %1, ^bb2, ^bb3
^bb2:  // pred: ^bb1
  %2 = memref.load %alloc[%0] : memref<3xf64>
  %3 = memref.load %alloc_2[%0] : memref<3xf64>
  %4 = arith.addf %2, %3 : f64
  memref.store %4, %alloc_3[%0] : memref<3xf64>
  %5 = arith.addi %0, %c1 : index
  cf.br ^bb1(%5 : index)
^bb3:  // pred: ^bb1
  return
}

// -----// IR Dump After CFToHandshake (lower-cf-to-handshake) //----- //
module {
  handshake.func @main(%arg0: none, ...) -> none attributes {argNames = ["in0"], resNames = ["out0"]} {
    %0 = memory[ld = 0, st = 1] (%dataResult_21, %addressResult_22) {id = 2 : i32, lsq = false} : memref<3xf64>, (f64, index) -> none
    %1:5 = memory[ld = 1, st = 3] (%dataResult_4, %addressResult_5, %dataResult_6, %addressResult_7, %dataResult_8, %addressResult_9, %addressResults_20) {id = 1 : i32, lsq = false} : memref<3xf64>, (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
    %2:5 = memory[ld = 1, st = 3] (%dataResult, %addressResult, %dataResult_0, %addressResult_1, %dataResult_2, %addressResult_3, %addressResults) {id = 0 : i32, lsq = false} : memref<3xf64>, (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
    %3 = merge %arg0 : none
    %4 = join %3, %2#1, %2#2, %2#3, %1#1, %1#2, %1#3 : none, none, none, none, none, none, none
    %5 = constant %3 {value = 3 : index} : index
    %6 = constant %3 {value = 3.000000e+00 : f64} : f64
    %7 = constant %3 {value = 2.000000e+00 : f64} : f64
    %8 = constant %3 {value = 1.000000e+00 : f64} : f64
    %9 = constant %3 {value = 2 : index} : index
    %10 = constant %3 {value = 1 : index} : index
    %11 = constant %3 {value = 0 : index} : index
    %dataResult, %addressResult = store [%11] %8, %3 : index, f64
    %12 = join %3, %2#1 : none, none
    %dataResult_0, %addressResult_1 = store [%10] %7, %12 : index, f64
    %13 = join %3, %2#1, %2#2 : none, none, none
    %dataResult_2, %addressResult_3 = store [%9] %6, %13 : index, f64
    %dataResult_4, %addressResult_5 = store [%11] %8, %3 : index, f64
    %14 = join %3, %1#1 : none, none
    %dataResult_6, %addressResult_7 = store [%10] %7, %14 : index, f64
    %15 = join %3, %1#1, %1#2 : none, none, none
    %dataResult_8, %addressResult_9 = store [%9] %6, %15 : index, f64
    %16 = br %4 : none
    %17 = br %5 : index
    %18 = br %10 : index
    %19 = br %11 : index
    %result, %index = control_merge %16 : none, index
    %20 = buffer [1] seq %28 {initValues = [0]} : i1
    %21 = mux %20 [%result, %38] : i1, none
    %22 = mux %index [%19] : index, index
    %23 = mux %20 [%22, %39] : i1, index
    %24 = mux %index [%17] : index, index
    %25 = mux %20 [%24, %36] : i1, index
    %26 = mux %index [%18] : index, index
    %27 = mux %20 [%26, %37] : i1, index
    %28 = merge %29 : i1
    %29 = arith.cmpi slt, %23, %25 : index
    %trueResult, %falseResult = cond_br %29, %23 : index
    %trueResult_10, %falseResult_11 = cond_br %29, %25 : index
    %trueResult_12, %falseResult_13 = cond_br %29, %27 : index
    %trueResult_14, %falseResult_15 = cond_br %29, %21 : none
    %30 = merge %trueResult_10 : index
    %31 = merge %trueResult_12 : index
    %32 = merge %trueResult : index
    %result_16, %index_17 = control_merge %trueResult_14 : none, index
    %33 = join %result_16, %2#4, %1#4, %0 : none, none, none, none
    %dataResult_18, %addressResults = load [%32] %2#0, %result_16 : index, f64
    %dataResult_19, %addressResults_20 = load [%32] %1#0, %result_16 : index, f64
    %34 = arith.addf %dataResult_18, %dataResult_19 : f64
    %dataResult_21, %addressResult_22 = store [%32] %34, %result_16 : index, f64
    %35 = arith.addi %32, %31 : index
    %36 = br %30 : index
    %37 = br %31 : index
    %38 = br %33 : none
    %39 = br %35 : index
    %result_23, %index_24 = control_merge %falseResult_15 : none, index
    return %result_23 : none
  }
}


input.mlir:3:11: error: 'handshake.memory' op result 1 has multiple uses.
    %c3 = arith.constant 3 : index
          ^
input.mlir:3:11: note: see current operation: %1:5 = "handshake.memory"(%17#0, %17#1, %19#0, %19#1, %21#0, %21#1, %47#1) <{id = 1 : i32, ldCount = 1 : i32, lsq = false, memRefType = memref<3xf64>, stCount = 3 : i32}> : (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
input.mlir:2:3: error: 'handshake.func' op HandshakeToHW: failed to verify that all values are used exactly once. Remember to run the fork/sink materialization pass before HW lowering.
  func.func @main() {
  ^
input.mlir:2:3: note: see current operation: 
"handshake.func"() <{function_type = (none) -> none}> ({
^bb0(%arg0: none):
  %0 = "handshake.memory"(%49#0, %49#1) <{id = 2 : i32, ldCount = 0 : i32, lsq = false, memRefType = memref<3xf64>, stCount = 1 : i32}> : (f64, index) -> none
  %1:5 = "handshake.memory"(%17#0, %17#1, %19#0, %19#1, %21#0, %21#1, %47#1) <{id = 1 : i32, ldCount = 1 : i32, lsq = false, memRefType = memref<3xf64>, stCount = 3 : i32}> : (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
  %2:5 = "handshake.memory"(%12#0, %12#1, %14#0, %14#1, %16#0, %16#1, %46#1) <{id = 0 : i32, ldCount = 1 : i32, lsq = false, memRefType = memref<3xf64>, stCount = 3 : i32}> : (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
  %3 = "handshake.merge"(%arg0) : (none) -> none
  %4 = "handshake.join"(%3, %2#1, %2#2, %2#3, %1#1, %1#2, %1#3) : (none, none, none, none, none, none, none) -> none
  %5 = "handshake.constant"(%3) <{value = 3 : index}> : (none) -> index
  %6 = "handshake.constant"(%3) <{value = 3.000000e+00 : f64}> : (none) -> f64
  %7 = "handshake.constant"(%3) <{value = 2.000000e+00 : f64}> : (none) -> f64
  %8 = "handshake.constant"(%3) <{value = 1.000000e+00 : f64}> : (none) -> f64
  %9 = "handshake.constant"(%3) <{value = 2 : index}> : (none) -> index
  %10 = "handshake.constant"(%3) <{value = 1 : index}> : (none) -> index
  %11 = "handshake.constant"(%3) <{value = 0 : index}> : (none) -> index
  %12:2 = "handshake.store"(%11, %8, %3) : (index, f64, none) -> (f64, index)
  %13 = "handshake.join"(%3, %2#1) : (none, none) -> none
  %14:2 = "handshake.store"(%10, %7, %13) : (index, f64, none) -> (f64, index)
  %15 = "handshake.join"(%3, %2#1, %2#2) : (none, none, none) -> none
  %16:2 = "handshake.store"(%9, %6, %15) : (index, f64, none) -> (f64, index)
  %17:2 = "handshake.store"(%11, %8, %3) : (index, f64, none) -> (f64, index)
  %18 = "handshake.join"(%3, %1#1) : (none, none) -> none
  %19:2 = "handshake.store"(%10, %7, %18) : (index, f64, none) -> (f64, index)
  %20 = "handshake.join"(%3, %1#1, %1#2) : (none, none, none) -> none
  %21:2 = "handshake.store"(%9, %6, %20) : (index, f64, none) -> (f64, index)
  %22 = "handshake.br"(%4) : (none) -> none
  %23 = "handshake.br"(%5) : (index) -> index
  %24 = "handshake.br"(%10) : (index) -> index
  %25 = "handshake.br"(%11) : (index) -> index
  %26:2 = "handshake.control_merge"(%22) : (none) -> (none, index)
  %27 = "handshake.buffer"(%35) <{bufferType = #handshake<buffer_type_enum seq>, initValues = [0], slots = 1 : i32}> : (i1) -> i1
  %28 = "handshake.mux"(%27, %26#0, %53) : (i1, none, none) -> none
  %29 = "handshake.mux"(%26#1, %25) : (index, index) -> index
  %30 = "handshake.mux"(%27, %29, %54) : (i1, index, index) -> index
  %31 = "handshake.mux"(%26#1, %23) : (index, index) -> index
  %32 = "handshake.mux"(%27, %31, %51) : (i1, index, index) -> index
  %33 = "handshake.mux"(%26#1, %24) : (index, index) -> index
  %34 = "handshake.mux"(%27, %33, %52) : (i1, index, index) -> index
  %35 = "handshake.merge"(%36) : (i1) -> i1
  %36 = "arith.cmpi"(%30, %32) <{predicate = 2 : i64}> : (index, index) -> i1
  %37:2 = "handshake.cond_br"(%36, %30) : (i1, index) -> (index, index)
  %38:2 = "handshake.cond_br"(%36, %32) : (i1, index) -> (index, index)
  %39:2 = "handshake.cond_br"(%36, %34) : (i1, index) -> (index, index)
  %40:2 = "handshake.cond_br"(%36, %28) : (i1, none) -> (none, none)
  %41 = "handshake.merge"(%38#0) : (index) -> index
  %42 = "handshake.merge"(%39#0) : (index) -> index
  %43 = "handshake.merge"(%37#0) : (index) -> index
  %44:2 = "handshake.control_merge"(%40#0) : (none) -> (none, index)
  %45 = "handshake.join"(%44#0, %2#4, %1#4, %0) : (none, none, none, none) -> none
  %46:2 = "handshake.load"(%43, %2#0, %44#0) : (index, f64, none) -> (f64, index)
  %47:2 = "handshake.load"(%43, %1#0, %44#0) : (index, f64, none) -> (f64, index)
  %48 = "arith.addf"(%46#0, %47#0) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
  %49:2 = "handshake.store"(%43, %48, %44#0) : (index, f64, none) -> (f64, index)
  %50 = "arith.addi"(%43, %42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  %51 = "handshake.br"(%41) : (index) -> index
  %52 = "handshake.br"(%42) : (index) -> index
  %53 = "handshake.br"(%45) : (none) -> none
  %54 = "handshake.br"(%50) : (index) -> index
  %55:2 = "handshake.control_merge"(%40#1) : (none) -> (none, index)
  "handshake.return"(%55#0) : (none) -> ()
}) {argNames = ["in0"], resNames = ["out0"], sym_name = "main"} : () -> ()
// -----// IR Dump After HandshakeToHW Failed (lower-handshake-to-hw) //----- //
module {
  handshake.func @main(%arg0: none, ...) -> none attributes {argNames = ["in0"], resNames = ["out0"]} {
    %0 = memory[ld = 0, st = 1] (%dataResult_21, %addressResult_22) {id = 2 : i32, lsq = false} : memref<3xf64>, (f64, index) -> none
    %1:5 = memory[ld = 1, st = 3] (%dataResult_4, %addressResult_5, %dataResult_6, %addressResult_7, %dataResult_8, %addressResult_9, %addressResults_20) {id = 1 : i32, lsq = false} : memref<3xf64>, (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
    %2:5 = memory[ld = 1, st = 3] (%dataResult, %addressResult, %dataResult_0, %addressResult_1, %dataResult_2, %addressResult_3, %addressResults) {id = 0 : i32, lsq = false} : memref<3xf64>, (f64, index, f64, index, f64, index, index) -> (f64, none, none, none, none)
    %3 = merge %arg0 : none
    %4 = join %3, %2#1, %2#2, %2#3, %1#1, %1#2, %1#3 : none, none, none, none, none, none, none
    %5 = constant %3 {value = 3 : index} : index
    %6 = constant %3 {value = 3.000000e+00 : f64} : f64
    %7 = constant %3 {value = 2.000000e+00 : f64} : f64
    %8 = constant %3 {value = 1.000000e+00 : f64} : f64
    %9 = constant %3 {value = 2 : index} : index
    %10 = constant %3 {value = 1 : index} : index
    %11 = constant %3 {value = 0 : index} : index
    %dataResult, %addressResult = store [%11] %8, %3 : index, f64
    %12 = join %3, %2#1 : none, none
    %dataResult_0, %addressResult_1 = store [%10] %7, %12 : index, f64
    %13 = join %3, %2#1, %2#2 : none, none, none
    %dataResult_2, %addressResult_3 = store [%9] %6, %13 : index, f64
    %dataResult_4, %addressResult_5 = store [%11] %8, %3 : index, f64
    %14 = join %3, %1#1 : none, none
    %dataResult_6, %addressResult_7 = store [%10] %7, %14 : index, f64
    %15 = join %3, %1#1, %1#2 : none, none, none
    %dataResult_8, %addressResult_9 = store [%9] %6, %15 : index, f64
    %16 = br %4 : none
    %17 = br %5 : index
    %18 = br %10 : index
    %19 = br %11 : index
    %result, %index = control_merge %16 : none, index
    %20 = buffer [1] seq %28 {initValues = [0]} : i1
    %21 = mux %20 [%result, %38] : i1, none
    %22 = mux %index [%19] : index, index
    %23 = mux %20 [%22, %39] : i1, index
    %24 = mux %index [%17] : index, index
    %25 = mux %20 [%24, %36] : i1, index
    %26 = mux %index [%18] : index, index
    %27 = mux %20 [%26, %37] : i1, index
    %28 = merge %29 : i1
    %29 = arith.cmpi slt, %23, %25 : index
    %trueResult, %falseResult = cond_br %29, %23 : index
    %trueResult_10, %falseResult_11 = cond_br %29, %25 : index
    %trueResult_12, %falseResult_13 = cond_br %29, %27 : index
    %trueResult_14, %falseResult_15 = cond_br %29, %21 : none
    %30 = merge %trueResult_10 : index
    %31 = merge %trueResult_12 : index
    %32 = merge %trueResult : index
    %result_16, %index_17 = control_merge %trueResult_14 : none, index
    %33 = join %result_16, %2#4, %1#4, %0 : none, none, none, none
    %dataResult_18, %addressResults = load [%32] %2#0, %result_16 : index, f64
    %dataResult_19, %addressResults_20 = load [%32] %1#0, %result_16 : index, f64
    %34 = arith.addf %dataResult_18, %dataResult_19 : f64
    %dataResult_21, %addressResult_22 = store [%32] %34, %result_16 : index, f64
    %35 = arith.addi %32, %31 : index
    %36 = br %30 : index
    %37 = br %31 : index
    %38 = br %33 : none
    %39 = br %35 : index
    %result_23, %index_24 = control_merge %falseResult_15 : none, index
    return %result_23 : none
  }
}


