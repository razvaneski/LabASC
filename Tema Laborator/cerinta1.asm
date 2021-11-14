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

et_loop:
	
