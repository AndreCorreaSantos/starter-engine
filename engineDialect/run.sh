#!/bin/bash

# Usage check
if [ -z "$1" ]; then
  echo "Usage: $0 <input> [optional_input_file_name_without_extension]"
  exit 1
fi

input="$1"
mlir_file="./test/Engine/${input}.mlir"
log_file="log.mlir"
output_file="outputs/${input}.ll"

# Capture second argument (if any)
second_arg="$2"

# If provided, define the input file path. (Adjust this path as needed.)
if [ -n "$second_arg" ]; then
  input_file="./test/inputs/${second_arg}.txt"
fi

# Check if the MLIR file exists
if [ ! -f "$mlir_file" ]; then
  echo "Error: ${mlir_file} does not exist."
  exit 1
fi

# Copy the MLIR file content to the log file
cat "$mlir_file" > "$log_file"

# Append the output of engine-opt to the log file
./build/bin/engine-opt --mlir-print-ir-after-all -debug-only=dialect-conversion "$mlir_file" > "$output_file" 2>> "$log_file"

# If a second argument (input file) is provided, pipe that into lli.
if [ -n "$second_arg" ]; then
  # Optional: check if the input file actually exists before piping it.
  if [ ! -f "$input_file" ]; then
    echo "Error: input file ${input_file} does not exist."
    exit 1
  fi
  cat "$input_file" | lli -opaque-pointers "$output_file" >> "$log_file" 2>&1
else
  lli -opaque-pointers "$output_file" >> "$log_file" 2>&1
fi
