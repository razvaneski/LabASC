.data
	s: .asciz "111 "
	x: .space 4
	formatPrintf: .asciz "%d\n"
.text
.global main

main:
	pushl $s
	call atoi
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80