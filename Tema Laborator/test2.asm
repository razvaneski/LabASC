.data
	s1: .asciz "mul"
	s2: .asciz "mul"
	x: .space 4
	formatPrintf: .asciz "%d\n"
.text
.global main

main:
	mov s1, %eax
	mov s2, %ebx
	call strcmp

	movl %ecx, x

	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
