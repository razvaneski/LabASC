.data
	s1: .asciz "mul"
	s2: .asciz "muf"
	da: .asciz "da\n"
	x: .space 4
	formatPrintf: .asciz "%d\n"
.text
.global main

main:
	movl s1, %eax
	movl s2, %ebx

	cmp %eax, %ebx
	jne exit

print:
	pushl $da
	call printf
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
