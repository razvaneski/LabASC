.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
.text

.global main

main:
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $m
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

et_exit:
	pushl n
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	pushl m
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	pushl $formatNewline
	call printf
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80