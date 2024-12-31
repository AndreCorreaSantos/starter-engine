./build/bin/engine-opt --mlir-print-ir-after-all ./test/Engine/linalg.mlir > outputs/linalg.ll

lli -opaque-pointers outputs/linalg.ll