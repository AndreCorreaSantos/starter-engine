; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"

declare void @free(ptr)

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i32 1) to i64))
  %2 = getelementptr double, ptr %1, i64 0
  store double 1.000000e+00, ptr %2, align 8
  br label %3

3:                                                ; preds = %16, %0
  %4 = phi i64 [ 0, %0 ], [ %18, %16 ]
  %5 = icmp slt i64 %4, 1
  br i1 %5, label %6, label %19

6:                                                ; preds = %3
  br label %7

7:                                                ; preds = %10, %6
  %8 = phi i64 [ 0, %6 ], [ %15, %10 ]
  %9 = icmp slt i64 %8, 1
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  %11 = add i64 %4, %8
  %12 = getelementptr double, ptr %1, i64 %11
  %13 = load double, ptr %12, align 8
  %14 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %13)
  %15 = add i64 %8, 1
  br label %7

16:                                               ; preds = %7
  %17 = call i32 (ptr, ...) @printf(ptr @nl)
  %18 = add i64 %4, 1
  br label %3

19:                                               ; preds = %3
  call void @free(ptr %1)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

