; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i32 3) to i64))
  %2 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i32 3) to i64))
  store double 1.000000e+00, ptr %1, align 8
  %3 = getelementptr double, ptr %1, i32 1
  store double 2.000000e+00, ptr %3, align 8
  %4 = getelementptr double, ptr %1, i32 2
  store double 3.000000e+00, ptr %4, align 8
  store double 1.000000e+00, ptr %2, align 8
  %5 = getelementptr double, ptr %2, i32 1
  store double 2.000000e+00, ptr %5, align 8
  %6 = getelementptr double, ptr %2, i32 2
  store double 3.000000e+00, ptr %6, align 8
  br label %7

7:                                                ; preds = %10, %0
  %8 = phi i64 [ 0, %0 ], [ %14, %10 ]
  %9 = icmp slt i64 %8, 3
  br i1 %9, label %10, label %15

10:                                               ; preds = %7
  %11 = getelementptr double, ptr %2, i64 %8
  %12 = load double, ptr %11, align 8
  %13 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %12)
  %14 = add i64 %8, 1
  br label %7

15:                                               ; preds = %7
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

