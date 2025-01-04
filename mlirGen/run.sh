mlir-opt input.mlir \
--convert-linalg-to-loops \
--convert-scf-to-cf \
--convert-arith-to-llvm \
--convert-func-to-llvm \
--reconcile-unrealized-casts \
> output.mlir