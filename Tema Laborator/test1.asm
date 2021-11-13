.data
	s: .asciz "01001"
	formatPrintf: .asciz "%d\n"
	x: .space 4
	doi: .long 2
	y: .space 4
.text

.global main

main:
	pushl $2
	pushl $doi
	pushl $s
	call strtol
	popl %ebx
	popl %ebx
	popl %ebx

	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80



	