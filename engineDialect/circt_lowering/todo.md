### TODO RIGHT NOW
 - [x] remove deallocs as they crash some circt passes. 
 - [x] implement dump IR so that engine-opt spits engine lowered code in MLIR upstream dialects
 - add Engine dialect operation in the start of the code that specifies whether we're lowering to llvm IR or to Verilog.
 