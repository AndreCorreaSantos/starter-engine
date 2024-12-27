; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

define { ptr, ptr, i64, [1 x i64], [1 x i64] } @add() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0
  %7 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %7, 0
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, ptr %7, 1
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 0, 2
  %11 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, i64 3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %11, i64 1, 4, 0
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %14 = getelementptr double, ptr %13, i64 0
  store double 1.000000e+00, ptr %14, align 8
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %16 = getelementptr double, ptr %15, i64 1
  store double 2.000000e+00, ptr %16, align 8
  %17 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %18 = getelementptr double, ptr %17, i64 2
  store double 3.000000e+00, ptr %18, align 8
  %19 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %20 = getelementptr double, ptr %19, i64 0
  store double 1.000000e+00, ptr %20, align 8
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %22 = getelementptr double, ptr %21, i64 1
  store double 2.000000e+00, ptr %22, align 8
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %24 = getelementptr double, ptr %23, i64 2
  store double 3.000000e+00, ptr %24, align 8
  %25 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %25, 0
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, ptr %25, 1
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 0, 2
  %29 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, i64 3, 3, 0
  %30 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, i64 1, 4, 0
  %31 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 0
  %32 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %33 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 2
  %34 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 3, 0
  %35 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 4, 0
  %36 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 0
  %37 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %38 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 2
  %39 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 3, 0
  %40 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 4, 0
  %41 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 0
  %42 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 1
  %43 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 2
  %44 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 3, 0
  %45 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 4, 0
  call void @linalg_add_view3xf64_view3xf64_view3xf64(ptr %31, ptr %32, i64 %33, i64 %34, i64 %35, ptr %36, ptr %37, i64 %38, i64 %39, i64 %40, ptr %41, ptr %42, i64 %43, i64 %44, i64 %45)
  ret { ptr, ptr, i64, [1 x i64], [1 x i64] } %30
}

define private void @linalg_add_view3xf64_view3xf64_view3xf64(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14) {
  %16 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %16, ptr %1, 1
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, i64 %2, 2
  %19 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, i64 %3, 3, 0
  %20 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %19, i64 %4, 4, 0
  %21 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, ptr %21, align 8
  %22 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %5, 0
  %23 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, ptr %6, 1
  %24 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %23, i64 %7, 2
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %24, i64 %8, 3, 0
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, i64 %9, 4, 0
  %27 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, ptr %27, align 8
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %10, 0
  %29 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, ptr %11, 1
  %30 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, i64 %12, 2
  %31 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, i64 %13, 3, 0
  %32 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %31, i64 %14, 4, 0
  %33 = alloca { ptr, ptr, i64, [1 x i64], [1 x i64] }, i64 1, align 8
  store { ptr, ptr, i64, [1 x i64], [1 x i64] } %32, ptr %33, align 8
  call void @_mlir_ciface_linalg_add_view3xf64_view3xf64_view3xf64(ptr %21, ptr %27, ptr %33)
  ret void
}

declare void @_mlir_ciface_linalg_add_view3xf64_view3xf64_view3xf64(ptr, ptr, ptr)

define void @main() {
  %1 = call { ptr, ptr, i64, [1 x i64], [1 x i64] } @add()
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

