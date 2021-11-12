.data
  v: .long 10, 20, 30, 40
  i: .long 0
  aux: .space 4
  formatPrintf: .asciz "%d\n"
.text

.global main

main:
	movl $v, %edi
	movl $i, %ecx

	movl %edi, %eax
	movl %eax, aux

	pushl aux
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80