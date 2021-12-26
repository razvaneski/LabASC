.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
	nrElem: .space 4
	i: .space 4
	aux: .space 4

	init: .space 1000
	perm: .space 1000

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
	movl $1, i
	movl perm, %edi // CHANGE TO INIT
	jmp et_citire_loop

et_citire_loop:
	movl i, %ecx

	pushl $aux
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl aux, %eax
	movl %eax, (%edi, %ecx, 4)

	addl $1, i
	cmp nrElem, i
	jle et_citire_loop

	popl %ebp
	ret

afisare:
	pushl %ebp
	movl %esp, %ebp

	movl $1, i
	movl perm, %edi
	jmp et_afisare_loop

et_afisare_loop:
	movl i, %ecx
	movl (%edi, %ecx, 4), %eax

	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	addl $1, i
	cmp nrElem, i
	jle et_afisare_loop

	popl %ebp
	ret

.global main

main:
	
	call citire
	call afisare

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
