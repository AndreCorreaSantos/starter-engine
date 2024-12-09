
declare i32 @printf(i8*, i32)
declare i32 @scanf(i8*, i32*, i32*)

define i32 @pow(i32 %x, i32 %y) {
start:
    br label %loop_start

loop_start:
    %i = phi i32 [0, %start], [%i.next, %loop]
    %r = phi i32 [1, %start], [%r.next, %loop]
    %done = icmp eq i32 %i, %y
    br i1 %done, label %exit, label %loop

loop:
    %r.next = mul i32 %r, %x
    %i.next = add i32 %i, 1
    br label %loop_start

exit:
    ret i32 %r
}

define i32 @main() {
start:
    ; Allocate variables for inputs
    %x_ptr = alloca i32
    %y_ptr = alloca i32

    ; Prepare the format string for scanf: "%d %d"
    %fmt_ptr = alloca [5 x i8]
    store [5 x i8] c"%d %d", [5 x i8]* %fmt_ptr
    %fmt = getelementptr [5 x i8], [5 x i8]* %fmt_ptr, i32 0, i32 0

    ; Call scanf to read two integers into x_ptr and y_ptr
    call i32 @scanf(i8* %fmt, i32* %x_ptr, i32* %y_ptr)

    ; Load the values read by scanf
    %x = load i32, i32* %x_ptr
    %y = load i32, i32* %y_ptr

    %r = call i32 @pow(i32 %x, i32 %y)

    ; Allocate space to hold %r's value
    %r_ptr = alloca i32
    store i32 %r, i32* %r_ptr

    ; Cast to i8* for the write call
    %byte_ptr = bitcast i32* %r_ptr to i8*

    ; Get the format string pointer
    %fmt.2 = getelementptr [2 x i8], [2 x i8]* @format_string, i32 0, i32 0

    ; Call printf to print the result
    call i32 @printf(i8* %fmt.2, i32 %r)

    ret i32 0
}

@format_string = constant [2 x i8] c"%d"
