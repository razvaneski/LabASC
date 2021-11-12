.data
  v: .long 10, 20, 30, 40
  i: .long 0
  aux: .space 4
  formatPrintf: .asciz "%d\n"
.text

.global main

main:
	lea v, %edi
	movl $1, %ecx

	movl (%edi, %ecx, 4), %edx
	movl %edx, aux

	pushl aux
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80