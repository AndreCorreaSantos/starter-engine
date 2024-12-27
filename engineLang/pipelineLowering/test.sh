#!/bin/bash

mlir-opt input2.mlir --pass-pipeline="builtin.module(
    convert-linalg-to-loops,
    convert-scf-to-cf,
    convert-to-llvm
    )" | mlir-translate --mlir-to-llvmir -o output.ll



# needs to replace 
# attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
# with
# attributes #0 = { nounwind readonly }
# Dont know why
