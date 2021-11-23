.data
	formatScanfNr: .asciz "%d"
	formatScanfText: .asciz "%s"

	formatPrintfNr: .asciz "%d "
	formatPrintfText: .asciz "%s\n"
	formatNewline: .asciz "\n"

	mat: .space 10000
	n: .space 4
	m: .space 4
	nrElem: .space 4
	cnt: .space 4
	x: .space 4
	s: .space 400
	curr: .space 4
	start: .space 4
	ind: .space 4

.text

.global main

main:
	pushl $s
	pushl $formatScanfText
	call scanf
	popl %ebx
	popl %ebx

	pushl $n
	pushl $formatScanfNr
	call scanf
	popl %ebx
	popl %ebx

	pushl $m
	pushl $formatScanfNr
	call scanf
	popl %ebx
	popl %ebx

	xorl %edx, %edx
	movl n, %eax
	movl m, %ebx
	mul %ebx
	movl %eax, nrElem
	movl $0, cnt

et_read:
	movl cnt, %eax
	cmp %eax, nrElem
	je et_op

	pushl $x
	pushl $formatScanfNr
	call scanf
	popl %ebx
	popl %ebx

	movl $mat, %edi
	movl cnt, %ecx
	movl x, %eax
	movl %eax, (%edi, %ecx, 4)

	incl cnt
	jmp et_read

et_op:
	pushl $s
	pushl $formatScanfText
	call scanf
	popl %ebx
	popl %ebx

	pushl $x
	pushl $formatScanfNr
	call scanf
	popl %ebx
	popl %ebx

	pushl $s
	pushl $formatScanfText
	call scanf
	popl %ebx
	popl %ebx

	movl $s, %edi
	xorl %ecx, %ecx
	movb (%edi, %ecx, 1), %al

	cmp $97, %al
	je et_add

	cmp $115, %al
	je et_sub

	cmp $109, %al
	je et_mul

	cmp $100, %al
	je et_div

	cmp $114, %al
	je et_rot90

	jmp et_exit

et_add:
	movl $mat, %edi
	xorl %ecx, %ecx	

et_add_loop:
	cmp %ecx, nrElem
	je et_print

	movl x, %eax

	addl %eax, (%edi, %ecx, 4)
	incl %ecx
	jmp et_add_loop

et_sub:
	movl $mat, %edi
	xorl %ecx, %ecx	

et_sub_loop:
	cmp %ecx, nrElem
	je et_print
	
	movl x, %eax

	subl %eax, (%edi, %ecx, 4)
	incl %ecx
	jmp et_sub_loop

et_mul:
	movl $mat, %edi
	xorl %ecx, %ecx

et_mul_loop:
	cmp %ecx, nrElem
	je et_print

	movl x, %ebx
	movl (%edi, %ecx, 4), %eax

	xorl %edx, %edx
	imul %ebx

	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	jmp et_mul_loop

et_div:
	movl $mat, %edi
	xorl %ecx, %ecx

et_div_loop:
	cmp %ecx, nrElem
	je et_print

	movl x, %ebx
	movl (%edi, %ecx, 4), %eax
	movl $0, %edx
	cdq
	idivl %ebx

	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	jmp et_div_loop

et_rot90:
	movl $mat, %edi
	xorl %ecx, %ecx

	movl nrElem, %eax
	subl m, %eax

	movl %eax, start
	movl $1, curr

et_rot90_loop:
	movl curr, %eax
	cmp m, %eax
	jg et_exit

	movl nrElem, %eax
	subl m, %eax
	addl curr, %eax
	movl %eax, start

	et_parcurg:
		cmp $0, start
		jle et_cont

		movl start, %ecx
		movl $mat, %edi
		movl (%edi, %ecx, 4), %eax

		pushl %eax
		pushl $formatPrintf
		call printf
		popl %ebx
		popl %ebx

		movl start, %eax
		subl m, %eax
		movl %eax, start

	et_cont:
		incl curr
		jmp et_rot90_loop

et_print:
	movl $0, curr

	pushl n
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	pushl m
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	jmp et_print_loop

et_print_loop:
	movl curr, %eax
	cmp %eax, nrElem
	je et_exit

	movl $mat, %edi
	movl curr, %ecx
	movl (%edi, %ecx, 4), %eax

	pushl %eax
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	incl curr
	jmp et_print_loop


et_exit:
	pushl $formatNewline
	call printf
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

	