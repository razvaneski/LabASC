.data
	formatScanf: .asciz "%s"

	chDelim: .asciz " "
	str: .space 100 # VERIFICA DIMENSIUNEA
	res: .space 4
	nr: .space 4
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"

	x: .space 4
	y: .space 4
	rezultat: .space 4

	a: .asciz "a"
	s: .asciz "s"
	m: .asciz "m"
	d: .asciz "d"

.text

.global main

main:
	pushl $str
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

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

	cmp $0, nr
	je et_loop

	pushl nr
	jmp et_loop

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

