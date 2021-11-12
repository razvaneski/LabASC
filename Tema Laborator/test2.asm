.data
	s1: .space 40
	formatScanf: .asciz "%s"
	x: .space 4
	y: .space 4
	m: .asciz "m"
	formatPrintf: .asciz "%c\n"
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
	movl (%edi, %ecx, 1), %al
	movl %al, x

	cmp $109, %al
	je exit

	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
