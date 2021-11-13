.data
	s1: .asciz "mul"
	formatScanf: .asciz "%s"
	x: .space 4
	y: .space 4
	m: .asciz "m"
	formatPrintf: .asciz "%c\n"
.text
.global main

main:

	xorl %ecx, %ecx

	movl $s1, %edi
	movb (%edi, %ecx, 1), %al

	cmp $109, %al
	je exit

	pushl m
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
