.data
	chDelim: .asciz " "
	str: .asciz "2 10 mul 5 div 7 6 sub add"
	res: .space 4
	multiplu: .asciz "mul"
	formatPrintf: .asciz "%s\n"
.text

.global main

main:
	pushl $chDelim
	pushl $str
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res
	pushl res
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

et_loop:
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res

	cmp $0, res
	je exit

	movl %eax, res
	cmp $multiplu, $res
	je printt

	jmp et_loop

printt:
	pushl res
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	jmp et_loop

exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80


