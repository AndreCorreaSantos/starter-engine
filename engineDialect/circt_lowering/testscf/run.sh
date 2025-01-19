>log.mlir

circt-opt --mlir-print-ir-after-all  input.mlir \
  --pass-pipeline="builtin.module(
  func.func(convert-affine-to-loopschedule),
  lower-cf-to-handshake,
  lower-handshake-to-
  )" > output.mlir 2>> log.mlir



