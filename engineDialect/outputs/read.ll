; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"
@scanf_fmt = internal constant [4 x i8] c"%lf\00"

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

declare i32 @scanf(ptr, ...)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0
  br label %7

7:                                                ; preds = %10, %0
  %8 = phi i64 [ 0, %0 ], [ %23, %10 ]
  %9 = icmp slt i64 %8, 3
  br i1 %9, label %10, label %24

10:                                               ; preds = %7
  %11 = alloca double, i64 1, align 8
  %12 = insertvalue { ptr, ptr, i64 } undef, ptr %11, 0
  %13 = insertvalue { ptr, ptr, i64 } %12, ptr %11, 1
  %14 = insertvalue { ptr, ptr, i64 } %13, i64 0, 2
  %15 = extractvalue { ptr, ptr, i64 } %14, 1
  %16 = ptrtoint ptr %15 to i64
  %17 = inttoptr i64 %16 to ptr
  %18 = call i32 (ptr, ...) @scanf(ptr @scanf_fmt, ptr %17)
  %19 = extractvalue { ptr, ptr, i64 } %14, 1
  %20 = load double, ptr %19, align 8
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %22 = getelementptr double, ptr %21, i64 %8
  store double %20, ptr %22, align 8
  %23 = add i64 %8, 1
  br label %7

24:                                               ; preds = %7
  br label %25

25:                                               ; preds = %28, %24
  %26 = phi i64 [ 0, %24 ], [ %33, %28 ]
  %27 = icmp slt i64 %26, 3
  br i1 %27, label %28, label %34

28:                                               ; preds = %25
  %29 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %30 = getelementptr double, ptr %29, i64 %26
  %31 = load double, ptr %30, align 8
  %32 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %31)
  %33 = add i64 %26, 1
  br label %25

34:                                               ; preds = %25
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

