.data
	str: .space 1000
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
	pushl $str #citire sir
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
	
	pushl res #transform in int
	call atoi
	popl %ebx
	
	movl %eax, nr
	pushl nr #incarc stiva cu primul numar
	
	jmp et_loop

et_operator:
	
	xorl %ecx, %ecx
	movl res, %edi
	movb (%edi, %ecx, 1), %al
	
	cmp $97, %al
	je et_add
	
	pushl res
	pushl $formatPrintfS
	call printf
	popl %ebx
	popl %ebx
	
	jmp et_loop

et_add:
	popl %ebx
	movl %ebx, aux
	popl %ebx
	add %ebx, aux
	pushl aux
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
	
	cmp $0, nr
	je et_operator
	
	pushl nr
	jmp et_loop

exit:
	popl %ebx
	movl %ebx, nr
	
	pushl nr
	pushl $formatPrintfN
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
