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
Legalizing operation : 'builtin.module'(0x5ebf36db24b0) {
} -> SUCCESS : operation marked legal by the target
//===-------------------------------------------===//

//===-------------------------------------------===//
Legalizing operation : 'func.func'(0x5ebf36db2420) {
  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'func.func -> ()' {
Trying to match "{anonymous}::FuncOpConversion"
    ** Insert  : 'llvm.func'(0x5ebf36e65370)
    ** Insert Block into : 'llvm.func'(0x5ebf36e65370)
    ** Erase   : 'func.func'(0x5ebf36db2420)
"{anonymous}::FuncOpConversion" result 1

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.func'(0x5ebf36e65370) {
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
Legalizing operation : 'engine.read'(0x5ebf36dc9e80) {
  %0 = "engine.read"() : () -> memref<3xf64>

  * Fold {
  } -> FAILURE : unable to fold

  * Pattern : 'engine.read -> ()' {
Trying to match "engine::ReadOpLowering"
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::AttrSizedOperandSegments<mlir::TypeID::get<mlir::OpTrait::AttrSizedOperandSegments>::Empty>)
    ** Insert  : 'memref.alloc'(0x5ebf36e63d10)
    ** Insert  : 'llvm.func'(0x5ebf36e6b3f0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::SingleBlockImplicitTerminator<mlir::LLVM::ReturnOp>::Impl<mlir::TypeID::get<mlir::OpTrait::SingleBlockImplicitTerminator<mlir::LLVM::ReturnOp>::Impl>::Empty>)
    ** Insert  : 'llvm.mlir.global'(0x5ebf36dffce0)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::AddressOfOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::OneTypedResult<mlir::LLVM::LLVMPointerType>::Impl<mlir::TypeID::get<mlir::OpTrait::OneTypedResult<mlir::LLVM::LLVMPointerType>::Impl>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::SymbolUserOpInterface::Trait<mlir::TypeID::get<mlir::SymbolUserOpInterface::Trait>::Empty>)
    ** Insert  : 'llvm.mlir.addressof'(0x754ae8001d70)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::ConstantOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::OneTypedResult<mlir::Type>::Impl<mlir::TypeID::get<mlir::OpTrait::OneTypedResult<mlir::Type>::Impl>::Empty>)
    ** Insert  : 'llvm.mlir.constant'(0x5ebf36de1470)
    ** Insert  : 'llvm.getelementptr'(0x5ebf36df5a70)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::arith::detail::ConstantOpGenericAdaptorBase::Properties)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::InferIntRangeInterface::Trait<mlir::TypeID::get<mlir::InferIntRangeInterface::Trait>::Empty>)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::InferTypeOpInterface::Trait<mlir::TypeID::get<mlir::InferTypeOpInterface::Trait>::Empty>)
    ** Insert  : 'arith.constant'(0x5ebf36e6e050)
    ** Insert  : 'arith.constant'(0x5ebf36e6e0f0)
    ** Insert  : 'arith.constant'(0x5ebf36e6e190)
    ** Insert Block into detached Region (nullptr parent op)'ImplicitTypeIDRegistry::lookupOrInsert(mlir::OpTrait::HasParent<mlir::scf::ExecuteRegionOp, mlir::scf::ForOp, mlir::scf::IfOp, mlir::scf::IndexSwitchOp, mlir::scf::WhileOp>::Impl<mlir::TypeID::get<mlir::OpTrait::HasParent<mlir::scf::ExecuteRegionOp, mlir::scf::ForOp, mlir::scf::IfOp, mlir::scf::IndexSwitchOp, mlir::scf::WhileOp>::Impl>::Empty>)
    ** Insert  : 'scf.yield'(0x5ebf36de1290)
    ** Insert  : 'scf.for'(0x754ae8000bb0)
    ** Replace : 'engine.read'(0x5ebf36dc9e80)
