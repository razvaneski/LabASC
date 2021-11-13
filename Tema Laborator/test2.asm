.data
	s1: .space 10
	res: .space 10
	chDelim: .asciz " "
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

	pushl $chDelim
	pushl $s1
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res

	xorl %ecx, %ecx
	movl res, %edi
	movb (%edi, %ecx, 1), %al

	cmp $109, %al
	je exit

	pushl res
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
