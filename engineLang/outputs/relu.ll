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
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %14 = getelementptr double, ptr %13, i64 0
  store double 1.000000e+00, ptr %14, align 8
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %16 = getelementptr double, ptr %15, i64 1
  store double 2.000000e+00, ptr %16, align 8
  %17 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %18 = getelementptr double, ptr %17, i64 2
  store double 3.000000e+00, ptr %18, align 8
  %19 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %20 = getelementptr double, ptr %19, i64 0
  %21 = load double, ptr %20, align 8
  %22 = fadd double %21, 1.000000e+00
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %24 = getelementptr double, ptr %23, i64 0
  store double %22, ptr %24, align 8
  %25 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %26 = getelementptr double, ptr %25, i64 1
  %27 = load double, ptr %26, align 8
  %28 = fadd double %27, 1.000000e+00
  %29 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %30 = getelementptr double, ptr %29, i64 1
  store double %28, ptr %30, align 8
  %31 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %32 = getelementptr double, ptr %31, i64 2
  %33 = load double, ptr %32, align 8
  %34 = fadd double %33, 1.000000e+00
  %35 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %36 = getelementptr double, ptr %35, i64 2
  store double %34, ptr %36, align 8
  br label %37

37:                                               ; preds = %40, %0
  %38 = phi i64 [ 0, %0 ], [ %45, %40 ]
  %39 = icmp slt i64 %38, 3
  br i1 %39, label %40, label %46

40:                                               ; preds = %37
  %41 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %42 = getelementptr double, ptr %41, i64 %38
  %43 = load double, ptr %42, align 8
  %44 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %43)
  %45 = add i64 %38, 1
  br label %37

46:                                               ; preds = %37
  %47 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 0
  call void @free(ptr %47)
  %48 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 0
  call void @free(ptr %48)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

