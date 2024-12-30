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
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 6) to i64))
  %2 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 2, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 3, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 3, 4, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 1, 4, 1
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %10 = getelementptr double, ptr %9, i64 0
  store double 1.000000e+00, ptr %10, align 8
  %11 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %12 = getelementptr double, ptr %11, i64 1
  store double 2.000000e+00, ptr %12, align 8
  %13 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %14 = getelementptr double, ptr %13, i64 2
  store double 3.000000e+00, ptr %14, align 8
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %16 = getelementptr double, ptr %15, i64 3
  store double 4.000000e+00, ptr %16, align 8
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %18 = getelementptr double, ptr %17, i64 4
  store double 5.000000e+00, ptr %18, align 8
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %20 = getelementptr double, ptr %19, i64 5
  store double 6.000000e+00, ptr %20, align 8
  br label %21

21:                                               ; preds = %36, %0
  %22 = phi i64 [ 0, %0 ], [ %38, %36 ]
  %23 = icmp slt i64 %22, 2
  br i1 %23, label %24, label %39

24:                                               ; preds = %21
  br label %25

25:                                               ; preds = %28, %24
  %26 = phi i64 [ 0, %24 ], [ %35, %28 ]
  %27 = icmp slt i64 %26, 3
  br i1 %27, label %28, label %36

28:                                               ; preds = %25
  %29 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %30 = mul i64 %22, 3
  %31 = add i64 %30, %26
  %32 = getelementptr double, ptr %29, i64 %31
  %33 = load double, ptr %32, align 8
  %34 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %33)
  %35 = add i64 %26, 1
  br label %25

36:                                               ; preds = %25
  %37 = call i32 (ptr, ...) @printf(ptr @nl)
  %38 = add i64 %22, 1
  br label %21

39:                                               ; preds = %21
  %40 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %40)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

