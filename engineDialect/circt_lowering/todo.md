### TODO RIGHT NOW
 - [x] remove deallocs as they crash some circt passes. 
 - [x] implement dump IR so that engine-opt spits engine lowered code in MLIR upstream dialects
 - [x] add Engine dialect operation in the start of the code that specifies whether we're lowering to llvm IR or to Verilog.
 - [] pass lowerSettings into lowerToAffine patterns to decide whether to add memref.deallocs (memref alloc dealloc).
 - [] decide how to lower func and print ops into hardware (or just removing them).
 - [] read about Polygeist, calyx and hls tool.
 

### Notes:
 - calyx supports float, but I still cannot use it properly as it generates `hw.constant` instructions which further passes do not support.
 - handshake works but only supports integers.

 - Check proper way to use the calyx flow, if not possible --> use handshake and write pass to convert float to int by shifting. 
 - Calyx native pass seems the proper way, however it is also causing issues with floats --> might be the version.
 - PROBLEM WITH .CALYX FOLDER --> FLOAT PRIMITIVES ARE NOT THERE --> FLOAT PRIMITIVES ARE ALSO NOT IN THE CALYX GIT REPO.

 - Maybe lower calyx to scf -> circt-translate --export native --> use fud to export verilog?