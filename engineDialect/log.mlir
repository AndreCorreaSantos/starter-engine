module {
  func.func @main() {

  "engine.settings"() { value = 0 : i32 } : () -> ()
  %0 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%0) : (memref<3xf64>) -> ()
  
  func.return
  }
}// -----// IR Dump After {anonymous}::LowerSettingsPass () //----- //
module {
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


lowerSettings: 0
// -----// IR Dump After {anonymous}::EngineToAffineLowerPass () //----- //
module {
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


// -----// IR Dump After ConvertLinalgToLoopsPass (convert-linalg-to-loops) //----- //
module {
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}



//===-------------------------------------------===//
Legalizing operation : 'builtin.module'(0x5b5573efe520) {
} -> SUCCESS : operation marked legal by the target
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'func.func'(0x5b5573efe490) {
  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'func.func -> ()' {
Trying to match "{anonymous}::FuncOpConversion"
    ** Insert  : 'llvm.func'(0x5b5573fab7e0)
    ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
    ** Erase   : 'func.func'(0x5b5573efe490)
"{anonymous}::FuncOpConversion" result 1

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.func'(0x5b5573fab7e0) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'func.return' op expects parent op 'func.func'
'func.func' op symbol declaration cannot have public visibility
mlir-asm-printer: 'builtin.module' failed to verify and will be printed in generic form
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "engine.read"() : () -> memref<3xf64>
    "engine.print"(%0) : (memref<3xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
  }) : () -> ()
}) : () -> ()


} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.read'(0x5b5573f15e80) {
  %0 = "engine.read"() : () -> memref<3xf64>

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.read -> ()' {
Trying to match "engine::ReadOpLowering"
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::AttrSizedOperandSegments<mlir::TypeID::get<mlir::OpTrait::AttrSizedOperandSegments>::Empty>)
    ** Insert  : 'memref.alloc'(0x5b5573faf980)
    ** Insert  : 'llvm.func'(0x5b5573fb5420)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::SingleBlockImplicitTerminator<mlir::LLVM::ReturnOp>::Impl<mlir::TypeID::get<mlir::OpTrait::SingleBlockImplicitTerminator<mlir::LLVM::ReturnOp>::Impl>::Empty>)
    ** Insert  : 'llvm.mlir.global'(0x5b5573f4b830)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::AddressOfOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::OneTypedResult<mlir::LLVM::LLVMPointerType>::Impl<mlir::TypeID::get<mlir::OpTrait::OneTypedResult<mlir::LLVM::LLVMPointerType>::Impl>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::SymbolUserOpInterface::Trait<mlir::TypeID::get<mlir::SymbolUserOpInterface::Trait>::Empty>)
    ** Insert  : 'llvm.mlir.addressof'(0x7123e8001d70)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::ConstantOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::OneTypedResult<mlir::Type>::Impl<mlir::TypeID::get<mlir::OpTrait::OneTypedResult<mlir::Type>::Impl>::Empty>)
    ** Insert  : 'llvm.mlir.constant'(0x5b5573f2cfc0)
    ** Insert  : 'llvm.getelementptr'(0x5b5573f415c0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::arith::detail::ConstantOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::InferIntRangeInterface::Trait<mlir::TypeID::get<mlir::InferIntRangeInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::InferTypeOpInterface::Trait<mlir::TypeID::get<mlir::InferTypeOpInterface::Trait>::Empty>)
    ** Insert  : 'arith.constant'(0x5b5573fb7bd0)
    ** Insert  : 'arith.constant'(0x5b5573fb7c70)
    ** Insert  : 'arith.constant'(0x5b5573fb8190)
    ** Insert Block into detached Region (nullptr parent op)'ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::HasParent<mlir::scf::ExecuteRegionOp, mlir::scf::ForOp, mlir::scf::IfOp, mlir::scf::IndexSwitchOp, mlir::scf::WhileOp>::Impl<mlir::TypeID::get<mlir::OpTrait::HasParent<mlir::scf::ExecuteRegionOp, mlir::scf::ForOp, mlir::scf::IfOp, mlir::scf::IndexSwitchOp, mlir::scf::WhileOp>::Impl>::Empty>)
    ** Insert  : 'scf.yield'(0x5b5573f2cde0)
    ** Insert  : 'scf.for'(0x7123e8000bb0)
    ** Erase   : 'scf.yield'(0x5b5573f2cde0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::PromotableAllocationOpInterface::Trait<mlir::TypeID::get<mlir::PromotableAllocationOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::DestructurableAllocationOpInterface::Trait<mlir::TypeID::get<mlir::DestructurableAllocationOpInterface::Trait>::Empty>)
    ** Insert  : 'memref.alloca'(0x5b5573faba00)
    ** Insert  : 'memref.extract_aligned_pointer_as_index'(0x5b5573faf840)
    ** Insert  : 'arith.index_cast'(0x5b5573fb9090)
    ** Insert  : 'llvm.inttoptr'(0x5b5573fb9150)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::CallOpGenericAdaptorBase::Properties)
    ** Insert  : 'llvm.call'(0x5b5573f73b80)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::memref::detail::LoadOpGenericAdaptorBase::Properties)
    ** Insert  : 'memref.load'(0x5b5573fb9210)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::memref::detail::StoreOpGenericAdaptorBase::Properties)
    ** Insert  : 'memref.store'(0x5b5573fab3f0)
    ** Insert  : 'scf.yield'(0x5b5573f29fe0)
    ** Replace : 'engine.read'(0x5b5573f15e80)
