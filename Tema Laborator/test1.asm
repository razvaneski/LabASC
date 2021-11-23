.data
	str: .asciz "0101010"
	formatPrintf: .asciz "%c\n"
	formatPrintfNr: .asciz "%d\n"
	aux: .space 4
.text

.global main

main:
	xorl %ecx, %ecx
	xorl %eax, %eax
	addl $1, %ecx
	movl $str, %edi
	movb (%edi, %ecx, 1), %al

	movl %eax, aux

	pushl aux
	call atoi
	popl %ebx

	movl %eax, aux

	pushl aux
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
