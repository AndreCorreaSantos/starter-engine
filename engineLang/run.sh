./build/bin/engine-opt ./test/Engine/linalg.mlir > linalg.ll

lli -opaque-pointers linalg.ll