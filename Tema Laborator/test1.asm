.data
	s1: .asciz "abc"
	s2: .asciz "def"

	formatPrintf: .asciz "%s\n"

.text

.global main

main:
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



	