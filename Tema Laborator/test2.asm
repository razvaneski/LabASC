.data
	a: .long 4
	b: .long -1
	formatPrintf: .asciz "%d\n"
.text

.global main

main:
	movl a, %eax

	xorl %edx, %edx
	imul b, %eax
	movl %eax, b

	pushl b
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

