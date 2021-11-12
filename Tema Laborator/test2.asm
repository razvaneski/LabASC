.data
	s1: .asciz "mul"
	da: .asciz "da\n"
	x: .space 4
	y: .space 4
	m: .asciz "m"
	formatPrintf: .asciz "%c\n"
.text
.global main

main:
	xorl %ecx, %ecx

	movl $s1, %edi
	movl (%edi, %ecx, 4), %eax
	movl %eax, x

	movl $m, %edi
	movl (%edi, %ecx, 4), %eax
	movl %eax, y

	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	pushl y
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
