module {
  func.func @main() {
    %c3 = arith.constant 3 : index
    %cst = arith.constant 3.000000e+00 : f64
    %cst_0 = arith.constant 2.000000e+00 : f64
    %cst_1 = arith.constant 1.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<3xf64>
    affine.store %cst_1, %alloc[%c0] : memref<3xf64>
    affine.store %cst_0, %alloc[%c1] : memref<3xf64>
    affine.store %cst, %alloc[%c2] : memref<3xf64>
    %alloc_2 = memref.alloc() : memref<3xf64>
    affine.store %cst_1, %alloc_2[%c0] : memref<3xf64>
    affine.store %cst_0, %alloc_2[%c1] : memref<3xf64>
    affine.store %cst, %alloc_2[%c2] : memref<3xf64>
    %alloc_3 = memref.alloc() : memref<3xf64>
    scf.for %arg0 = %c0 to %c3 step %c1 {
      %0 = memref.load %alloc[%arg0] : memref<3xf64>
      %1 = memref.load %alloc_2[%arg0] : memref<3xf64>
      %2 = arith.addf %0, %1 : f64
      memref.store %2, %alloc_3[%arg0] : memref<3xf64>
    }
    return
  }
}
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
  scf.for %arg0 = %c0 to %c3 step %c1 {
    %0 = memref.load %alloc[%arg0] : memref<3xf64>
    %1 = memref.load %alloc_2[%arg0] : memref<3xf64>
    %2 = arith.addf %0, %1 : f64
    memref.store %2, %alloc_3[%arg0] : memref<3xf64>
  }
  return
}

