./build/bin/engine-opt --mlir-print-ir-after-all ./test/Engine/linalg.mlir > linalg.ll

lli -opaque-pointers linalg.ll