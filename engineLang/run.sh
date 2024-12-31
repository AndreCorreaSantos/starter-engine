./build/bin/engine-opt --mlir-print-ir-after-all ./test/Engine/linalgdot.mlir > outputs/linalgdot.ll

lli -opaque-pointers outputs/linalgdot.ll