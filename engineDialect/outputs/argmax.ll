; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0
  %7 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %8 = getelementptr double, ptr %7, i64 0
  store double 1.000000e+00, ptr %8, align 8
  %9 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %10 = getelementptr double, ptr %9, i64 1
  store double 2.000000e+00, ptr %10, align 8
  %11 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %12 = getelementptr double, ptr %11, i64 2
  store double 3.000000e+00, ptr %12, align 8
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %14 = getelementptr double, ptr %13, i64 0
  %15 = load double, ptr %14, align 8
  br label %16

16:                                               ; preds = %20, %0
  %17 = phi i64 [ 0, %0 ], [ %26, %20 ]
  %18 = phi double [ %15, %0 ], [ %25, %20 ]
  %19 = icmp slt i64 %17, 3
  br i1 %19, label %20, label %27

20:                                               ; preds = %16
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %22 = getelementptr double, ptr %21, i64 %17
  %23 = load double, ptr %22, align 8
  %24 = fcmp ogt double %23, %18
  %25 = select i1 %24, double %23, double %18
  %26 = add i64 %17, 1
  br label %16

27:                                               ; preds = %16
  %28 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 1) to i64))
  %29 = insertvalue { ptr, ptr, i64 } undef, ptr %28, 0
  %30 = insertvalue { ptr, ptr, i64 } %29, ptr %28, 1
  %31 = insertvalue { ptr, ptr, i64 } %30, i64 0, 2
  %32 = extractvalue { ptr, ptr, i64 } %31, 1
  store double %18, ptr %32, align 8
  %33 = extractvalue { ptr, ptr, i64 } %31, 1
  %34 = load double, ptr %33, align 8
  %35 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %34)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

