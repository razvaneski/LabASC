.data
	s1: .asciz "mul"
	s2: .asciz "muf"
	da: .asciz "da\n"
	x: .space 4
	formatPrintf: .asciz "%d\n"
.text
.global main

main:
	movl $s1, %edi
	xorl %ecx, %ecx

	movl (%edi, %ecx, 4), %eax
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
