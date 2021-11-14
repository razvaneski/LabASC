.data
	formatScanf: .asciz "%s"
	formatPrintf: .asciz "%s\n"

	s16: .space 1000
	s2: .space 1000

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

.text

.global main

main:
	pushl $s16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	xorl %ecx, %ecx
	movl s16, %edi

et_transf:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je exit

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
	pushl $val0
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

et_1:
et_2:
et_3:
et_4:
et_5:
et_6:
et_7:
et_8:
et_9:
et_A:
et_B:
et_C:
et_D:
et_E:
et_F:

exit:
	pushl $s2
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
