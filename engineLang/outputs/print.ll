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
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 1) to i64))
  %2 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 1, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 1, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 1, 4, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 1, 4, 1
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %10 = getelementptr double, ptr %9, i64 0
  store double 1.000000e+00, ptr %10, align 8
  br label %11

11:                                               ; preds = %25, %0
  %12 = phi i64 [ 0, %0 ], [ %27, %25 ]
  %13 = icmp slt i64 %12, 1
  br i1 %13, label %14, label %28

14:                                               ; preds = %11
  br label %15

15:                                               ; preds = %18, %14
  %16 = phi i64 [ 0, %14 ], [ %24, %18 ]
  %17 = icmp slt i64 %16, 1
  br i1 %17, label %18, label %25

18:                                               ; preds = %15
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %20 = add i64 %12, %16
  %21 = getelementptr double, ptr %19, i64 %20
  %22 = load double, ptr %21, align 8
  %23 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %22)
  %24 = add i64 %16, 1
  br label %15

25:                                               ; preds = %15
  %26 = call i32 (ptr, ...) @printf(ptr @nl)
  %27 = add i64 %12, 1
  br label %11

28:                                               ; preds = %11
  %29 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %29)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

