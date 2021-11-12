.data
	str: .asciz "2 10 mul 5 div 7 6 sub add"
	chDelim: .asciz " "
	formatPrintf: .asciz "%s\n"
	res: .space 4 
	res2: .space 4
.text

.global main

main:
	pushl $chDelim
	pushl $str
	call strtok 
	popl %ebx
	popl %ebx
	
	movl %eax, res
	
	pushl res				# este deja un pointer
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
et_for:
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx 
	
	cmp $0, %eax
	je exit
	
	movl %eax, res

	pushl %eax
	pushl %ecx
	pushl %edx

	pushl res
	call atoi
	popl %ebx

	movl %eax, res2

	popl %edx
	popl %ecx
	popl %eax
	
	pushl res2				# este deja un pointer
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	jmp et_for	

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80