// -----// IR Dump After SCFToCalyx (lower-scf-to-calyx) //----- //
module attributes {calyx.entrypoint = "main"} {
  calyx.component @main(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %c1_i32 = hw.constant 1 : i32
    %true = hw.constant true
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %c2_i32 = hw.constant 2 : i32
    %cst = calyx.constant @cst_2 <1.000000e+00 : f64> : i64
    %cst_0 = calyx.constant @cst_1 <2.000000e+00 : f64> : i64
    %cst_1 = calyx.constant @cst_0 <3.000000e+00 : f64> : i64
    %std_slice_8.in, %std_slice_8.out = calyx.std_slice @std_slice_8 : i32, i2
    %std_slice_7.in, %std_slice_7.out = calyx.std_slice @std_slice_7 : i32, i2
    %std_slice_6.in, %std_slice_6.out = calyx.std_slice @std_slice_6 : i32, i2
    %std_slice_5.in, %std_slice_5.out = calyx.std_slice @std_slice_5 : i32, i2
    %std_slice_4.in, %std_slice_4.out = calyx.std_slice @std_slice_4 : i32, i2
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i2
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i2
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i2
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i2
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %addf_0_reg.in, %addf_0_reg.write_en, %addf_0_reg.clk, %addf_0_reg.reset, %addf_0_reg.out, %addf_0_reg.done = calyx.register @addf_0_reg : i64, i1, i1, i1, i64, i1
    %std_addFN_0.clk, %std_addFN_0.reset, %std_addFN_0.go, %std_addFN_0.control, %std_addFN_0.subOp, %std_addFN_0.left, %std_addFN_0.right, %std_addFN_0.roundingMode, %std_addFN_0.out, %std_addFN_0.exceptionalFlags, %std_addFN_0.done = calyx.ieee754.add @std_addFN_0 : i1, i1, i1, i1, i1, i64, i64, i3, i64, i5, i1
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i64, i1, i1, i1, i64, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i64, i1, i1, i1, i64, i1
    %mem_2.addr0, %mem_2.clk, %mem_2.reset, %mem_2.content_en, %mem_2.write_en, %mem_2.write_data, %mem_2.read_data, %mem_2.done = calyx.seq_mem @mem_2 <[3] x 64> [2] {external = true} : i2, i1, i1, i1, i1, i64, i64, i1
    %mem_1.addr0, %mem_1.clk, %mem_1.reset, %mem_1.content_en, %mem_1.write_en, %mem_1.write_data, %mem_1.read_data, %mem_1.done = calyx.seq_mem @mem_1 <[3] x 64> [2] {external = true} : i2, i1, i1, i1, i1, i64, i64, i1
    %mem_0.addr0, %mem_0.clk, %mem_0.reset, %mem_0.content_en, %mem_0.write_en, %mem_0.write_data, %mem_0.read_data, %mem_0.done = calyx.seq_mem @mem_0 <[3] x 64> [2] {external = true} : i2, i1, i1, i1, i1, i64, i64, i1
    %for_0_induction_var_reg.in, %for_0_induction_var_reg.write_en, %for_0_induction_var_reg.clk, %for_0_induction_var_reg.reset, %for_0_induction_var_reg.out, %for_0_induction_var_reg.done = calyx.register @for_0_induction_var_reg : i32, i1, i1, i1, i32, i1
    calyx.wires {
      calyx.group @init_for_0_induction_var {
        calyx.assign %for_0_induction_var_reg.in = %c0_i32 : i32
        calyx.assign %for_0_induction_var_reg.write_en = %true : i1
        calyx.group_done %for_0_induction_var_reg.done : i1
      }
      calyx.group @bb0_0 {
        calyx.assign %std_slice_8.in = %c0_i32 : i32
        calyx.assign %mem_0.addr0 = %std_slice_8.out : i2
        calyx.assign %mem_0.write_data = %cst : i64
        calyx.assign %mem_0.write_en = %true : i1
        calyx.assign %mem_0.content_en = %true : i1
        calyx.group_done %mem_0.done : i1
      }
      calyx.group @bb0_1 {
        calyx.assign %std_slice_7.in = %c1_i32 : i32
        calyx.assign %mem_0.addr0 = %std_slice_7.out : i2
        calyx.assign %mem_0.write_data = %cst_0 : i64
        calyx.assign %mem_0.write_en = %true : i1
        calyx.assign %mem_0.content_en = %true : i1
        calyx.group_done %mem_0.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_6.in = %c2_i32 : i32
        calyx.assign %mem_0.addr0 = %std_slice_6.out : i2
        calyx.assign %mem_0.write_data = %cst_1 : i64
        calyx.assign %mem_0.write_en = %true : i1
        calyx.assign %mem_0.content_en = %true : i1
        calyx.group_done %mem_0.done : i1
      }
      calyx.group @bb0_3 {
        calyx.assign %std_slice_5.in = %c0_i32 : i32
        calyx.assign %mem_1.addr0 = %std_slice_5.out : i2
        calyx.assign %mem_1.write_data = %cst : i64
        calyx.assign %mem_1.write_en = %true : i1
        calyx.assign %mem_1.content_en = %true : i1
        calyx.group_done %mem_1.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_4.in = %c1_i32 : i32
        calyx.assign %mem_1.addr0 = %std_slice_4.out : i2
        calyx.assign %mem_1.write_data = %cst_0 : i64
        calyx.assign %mem_1.write_en = %true : i1
        calyx.assign %mem_1.content_en = %true : i1
        calyx.group_done %mem_1.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_slice_3.in = %c2_i32 : i32
        calyx.assign %mem_1.addr0 = %std_slice_3.out : i2
        calyx.assign %mem_1.write_data = %cst_1 : i64
        calyx.assign %mem_1.write_en = %true : i1
        calyx.assign %mem_1.content_en = %true : i1
        calyx.group_done %mem_1.done : i1
      }
      calyx.group @bb0_6 {
        calyx.assign %std_slice_2.in = %for_0_induction_var_reg.out : i32
        calyx.assign %mem_0.addr0 = %std_slice_2.out : i2
        calyx.assign %mem_0.content_en = %true : i1
        calyx.assign %mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %mem_0.read_data : i64
        calyx.assign %load_0_reg.write_en = %mem_0.done : i1
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_7 {
        calyx.assign %std_slice_1.in = %for_0_induction_var_reg.out : i32
        calyx.assign %mem_1.addr0 = %std_slice_1.out : i2
        calyx.assign %mem_1.content_en = %true : i1
        calyx.assign %mem_1.write_en = %false : i1
        calyx.assign %load_1_reg.in = %mem_1.read_data : i64
        calyx.assign %load_1_reg.write_en = %mem_1.done : i1
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_addFN_0.left = %load_0_reg.out : i64
        calyx.assign %std_addFN_0.right = %load_1_reg.out : i64
        calyx.assign %addf_0_reg.in = %std_addFN_0.out : i64
        calyx.assign %addf_0_reg.write_en = %std_addFN_0.done : i1
        %0 = comb.xor %std_addFN_0.done, %true : i1
        calyx.assign %std_addFN_0.go = %0 ? %true : i1
        calyx.assign %std_addFN_0.subOp = %false : i1
        calyx.group_done %addf_0_reg.done : i1
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_0.in = %for_0_induction_var_reg.out : i32
        calyx.assign %mem_2.addr0 = %std_slice_0.out : i2
        calyx.assign %mem_2.write_data = %addf_0_reg.out : i64
        calyx.assign %mem_2.write_en = %true : i1
        calyx.assign %mem_2.content_en = %true : i1
        calyx.group_done %mem_2.done : i1
      }
      calyx.group @incr_for_0_induction_var {
        calyx.assign %std_add_0.left = %for_0_induction_var_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.assign %for_0_induction_var_reg.in = %std_add_0.out : i32
        calyx.assign %for_0_induction_var_reg.write_en = %true : i1
        calyx.group_done %for_0_induction_var_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_1
          calyx.enable @bb0_2
          calyx.enable @bb0_3
          calyx.enable @bb0_4
          calyx.enable @bb0_5
          calyx.par {
            calyx.enable @init_for_0_induction_var
          }
          calyx.repeat 3 {
            calyx.seq {
              calyx.seq {
                calyx.enable @bb0_6
                calyx.enable @bb0_7
                calyx.enable @bb0_8
                calyx.enable @bb0_9
              }
              calyx.enable @incr_for_0_induction_var
            }
          }
        }
      }
    }
  } {toplevel}
}


