#!/bin/bash

out="../build/bin/engine-opt --mlir-print-ir-after-all input.mlir"

eval "$out" | circt-opt \
  --pass-pipeline="builtin.module(
    func.func(convert-affine-to-loopschedule),
    lower-scf-to-calyx)" > output.mlir
