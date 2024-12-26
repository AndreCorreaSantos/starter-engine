#!/bin/bash

./build/bin/engine-opt ./test/Engine/tensorLinalg.mlir > lowered_tensorLinalg.mlir


lli -opaque-pointers lowered_tensorLinalg.mlir
