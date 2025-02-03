; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i64 10) to i64))
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 10, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0
  %7 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %8 = getelementptr i32, ptr %7, i64 0
  store i32 -2, ptr %8, align 4
  %9 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %10 = getelementptr i32, ptr %9, i64 1
  store i32 3, ptr %10, align 4
  %11 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %12 = getelementptr i32, ptr %11, i64 2
  store i32 1, ptr %12, align 4
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %14 = getelementptr i32, ptr %13, i64 3
  store i32 -1, ptr %14, align 4
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %16 = getelementptr i32, ptr %15, i64 4
  store i32 -1, ptr %16, align 4
  %17 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %18 = getelementptr i32, ptr %17, i64 5
  store i32 1, ptr %18, align 4
  %19 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %20 = getelementptr i32, ptr %19, i64 6
  store i32 0, ptr %20, align 4
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %22 = getelementptr i32, ptr %21, i64 7
  store i32 0, ptr %22, align 4
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %24 = getelementptr i32, ptr %23, i64 8
  store i32 -1, ptr %24, align 4
  %25 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %26 = getelementptr i32, ptr %25, i64 9
  store i32 0, ptr %26, align 4
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

