
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
