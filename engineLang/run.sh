#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <input>"
    exit 1
fi

input="$1"

./build/bin/engine-opt --mlir-print-ir-after-all ./test/Engine/${input}.mlir > outputs/${input}.ll 2> log.mlir
lli -opaque-pointers outputs/${input}.ll >> log.mlir 2>&1
