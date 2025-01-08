; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"

declare i32 @printf(ptr, ...)

declare void @free(ptr)

declare ptr @malloc(i64)

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @const() {
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
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %21)
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %8
}

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
  %17 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 6) to i64))
  %18 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %17, 0
  %19 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %18, ptr %17, 1
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %19, i64 0, 2
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, i64 2, 3, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 3, 3, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 3, 4, 0
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 1, 4, 1
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %26 = getelementptr double, ptr %25, i64 0
  store double 1.000000e+00, ptr %26, align 8
  %27 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %28 = getelementptr double, ptr %27, i64 1
  store double 2.000000e+00, ptr %28, align 8
  %29 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %30 = getelementptr double, ptr %29, i64 2
  store double 3.000000e+00, ptr %30, align 8
  %31 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %32 = getelementptr double, ptr %31, i64 3
  store double 4.000000e+00, ptr %32, align 8
  %33 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %34 = getelementptr double, ptr %33, i64 4
  store double 5.000000e+00, ptr %34, align 8
  %35 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %36 = getelementptr double, ptr %35, i64 5
  store double 6.000000e+00, ptr %36, align 8
  %37 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %38 = getelementptr double, ptr %37, i64 0
  store double 1.000000e+00, ptr %38, align 8
  %39 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %40 = getelementptr double, ptr %39, i64 1
  store double 2.000000e+00, ptr %40, align 8
  %41 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %42 = getelementptr double, ptr %41, i64 2
  store double 3.000000e+00, ptr %42, align 8
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %44 = getelementptr double, ptr %43, i64 3
  store double 4.000000e+00, ptr %44, align 8
  %45 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %46 = getelementptr double, ptr %45, i64 4
  store double 5.000000e+00, ptr %46, align 8
  %47 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %48 = getelementptr double, ptr %47, i64 5
  store double 6.000000e+00, ptr %48, align 8
  br label %49

49:                                               ; preds = %73, %0
  %50 = phi i64 [ 0, %0 ], [ %74, %73 ]
  %51 = icmp slt i64 %50, 2
  br i1 %51, label %52, label %75

52:                                               ; preds = %49
  br label %53

53:                                               ; preds = %56, %52
  %54 = phi i64 [ 0, %52 ], [ %72, %56 ]
  %55 = icmp slt i64 %54, 3
  br i1 %55, label %56, label %73

56:                                               ; preds = %53
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %58 = mul i64 %50, 3
  %59 = add i64 %58, %54
  %60 = getelementptr double, ptr %57, i64 %59
  %61 = load double, ptr %60, align 8
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %63 = mul i64 %50, 3
  %64 = add i64 %63, %54
  %65 = getelementptr double, ptr %62, i64 %64
  %66 = load double, ptr %65, align 8
  %67 = fadd double %61, %66
  %68 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %69 = mul i64 %50, 3
  %70 = add i64 %69, %54
  %71 = getelementptr double, ptr %68, i64 %70
  store double %67, ptr %71, align 8
  %72 = add i64 %54, 1
  br label %53

73:                                               ; preds = %53
  %74 = add i64 %50, 1
  br label %49

75:                                               ; preds = %49
  br label %76

76:                                               ; preds = %91, %75
  %77 = phi i64 [ 0, %75 ], [ %93, %91 ]
  %78 = icmp slt i64 %77, 2
  br i1 %78, label %79, label %94

79:                                               ; preds = %76
  br label %80

80:                                               ; preds = %83, %79
  %81 = phi i64 [ 0, %79 ], [ %90, %83 ]
  %82 = icmp slt i64 %81, 3
  br i1 %82, label %83, label %91

83:                                               ; preds = %80
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %85 = mul i64 %77, 3
  %86 = add i64 %85, %81
  %87 = getelementptr double, ptr %84, i64 %86
  %88 = load double, ptr %87, align 8
  %89 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %88)
  %90 = add i64 %81, 1
  br label %80

91:                                               ; preds = %80
  %92 = call i32 (ptr, ...) @printf(ptr @nl)
  %93 = add i64 %77, 1
  br label %76

94:                                               ; preds = %76
  %95 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 0
  call void @free(ptr %95)
  %96 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 0
  call void @free(ptr %96)
  %97 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %97)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

