.data
	s1: .space 10
	formatScanf: .asciz "%[^\n]s"
	x: .space 4
	y: .space 4
	m: .asciz "nu e m\n"
	formatPrintf: .asciz "%s\n"
.text
.global main

main:
	pushl $s1
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	xorl %ecx, %ecx

	movl $s1, %edi
	movb (%edi, %ecx, 1), %al

	cmp $109, %al
	je exit

	pushl $m
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
