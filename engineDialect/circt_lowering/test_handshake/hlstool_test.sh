#!/bin/bash

out="../../build/bin/engine-opt stress.mlir"

$out &> log.mlir

$out | hlstool --verilog > output.mlir 2>&1 >> log.mlir