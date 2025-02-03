; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%d \00"

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i64 2) to i64))
  %2 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4, i64 1, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5, i64 1, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %6, i64 1, 3, 2
  %8 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %7, i64 2, 3, 3
  %9 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %8, i64 2, 4, 0
  %10 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %9, i64 2, 4, 1
  %11 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %10, i64 2, 4, 2
  %12 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %11, i64 1, 4, 3
  %13 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %12, 1
  %14 = getelementptr i32, ptr %13, i64 0
  store i32 -1, ptr %14, align 4
  %15 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %12, 1
  %16 = getelementptr i32, ptr %15, i64 1
  store i32 2, ptr %16, align 4
  %17 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i64 2) to i64))
  %18 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } undef, ptr %17, 0
  %19 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %18, ptr %17, 1
  %20 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %19, i64 0, 2
  %21 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %20, i64 1, 3, 0
  %22 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %21, i64 1, 3, 1
  %23 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %22, i64 1, 3, 2
  %24 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %23, i64 2, 3, 3
  %25 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %24, i64 2, 4, 0
  %26 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %25, i64 2, 4, 1
  %27 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %26, i64 2, 4, 2
  %28 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %27, i64 1, 4, 3
  %29 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %12, 1
  %30 = getelementptr i32, ptr %29, i64 0
  %31 = load i32, ptr %30, align 4
  %32 = icmp sgt i32 %31, 0
  %33 = select i1 %32, i32 %31, i32 0
  %34 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %28, 1
  %35 = getelementptr i32, ptr %34, i64 0
  store i32 %33, ptr %35, align 4
  %36 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %12, 1
  %37 = getelementptr i32, ptr %36, i64 1
  %38 = load i32, ptr %37, align 4
  %39 = icmp sgt i32 %38, 0
  %40 = select i1 %39, i32 %38, i32 0
  %41 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %28, 1
  %42 = getelementptr i32, ptr %41, i64 1
  store i32 %40, ptr %42, align 4
  br label %43

43:                                               ; preds = %76, %0
  %44 = phi i64 [ 0, %0 ], [ %78, %76 ]
  %45 = icmp slt i64 %44, 1
  br i1 %45, label %46, label %79

46:                                               ; preds = %43
  br label %47

47:                                               ; preds = %73, %46
  %48 = phi i64 [ 0, %46 ], [ %75, %73 ]
  %49 = icmp slt i64 %48, 1
  br i1 %49, label %50, label %76

50:                                               ; preds = %47
  br label %51

51:                                               ; preds = %70, %50
  %52 = phi i64 [ 0, %50 ], [ %72, %70 ]
  %53 = icmp slt i64 %52, 1
  br i1 %53, label %54, label %73

54:                                               ; preds = %51
  br label %55

55:                                               ; preds = %58, %54
  %56 = phi i64 [ 0, %54 ], [ %69, %58 ]
  %57 = icmp slt i64 %56, 2
  br i1 %57, label %58, label %70

58:                                               ; preds = %55
  %59 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %28, 1
  %60 = mul i64 %44, 2
  %61 = mul i64 %48, 2
  %62 = add i64 %60, %61
  %63 = mul i64 %52, 2
  %64 = add i64 %62, %63
  %65 = add i64 %64, %56
  %66 = getelementptr i32, ptr %59, i64 %65
  %67 = load i32, ptr %66, align 4
  %68 = call i32 (ptr, ...) @printf(ptr @frmt_spec, i32 %67)
  %69 = add i64 %56, 1
  br label %55

70:                                               ; preds = %55
  %71 = call i32 (ptr, ...) @printf(ptr @nl)
  %72 = add i64 %52, 1
  br label %51

73:                                               ; preds = %51
  %74 = call i32 (ptr, ...) @printf(ptr @nl)
  %75 = add i64 %48, 1
  br label %47

76:                                               ; preds = %47
  %77 = call i32 (ptr, ...) @printf(ptr @nl)
  %78 = add i64 %44, 1
  br label %43

79:                                               ; preds = %43
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

