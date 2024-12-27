./build/bin/engine-opt ./test/Engine/linalg2.mlir > linalg2.ll

lli -opaque-pointers linalg2.ll