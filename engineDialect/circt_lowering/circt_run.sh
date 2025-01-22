#!/bin/bash

# Clear the log file at the beginning

> log.mlir

out="../build/bin/engine-opt --mlir-print-ir-after-all input.mlir"

enginePass=$(eval "$out")

echo "$enginePass" >> log.mlir

echo "$enginePass" | circt-opt --mlir-print-ir-after-all \
 --pass-pipeline="builtin.module(
    func.func(convert-affine-to-loopschedule),
    lower-scf-to-calyx,
    calyx-native
  )" > output.mlir 2>> log.mlir



# affine to loopschedule
# sfm to calyx
# calyx to fsm
# fsm to sv
# export verilog
