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