"engine::ReadOpLowering" result 1

    //===-------------------------------------------===//
    Legalizing operation : 'memref.alloc'(0x5b5573faf980) {
      %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'memref.alloc -> ()' {
Trying to match "{anonymous}::AllocOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573f1f910)
        ** Insert  : 'llvm.mlir.constant'(0x5b5573f1f7c0)
        ** Insert  : 'llvm.mlir.zero'(0x5b5573fbb050)
        ** Insert  : 'llvm.getelementptr'(0x5b5573fab4c0)
        ** Insert  : 'llvm.ptrtoint'(0x5b5573fbba10)
        ** Insert  : 'llvm.call'(0x5b5573edc8d0)
        ** Insert  : 'llvm.mlir.undef'(0x5b5573fbfd60)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::InsertValueOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.insertvalue'(0x5b5573f15670)
        ** Insert  : 'llvm.insertvalue'(0x5b5573f15720)
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc0720)
        ** Insert  : 'llvm.insertvalue'(0x5b5573fc0c30)
        ** Insert  : 'llvm.insertvalue'(0x5b5573fc0d10)
        ** Insert  : 'llvm.insertvalue'(0x5b5573fc0df0)
        ** Replace : 'memref.alloc'(0x5b5573faf980)
"{anonymous}::AllocOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573f1f910) {
          %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573f1f7c0) {
          %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.zero'(0x5b5573fbb050) {
          %2 = "llvm.mlir.zero"() : () -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.getelementptr'(0x5b5573fab4c0) {
          %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.ptrtoint'(0x5b5573fbba10) {
          %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.call'(0x5b5573edc8d0) {
          %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.undef'(0x5b5573fbfd60) {
          %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573f15670) {
          %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573f15720) {
          %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc0720) {
          %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573fc0c30) {
          %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573fc0d10) {
          %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573fc0df0) {
          %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::VariadicResults<mlir::TypeID::get<mlir::OpTrait::VariadicResults>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::AtLeastNOperands<3>::Impl<mlir::TypeID::get<mlir::OpTrait::AtLeastNOperands<3>::Impl>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::SingleBlockImplicitTerminator<mlir::scf::YieldOp>::Impl<mlir::TypeID::get<mlir::OpTrait::SingleBlockImplicitTerminator<mlir::scf::YieldOp>::Impl>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LoopLikeOpInterface::Trait<mlir::TypeID::get<mlir::LoopLikeOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::RegionBranchOpInterface::Trait<mlir::TypeID::get<mlir::RegionBranchOpInterface::Trait>::Empty>)
