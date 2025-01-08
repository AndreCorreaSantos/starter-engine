#!/bin/bash

mlir-opt input2.mlir --pass-pipeline="builtin.module(
    convert-linalg-to-loops,
    convert-scf-to-cf,
    convert-to-llvm{filter-dialects=arith,memref,cf,func}
  )" \
  | mlir-translate --mlir-to-llvmir -o output.ll


# | mlir-translate --mlir-to-llvmir -o output.ll

# affine to std - no pass for it

# scf to cf
# arithtollvm
# finalize memreftollvm
# cf to llvm
# func to llvm



#    convert-arith-to-llvm,
    # finalize-memref-to-llvm,
    # convert-cf-to-llvm,
    # convert-func-to-llvm