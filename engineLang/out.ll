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
  br label %31

31:                                               ; preds = %34, %0
  %32 = phi i64 [ %44, %34 ], [ 0, %0 ]
  %33 = icmp slt i64 %32, 3
  br i1 %33, label %34, label %45

34:                                               ; preds = %31
  %35 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %36 = getelementptr double, ptr %35, i64 %32
  %37 = load double, ptr %36, align 8
  %38 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %39 = getelementptr double, ptr %38, i64 %32
  %40 = load double, ptr %39, align 8
  %41 = fadd double %37, %40
  %42 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 1
  %43 = getelementptr double, ptr %42, i64 %32
  store double %41, ptr %43, align 8
  %44 = add i64 %32, 1
  br label %31

45:                                               ; preds = %31
  ret { ptr, ptr, i64, [1 x i64], [1 x i64] } %30
}

define void @main() {
  %1 = call { ptr, ptr, i64, [1 x i64], [1 x i64] } @add()
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

