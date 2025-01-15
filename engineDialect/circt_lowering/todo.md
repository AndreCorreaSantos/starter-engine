### TODO RIGHT NOW
 - [x] remove deallocs as they crash some circt passes. 
 - [x] implement dump IR so that engine-opt spits engine lowered code in MLIR upstream dialects
 - [x] add Engine dialect operation in the start of the code that specifies whether we're lowering to llvm IR or to Verilog.
 - [] pass lowerSettings into lowerToAffine patterns to decide whether to add memref.deallocs (memref alloc dealloc).
 - [] decide how to lower func and print ops into hardware (or just removing them).
 