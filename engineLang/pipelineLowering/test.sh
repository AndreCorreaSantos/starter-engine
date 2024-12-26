#!/bin/bash
engine-opt input2.mlir --pass-pipeline="builtin.module(convert-linalg-to-loops,convert-to-llvm)" -o output.ll
# mlir-opt input2.mlir --pass-pipeline="builtin.module(one-shot-bufferize,linalg-to-loops,convert-scf-to-cf,convert-to-llvm)" -o output.ll
