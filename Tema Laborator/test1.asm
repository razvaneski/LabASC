# 2 10 add 5 add 7 6 add add

.data
	formatScanf: .asciz "%[^\n]s"

	chDelim: .asciz " "
	str: .space 1000
	res: .space 4
	nr: .space 4
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"

	x: .space 4
	y: .space 4
	rezultat: .space 4

	a: .asciz "add"
	s: .asciz "sub"
	m: .asciz "mul"
	d: .asciz "div"

.text

.global main

main:
	pushl $str # citesc expresia
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $chDelim # ii aplic strtok
	pushl $str
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res

	pushl res # transform rezultatul in numar
	call atoi
	popl %ebx

	movl %eax, nr

	cmp $0, nr # daca nu e numar, inseamna ca e operator
	je et_operator

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	jmp et_loop

et_operator:
	movl res, %edi

	movb (%edi, %ecx, 1), %al

	cmp $61, %al
	je et_loop

	pushl res
	pushl $formatPrintf
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

	cmp $0, nr
	je et_operator

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

