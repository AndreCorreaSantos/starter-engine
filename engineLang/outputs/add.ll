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
  store double 4.000000e+00, ptr %14, align 8
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %16 = getelementptr double, ptr %15, i64 1
  store double 5.000000e+00, ptr %16, align 8
  %17 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %18 = getelementptr double, ptr %17, i64 2
  store double 6.000000e+00, ptr %18, align 8
  %19 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %20 = getelementptr double, ptr %19, i64 0
  store double 4.000000e+00, ptr %20, align 8
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %22 = getelementptr double, ptr %21, i64 1
  store double 5.000000e+00, ptr %22, align 8
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %24 = getelementptr double, ptr %23, i64 2
  store double 6.000000e+00, ptr %24, align 8
  %25 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 1) to i64))
  %26 = insertvalue { ptr, ptr, i64 } undef, ptr %25, 0
  %27 = insertvalue { ptr, ptr, i64 } %26, ptr %25, 1
  %28 = insertvalue { ptr, ptr, i64 } %27, i64 0, 2
  br label %29

29:                                               ; preds = %32, %0
  %30 = phi i64 [ 0, %0 ], [ %44, %32 ]
  %31 = icmp slt i64 %30, 3
  br i1 %31, label %32, label %45

32:                                               ; preds = %29
  %33 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %34 = getelementptr double, ptr %33, i64 %30
  %35 = load double, ptr %34, align 8
  %36 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %37 = getelementptr double, ptr %36, i64 %30
  %38 = load double, ptr %37, align 8
  %39 = extractvalue { ptr, ptr, i64 } %28, 1
  %40 = load double, ptr %39, align 8
  %41 = fmul double %35, %38
  %42 = fadd double %40, %41
  %43 = extractvalue { ptr, ptr, i64 } %28, 1
  store double %42, ptr %43, align 8
  %44 = add i64 %30, 1
  br label %29

45:                                               ; preds = %29
  %46 = extractvalue { ptr, ptr, i64 } %28, 1
  %47 = load double, ptr %46, align 8
  %48 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %47)
  %49 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 0
  call void @free(ptr %49)
  %50 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 0
  call void @free(ptr %50)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

