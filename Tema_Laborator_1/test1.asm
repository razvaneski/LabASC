.data
	a: .long 15
	b: .long 15
	res: .space 4

	formatPrintf: .asciz "%d\n"

.text

.global main

main:
	xorl %edx, %edx
	movl a, %eax
	movl b, %ebx

	cdq
	idivl %ebx

	movl %eax, res

	pushl res
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

et_exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
