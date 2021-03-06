.data
	str: .space 1000
	val: .space 1000
	formatScanf: .asciz "%[^\n]s"
	formatPrintfS: .asciz "%s\n"
	formatPrintfN: .asciz "%d\n"
	nr: .space 4
	res: .space 4
 
	aux: .space 4
		
	chDelim: .asciz " "

.text

.global main

main:
	pushl $str
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $chDelim #apelez strtok
	pushl $str
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	jmp et_loop

et_loop:
	cmp $0, res
	je et_exit
	
	pushl res
	call atoi
	popl %ebx
	
	movl %eax, nr
	
	cmp $0, nr
	je et_text
	
	pushl nr

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	jmp et_loop

et_text:
	pushl res
	call strlen
	popl %ebx

	cmp $1, %eax
	je et_variabila

	jmp et_operator

et_variabila:
	xorl %ecx, %ecx
	xorl %eax, %eax
	movl res, %edi
	movb (%edi, %ecx, 1), %al
	subl $97, %eax

	movl %eax, %ecx
	movl $val, %edi
	movl (%edi, %ecx, 4), %ebx

	cmp $0, %ebx
	je et_gol

	pushl %ebx

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	jmp et_loop

et_gol:
	pushl %eax

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	jmp et_loop

et_operator:
	xorl %ecx, %ecx
	movl res, %edi
	movb (%edi, %ecx, 1), %al
	
	cmp $97, %al
	je et_add
	
	cmp $115, %al
	je et_sub
	
	cmp $109, %al
	je et_mul
	
	cmp $100, %al
	je et_div

	cmp $108, %al
	je et_let

et_let:
	popl %ebx
	popl %ecx
	movl $val, %edi
	movl %ebx, (%edi, %ecx, 4)

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	jmp et_loop

et_add:
	popl %ebx
	movl %ebx, aux
	popl %ebx
	addl %ebx, aux
	pushl aux

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	
	jmp et_loop

et_sub: 
	popl %ebx
	movl %ebx, aux
	popl %ebx
	sub aux, %ebx
	movl %ebx, aux
	pushl aux

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	
	jmp et_loop
	
et_mul:
	popl %ebx
	popl %eax
	xorl %edx, %edx
	
	imul %ebx
	movl %eax, aux
	pushl aux

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	
	jmp et_loop
	
et_div:
	popl %ebx
	popl %eax
	xorl %edx, %edx
	
	cdq
	idivl %ebx
	movl %eax, aux
	pushl aux

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res
	
	jmp et_loop

et_exit:
	pushl $formatPrintfN
	call printf
	popl %ebx
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
