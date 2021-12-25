.data
	v: .space 1000
	s: .space 1000
	curr: .space 1000
	nr: .space 4

	val: .space 4
	pos: .space 4

	a: .space 4
	b: .space 4

	chDelim: .asciz " "
	formatScanf: .asciz "%[^\n]s"
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"
.text

.globl main

main:
	pushl $s
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $chDelim
	pushl $s
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, curr
	jmp et_parcurgere

et_parcurgere:
	cmp $0, curr
	je exit

	pushl curr
	call atoi
	popl %ebx

	movl %eax, nr

	cmp $0, nr
	je et_caracter

	pushl nr

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, curr

	jmp et_parcurgere

et_caracter:
	pushl curr
	call strlen
	popl %ebx

	cmp $1, %eax
	je et_litera #continui cu expresie daca nu e litera

	movl curr, %edi
	xorl %ecx, %ecx

	movb (%edi, %ecx, 1), %al

	cmp $108, %al
	je et_let

	cmp $97, %al
	je et_add

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, curr

	jmp et_parcurgere

et_add:
	popl %ebx
	movl %ebx, b

	cmp $0, b
	jl et_add_b_minus

et_cont_add_b:
	popl %ebx
	movl %ebx, a

	cmp $0, a
	jl et_add_a_minus

et_cont_add_a:
	movl a, %eax
	addl b, %eax

	pushl %eax

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, curr

	jmp et_parcurgere

et_add_b_minus:
	movl b, %eax
	xorl %edx, %edx
	movl $-1, %ebx
	imul %ebx
	subl $97, %eax

	pushl %eax
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	movl %eax, %ecx
	movl $v, %edi
	movl (%edi, %ecx, 4), %eax
	movl %eax, b

	pushl %eax
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	jmp et_cont_add_b

et_add_a_minus:
	jmp et_cont_add_a

et_let:
	popl %ebx
	movl %ebx, val

	popl %eax
	movl $-1, %ebx
	xorl %edx, %edx
	imul %ebx
	subl $97, %eax
	movl %eax, pos

	movl pos, %ecx
	movl $v, %edi
	movl val, %ebx
	movl %ebx, (%edi, %ecx, 4)

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, curr

	jmp et_parcurgere

et_litera:
	xorl %ecx, %ecx
	xorl %eax, %eax
	movl curr, %edi
	movb (%edi, %ecx, 1), %al

	xorl %edx, %edx
	movl $-1, %ebx
	imul %ebx

	pushl %eax

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, curr

	jmp et_parcurgere

exit:
	movl $23, %ecx
	movl $v, %edi
	movl (%edi, %ecx, 4),
	pushl %eax
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
