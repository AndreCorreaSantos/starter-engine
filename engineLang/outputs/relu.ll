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
  %9 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 6) to i64))
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %9, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, ptr %9, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 0, 2
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 2, 3, 0
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 3, 3, 1
  %15 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, i64 3, 4, 0
  %16 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %15, i64 1, 4, 1
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %18 = getelementptr double, ptr %17, i64 0
  store double 1.000000e+00, ptr %18, align 8
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %20 = getelementptr double, ptr %19, i64 1
  store double -2.000000e+00, ptr %20, align 8
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %22 = getelementptr double, ptr %21, i64 2
  store double 3.000000e+00, ptr %22, align 8
  %23 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %24 = getelementptr double, ptr %23, i64 3
  store double 1.000000e+00, ptr %24, align 8
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %26 = getelementptr double, ptr %25, i64 4
  store double -2.000000e+00, ptr %26, align 8
  %27 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %28 = getelementptr double, ptr %27, i64 5
  store double 3.000000e+00, ptr %28, align 8
  %29 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %30 = getelementptr double, ptr %29, i64 0
  %31 = load double, ptr %30, align 8
  %32 = fcmp ogt double %31, 0.000000e+00
  %33 = select i1 %32, double %31, double 0.000000e+00
  %34 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %35 = getelementptr double, ptr %34, i64 0
  store double %33, ptr %35, align 8
  %36 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %37 = getelementptr double, ptr %36, i64 1
  %38 = load double, ptr %37, align 8
  %39 = fcmp ogt double %38, 0.000000e+00
  %40 = select i1 %39, double %38, double 0.000000e+00
  %41 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %42 = getelementptr double, ptr %41, i64 1
  store double %40, ptr %42, align 8
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %44 = getelementptr double, ptr %43, i64 2
  %45 = load double, ptr %44, align 8
  %46 = fcmp ogt double %45, 0.000000e+00
  %47 = select i1 %46, double %45, double 0.000000e+00
  %48 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %49 = getelementptr double, ptr %48, i64 2
  store double %47, ptr %49, align 8
  %50 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %51 = getelementptr double, ptr %50, i64 3
  %52 = load double, ptr %51, align 8
  %53 = fcmp ogt double %52, 0.000000e+00
  %54 = select i1 %53, double %52, double 0.000000e+00
  %55 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %56 = getelementptr double, ptr %55, i64 3
  store double %54, ptr %56, align 8
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %58 = getelementptr double, ptr %57, i64 4
  %59 = load double, ptr %58, align 8
  %60 = fcmp ogt double %59, 0.000000e+00
  %61 = select i1 %60, double %59, double 0.000000e+00
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %63 = getelementptr double, ptr %62, i64 4
  store double %61, ptr %63, align 8
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %65 = getelementptr double, ptr %64, i64 5
  %66 = load double, ptr %65, align 8
  %67 = fcmp ogt double %66, 0.000000e+00
  %68 = select i1 %67, double %66, double 0.000000e+00
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %70 = getelementptr double, ptr %69, i64 5
  store double %68, ptr %70, align 8
  br label %71

71:                                               ; preds = %86, %0
  %72 = phi i64 [ 0, %0 ], [ %88, %86 ]
  %73 = icmp slt i64 %72, 2
  br i1 %73, label %74, label %89

74:                                               ; preds = %71
  br label %75

75:                                               ; preds = %78, %74
  %76 = phi i64 [ 0, %74 ], [ %85, %78 ]
  %77 = icmp slt i64 %76, 3
  br i1 %77, label %78, label %86

78:                                               ; preds = %75
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %80 = mul i64 %72, 3
  %81 = add i64 %80, %76
  %82 = getelementptr double, ptr %79, i64 %81
  %83 = load double, ptr %82, align 8
  %84 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %83)
  %85 = add i64 %76, 1
  br label %75

86:                                               ; preds = %75
  %87 = call i32 (ptr, ...) @printf(ptr @nl)
  %88 = add i64 %72, 1
  br label %71

89:                                               ; preds = %71
  %90 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 0
  call void @free(ptr %90)
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %91)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

