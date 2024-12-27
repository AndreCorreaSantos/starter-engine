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
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i32 6) to i64))
  %2 = getelementptr double, ptr %1, i64 0
  store double 1.000000e+00, ptr %2, align 8
  %3 = getelementptr double, ptr %1, i64 1
  store double 2.000000e+00, ptr %3, align 8
  %4 = getelementptr double, ptr %1, i64 2
  store double 3.000000e+00, ptr %4, align 8
  %5 = getelementptr double, ptr %1, i64 3
  store double 4.000000e+00, ptr %5, align 8
  %6 = getelementptr double, ptr %1, i64 4
  store double 5.000000e+00, ptr %6, align 8
  %7 = getelementptr double, ptr %1, i64 5
  store double 6.000000e+00, ptr %7, align 8
  br label %8

8:                                                ; preds = %22, %0
  %9 = phi i64 [ 0, %0 ], [ %24, %22 ]
  %10 = icmp slt i64 %9, 2
  br i1 %10, label %11, label %25

11:                                               ; preds = %8
  br label %12

12:                                               ; preds = %15, %11
  %13 = phi i64 [ 0, %11 ], [ %21, %15 ]
  %14 = icmp slt i64 %13, 3
  br i1 %14, label %15, label %22

15:                                               ; preds = %12
  %16 = mul i64 %9, 3
  %17 = add i64 %16, %13
  %18 = getelementptr double, ptr %1, i64 %17
  %19 = load double, ptr %18, align 8
  %20 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %19)
  %21 = add i64 %13, 1
  br label %12

22:                                               ; preds = %12
  %23 = call i32 (ptr, ...) @printf(ptr @nl)
  %24 = add i64 %9, 1
  br label %8

25:                                               ; preds = %8
  call void @free(ptr %1)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

