.data
	chDelim: .asciz " "
	str: .asciz "2 10 add 5 add 7 6 add add"
	res: .space 4
	nr: .space 4
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"

	x: .space 4
	y: .space 4

	a: .asciz "add"
	s: .asciz "sub"
	m: .asciz "mul"
	d: .asciz "div"

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

	cmp $0, nr
	je operator

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	pushl nr

operator:
	popl %ebx
	movl %ebx, x
	popl %ebx
	movl %ebx, y

	movl nr, %eax

	movl a, %ebx
	cmp %eax, %ebx
	je et_add

	movl s, %ebx
	cmp %eax, %ebx
	je et_sub

	movl m, %ebx
	cmp %eax, %ebx
	je et_mul

	movl d, %ebx
	cmp %eax, %ebx
	je et_div

	jmp et_loop

et_add:
	movl x, %eax
	movl y, %ebx
	add %ebx, %eax

	pushl %eax
	je et_loop

et_sub:
	movl x, %eax
	movl y, %ebx
	sub %ebx, %eax

	pushl %eax
	je et_loop

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
	je operator

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	pushl nr

	jmp et_loop

exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80

