; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nl = internal constant [2 x i8] c"\0A\00"
@frmt_spec = internal constant [4 x i8] c"%f \00"
@my_tensor = private global [2 x [2 x double]] zeroinitializer

declare void @free(ptr)

declare i32 @printf(ptr, ...)

declare ptr @malloc(i64)

define void @main() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 4) to i64))
  %2 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 2, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 2, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 2, 4, 0
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
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 3, 0
  %18 = mul i64 1, %17
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 3, 1
  %20 = mul i64 %18, %19
  %21 = mul i64 %20, ptrtoint (ptr getelementptr (double, ptr null, i32 1) to i64)
  %22 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 1
  %23 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 2
  %24 = getelementptr double, ptr %22, i64 %23
  call void @llvm.memcpy.p0.p0.i64(ptr @my_tensor, ptr %24, i64 %21, i1 false)
  br label %25

25:                                               ; preds = %39, %0
  %26 = phi i64 [ 0, %0 ], [ %41, %39 ]
  %27 = icmp slt i64 %26, 2
  br i1 %27, label %28, label %42

28:                                               ; preds = %25
  br label %29

29:                                               ; preds = %32, %28
  %30 = phi i64 [ 0, %28 ], [ %38, %32 ]
  %31 = icmp slt i64 %30, 2
  br i1 %31, label %32, label %39

32:                                               ; preds = %29
  %33 = mul i64 %26, 2
  %34 = add i64 %33, %30
  %35 = getelementptr double, ptr @my_tensor, i64 %34
  %36 = load double, ptr %35, align 8
  %37 = call i32 (ptr, ...) @printf(ptr @frmt_spec, double %36)
  %38 = add i64 %30, 1
  br label %29

39:                                               ; preds = %29
  %40 = call i32 (ptr, ...) @printf(ptr @nl)
  %41 = add i64 %26, 1
  br label %25

42:                                               ; preds = %25
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, 0
  call void @free(ptr %43)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}

