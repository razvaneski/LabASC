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
	je exit
	
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
	pushl res
	pushl $formatPrintfS
	call printf
	popl %ebx
	popl %ebx
	jmp et_exit

et_operator:
	jmp et_loop

et_exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80