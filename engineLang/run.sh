#!/bin/bash

./build/bin/engine-opt ./test/Engine/print.mlir > out.mlir


lli -opaque-pointers out.mlir
