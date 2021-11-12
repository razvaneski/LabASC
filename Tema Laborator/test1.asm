.data
	chDelim: .asciz " "
	str: .asciz "2 10 mul 5 div 7 6 sub add"
	res: .space 4
	nr: .space 4
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"

	x: .space 4
	y: .space 4

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
	call atoi
	popl %ebx

	movl %eax, nr

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

et_loop:
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res

	cmp $0, res
	je exit


	pushl res
	call atoi
	popl %ebx

	movl %eax, nr

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	jmp et_loop

exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80

