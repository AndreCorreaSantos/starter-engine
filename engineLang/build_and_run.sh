mkdir build && cd build
cmake -G Ninja .. \
  -DLLVM_DIR=$LLVM_REPO/build/lib/cmake/llvm \
  -DMLIR_DIR=$LLVM_REPO/build/lib/cmake/mlir \

cmake --build . --target engine-opt

# # test run

# ./build/bin/engine-opt ./test/Engine/print.mlir > print.ll
# $BUILD_DIR/bin/lli print.ll
