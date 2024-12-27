./build/bin/ input2.mlir --pass-pipeline="builtin.module(
    one-shot-bufferize,
    convert-linalg-to-loops,
    convert-scf-to-cf,
    convert-to-llvm
    )" | mlir-translate --mlir-to-llvmir -o output.ll
