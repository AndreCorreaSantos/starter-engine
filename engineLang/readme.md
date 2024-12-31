
## COMPILATION ORDER SUPPOSED:

### 1) First pass order hypothesized
- `mlir::Linalg` to loops  
- `engine::lower` to affine  
- `mlir::scf` to cf  
- `engine::to` llvm  

**Problem:**  
- `mlir::Linalg` to loops eliminates `engine::` operations, so they cannot run before `engine::lower` operations.

---

### 2) Solution: Try to run `engine::lower` to affine before `mlir::Linalg` to loops
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

### 3) Solution: Fix LLVM and affine pass wrappers  
- Refactor them to also convert Linalg operations to loops at some point, as they already include SCF to CF conversions (LLVM pass wrapper).
- maybe do mlir::lower to affine in the LLVM pass wrapper?
- what are illegal dialects and operations in the llvm pass wrapper?:
    - Legal operations are not converted in the pass for which they have been marked as legal. Only illegal operations are converted.

### Types of conversions:
 - Partial Conversions:
    - Convert only the operations that have been marked explicitly as illegal for the target dialect.
 - Full Conversions:
    - Convert all operations in the source to the target dialect. Insures no operations are unknown to the target dialect at this point.
 - Analysis Conversions:
    - Perform partial conversion and "writes down" the operations which cannot be converted to the target dialect. No rewrites or transformations  are applied to the source code, only analysis is performed.

### Hypothesized passes:

1. "LowerToAffine" - performs partial conversion, Making only the engine:: dialect (custom built dialect for the project) operations illegal and lowers it to affine dialect.
2. "LowerToLLVM" llvm - performs full conversion of all dialects directly to llvm. -> problem: there is only populateLinalgToSTDConversionPatterns, no populateLinalgToLoopsConversion patterns and apparently linalgtostd cannot run in JIT? (What is this jit compiler?)


#### Conversion target:  definition of what is considered to be legal during the conversion process.
 - Legal: will not be converted to the target, i.e. is already supported by it.
 - Illegal: must be converted to the target, rewritten or removed, as it is not supported by the target dialect.
 - Dynamic: This action signals that only some instances of a given operation are legal. e.g. saying that arith.addi is only legal when operating on 32-bit integers.


#### Logic seems correct but problems:
 - Linalg to std conversion patterns inside the lowerToLLVM works, does not erase "engine" operations but crashes jit compiler, cannot be run by lli.
 - Linalg to loops on the engine opt file erases all "engine" operations.

### Solution:
 - write a pass wrapper for linalg pass and legalize all the "engine" dialect so as to keep it safe? - try this first.
 - or maybe instead of using lli, lower it to object files and run it some other way? 



#### 4)
   Lower Linalg to loops is the only way to go, but it eliminates my non lowered dialect's operations. 
   ### Solution:
      - feels like a hack, but I might have to first lower my dialect's operations to llvm and then afterwards lower everything to llvm again.

      : MARK LINALG OPERATIONS AS LEGAL, LOWER MY DIALECT'S OPS TO LLVM, THEN LOWER LINALG TO LLVM AFTERWARDS.


      - lowering to linalg to loops and then using the patterns from lowerToLLVM causes it to not recognize some arith operations.
      - lowering linalg-to-loops, scf-to-cf, convert-to-llvm in the engine-opt causes it to generate unrealized-conversion casts which cannot be reconciled.


#### 5)
   !!!! MARKING MY ENGINE OPERATIONS AS HAVING SIDE EFFECTS SOLVED IT, LINALG CAN BE LOWERED !!!!
   next goal: MAKE tensors loaded via engine.constant able to be inserted into linalg.add and linalg.dot operations.

      