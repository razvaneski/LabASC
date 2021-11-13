.data
	s1: .space 1000
	s2: .space 1000

	formatPrintf: .asciz "%s\n"
	formatScanf: .asciz "%s"

.text

.global main

main:
	pushl $s1
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $s2
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $s2
	pushl $s1
	call strcat
	popl %ebx
	popl %ebx

	pushl $s1
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80



	