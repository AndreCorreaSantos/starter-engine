; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 10) to i64))
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 10, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0
  %7 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %8 = getelementptr double, ptr %7, i64 0
  store double -2.000000e-01, ptr %8, align 8
  %9 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %10 = getelementptr double, ptr %9, i64 1
  store double 3.000000e-01, ptr %10, align 8
  %11 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %12 = getelementptr double, ptr %11, i64 2
  store double 1.000000e-01, ptr %12, align 8
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %14 = getelementptr double, ptr %13, i64 3
  store double -1.000000e-01, ptr %14, align 8
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %16 = getelementptr double, ptr %15, i64 4
  store double -1.000000e-01, ptr %16, align 8
  %17 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %18 = getelementptr double, ptr %17, i64 5
  store double 1.000000e-01, ptr %18, align 8
  %19 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %20 = getelementptr double, ptr %19, i64 6
  store double -0.000000e+00, ptr %20, align 8
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %22 = getelementptr double, ptr %21, i64 7
  store double -0.000000e+00, ptr %22, align 8
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %24 = getelementptr double, ptr %23, i64 8
  store double -1.000000e-01, ptr %24, align 8
  %25 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %26 = getelementptr double, ptr %25, i64 9
  store double 0.000000e+00, ptr %26, align 8
  br label %27

27:                                               ; preds = %30, %0
  %28 = phi i64 [ 0, %0 ], [ %35, %30 ]
  %29 = icmp slt i64 %28, 10
  br i1 %29, label %30, label %36

30:                                               ; preds = %27
  %31 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %32 = getelementptr double, ptr %31, i64 %28
  %33 = load double, ptr %32, align 8
  %34 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %33)
  %35 = add i64 %28, 1
  br label %27

36:                                               ; preds = %27
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

