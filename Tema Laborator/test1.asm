.data
	chDelim: .asciz " "
	str: .asciz "2 10 mul 5 div 7 6 sub add"
	res: .space 4
	formatPrintf: .asciz "%s\n"
.text

.global main

main:
	pushl $chDelim
	pushl $str
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res
	pushl res
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80


