## COMPILATION ORDER SUPPOSED:

### 1) First pass order hypothesized:
- `mlir::Linalg` to loops  
- `engine::lower` to affine  
- `mlir::scf` to cf  
- `engine::to` llvm  

**Problem:**  
- `mlir::Linalg` to loops eliminates `engine::` operations, so they cannot run before `engine::lower` operations.

---

### 2) Solution: Try to run `engine::lower` to affine before `mlir::Linalg` to loops:
- Legalize Linalg operations so this pass does not interfere with them, and they can all be lowered to loops later.

**Proposed order:**  
1. `engine::lower` to affine  
2. `mlir::Linalg` to loops  
3. `mlir::scf` to cf  
4. `engine::to` llvm  

**Issue:**  
For some reason, the print calls are not even generated after the `lower` to affine pass. There is no reason why they should not be, as the `mlir::` pass happens after the `lower` to affine.  

**Note:**  
Lowering Linalg to loops must be run **before** `engine::lower` to affine.  
How do I ensure that `mlir::Linalg` to loops ignores `engine::` operations?

---

### 3) Solution: Fix LLVM and affine pass wrappers:
- Refactor them to also convert Linalg operations to loops at some point, as they already include SCF to CF conversions (LLVM pass wrapper).
- Maybe do `mlir::lower` to affine in the LLVM pass wrapper?
- What are illegal dialects and operations in the LLVM pass wrapper?  
    - Legal operations are not converted in the pass for which they have been marked as legal. Only illegal operations are converted.

---

### Types of conversions:
- **Partial Conversions:**  
  Convert only the operations that have been marked explicitly as illegal for the target dialect.  

- **Full Conversions:**  
  Convert all operations in the source to the target dialect. Ensures no operations are unknown to the target dialect at this point.  

- **Analysis Conversions:**  
  Perform partial conversion and "write down" the operations which cannot be converted to the target dialect. No rewrites or transformations are applied to the source code, only analysis is performed.

---

### Hypothesized passes:

1. **"LowerToAffine":**  
   Performs partial conversion, making only the `engine::` dialect (custom-built dialect for the project) operations illegal and lowers it to affine dialect.

2. **"LowerToLLVM":**  
   Performs full conversion of all dialects directly to LLVM.  

   **Problem:**  
   There is only `populateLinalgToSTDConversionPatterns`, no `populateLinalgToLoopsConversion` patterns, and apparently `linalg-to-std` cannot run in JIT? (What is this JIT compiler?)

---

#### Conversion target:
Definition of what is considered to be legal during the conversion process:
- **Legal:** Will not be converted to the target, i.e., is already supported by it.  
- **Illegal:** Must be converted to the target, rewritten, or removed, as it is not supported by the target dialect.  
- **Dynamic:** This action signals that only some instances of a given operation are legal, e.g., saying that `arith.addi` is only legal when operating on 32-bit integers.

---

### Logic seems correct, but problems:
- `Linalg-to-std` conversion patterns inside the `lowerToLLVM` work, do not erase `engine` operations but crash the JIT compiler. It cannot be run by `lli`.  
- `Linalg-to-loops` on the engine-opt file erases all `engine` operations.

---

### Solution:
- Write a pass wrapper for the Linalg pass and legalize all the `engine` dialect to keep it safe—try this first.  
- Or maybe instead of using `lli`, lower it to object files and run it some other way?

---

### 4) Lowering Linalg to loops:
This is the only way to go, but it eliminates my non-lowered dialect's operations.

**Solution:**  
- Feels like a hack, but I might have to first lower my dialect's operations to LLVM and then afterwards lower everything to LLVM again.  

  **MARK LINALG OPERATIONS AS LEGAL, LOWER MY DIALECT'S OPS TO LLVM, THEN LOWER LINALG TO LLVM AFTERWARDS.**

- Lowering `linalg-to-loops` and then using the patterns from `lowerToLLVM` causes it to not recognize some `arith` operations.  
- Lowering `linalg-to-loops`, `scf-to-cf`, and `convert-to-llvm` in the engine-opt causes it to generate unrealized-conversion casts which cannot be reconciled.

---

### 5) Solution:
**Marking my `engine` operations as having side effects solved it—Linalg can be lowered!**  

**Next goal:**  
Make tensors loaded via `engine.constant` able to be inserted into `linalg.add` and `linalg.dot` operations.  

**Problems:**  
- Tensors loaded via `engine.constant` get converted to `memref` on lower to affine.  

**Solution:**  
- Make an operation wrapper for Linalg to fix the operand types.  

## Goals for now:
   Understand Affine Lowerings:
   - understand PrintOp Lowering - operand rewrite will be similar. 
   - understand binOp Lowering - as that will be very similar to the linalg ops lowerings.


  

this:
``` mlir
%output = "engine.dot"(%t1, %t2) : (tensor<2x3xf64>, tensor<2x3xf64>) -> tensor<2x3xf64>
```
must produce this after lowering to affine:
```mlir
  %output = memref.alloc() : memref<2x3xf64>
  linalg.add ins(%t1,%t2 : memref<2x3xf64>, memref<2x3xf64>) outs(%output : memref<2x3xf64>)
```

tasks:
 - generate output memref allocation
 - generate linalg call with operands
 - change declared operand types into memrefs instead of tensor
