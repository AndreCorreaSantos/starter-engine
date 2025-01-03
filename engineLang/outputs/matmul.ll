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
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 9) to i64))
  %2 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 3, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 3, 4, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 1, 4, 1
  %9 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %9, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, ptr %9, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 0, 2
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1, 3, 0
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 3, 3, 1
  %15 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, i64 3, 4, 0
  %16 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %15, i64 1, 4, 1
  %17 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 3) to i64))
  %18 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %17, 0
  %19 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %18, ptr %17, 1
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %19, i64 0, 2
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, i64 3, 3, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 1, 3, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 1, 4, 0
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
  %31 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %32 = getelementptr double, ptr %31, i64 0
  store double 1.000000e+00, ptr %32, align 8
  %33 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %34 = getelementptr double, ptr %33, i64 1
  store double 2.000000e+00, ptr %34, align 8
  %35 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %36 = getelementptr double, ptr %35, i64 2
  store double 3.000000e+00, ptr %36, align 8
  br label %37

37:                                               ; preds = %72, %0
  %38 = phi i64 [ 0, %0 ], [ %73, %72 ]
  %39 = icmp slt i64 %38, 3
  br i1 %39, label %40, label %74

40:                                               ; preds = %37
  br label %41

41:                                               ; preds = %70, %40
  %42 = phi i64 [ 0, %40 ], [ %71, %70 ]
  %43 = icmp slt i64 %42, 3
  br i1 %43, label %44, label %72

44:                                               ; preds = %41
  br label %45

45:                                               ; preds = %48, %44
  %46 = phi i64 [ 0, %44 ], [ %69, %48 ]
  %47 = icmp slt i64 %46, 1
  br i1 %47, label %48, label %70

48:                                               ; preds = %45
  %49 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %50 = add i64 %38, %46
  %51 = getelementptr double, ptr %49, i64 %50
  %52 = load double, ptr %51, align 8
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %54 = mul i64 %46, 3
  %55 = add i64 %54, %42
  %56 = getelementptr double, ptr %53, i64 %55
  %57 = load double, ptr %56, align 8
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %59 = mul i64 %38, 3
  %60 = add i64 %59, %42
  %61 = getelementptr double, ptr %58, i64 %60
  %62 = load double, ptr %61, align 8
  %63 = fmul double %52, %57
  %64 = fadd double %62, %63
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %66 = mul i64 %38, 3
  %67 = add i64 %66, %42
  %68 = getelementptr double, ptr %65, i64 %67
  store double %64, ptr %68, align 8
  %69 = add i64 %46, 1
  br label %45

70:                                               ; preds = %45
  %71 = add i64 %42, 1
  br label %41

72:                                               ; preds = %41
  %73 = add i64 %38, 1
  br label %37

74:                                               ; preds = %37
  br label %75

75:                                               ; preds = %90, %74
  %76 = phi i64 [ 0, %74 ], [ %92, %90 ]
  %77 = icmp slt i64 %76, 3
  br i1 %77, label %78, label %93

78:                                               ; preds = %75
  br label %79

79:                                               ; preds = %82, %78
  %80 = phi i64 [ 0, %78 ], [ %89, %82 ]
  %81 = icmp slt i64 %80, 3
  br i1 %81, label %82, label %90

82:                                               ; preds = %79
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %84 = mul i64 %76, 3
  %85 = add i64 %84, %80
  %86 = getelementptr double, ptr %83, i64 %85
  %87 = load double, ptr %86, align 8
  %88 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %87)
  %89 = add i64 %80, 1
  br label %79

90:                                               ; preds = %79
  %91 = call i32 (ptr, ...) @printf(ptr @nl)
  %92 = add i64 %76, 1
  br label %75

93:                                               ; preds = %75
  %94 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 0
  call void @free(ptr %94)
  %95 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 0
  call void @free(ptr %95)
  %96 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %96)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

