
> log.mlir

out="../../build/bin/engine-opt --mlir-print-ir-after-all input.mlir"

enginePass=$(eval "$out")

echo "$enginePass" >> log.mlir | hlstool --mlir-print-ir-after-all  --verilog hlsinput.mlir > output.mlir 2>> log.mlir