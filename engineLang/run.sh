#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <input>"
    exit 1
fi

input="$1"
mlir_file="./test/Engine/${input}.mlir"
log_file="log.mlir"
output_file="outputs/${input}.ll"

# Check if the MLIR file exists
if [ ! -f "$mlir_file" ]; then
    echo "Error: ${mlir_file} does not exist."
    exit 1
fi

# Copy the MLIR file content to the log file
cat "$mlir_file" > "$log_file"

# Append the output of engine-opt to the log file
./build/bin/engine-opt --mlir-print-ir-after-all "$mlir_file" > "$output_file" 2>> "$log_file"

# Run lli and append its output to the log file
lli -opaque-pointers "$output_file" >> "$log_file" 2>&1
