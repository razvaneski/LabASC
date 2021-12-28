.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
	nrElem: .space 4
	i: .space 4
	x: .space 4

	init: .zero 1000 # vectorul initial
	perm: .zero 1000 # permutarea finala
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
	movl $perm, %edi
	movl $init, %esi
	jmp readproc_loop

readproc_loop:
	pushl $aux
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl aux, %eax
	movl i, %ecx
	movl $init, %esi
	movl %eax, (%edi, %ecx, 4) # perm[i] = aux
	movl %eax, (%esi, %ecx, 4) # init[i] = aux

	movl aux, %ecx
	movl $f, %esi
	movl (%esi, %ecx, 4), %eax
	incl %eax
	movl %eax, (%esi, %ecx, 4) # f[aux] += 1

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

checkperm:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ecx
	movl (%edi, %ecx, 4), %eax
	movl %eax, x

	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	popl %ebp
	ret


.global main

main:
	pushl $5
	call checkperm
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
