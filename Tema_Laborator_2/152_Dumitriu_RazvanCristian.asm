.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
	nrElem: .space 4
	i: .space 4

	init: .space 1000

.text

citire:
	pushl %ebp
	movl %esp, %ebp

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

	xorl %edx, %edx
	movl $3, %ebx
	movl n, %eax
	mull %ebx

	movl %eax, nrElem

	popl %ebp
	ret

.global main

main:
	pushl $101
	call citire
	popl %eax
	movl %eax, nrElem

et_exit:
	pushl nrElem
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