'scf.yield' op must be the last operation in the parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "arith.constant"() <{value = 0 : index}> : () -> index
  %18 = "arith.constant"() <{value = 3 : index}> : () -> index
  %19 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%17, %18, %19) ({
  ^bb0(%arg0: index):
    %21 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    %22 = "memref.extract_aligned_pointer_as_index"(%21) : (memref<f64>) -> index
    %23 = "arith.index_cast"(%22) : (index) -> i64
    %24 = "llvm.inttoptr"(%23) : (i64) -> !llvm.ptr
    %25 = "llvm.call"(%16, %24) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
    %26 = "memref.load"(%21) <{nontemporal = false}> : (memref<f64>) -> f64
    "memref.store"(%26, %13, %arg0) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %20 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%20) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.func'(0x5b5573fb5420) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.global'(0x5b5573f4b830) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.addressof'(0x7123e8001d70) {
      %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.constant'(0x5b5573f2cfc0) {
      %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.getelementptr'(0x5b5573f415c0) {
      %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5b5573fb7bd0) {
      %17 = "arith.constant"() <{value = 0 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc3c60)
        ** Replace : 'arith.constant'(0x5b5573fb7bd0)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc3c60) {
          %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'scf.yield' op must be the last operation in the parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "arith.constant"() <{value = 3 : index}> : () -> index
  %20 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%18, %19, %20) ({
  ^bb0(%arg0: index):
    %22 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    %23 = "memref.extract_aligned_pointer_as_index"(%22) : (memref<f64>) -> index
    %24 = "arith.index_cast"(%23) : (index) -> i64
    %25 = "llvm.inttoptr"(%24) : (i64) -> !llvm.ptr
    %26 = "llvm.call"(%16, %25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
    %27 = "memref.load"(%22) <{nontemporal = false}> : (memref<f64>) -> f64
    "memref.store"(%27, %13, %arg0) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %21 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%21) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5b5573fb7c70) {
      %19 = "arith.constant"() <{value = 3 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc0f40)
        ** Replace : 'arith.constant'(0x5b5573fb7c70)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc0f40) {
          %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'scf.yield' op must be the last operation in the parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%18, %20, %21) ({
  ^bb0(%arg0: index):
    %23 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    %24 = "memref.extract_aligned_pointer_as_index"(%23) : (memref<f64>) -> index
    %25 = "arith.index_cast"(%24) : (index) -> i64
    %26 = "llvm.inttoptr"(%25) : (i64) -> !llvm.ptr
    %27 = "llvm.call"(%16, %26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
    %28 = "memref.load"(%23) <{nontemporal = false}> : (memref<f64>) -> f64
    "memref.store"(%28, %13, %arg0) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %22 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%22) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5b5573fb8190) {
      %21 = "arith.constant"() <{value = 1 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc2ff0)
        ** Replace : 'arith.constant'(0x5b5573fb8190)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc2ff0) {
          %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'scf.yield' op must be the last operation in the parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%18, %20, %22) ({
  ^bb0(%arg0: index):
    %24 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    %25 = "memref.extract_aligned_pointer_as_index"(%24) : (memref<f64>) -> index
    %26 = "arith.index_cast"(%25) : (index) -> i64
    %27 = "llvm.inttoptr"(%26) : (i64) -> !llvm.ptr
    %28 = "llvm.call"(%16, %27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
    %29 = "memref.load"(%24) <{nontemporal = false}> : (memref<f64>) -> f64
    "memref.store"(%29, %13, %arg0) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %23 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%23) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.yield'(0x5b5573f2cde0) {
      "scf.yield"() : () -> ()

    } -> SUCCESS : operation marked 'ignored' during conversion
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.for'(0x7123e8000bb0) {
      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'scf.for -> ()' {
Trying to match "{anonymous}::ForLowering"
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
        ** Insert  : 'func.return'(0x5b5573f12ec0)
        ** Insert  : 'engine.print'(0x5b5573efe260)
        ** Insert  : 'engine.read'(0x5b5573f15e80)
        ** Insert  : 'scf.for'(0x7123e8000bb0)
        ** Insert Block into : 'scf.for'(0x7123e8000bb0)
        ** Insert  : 'scf.yield'(0x5b5573f29fe0)
        ** Insert  : 'scf.yield'(0x5b5573f2cde0)
        ** Insert  : 'memref.store'(0x5b5573fab3f0)
        ** Insert  : 'memref.load'(0x5b5573fb9210)
        ** Insert  : 'llvm.call'(0x5b5573f73b80)
        ** Insert  : 'llvm.inttoptr'(0x5b5573fb9150)
        ** Insert  : 'arith.index_cast'(0x5b5573fb9090)
        ** Insert  : 'memref.extract_aligned_pointer_as_index'(0x5b5573faf840)
        ** Insert  : 'memref.alloca'(0x5b5573faba00)
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::arith::detail::AddIOpGenericAdaptorBase::Properties)
        ** Insert  : 'arith.addi'(0x5b5573fc35c0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::OneSuccessor<mlir::TypeID::get<mlir::OpTrait::OneSuccessor>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::BranchOpInterface::Trait<mlir::TypeID::get<mlir::BranchOpInterface::Trait>::Empty>)
        ** Insert  : 'cf.br'(0x5b5573faba70)
        ** Erase   : 'scf.yield'(0x5b5573f29fe0)
        ** Insert  : 'cf.br'(0x5b5573fb70f0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::arith::detail::CmpIOpGenericAdaptorBase::Properties)
        ** Insert  : 'arith.cmpi'(0x5b5573fc1490)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::cf::detail::CondBranchOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::NSuccessors<2>::Impl<mlir::TypeID::get<mlir::OpTrait::NSuccessors<2>::Impl>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::AtLeastNOperands<1>::Impl<mlir::TypeID::get<mlir::OpTrait::AtLeastNOperands<1>::Impl>::Empty>)
        ** Insert  : 'cf.cond_br'(0x7123f00013d0)
        ** Replace : 'scf.for'(0x7123e8000bb0)
"{anonymous}::ForLowering" result 1
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)

        //===-------------------------------------------===//
        Legalizing operation : 'arith.addi'(0x5b5573fc35c0) {
          %33 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index

          * Fold {
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::NOperands<2>::Impl<mlir::TypeID::get<mlir::OpTrait::NOperands<2>::Impl>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::IsCommutative<mlir::TypeID::get<mlir::OpTrait::IsCommutative>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::arith::ArithIntegerOverflowFlagsInterface::Trait<mlir::TypeID::get<mlir::arith::ArithIntegerOverflowFlagsInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::SameOperandsAndResultType<mlir::TypeID::get<mlir::OpTrait::SameOperandsAndResultType>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::VectorUnrollOpInterface::Trait<mlir::TypeID::get<mlir::VectorUnrollOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::Elementwise<mlir::TypeID::get<mlir::OpTrait::Elementwise>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::Scalarizable<mlir::TypeID::get<mlir::OpTrait::Scalarizable>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::Vectorizable<mlir::TypeID::get<mlir::OpTrait::Vectorizable>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::Tensorizable<mlir::TypeID::get<mlir::OpTrait::Tensorizable>::Empty>)
          } -> FAILURE : unable to fold

          * Pattern : 'arith.addi -> ()' {
Trying to match "mlir::VectorConvertToLLVMPattern<mlir::arith::AddIOp, mlir::LLVM::AddOp, mlir::arith::AttrConvertOverflowToLLVM>"
            ** Insert  : 'llvm.add'(0x5b5573fc1f20)
            ** Replace : 'arith.addi'(0x5b5573fc35c0)
"mlir::VectorConvertToLLVMPattern<mlir::arith::AddIOp, mlir::LLVM::AddOp, mlir::arith::AttrConvertOverflowToLLVM>" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.add'(0x5b5573fc1f20) {
              %33 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
type mismatch for bb argument #0 of successor #0
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 2 preds: ^bb0, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // pred: ^bb1
  %27 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %28 = "memref.extract_aligned_pointer_as_index"(%27) : (memref<f64>) -> index
  %29 = "arith.index_cast"(%28) : (index) -> i64
  %30 = "llvm.inttoptr"(%29) : (i64) -> !llvm.ptr
  %31 = "llvm.call"(%16, %30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %32 = "memref.load"(%27) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%32, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %33 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %34 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "cf.br"(%34)[^bb1] : (index) -> ()
^bb3:  // pred: ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %35 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%35) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'cf.br'(0x5b5573faba70) {
          "cf.br"(%34)[^bb1] : (index) -> ()

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'cf.br -> ()' {
Trying to match "{anonymous}::BranchOpLowering"
            ** Insert  : 'llvm.br'(0x5b5573fc2a90)
            ** Replace : 'cf.br'(0x5b5573faba70)
"{anonymous}::BranchOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.br'(0x5b5573fc2a90) {
              "llvm.br"(%33)[^bb1] : (i64) -> ()

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
type mismatch for bb argument #0 of successor #0
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 3 preds: ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // pred: ^bb1
  %27 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %28 = "memref.extract_aligned_pointer_as_index"(%27) : (memref<f64>) -> index
  %29 = "arith.index_cast"(%28) : (index) -> i64
  %30 = "llvm.inttoptr"(%29) : (i64) -> !llvm.ptr
  %31 = "llvm.call"(%16, %30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %32 = "memref.load"(%27) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%32, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %33 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %34 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%33)[^bb1] : (i64) -> ()
  "cf.br"(%34)[^bb1] : (index) -> ()
^bb3:  // pred: ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %35 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%35) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'cf.br'(0x5b5573fb70f0) {
          "cf.br"(%18)[^bb1] : (index) -> ()

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'cf.br -> ()' {
Trying to match "{anonymous}::BranchOpLowering"
            ** Insert  : 'llvm.br'(0x5b5573fc2b60)
            ** Replace : 'cf.br'(0x5b5573fb70f0)
"{anonymous}::BranchOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.br'(0x5b5573fc2b60) {
              "llvm.br"(%17)[^bb1] : (i64) -> ()

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // pred: ^bb1
  %27 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %28 = "memref.extract_aligned_pointer_as_index"(%27) : (memref<f64>) -> index
  %29 = "arith.index_cast"(%28) : (index) -> i64
  %30 = "llvm.inttoptr"(%29) : (i64) -> !llvm.ptr
  %31 = "llvm.call"(%16, %30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %32 = "memref.load"(%27) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%32, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %33 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %34 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%33)[^bb1] : (i64) -> ()
  "cf.br"(%34)[^bb1] : (index) -> ()
^bb3:  // pred: ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %35 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%35) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'arith.cmpi'(0x5b5573fc1490) {
          %26 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1

          * Fold {
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::SameTypeOperands<mlir::TypeID::get<mlir::OpTrait::SameTypeOperands>::Empty>)
          } -> FAILURE : unable to fold

          * Pattern : 'arith.cmpi -> ()' {
Trying to match "{anonymous}::CmpIOpLowering"
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::ICmpOpGenericAdaptorBase::Properties)
            ** Insert  : 'llvm.icmp'(0x5b5573fc4650)
            ** Replace : 'arith.cmpi'(0x5b5573fc1490)
"{anonymous}::CmpIOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.icmp'(0x5b5573fc4650) {
              %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // pred: ^bb1
  %28 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %29 = "memref.extract_aligned_pointer_as_index"(%28) : (memref<f64>) -> index
  %30 = "arith.index_cast"(%29) : (index) -> i64
  %31 = "llvm.inttoptr"(%30) : (i64) -> !llvm.ptr
  %32 = "llvm.call"(%16, %31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %33 = "memref.load"(%28) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%33, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %34 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %35 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%34)[^bb1] : (i64) -> ()
  "cf.br"(%35)[^bb1] : (index) -> ()
^bb3:  // pred: ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %36 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%36) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'cf.cond_br'(0x7123f00013d0) {
          "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'cf.cond_br -> ()' {
Trying to match "{anonymous}::CondBranchOpLowering"
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::BranchWeightOpInterface::Trait<mlir::TypeID::get<mlir::LLVM::BranchWeightOpInterface::Trait>::Empty>)
            ** Insert  : 'llvm.cond_br'(0x5b5573fc3d10)
            ** Replace : 'cf.cond_br'(0x7123f00013d0)
"{anonymous}::CondBranchOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.cond_br'(0x5b5573fc3d10) {
              "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %29 = "memref.extract_aligned_pointer_as_index"(%28) : (memref<f64>) -> index
  %30 = "arith.index_cast"(%29) : (index) -> i64
  %31 = "llvm.inttoptr"(%30) : (i64) -> !llvm.ptr
  %32 = "llvm.call"(%16, %31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %33 = "memref.load"(%28) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%33, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %34 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %35 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%34)[^bb1] : (i64) -> ()
  "cf.br"(%35)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %36 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%36) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %29 = "memref.extract_aligned_pointer_as_index"(%28) : (memref<f64>) -> index
  %30 = "arith.index_cast"(%29) : (index) -> i64
  %31 = "llvm.inttoptr"(%30) : (i64) -> !llvm.ptr
  %32 = "llvm.call"(%16, %31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %33 = "memref.load"(%28) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%33, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %34 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %35 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%34)[^bb1] : (i64) -> ()
  "cf.br"(%35)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %36 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%36) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'memref.alloca'(0x5b5573faba00) {
      %28 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'memref.alloca -> ()' {
Trying to match "{anonymous}::AllocaOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc4830)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::AllocaOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.alloca'(0x5b5573fc4890)
        ** Insert  : 'llvm.mlir.undef'(0x5b5573fc49d0)
        ** Insert  : 'llvm.insertvalue'(0x5b5573fc4a60)
        ** Insert  : 'llvm.insertvalue'(0x5b5573fc4b40)
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc4c20)
        ** Insert  : 'llvm.insertvalue'(0x5b5573fc4cb0)
        ** Replace : 'memref.alloca'(0x5b5573faba00)
"{anonymous}::AllocaOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc4830) {
          %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.alloca'(0x5b5573fc4890) {
          %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.undef'(0x5b5573fc49d0) {
          %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573fc4a60) {
          %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573fc4b40) {
          %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc4c20) {
          %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5b5573fc4cb0) {
          %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %37 = "arith.index_cast"(%36) : (index) -> i64
  %38 = "llvm.inttoptr"(%37) : (i64) -> !llvm.ptr
  %39 = "llvm.call"(%16, %38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %40 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%40, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %41 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %42 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%41)[^bb1] : (i64) -> ()
  "cf.br"(%42)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %43 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%43) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'memref.extract_aligned_pointer_as_index'(0x5b5573faf840) {
      %36 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index

      * Fold {
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::OneTypedResult<mlir::IndexType>::Impl<mlir::TypeID::get<mlir::OpTrait::OneTypedResult<mlir::IndexType>::Impl>::Empty>)
      } -> FAILURE : unable to fold

      * Pattern : 'memref.extract_aligned_pointer_as_index -> ()' {
Trying to match "{anonymous}::ConvertExtractAlignedPointerAsIndex"
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::ExtractValueOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.extractvalue'(0x5b5573fc4df0)
        ** Insert  : 'llvm.ptrtoint'(0x5b5573fc4e80)
        ** Replace : 'memref.extract_aligned_pointer_as_index'(0x5b5573faf840)
"{anonymous}::ConvertExtractAlignedPointerAsIndex" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.extractvalue'(0x5b5573fc4df0) {
          %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.ptrtoint'(0x5b5573fc4e80) {
          %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%42, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %43 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %44 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%43)[^bb1] : (i64) -> ()
  "cf.br"(%44)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %45 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%45) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.index_cast'(0x5b5573fb9090) {
      %39 = "arith.index_cast"(%38) : (index) -> i64

      * Fold {
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::SameOperandsAndResultShape<mlir::TypeID::get<mlir::OpTrait::SameOperandsAndResultShape>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::CastOpInterface::Trait<mlir::TypeID::get<mlir::CastOpInterface::Trait>::Empty>)
      } -> FAILURE : unable to fold

      * Pattern : 'arith.index_cast -> ()' {
Trying to match "{anonymous}::IndexCastOpLowering<mlir::arith::IndexCastOp, mlir::LLVM::SExtOp>"
        ** Replace : 'arith.index_cast'(0x5b5573fb9090)
"{anonymous}::IndexCastOpLowering<mlir::arith::IndexCastOp, mlir::LLVM::SExtOp>" result 1
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%42, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %43 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %44 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%43)[^bb1] : (i64) -> ()
  "cf.br"(%44)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %45 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%45) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.inttoptr'(0x5b5573fb9150) {
      %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.call'(0x5b5573f73b80) {
      %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'memref.load'(0x5b5573fb9210) {
      %42 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64

      * Fold {
ImplicitTypeIDRegistry::lookupOrInsert(mlir::PromotableMemOpInterface::Trait<mlir::TypeID::get<mlir::PromotableMemOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::DestructurableAccessorOpInterface::Trait<mlir::TypeID::get<mlir::DestructurableAccessorOpInterface::Trait>::Empty>)
      } -> FAILURE : unable to fold

      * Pattern : 'memref.load -> ()' {
Trying to match "{anonymous}::LoadOpLowering"
        ** Insert  : 'llvm.extractvalue'(0x5b5573fc50d0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::LoadOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.load'(0x5b5573fc3b80)
        ** Replace : 'memref.load'(0x5b5573fb9210)
"{anonymous}::LoadOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.extractvalue'(0x5b5573fc50d0) {
          %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.load'(0x5b5573fc3b80) {
          %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %45 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %46 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%45)[^bb1] : (i64) -> ()
  "cf.br"(%46)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %47 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%47) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'memref.store'(0x5b5573fab3f0) {
      "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()

      * Fold {
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::AtLeastNOperands<2>::Impl<mlir::TypeID::get<mlir::OpTrait::AtLeastNOperands<2>::Impl>::Empty>)
      } -> FAILURE : unable to fold

      * Pattern : 'memref.store -> ()' {
Trying to match "{anonymous}::StoreOpLowering"
        ** Insert  : 'llvm.extractvalue'(0x5b5573fc5250)
        ** Insert  : 'llvm.getelementptr'(0x5b5573fc52e0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::StoreOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.store'(0x5b5573f2d010)
        ** Replace : 'memref.store'(0x5b5573fab3f0)
"{anonymous}::StoreOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.extractvalue'(0x5b5573fc5250) {
          %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.getelementptr'(0x5b5573fc52e0) {
          %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.store'(0x5b5573f2d010) {
          "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.yield'(0x5b5573f29fe0) {
      "scf.yield"() : () -> ()

    } -> SUCCESS : operation marked 'ignored' during conversion
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'engine.print'(0x5b5573efe260) {
  "engine.print"(%49) : (memref<3xf64>) -> ()

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.print -> ()' {
Trying to match "engine::PrintOpLowering"
    ** Insert  : 'llvm.func'(0x5b5573fc5450)
    ** Insert  : 'llvm.mlir.global'(0x5b5573f3be20)
    ** Insert  : 'llvm.mlir.addressof'(0x5b5573fc5160)
    ** Insert  : 'llvm.mlir.constant'(0x5b5573fc6e30)
    ** Insert  : 'llvm.getelementptr'(0x5b5573f17040)
    ** Insert  : 'llvm.mlir.global'(0x5b5573f09590)
    ** Insert  : 'llvm.mlir.addressof'(0x5b5573fc6f20)
    ** Insert  : 'llvm.mlir.constant'(0x5b5573fc6fb0)
    ** Insert  : 'llvm.getelementptr'(0x5b5573f09080)
    ** Insert  : 'arith.constant'(0x5b5573fc6000)
    ** Insert  : 'arith.constant'(0x5b5573fc60a0)
    ** Insert  : 'arith.constant'(0x5b5573fc6140)
    ** Insert Block into detached Region (nullptr parent op)'    ** Insert  : 'scf.yield'(0x5b5573fc6230)
    ** Insert  : 'scf.for'(0x5b5573fc1e40)
    ** Erase   : 'scf.yield'(0x5b5573fc6230)
    ** Insert  : 'scf.yield'(0x5b5573fc6320)
    ** Insert  : 'memref.load'(0x5b5573fc63c0)
    ** Insert  : 'llvm.call'(0x5b5573fc7440)
    ** Erase   : 'engine.print'(0x5b5573efe260)
"engine::PrintOpLowering" result 1

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.func'(0x5b5573fc5450) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.global'(0x5b5573f3be20) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.addressof'(0x5b5573fc5160) {
      %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc6e30) {
      %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.getelementptr'(0x5b5573f17040) {
      %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.global'(0x5b5573f09590) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.addressof'(0x5b5573fc6f20) {
      %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc6fb0) {
      %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.getelementptr'(0x5b5573f09080) {
      %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5b5573fc6000) {
      %56 = "arith.constant"() <{value = 0 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc7980)
        ** Replace : 'arith.constant'(0x5b5573fc6000)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc7980) {
          %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "arith.constant"() <{value = 3 : index}> : () -> index
  %59 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%57, %58, %59) ({
  ^bb0(%arg0: index):
    %60 = "memref.load"(%49, %arg0) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
    %61 = "llvm.call"(%52, %60) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5b5573fc60a0) {
      %58 = "arith.constant"() <{value = 3 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fc7b30)
        ** Replace : 'arith.constant'(0x5b5573fc60a0)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fc7b30) {
          %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%57, %59, %60) ({
  ^bb0(%arg0: index):
    %61 = "memref.load"(%49, %arg0) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
    %62 = "llvm.call"(%52, %61) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5b5573fc6140) {
      %60 = "arith.constant"() <{value = 1 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5b5573fcac30)
        ** Replace : 'arith.constant'(0x5b5573fc6140)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5b5573fcac30) {
          %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "scf.for"(%57, %59, %61) ({
  ^bb0(%arg0: index):
    %62 = "memref.load"(%49, %arg0) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
    %63 = "llvm.call"(%52, %62) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
    "scf.yield"() : () -> ()
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.yield'(0x5b5573fc6230) {
      "scf.yield"() : () -> ()

    } -> SUCCESS : operation marked 'ignored' during conversion
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.for'(0x5b5573fc1e40) {
      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'scf.for -> ()' {
Trying to match "{anonymous}::ForLowering"
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
        ** Insert  : 'func.return'(0x5b5573f12ec0)
        ** Insert  : 'engine.print'(0x5b5573efe260)
        ** Insert  : 'scf.for'(0x5b5573fc1e40)
        ** Insert Block into : 'scf.for'(0x5b5573fc1e40)
        ** Insert  : 'scf.yield'(0x5b5573fc6320)
        ** Insert  : 'scf.yield'(0x5b5573fc6230)
        ** Insert  : 'llvm.call'(0x5b5573fc7440)
        ** Insert  : 'memref.load'(0x5b5573fc63c0)
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)
        ** Insert  : 'arith.addi'(0x5b5573fcaf20)
        ** Insert  : 'cf.br'(0x5b5573fc56b0)
        ** Erase   : 'scf.yield'(0x5b5573fc6320)
        ** Insert  : 'cf.br'(0x5b5573fc5750)
        ** Insert  : 'arith.cmpi'(0x5b5573fc7bf0)
        ** Insert  : 'cf.cond_br'(0x5b5573fc7a00)
        ** Replace : 'scf.for'(0x5b5573fc1e40)
"{anonymous}::ForLowering" result 1
        ** Insert Block into : 'llvm.func'(0x5b5573fab7e0)

        //===-------------------------------------------===//
        Legalizing operation : 'arith.addi'(0x5b5573fcaf20) {
          %68 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'arith.addi -> ()' {
Trying to match "mlir::VectorConvertToLLVMPattern<mlir::arith::AddIOp, mlir::LLVM::AddOp, mlir::arith::AttrConvertOverflowToLLVM>"
            ** Insert  : 'llvm.add'(0x5b5573fc80e0)
            ** Replace : 'arith.addi'(0x5b5573fcaf20)
"mlir::VectorConvertToLLVMPattern<mlir::arith::AddIOp, mlir::LLVM::AddOp, mlir::arith::AttrConvertOverflowToLLVM>" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.add'(0x5b5573fc80e0) {
              %68 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 2 preds: ^bb3, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // pred: ^bb4
  %66 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %67 = "llvm.call"(%52, %66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %68 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %69 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "cf.br"(%69)[^bb4] : (index) -> ()
^bb6:  // pred: ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'cf.br'(0x5b5573fc56b0) {
          "cf.br"(%69)[^bb4] : (index) -> ()

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'cf.br -> ()' {
Trying to match "{anonymous}::BranchOpLowering"
            ** Insert  : 'llvm.br'(0x5b5573fc82f0)
            ** Replace : 'cf.br'(0x5b5573fc56b0)
"{anonymous}::BranchOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.br'(0x5b5573fc82f0) {
              "llvm.br"(%68)[^bb4] : (i64) -> ()

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 3 preds: ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // pred: ^bb4
  %66 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %67 = "llvm.call"(%52, %66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %68 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %69 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%68)[^bb4] : (i64) -> ()
  "cf.br"(%69)[^bb4] : (index) -> ()
^bb6:  // pred: ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'cf.br'(0x5b5573fc5750) {
          "cf.br"(%57)[^bb4] : (index) -> ()

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'cf.br -> ()' {
Trying to match "{anonymous}::BranchOpLowering"
            ** Insert  : 'llvm.br'(0x5b5573fc83f0)
            ** Replace : 'cf.br'(0x5b5573fc5750)
"{anonymous}::BranchOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.br'(0x5b5573fc83f0) {
              "llvm.br"(%56)[^bb4] : (i64) -> ()

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // pred: ^bb4
  %66 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %67 = "llvm.call"(%52, %66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %68 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %69 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%68)[^bb4] : (i64) -> ()
  "cf.br"(%69)[^bb4] : (index) -> ()
^bb6:  // pred: ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'arith.cmpi'(0x5b5573fc7bf0) {
          %65 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'arith.cmpi -> ()' {
Trying to match "{anonymous}::CmpIOpLowering"
            ** Insert  : 'llvm.icmp'(0x5b5573fc8500)
            ** Replace : 'arith.cmpi'(0x5b5573fc7bf0)
"{anonymous}::CmpIOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.icmp'(0x5b5573fc8500) {
              %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %66 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // pred: ^bb4
  %67 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %68 = "llvm.call"(%52, %67) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %69 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %70 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%69)[^bb4] : (i64) -> ()
  "cf.br"(%70)[^bb4] : (index) -> ()
^bb6:  // pred: ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'cf.cond_br'(0x5b5573fc7a00) {
          "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()

          * Fold {
          } -> FAILURE : unable to fold

          * Pattern : 'cf.cond_br -> ()' {
Trying to match "{anonymous}::CondBranchOpLowering"
            ** Insert  : 'llvm.cond_br'(0x5b5573ec0180)
            ** Replace : 'cf.cond_br'(0x5b5573fc7a00)
"{anonymous}::CondBranchOpLowering" result 1

            //===-------------------------------------------===//
            Legalizing operation : 'llvm.cond_br'(0x5b5573ec0180) {
              "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()

            } -> SUCCESS : operation marked legal by the target
            //===-------------------------------------------===//
          } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %66 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // 2 preds: ^bb4, ^bb4
  %67 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %68 = "llvm.call"(%52, %67) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %69 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %70 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%69)[^bb4] : (i64) -> ()
  "cf.br"(%70)[^bb4] : (index) -> ()
^bb6:  // 2 preds: ^bb4, ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


        } -> SUCCESS
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %66 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // 2 preds: ^bb4, ^bb4
  %67 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %68 = "llvm.call"(%52, %67) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %69 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %70 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%69)[^bb4] : (i64) -> ()
  "cf.br"(%70)[^bb4] : (index) -> ()
^bb6:  // 2 preds: ^bb4, ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.yield'(0x5b5573fc6320) {
      "scf.yield"() : () -> ()

    } -> SUCCESS : operation marked 'ignored' during conversion
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'memref.load'(0x5b5573fc63c0) {
      %67 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'memref.load -> ()' {
Trying to match "{anonymous}::LoadOpLowering"
        ** Insert  : 'llvm.extractvalue'(0x5b5573fc8670)
        ** Insert  : 'llvm.getelementptr'(0x5b5573fc8700)
        ** Insert  : 'llvm.load'(0x5b5573fc8850)
        ** Replace : 'memref.load'(0x5b5573fc63c0)
"{anonymous}::LoadOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.extractvalue'(0x5b5573fc8670) {
          %67 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.getelementptr'(0x5b5573fc8700) {
          %68 = "llvm.getelementptr"(%67, %64) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.load'(0x5b5573fc8850) {
          %69 = "llvm.load"(%68) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %66 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // 2 preds: ^bb4, ^bb4
  %67 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %68 = "llvm.getelementptr"(%67, %64) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %69 = "llvm.load"(%68) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %70 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %71 = "llvm.call"(%52, %70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %72 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %73 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%72)[^bb4] : (i64) -> ()
  "cf.br"(%73)[^bb4] : (index) -> ()
^bb6:  // 2 preds: ^bb4, ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.call'(0x5b5573fc7440) {
      %71 = "llvm.call"(%52, %70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %66 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // 2 preds: ^bb4, ^bb4
  %67 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %68 = "llvm.getelementptr"(%67, %64) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %69 = "llvm.load"(%68) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %70 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %71 = "llvm.call"(%52, %70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %72 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %73 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%72)[^bb4] : (i64) -> ()
  "cf.br"(%73)[^bb4] : (index) -> ()
^bb6:  // 2 preds: ^bb4, ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


} -> SUCCESS
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'func.return'(0x5b5573f12ec0) {
  "func.return"() : () -> ()

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'func.return -> ()' {
Trying to match "{anonymous}::ReturnOpLowering"
    ** Insert  : 'llvm.return'(0x5b5573fc87e0)
    ** Replace : 'func.return'(0x5b5573f12ec0)
"{anonymous}::ReturnOpLowering" result 1

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.return'(0x5b5573fc87e0) {
      "llvm.return"() : () -> ()

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//
  } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
operation with block successors must terminate its parent block
mlir-asm-printer: 'llvm.func' failed to verify and will be printed in generic form
"llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
  %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
  %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
  %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>
  %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr
  %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %18 = "arith.constant"() <{value = 0 : index}> : () -> index
  %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %20 = "arith.constant"() <{value = 3 : index}> : () -> index
  %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %22 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%17)[^bb1] : (i64) -> ()
  "cf.br"(%18)[^bb1] : (index) -> ()
^bb1(%23: i64):  // 4 preds: ^bb0, ^bb0, ^bb2, ^bb2
  %24 = "builtin.unrealized_conversion_cast"(%23) : (i64) -> index
  %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
  %26 = "llvm.icmp"(%25, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %27 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %20) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%26)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb2:  // 2 preds: ^bb1, ^bb1
  %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %29 = "llvm.alloca"(%28) <{elem_type = f64}> : (i64) -> !llvm.ptr
  %30 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64)>
  %31 = "llvm.insertvalue"(%30, %29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
  %33 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
  %35 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
  %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
  %38 = "memref.extract_aligned_pointer_as_index"(%35) : (memref<f64>) -> index
  %39 = "arith.index_cast"(%38) : (index) -> i64
  %40 = "llvm.inttoptr"(%39) : (i64) -> !llvm.ptr
  %41 = "llvm.call"(%16, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @scanf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, !llvm.ptr) -> i32
  %42 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
  %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %44 = "memref.load"(%35) <{nontemporal = false}> : (memref<f64>) -> f64
  %45 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %46 = "llvm.getelementptr"(%45, %25) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  "llvm.store"(%43, %46) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
  "memref.store"(%44, %13, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (f64, memref<3xf64>, index) -> ()
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %47 = "llvm.add"(%25, %21) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %48 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%47)[^bb1] : (i64) -> ()
  "cf.br"(%48)[^bb1] : (index) -> ()
^bb3:  // 2 preds: ^bb1, ^bb1
  "scf.for"(%18, %20, %22) ({
  }) : (index, index, index) -> ()
  %49 = "engine.read"() : () -> memref<3xf64>
  %50 = "llvm.mlir.addressof"() <{global_name = @frmt_spec}> : () -> !llvm.ptr
  %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %52 = "llvm.getelementptr"(%50, %51, %51) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %53 = "llvm.mlir.addressof"() <{global_name = @nl}> : () -> !llvm.ptr
  %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %55 = "llvm.getelementptr"(%53, %54, %54) <{elem_type = !llvm.array<2 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr
  %56 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
  %57 = "arith.constant"() <{value = 0 : index}> : () -> index
  %58 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
  %59 = "arith.constant"() <{value = 3 : index}> : () -> index
  %60 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
  %61 = "arith.constant"() <{value = 1 : index}> : () -> index
  "llvm.br"(%56)[^bb4] : (i64) -> ()
  "cf.br"(%57)[^bb4] : (index) -> ()
^bb4(%62: i64):  // 4 preds: ^bb3, ^bb3, ^bb5, ^bb5
  %63 = "builtin.unrealized_conversion_cast"(%62) : (i64) -> index
  %64 = "builtin.unrealized_conversion_cast"(%63) : (index) -> i64
  %65 = "llvm.icmp"(%64, %58) <{predicate = 2 : i64}> : (i64, i64) -> i1
  %66 = "arith.cmpi"(<<UNKNOWN SSA VALUE>>, %59) <{predicate = 2 : i64}> : (index, index) -> i1
  "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  "cf.cond_br"(%66)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
^bb5:  // 2 preds: ^bb4, ^bb4
  %67 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
  %68 = "llvm.getelementptr"(%67, %64) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
  %69 = "llvm.load"(%68) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
  %70 = "memref.load"(%49, <<UNKNOWN SSA VALUE>>) <{nontemporal = false}> : (memref<3xf64>, index) -> f64
  %71 = "llvm.call"(%52, %70) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr, ...)>}> : (!llvm.ptr, f64) -> i32
  "scf.yield"() : () -> ()
  "scf.yield"() : () -> ()
  %72 = "llvm.add"(%64, %60) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
  %73 = "arith.addi"(<<UNKNOWN SSA VALUE>>, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
  "llvm.br"(%72)[^bb4] : (i64) -> ()
  "cf.br"(%73)[^bb4] : (index) -> ()
^bb6:  // 2 preds: ^bb4, ^bb4
  "scf.for"(%57, %59, %61) ({
  }) : (index, index, index) -> ()
  "engine.print"(%49) : (memref<3xf64>) -> ()
  "llvm.return"() : () -> ()
  "func.return"() : () -> ()
}) : () -> ()


} -> SUCCESS
//===-------------------------------------------===//
ImplicitTypeIDRegistry::lookupOrInsert(mlir::PromotableOpInterface::Trait<mlir::TypeID::get<mlir::PromotableOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::SafeMemorySlotAccessOpInterface::Trait<mlir::TypeID::get<mlir::SafeMemorySlotAccessOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::ViewLikeOpInterface::Trait<mlir::TypeID::get<mlir::ViewLikeOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::AccessGroupOpInterface::Trait<mlir::TypeID::get<mlir::LLVM::AccessGroupOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::AliasAnalysisOpInterface::Trait<mlir::TypeID::get<mlir::LLVM::AliasAnalysisOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::FastmathFlagsInterface::Trait<mlir::TypeID::get<mlir::LLVM::FastmathFlagsInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::CallOpInterface::Trait<mlir::TypeID::get<mlir::CallOpInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::IntegerOverflowFlagsInterface::Trait<mlir::TypeID::get<mlir::LLVM::IntegerOverflowFlagsInterface::Trait>::Empty>)
// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass () //----- //
ImplicitTypeIDRegistry::lookupOrInsert(mlir::AttributeTrait::IsLocation<mlir::TypeID::get<mlir::AttributeTrait::IsLocation>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::TypedAttr::Trait<mlir::TypeID::get<mlir::TypedAttr::Trait>::Empty>)
module {
  llvm.mlir.global internal constant @nl("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @frmt_spec("%f \00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @scanf_fmt("%lf\00") {addr_space = 0 : i32}
  llvm.func @scanf(!llvm.ptr, ...) -> i32
  llvm.func @main() {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.call @malloc(%4) : (i64) -> !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %0, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %1, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.mlir.addressof @scanf_fmt : !llvm.ptr
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.getelementptr %13[%14, %14] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.mlir.constant(3 : index) : i64
    %18 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%16 : i64)
  ^bb1(%19: i64):  // 2 preds: ^bb0, ^bb2
    %20 = llvm.icmp "slt" %19, %17 : i64
    llvm.cond_br %20, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %21 = llvm.mlir.constant(1 : index) : i64
    %22 = llvm.alloca %21 x f64 : (i64) -> !llvm.ptr
    %23 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64)>
    %24 = llvm.insertvalue %22, %23[0] : !llvm.struct<(ptr, ptr, i64)> 
    %25 = llvm.insertvalue %22, %24[1] : !llvm.struct<(ptr, ptr, i64)> 
    %26 = llvm.mlir.constant(0 : index) : i64
    %27 = llvm.insertvalue %26, %25[2] : !llvm.struct<(ptr, ptr, i64)> 
    %28 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64)> 
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.inttoptr %29 : i64 to !llvm.ptr
    %31 = llvm.call @scanf(%15, %30) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %32 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64)> 
    %33 = llvm.load %32 : !llvm.ptr -> f64
    %34 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.getelementptr %34[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %33, %35 : f64, !llvm.ptr
    %36 = llvm.add %19, %18 : i64
    llvm.br ^bb1(%36 : i64)
  ^bb3:  // pred: ^bb1
    %37 = llvm.mlir.addressof @frmt_spec : !llvm.ptr
    %38 = llvm.mlir.constant(0 : index) : i64
    %39 = llvm.getelementptr %37[%38, %38] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %40 = llvm.mlir.addressof @nl : !llvm.ptr
    %41 = llvm.mlir.constant(0 : index) : i64
    %42 = llvm.getelementptr %40[%41, %41] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %43 = llvm.mlir.constant(0 : index) : i64
    %44 = llvm.mlir.constant(3 : index) : i64
    %45 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb4(%43 : i64)
  ^bb4(%46: i64):  // 2 preds: ^bb3, ^bb5
    %47 = llvm.icmp "slt" %46, %44 : i64
    llvm.cond_br %47, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %48 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.getelementptr %48[%46] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %50 = llvm.load %49 : !llvm.ptr -> f64
    %51 = llvm.call @printf(%39, %50) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %52 = llvm.add %46, %45 : i64
    llvm.br ^bb4(%52 : i64)
  ^bb6:  // pred: ^bb4
    llvm.return
  }
}


ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVMTranslationDialectInterface)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::DataLayoutOpInterface)
0.100000 1.000000 2.000000 