Error: Failed to parse `/tmp/calyxNativeTemp-143691`:  --> /tmp/calyxNativeTemp-143691:8:28
  |
8 |     cst_2 = std_float_const(0, 64, 1.000000);
  |                            ^---
  |
  = expected args
<stdin>:1:1: error: 
module {
^
<stdin>:1:1: note: see current operation: 
"builtin.module"() ({
  "calyx.component"() <{function_type = (i1, i1, i1, i1) -> (), portAttributes = [{clk}, {reset}, {go}, {done}], portDirections = -8 : i4, portNames = ["clk", "reset", "go", "done"]}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1):
    %0 = "hw.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "hw.constant"() <{value = true}> : () -> i1
    %2 = "hw.constant"() <{value = false}> : () -> i1
    %3 = "hw.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "hw.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "calyx.constant"() <{sym_name = "cst_2", value = 1.000000e+00 : f64}> : () -> i64
    %6 = "calyx.constant"() <{sym_name = "cst_1", value = 2.000000e+00 : f64}> : () -> i64
    %7 = "calyx.constant"() <{sym_name = "cst_0", value = 3.000000e+00 : f64}> : () -> i64
    %8:2 = "calyx.std_slice"() <{sym_name = "std_slice_8"}> : () -> (i32, i2)
    %9:2 = "calyx.std_slice"() <{sym_name = "std_slice_7"}> : () -> (i32, i2)
    %10:2 = "calyx.std_slice"() <{sym_name = "std_slice_6"}> : () -> (i32, i2)
    %11:2 = "calyx.std_slice"() <{sym_name = "std_slice_5"}> : () -> (i32, i2)
    %12:2 = "calyx.std_slice"() <{sym_name = "std_slice_4"}> : () -> (i32, i2)
    %13:2 = "calyx.std_slice"() <{sym_name = "std_slice_3"}> : () -> (i32, i2)
    %14:2 = "calyx.std_slice"() <{sym_name = "std_slice_2"}> : () -> (i32, i2)
    %15:2 = "calyx.std_slice"() <{sym_name = "std_slice_1"}> : () -> (i32, i2)
    %16:2 = "calyx.std_slice"() <{sym_name = "std_slice_0"}> : () -> (i32, i2)
    %17:3 = "calyx.std_add"() <{sym_name = "std_add_0"}> : () -> (i32, i32, i32)
    %18:6 = "calyx.register"() <{sym_name = "addf_0_reg"}> : () -> (i64, i1, i1, i1, i64, i1)
    %19:11 = "calyx.ieee754.add"() <{sym_name = "std_addFN_0"}> : () -> (i1, i1, i1, i1, i1, i64, i64, i3, i64, i5, i1)
    %20:6 = "calyx.register"() <{sym_name = "load_1_reg"}> : () -> (i64, i1, i1, i1, i64, i1)
    %21:6 = "calyx.register"() <{sym_name = "load_0_reg"}> : () -> (i64, i1, i1, i1, i64, i1)
    %22:8 = "calyx.seq_mem"() <{addrSizes = [2], sizes = [3], sym_name = "mem_2", width = 64 : i64}> {external = true} : () -> (i2, i1, i1, i1, i1, i64, i64, i1)
    %23:8 = "calyx.seq_mem"() <{addrSizes = [2], sizes = [3], sym_name = "mem_1", width = 64 : i64}> {external = true} : () -> (i2, i1, i1, i1, i1, i64, i64, i1)
    %24:8 = "calyx.seq_mem"() <{addrSizes = [2], sizes = [3], sym_name = "mem_0", width = 64 : i64}> {external = true} : () -> (i2, i1, i1, i1, i1, i64, i64, i1)
    %25:6 = "calyx.register"() <{sym_name = "for_0_induction_var_reg"}> : () -> (i32, i1, i1, i1, i32, i1)
    "calyx.wires"() ({
      "calyx.group"() <{sym_name = "init_for_0_induction_var"}> ({
        "calyx.assign"(%25#0, %3) : (i32, i32) -> ()
        "calyx.assign"(%25#1, %1) : (i1, i1) -> ()
        "calyx.group_done"(%25#5) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_0"}> ({
        "calyx.assign"(%8#0, %3) : (i32, i32) -> ()
        "calyx.assign"(%24#0, %8#1) : (i2, i2) -> ()
        "calyx.assign"(%24#5, %5) : (i64, i64) -> ()
        "calyx.assign"(%24#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%24#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%24#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_1"}> ({
        "calyx.assign"(%9#0, %0) : (i32, i32) -> ()
        "calyx.assign"(%24#0, %9#1) : (i2, i2) -> ()
        "calyx.assign"(%24#5, %6) : (i64, i64) -> ()
        "calyx.assign"(%24#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%24#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%24#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_2"}> ({
        "calyx.assign"(%10#0, %4) : (i32, i32) -> ()
        "calyx.assign"(%24#0, %10#1) : (i2, i2) -> ()
        "calyx.assign"(%24#5, %7) : (i64, i64) -> ()
        "calyx.assign"(%24#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%24#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%24#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_3"}> ({
        "calyx.assign"(%11#0, %3) : (i32, i32) -> ()
        "calyx.assign"(%23#0, %11#1) : (i2, i2) -> ()
        "calyx.assign"(%23#5, %5) : (i64, i64) -> ()
        "calyx.assign"(%23#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%23#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%23#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_4"}> ({
        "calyx.assign"(%12#0, %0) : (i32, i32) -> ()
        "calyx.assign"(%23#0, %12#1) : (i2, i2) -> ()
        "calyx.assign"(%23#5, %6) : (i64, i64) -> ()
        "calyx.assign"(%23#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%23#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%23#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_5"}> ({
        "calyx.assign"(%13#0, %4) : (i32, i32) -> ()
        "calyx.assign"(%23#0, %13#1) : (i2, i2) -> ()
        "calyx.assign"(%23#5, %7) : (i64, i64) -> ()
        "calyx.assign"(%23#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%23#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%23#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_6"}> ({
        "calyx.assign"(%14#0, %25#4) : (i32, i32) -> ()
        "calyx.assign"(%24#0, %14#1) : (i2, i2) -> ()
        "calyx.assign"(%24#3, %1) : (i1, i1) -> ()
        "calyx.assign"(%24#4, %2) : (i1, i1) -> ()
        "calyx.assign"(%21#0, %24#6) : (i64, i64) -> ()
        "calyx.assign"(%21#1, %24#7) : (i1, i1) -> ()
        "calyx.group_done"(%21#5) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_7"}> ({
        "calyx.assign"(%15#0, %25#4) : (i32, i32) -> ()
        "calyx.assign"(%23#0, %15#1) : (i2, i2) -> ()
        "calyx.assign"(%23#3, %1) : (i1, i1) -> ()
        "calyx.assign"(%23#4, %2) : (i1, i1) -> ()
        "calyx.assign"(%20#0, %23#6) : (i64, i64) -> ()
        "calyx.assign"(%20#1, %23#7) : (i1, i1) -> ()
        "calyx.group_done"(%20#5) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_8"}> ({
        "calyx.assign"(%19#5, %21#4) : (i64, i64) -> ()
        "calyx.assign"(%19#6, %20#4) : (i64, i64) -> ()
        "calyx.assign"(%18#0, %19#8) : (i64, i64) -> ()
        "calyx.assign"(%18#1, %19#10) : (i1, i1) -> ()
        %26 = "comb.xor"(%19#10, %1) : (i1, i1) -> i1
        "calyx.assign"(%19#2, %1, %26) : (i1, i1, i1) -> ()
        "calyx.assign"(%19#4, %2) : (i1, i1) -> ()
        "calyx.group_done"(%18#5) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "bb0_9"}> ({
        "calyx.assign"(%16#0, %25#4) : (i32, i32) -> ()
        "calyx.assign"(%22#0, %16#1) : (i2, i2) -> ()
        "calyx.assign"(%22#5, %18#4) : (i64, i64) -> ()
        "calyx.assign"(%22#4, %1) : (i1, i1) -> ()
        "calyx.assign"(%22#3, %1) : (i1, i1) -> ()
        "calyx.group_done"(%22#7) : (i1) -> ()
      }) : () -> ()
      "calyx.group"() <{sym_name = "incr_for_0_induction_var"}> ({
        "calyx.assign"(%17#0, %25#4) : (i32, i32) -> ()
        "calyx.assign"(%17#1, %0) : (i32, i32) -> ()
        "calyx.assign"(%25#0, %17#2) : (i32, i32) -> ()
        "calyx.assign"(%25#1, %1) : (i1, i1) -> ()
        "calyx.group_done"(%25#5) : (i1) -> ()
      }) : () -> ()
    }) : () -> ()
    "calyx.control"() ({
      "calyx.seq"() ({
        "calyx.seq"() ({
          "calyx.enable"() <{groupName = @bb0_0}> : () -> ()
          "calyx.enable"() <{groupName = @bb0_1}> : () -> ()
          "calyx.enable"() <{groupName = @bb0_2}> : () -> ()
          "calyx.enable"() <{groupName = @bb0_3}> : () -> ()
          "calyx.enable"() <{groupName = @bb0_4}> : () -> ()
          "calyx.enable"() <{groupName = @bb0_5}> : () -> ()
          "calyx.par"() ({
            "calyx.enable"() <{groupName = @init_for_0_induction_var}> : () -> ()
          }) : () -> ()
          "calyx.repeat"() <{count = 3 : i32}> ({
            "calyx.seq"() ({
              "calyx.seq"() ({
                "calyx.enable"() <{groupName = @bb0_6}> : () -> ()
                "calyx.enable"() <{groupName = @bb0_7}> : () -> ()
                "calyx.enable"() <{groupName = @bb0_8}> : () -> ()
                "calyx.enable"() <{groupName = @bb0_9}> : () -> ()
              }) : () -> ()
              "calyx.enable"() <{groupName = @incr_for_0_induction_var}> : () -> ()
            }) : () -> ()
          }) : () -> ()
        }) : () -> ()
      }) : () -> ()
    }) : () -> ()
  }) {sym_name = "main", toplevel} : () -> ()
}) {calyx.entrypoint = "main"} : () -> ()
// -----// IR Dump After CalyxNative Failed (calyx-native) //----- //
module attributes {calyx.entrypoint = "main"} {
  calyx.component @main(%clk: i1 {clk}, %reset: i1 {reset}, %go: i1 {go}) -> (%done: i1 {done}) {
    %c1_i32 = hw.constant 1 : i32
    %true = hw.constant true
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %c2_i32 = hw.constant 2 : i32
    %cst = calyx.constant @cst_2 <1.000000e+00 : f64> : i64
    %cst_0 = calyx.constant @cst_1 <2.000000e+00 : f64> : i64
    %cst_1 = calyx.constant @cst_0 <3.000000e+00 : f64> : i64
    %std_slice_8.in, %std_slice_8.out = calyx.std_slice @std_slice_8 : i32, i2
    %std_slice_7.in, %std_slice_7.out = calyx.std_slice @std_slice_7 : i32, i2
    %std_slice_6.in, %std_slice_6.out = calyx.std_slice @std_slice_6 : i32, i2
    %std_slice_5.in, %std_slice_5.out = calyx.std_slice @std_slice_5 : i32, i2
    %std_slice_4.in, %std_slice_4.out = calyx.std_slice @std_slice_4 : i32, i2
    %std_slice_3.in, %std_slice_3.out = calyx.std_slice @std_slice_3 : i32, i2
    %std_slice_2.in, %std_slice_2.out = calyx.std_slice @std_slice_2 : i32, i2
    %std_slice_1.in, %std_slice_1.out = calyx.std_slice @std_slice_1 : i32, i2
    %std_slice_0.in, %std_slice_0.out = calyx.std_slice @std_slice_0 : i32, i2
    %std_add_0.left, %std_add_0.right, %std_add_0.out = calyx.std_add @std_add_0 : i32, i32, i32
    %addf_0_reg.in, %addf_0_reg.write_en, %addf_0_reg.clk, %addf_0_reg.reset, %addf_0_reg.out, %addf_0_reg.done = calyx.register @addf_0_reg : i64, i1, i1, i1, i64, i1
    %std_addFN_0.clk, %std_addFN_0.reset, %std_addFN_0.go, %std_addFN_0.control, %std_addFN_0.subOp, %std_addFN_0.left, %std_addFN_0.right, %std_addFN_0.roundingMode, %std_addFN_0.out, %std_addFN_0.exceptionalFlags, %std_addFN_0.done = calyx.ieee754.add @std_addFN_0 : i1, i1, i1, i1, i1, i64, i64, i3, i64, i5, i1
    %load_1_reg.in, %load_1_reg.write_en, %load_1_reg.clk, %load_1_reg.reset, %load_1_reg.out, %load_1_reg.done = calyx.register @load_1_reg : i64, i1, i1, i1, i64, i1
    %load_0_reg.in, %load_0_reg.write_en, %load_0_reg.clk, %load_0_reg.reset, %load_0_reg.out, %load_0_reg.done = calyx.register @load_0_reg : i64, i1, i1, i1, i64, i1
    %mem_2.addr0, %mem_2.clk, %mem_2.reset, %mem_2.content_en, %mem_2.write_en, %mem_2.write_data, %mem_2.read_data, %mem_2.done = calyx.seq_mem @mem_2 <[3] x 64> [2] {external = true} : i2, i1, i1, i1, i1, i64, i64, i1
    %mem_1.addr0, %mem_1.clk, %mem_1.reset, %mem_1.content_en, %mem_1.write_en, %mem_1.write_data, %mem_1.read_data, %mem_1.done = calyx.seq_mem @mem_1 <[3] x 64> [2] {external = true} : i2, i1, i1, i1, i1, i64, i64, i1
    %mem_0.addr0, %mem_0.clk, %mem_0.reset, %mem_0.content_en, %mem_0.write_en, %mem_0.write_data, %mem_0.read_data, %mem_0.done = calyx.seq_mem @mem_0 <[3] x 64> [2] {external = true} : i2, i1, i1, i1, i1, i64, i64, i1
    %for_0_induction_var_reg.in, %for_0_induction_var_reg.write_en, %for_0_induction_var_reg.clk, %for_0_induction_var_reg.reset, %for_0_induction_var_reg.out, %for_0_induction_var_reg.done = calyx.register @for_0_induction_var_reg : i32, i1, i1, i1, i32, i1
    calyx.wires {
      calyx.group @init_for_0_induction_var {
        calyx.assign %for_0_induction_var_reg.in = %c0_i32 : i32
        calyx.assign %for_0_induction_var_reg.write_en = %true : i1
        calyx.group_done %for_0_induction_var_reg.done : i1
      }
      calyx.group @bb0_0 {
        calyx.assign %std_slice_8.in = %c0_i32 : i32
        calyx.assign %mem_0.addr0 = %std_slice_8.out : i2
        calyx.assign %mem_0.write_data = %cst : i64
        calyx.assign %mem_0.write_en = %true : i1
        calyx.assign %mem_0.content_en = %true : i1
        calyx.group_done %mem_0.done : i1
      }
      calyx.group @bb0_1 {
        calyx.assign %std_slice_7.in = %c1_i32 : i32
        calyx.assign %mem_0.addr0 = %std_slice_7.out : i2
        calyx.assign %mem_0.write_data = %cst_0 : i64
        calyx.assign %mem_0.write_en = %true : i1
        calyx.assign %mem_0.content_en = %true : i1
        calyx.group_done %mem_0.done : i1
      }
      calyx.group @bb0_2 {
        calyx.assign %std_slice_6.in = %c2_i32 : i32
        calyx.assign %mem_0.addr0 = %std_slice_6.out : i2
        calyx.assign %mem_0.write_data = %cst_1 : i64
        calyx.assign %mem_0.write_en = %true : i1
        calyx.assign %mem_0.content_en = %true : i1
        calyx.group_done %mem_0.done : i1
      }
      calyx.group @bb0_3 {
        calyx.assign %std_slice_5.in = %c0_i32 : i32
        calyx.assign %mem_1.addr0 = %std_slice_5.out : i2
        calyx.assign %mem_1.write_data = %cst : i64
        calyx.assign %mem_1.write_en = %true : i1
        calyx.assign %mem_1.content_en = %true : i1
        calyx.group_done %mem_1.done : i1
      }
      calyx.group @bb0_4 {
        calyx.assign %std_slice_4.in = %c1_i32 : i32
        calyx.assign %mem_1.addr0 = %std_slice_4.out : i2
        calyx.assign %mem_1.write_data = %cst_0 : i64
        calyx.assign %mem_1.write_en = %true : i1
        calyx.assign %mem_1.content_en = %true : i1
        calyx.group_done %mem_1.done : i1
      }
      calyx.group @bb0_5 {
        calyx.assign %std_slice_3.in = %c2_i32 : i32
        calyx.assign %mem_1.addr0 = %std_slice_3.out : i2
        calyx.assign %mem_1.write_data = %cst_1 : i64
        calyx.assign %mem_1.write_en = %true : i1
        calyx.assign %mem_1.content_en = %true : i1
        calyx.group_done %mem_1.done : i1
      }
      calyx.group @bb0_6 {
        calyx.assign %std_slice_2.in = %for_0_induction_var_reg.out : i32
        calyx.assign %mem_0.addr0 = %std_slice_2.out : i2
        calyx.assign %mem_0.content_en = %true : i1
        calyx.assign %mem_0.write_en = %false : i1
        calyx.assign %load_0_reg.in = %mem_0.read_data : i64
        calyx.assign %load_0_reg.write_en = %mem_0.done : i1
        calyx.group_done %load_0_reg.done : i1
      }
      calyx.group @bb0_7 {
        calyx.assign %std_slice_1.in = %for_0_induction_var_reg.out : i32
        calyx.assign %mem_1.addr0 = %std_slice_1.out : i2
        calyx.assign %mem_1.content_en = %true : i1
        calyx.assign %mem_1.write_en = %false : i1
        calyx.assign %load_1_reg.in = %mem_1.read_data : i64
        calyx.assign %load_1_reg.write_en = %mem_1.done : i1
        calyx.group_done %load_1_reg.done : i1
      }
      calyx.group @bb0_8 {
        calyx.assign %std_addFN_0.left = %load_0_reg.out : i64
        calyx.assign %std_addFN_0.right = %load_1_reg.out : i64
        calyx.assign %addf_0_reg.in = %std_addFN_0.out : i64
        calyx.assign %addf_0_reg.write_en = %std_addFN_0.done : i1
        %0 = comb.xor %std_addFN_0.done, %true : i1
        calyx.assign %std_addFN_0.go = %0 ? %true : i1
        calyx.assign %std_addFN_0.subOp = %false : i1
        calyx.group_done %addf_0_reg.done : i1
      }
      calyx.group @bb0_9 {
        calyx.assign %std_slice_0.in = %for_0_induction_var_reg.out : i32
        calyx.assign %mem_2.addr0 = %std_slice_0.out : i2
        calyx.assign %mem_2.write_data = %addf_0_reg.out : i64
        calyx.assign %mem_2.write_en = %true : i1
        calyx.assign %mem_2.content_en = %true : i1
        calyx.group_done %mem_2.done : i1
      }
      calyx.group @incr_for_0_induction_var {
        calyx.assign %std_add_0.left = %for_0_induction_var_reg.out : i32
        calyx.assign %std_add_0.right = %c1_i32 : i32
        calyx.assign %for_0_induction_var_reg.in = %std_add_0.out : i32
        calyx.assign %for_0_induction_var_reg.write_en = %true : i1
        calyx.group_done %for_0_induction_var_reg.done : i1
      }
    }
    calyx.control {
      calyx.seq {
        calyx.seq {
          calyx.enable @bb0_0
          calyx.enable @bb0_1
          calyx.enable @bb0_2
          calyx.enable @bb0_3
          calyx.enable @bb0_4
          calyx.enable @bb0_5
          calyx.par {
            calyx.enable @init_for_0_induction_var
          }
          calyx.repeat 3 {
            calyx.seq {
              calyx.seq {
                calyx.enable @bb0_6
                calyx.enable @bb0_7
                calyx.enable @bb0_8
                calyx.enable @bb0_9
              }
              calyx.enable @incr_for_0_induction_var
            }
          }
        }
      }
    }
  } {toplevel}
}


