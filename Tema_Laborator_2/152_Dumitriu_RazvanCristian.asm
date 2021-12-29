.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
	nrElem: .space 4
	i: .space 4
	x: .space 4
	aux: .space 4
	curr: .space 4

	perm: .zero 1000 # permutarea finala - vom stoca elementele fixate cu minus
	f: .zero 1000 # vector frecventa

.text

backslashN:
	pushl %ebp
	movl %esp, %ebp

	pushl $formatNewline
	call printf
	popl %ebx

	popl %ebp
	ret

readproc:
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
	lea f, %esi # intelegem pe parcursul programului %esi ~ f si %edi ~ perm
	lea perm, %edi

	jmp readproc_loop

readproc_loop:
	pushl $aux
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl aux, %eax
	xorl %edx, %edx
	movl $-1, %ebx
	imull %ebx
	movl i, %ecx
	movl %eax, (%edi, %ecx, 4) # perm[i] = -aux

	incl i
	movl i, %eax
	cmp nrElem, %eax
	jle readproc_loop

	popl %ebp
	ret

printproc:
	pushl %ebp
	movl %esp, %ebp

	movl $1, i
	movl $perm, %edi
	jmp printproc_loop

printproc_loop:
	movl i, %ecx
	movl (%edi, %ecx, 4), %eax

	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	incl i
	movl i, %eax
	cmp nrElem, %eax
	jle printproc_loop

	call backslashN
	popl %ebp
	ret

bkt:
	pushl %ebp
	movl %esp, %ebp

	movl $1, i
	movl $perm, %edi
	movl i, %ecx

	movl (%edi, %ecx, 4), %eax
	movl %eax, curr

.global main

main:
	call readproc
	call printproc
	call backslashN
	jmp exit

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
