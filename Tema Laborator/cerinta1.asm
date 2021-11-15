.data
	formatScanf: .asciz "%s"
	formatPrintf: .asciz "%s\n"

	s16: .space 1000
	s2: .space 1000
	curr: .space 4

	val0: .asciz "0000"
	val1: .asciz "0001"
	val2: .asciz "0010"
	val3: .asciz "0011"
	val4: .asciz "0100"
	val5: .asciz "0101"
	val6: .asciz "0110"
	val7: .asciz "0111"
	val8: .asciz "1000"
	val9: .asciz "1001"
	valA: .asciz "1010" #10
	valB: .asciz "1011" #11
	valC: .asciz "1100" #12
	valD: .asciz "1101" #13
	valE: .asciz "1110" #14
	valF: .asciz "1111" #15

	text_div: .asciz "div "

.text

.global main

main:
	pushl $s16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	xorl %ecx, %ecx
	movl $s16, %edi

	jmp et_transf

et_transf:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je et_cont

	incl %ecx

	cmp $48, %al
	je et_0

	cmp $49, %al
	je et_1

	cmp $50, %al
	je et_2

	cmp $51, %al
	je et_3

	cmp $52, %al
	je et_4

	cmp $53, %al
	je et_5

	cmp $54, %al
	je et_6

	cmp $55, %al
	je et_7

	cmp $56, %al
	je et_8

	cmp $57, %al
	je et_9

	cmp $65, %al
	je et_A

	cmp $66, %al
	je et_B

	cmp $67, %al
	je et_C

	cmp $68, %al
	je et_D

	cmp $69, %al
	je et_E

	cmp $70, %al
	je et_F

et_0:
	pushl %ecx

	pushl $val0
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_1:
	pushl %ecx

	pushl $val1
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_2:
	pushl %ecx

	pushl $val2
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_3:
	pushl %ecx

	pushl $val3
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_4:
	pushl %ecx

	pushl $val4
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_5:
	pushl %ecx

	pushl $val5
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_6:
	pushl %ecx

	pushl $val6
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_7:
	pushl %ecx

	pushl $val7
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_8:
	pushl %ecx

	pushl $val8
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_9:
	pushl %ecx

	pushl $val9
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_A:
	pushl %ecx

	pushl $valA
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_B:
	pushl %ecx

	pushl $valB
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_C:
	pushl %ecx

	pushl $valC
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_D:
	pushl %ecx

	pushl $valD
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_E:
	pushl %ecx

	pushl $valE
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_F:
	pushl %ecx

	pushl $valF
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_cont:
	movl $0, curr
	movl $s2, %edi

et_parcurgere:
	movl curr, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je exit

	addl $2, %ecx
	movb (%edi, %ecx, 1), %al

	cmp $49, %al
	je et_variabila

	movl curr, %ecx
	addl $1, %ecx
	movb (%edi, %ecx, 1), %al

	cmp $49, %al
	je et_operatie

	cmp $48, %al
	je et_intreg

	jmp et_parcurgere

et_variabila:
	addl $12, curr
	jmp et_parcurgere

et_operatie:
	movl curr, %ecx
	addl $9, %ecx

	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je et_div

et_div:
	pushl $text_div
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_intreg:
	addl $12, curr
	jmp et_parcurgere

exit:
	pushl $s2
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
