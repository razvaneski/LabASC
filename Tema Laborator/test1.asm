.data
	chDelim: .asciz " "
	str: .asciz "2 10 mul 5 add 7 6 mul sub"
	res: .space 4
	nr: .space 4
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"
	formatPrintfCh: .asciz "%c\n"

	x: .space 4
	y: .space 4
	rezultat: .space 4

	a: .asciz "add"
	s: .asciz "sub"
	m: .asciz "mul"
	d: .asciz "div"

	aux: .space 4

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
	je et_operator

	pushl nr
	jmp et_loop

et_mul:
	pushl res
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	popl %ebx
	movl %ebx, x
	popl %ebx
	add x, %ebx
	pushl %ebx
	
	je et_loop

et_operator:
	movl $res, %edi
	xorl %ecx, %ecx
	movb (%edi, %ecx, 4), %al
	mov %al, aux


	pushl $aux
	pushl $formatPrintfCh
	call printf
	popl %ebx
	popl %ebx

	cmp $109, %al
	je et_mul

	jmp exit

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

	jmp et_loop

exit:
	popl %ebx
	movl %ebx, rezultat

	pushl rezultat
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80

