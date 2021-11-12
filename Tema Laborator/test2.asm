.data
	s1: .asciz "mul"
	s2: .asciz "m"
	da: .asciz "da\n"
	x: .space 4
	formatPrintf: .asciz "%c\n"
.text
.global main

main:
	movl $s1, %edi
	xorl %ecx, %ecx

	movl (%edi, %ecx, 4), %eax
	movl %eax, x

	movl $s2, %ebx
	cmp $x, %ebx
	jne exit

	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
