; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

define { ptr, ptr, i64, [1 x i64], [1 x i64] } @sqrt() {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (float, ptr null, i64 3) to i64))
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 3, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0
  %7 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (float, ptr null, i64 3) to i64))
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %7, 0
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, ptr %7, 1
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 0, 2
  %11 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, i64 3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %11, i64 1, 4, 0
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %14 = getelementptr float, ptr %13, i64 0
  store float 1.000000e+00, ptr %14, align 4
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %16 = getelementptr float, ptr %15, i64 1
  store float 2.000000e+00, ptr %16, align 4
  %17 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %18 = getelementptr float, ptr %17, i64 2
  store float 3.000000e+00, ptr %18, align 4
  %19 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %20 = getelementptr float, ptr %19, i64 0
  store float 1.000000e+00, ptr %20, align 4
  %21 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %22 = getelementptr float, ptr %21, i64 1
  store float 2.000000e+00, ptr %22, align 4
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %24 = getelementptr float, ptr %23, i64 2
  store float 3.000000e+00, ptr %24, align 4
  %25 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (float, ptr null, i64 3) to i64))
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %25, 0
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, ptr %25, 1
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 0, 2
  %29 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, i64 3, 3, 0
  %30 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, i64 1, 4, 0
  br label %31

31:                                               ; preds = %34, %0
  %32 = phi i64 [ %44, %34 ], [ 0, %0 ]
  %33 = icmp slt i64 %32, 3
  br i1 %33, label %34, label %45

34:                                               ; preds = %31
  %35 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, 1
  %36 = getelementptr float, ptr %35, i64 %32
  %37 = load float, ptr %36, align 4
  %38 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, 1
  %39 = getelementptr float, ptr %38, i64 %32
  %40 = load float, ptr %39, align 4
  %41 = fadd float %37, %40
  %42 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 1
  %43 = getelementptr float, ptr %42, i64 %32
  store float %41, ptr %43, align 4
  %44 = add i64 %32, 1
  br label %31

45:                                               ; preds = %31
  ret { ptr, ptr, i64, [1 x i64], [1 x i64] } %30
}

define void @main() {
  %1 = call { ptr, ptr, i64, [1 x i64], [1 x i64] } @sqrt()
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
