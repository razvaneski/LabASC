.data
	s: .asciz "11"
	x: .space 4
	formatPrintf: .asciz "%d\n"
.text
.global main

main:
	pushl $s
	call atoi
	popl %ebx

	movl %eax, x

	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80