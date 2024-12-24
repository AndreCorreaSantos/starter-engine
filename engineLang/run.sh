#!/bin/bash

# Run engine-opt and redirect output to test.mlir
./build/bin/engine-opt ./test/Engine/storeLoad.mlir > test.mlir

# Replace the attributes line in test.mlir
sed -i 's/attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }/attributes #0 = { nocallback nofree nounwind willreturn }/' test.mlir

# Run lli on the modified file
lli -opaque-pointers test.mlir
