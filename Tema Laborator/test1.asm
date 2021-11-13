.data
	c: .asciz "a"
	formatPrintf: .asciz "%s\n"
	x: .space 4
	y: .space 4
.text

.global main

main:
	movl c, %eax

	subl $97, %eax
	movl %eax, x

	cmp $0, $x
	je exit

	pushl $x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80



	