"engine::ReadOpLowering" result 1

    //===-------------------------------------------===//
    Legalizing operation : 'memref.alloc'(0x5ebf36e63d10) {
      %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf64>

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'memref.alloc -> ()' {
Trying to match "{anonymous}::AllocOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5ebf36dde4a0)
        ** Insert  : 'llvm.mlir.constant'(0x5ebf36dd3650)
        ** Insert  : 'llvm.mlir.zero'(0x5ebf36dd3500)
        ** Insert  : 'llvm.getelementptr'(0x5ebf36e63db0)
        ** Insert  : 'llvm.ptrtoint'(0x5ebf36e60c50)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::CallOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.call'(0x5ebf36d908d0)
        ** Insert  : 'llvm.mlir.undef'(0x5ebf36e71110)
ImplicitTypeIDRegistry::lookupOrInsert(mlir::LLVM::detail::InsertValueOpGenericAdaptorBase::Properties)
        ** Insert  : 'llvm.insertvalue'(0x5ebf36dc9670)
        ** Insert  : 'llvm.insertvalue'(0x5ebf36dc9720)
        ** Insert  : 'llvm.mlir.constant'(0x5ebf36e74bd0)
        ** Insert  : 'llvm.insertvalue'(0x5ebf36e750e0)
        ** Insert  : 'llvm.insertvalue'(0x5ebf36e751c0)
        ** Insert  : 'llvm.insertvalue'(0x5ebf36e752a0)
        ** Replace : 'memref.alloc'(0x5ebf36e63d10)
"{anonymous}::AllocOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5ebf36dde4a0) {
          %0 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5ebf36dd3650) {
          %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.zero'(0x5ebf36dd3500) {
          %2 = "llvm.mlir.zero"() : () -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.getelementptr'(0x5ebf36e63db0) {
          %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.ptrtoint'(0x5ebf36e60c50) {
          %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.call'(0x5ebf36d908d0) {
          %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.undef'(0x5ebf36e71110) {
          %6 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5ebf36dc9670) {
          %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5ebf36dc9720) {
          %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5ebf36e74bd0) {
          %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5ebf36e750e0) {
          %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5ebf36e751c0) {
          %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.insertvalue'(0x5ebf36e752a0) {
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
'func.return' op expects parent op 'func.func'
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
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %20 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%20) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.func'(0x5ebf36e6b3f0) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.global'(0x5ebf36dffce0) {
    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.addressof'(0x754ae8001d70) {
      %14 = "llvm.mlir.addressof"() <{global_name = @scanf_fmt}> : () -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.mlir.constant'(0x5ebf36de1470) {
      %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'llvm.getelementptr'(0x5ebf36df5a70) {
      %16 = "llvm.getelementptr"(%14, %15, %15) <{elem_type = !llvm.array<4 x i8>, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i64, i64) -> !llvm.ptr

    } -> SUCCESS : operation marked legal by the target
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5ebf36e6e050) {
      %17 = "arith.constant"() <{value = 0 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5ebf36e78100)
        ** Replace : 'arith.constant'(0x5ebf36e6e050)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5ebf36e78100) {
          %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'func.return' op expects parent op 'func.func'
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
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %21 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%21) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5ebf36e6e0f0) {
      %19 = "arith.constant"() <{value = 3 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5ebf36e75860)
        ** Replace : 'arith.constant'(0x5ebf36e6e0f0)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5ebf36e75860) {
          %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'func.return' op expects parent op 'func.func'
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
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %22 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%22) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'arith.constant'(0x5ebf36e6e190) {
      %21 = "arith.constant"() <{value = 1 : index}> : () -> index

      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'arith.constant -> ()' {
Trying to match "{anonymous}::ConstantOpLowering"
        ** Insert  : 'llvm.mlir.constant'(0x5ebf36e75ab0)
        ** Replace : 'arith.constant'(0x5ebf36e6e190)
"{anonymous}::ConstantOpLowering" result 1

        //===-------------------------------------------===//
        Legalizing operation : 'llvm.mlir.constant'(0x5ebf36e75ab0) {
          %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64

        } -> SUCCESS : operation marked legal by the target
        //===-------------------------------------------===//
      } -> SUCCESS : pattern applied successfully
// *** IR Dump After Pattern Application ***
'func.return' op expects parent op 'func.func'
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
    "scf.yield"() : () -> ()
  }) : (index, index, index) -> ()
  %23 = "engine.read"() : () -> memref<3xf64>
  "engine.print"(%23) : (memref<3xf64>) -> ()
  "func.return"() : () -> ()
}) : () -> ()


    } -> SUCCESS
    //===-------------------------------------------===//

    //===-------------------------------------------===//
    Legalizing operation : 'scf.yield'(0x5ebf36de1290) {
      "scf.yield"() : () -> ()

      * Fold {
      } -> FAILURE : unable to fold
    } -> FAILURE : no matched legalization pattern
    //===-------------------------------------------===//
  } -> FAILURE : failed to legalize generated operation 'scf.yield'(0x00005EBF36DE1290)
} -> FAILURE : pattern failed to match
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//
ImplicitTypeIDRegistry::lookupOrInsert(mlir::AttributeTrait::IsLocation<mlir::TypeID::get<mlir::AttributeTrait::IsLocation>::Empty>)
loc("./test/Engine/read.mlir":5:8): error: failed to legalize operation 'engine.read'
// -----// IR Dump After {anonymous}::EngineToLLVMLoweringPass Failed () //----- //
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @main() {
    %0 = "engine.read"() : () -> memref<3xf64>
    engine.print %0 : memref<3xf64>
    return
  }
}


lli: Symbols not found: [ main ]
