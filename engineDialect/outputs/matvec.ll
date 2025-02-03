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
  %2 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 1, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 1, 4, 0
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
  %15 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 1) to i64))
  %16 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %15, 0
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %16, ptr %15, 1
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, i64 0, 2
  %19 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, i64 1, 3, 0
  %20 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %19, i64 1, 4, 0
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 1
  %22 = getelementptr double, ptr %21, i64 0
  store double 2.000000e+00, ptr %22, align 8
  %23 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %24 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %23, 0
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %24, ptr %23, 1
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, i64 0, 2
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, i64 3, 3, 0
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 1, 4, 0
  %29 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %30 = getelementptr double, ptr %29, i64 0
  store double 0.000000e+00, ptr %30, align 8
  %31 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %32 = getelementptr double, ptr %31, i64 1
  store double 0.000000e+00, ptr %32, align 8
  %33 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %34 = getelementptr double, ptr %33, i64 2
  store double 0.000000e+00, ptr %34, align 8
  br label %35

35:                                               ; preds = %58, %0
  %36 = phi i64 [ 0, %0 ], [ %59, %58 ]
  %37 = icmp slt i64 %36, 3
  br i1 %37, label %38, label %60

38:                                               ; preds = %35
  br label %39

39:                                               ; preds = %42, %38
  %40 = phi i64 [ 0, %38 ], [ %57, %42 ]
  %41 = icmp slt i64 %40, 1
  br i1 %41, label %42, label %58

42:                                               ; preds = %39
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %44 = add i64 %36, %40
  %45 = getelementptr double, ptr %43, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 1
  %48 = getelementptr double, ptr %47, i64 %40
  %49 = load double, ptr %48, align 8
  %50 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %51 = getelementptr double, ptr %50, i64 %36
  %52 = load double, ptr %51, align 8
  %53 = fmul double %46, %49
  %54 = fadd double %52, %53
  %55 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %56 = getelementptr double, ptr %55, i64 %36
  store double %54, ptr %56, align 8
  %57 = add i64 %40, 1
  br label %39

58:                                               ; preds = %39
  %59 = add i64 %36, 1
  br label %35

60:                                               ; preds = %35
  br label %61

61:                                               ; preds = %64, %60
  %62 = phi i64 [ 0, %60 ], [ %69, %64 ]
  %63 = icmp slt i64 %62, 3
  br i1 %63, label %64, label %70

64:                                               ; preds = %61
  %65 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %66 = getelementptr double, ptr %65, i64 %62
  %67 = load double, ptr %66, align 8
  %68 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %67)
  %69 = add i64 %62, 1
  br label %61

70:                                               ; preds = %61
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

