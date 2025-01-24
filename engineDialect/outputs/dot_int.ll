; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%d \00"

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i64 3) to i64))
  %2 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 1, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 1, 4, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 1, 4, 1
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %10 = getelementptr i32, ptr %9, i64 0
  store i32 1, ptr %10, align 4
  %11 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %12 = getelementptr i32, ptr %11, i64 1
  store i32 2, ptr %12, align 4
  %13 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %14 = getelementptr i32, ptr %13, i64 2
  store i32 3, ptr %14, align 4
  %15 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i64 1) to i64))
  %16 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %15, 0
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %16, ptr %15, 1
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, i64 0, 2
  %19 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, i64 1, 3, 0
  %20 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %19, i64 1, 4, 0
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 1
  %22 = getelementptr i32, ptr %21, i64 0
  store i32 2, ptr %22, align 4
  %23 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i64 3) to i64))
  %24 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %23, 0
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %24, ptr %23, 1
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, i64 0, 2
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, i64 3, 3, 0
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 1, 4, 0
  %29 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %30 = getelementptr i32, ptr %29, i64 0
  store i32 0, ptr %30, align 4
  %31 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %32 = getelementptr i32, ptr %31, i64 1
  store i32 0, ptr %32, align 4
  %33 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %34 = getelementptr i32, ptr %33, i64 2
  store i32 0, ptr %34, align 4
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
  %45 = getelementptr i32, ptr %43, i64 %44
  %46 = load i32, ptr %45, align 4
  %47 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 1
  %48 = getelementptr i32, ptr %47, i64 %40
  %49 = load i32, ptr %48, align 4
  %50 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %51 = getelementptr i32, ptr %50, i64 %36
  %52 = load i32, ptr %51, align 4
  %53 = mul i32 %46, %49
  %54 = add i32 %52, %53
  %55 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 1
  %56 = getelementptr i32, ptr %55, i64 %36
  store i32 %54, ptr %56, align 4
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
  %66 = getelementptr i32, ptr %65, i64 %62
  %67 = load i32, ptr %66, align 4
  %68 = call i32 (ptr, ...) @printf(ptr @frmt_spec, i32 %67)
  %69 = add i64 %62, 1
  br label %61

70:                                               ; preds = %61
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

