.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
	nrElem: .space 4
	i: .space 4
	aux: .space 4
	curr: .space 4
	elem: .space 4

	init: .space 1000 # vectorul initial
	perm: .space 1000 # permutarea finala
	f: .space 1000 # vector frecventa

.text

backslashN:
	pushl %ebp
	movl %esp, %ebp

	pushl $formatNewline
	call printf
	popl %ebx

	popl %ebp
	ret

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
	movl $perm, %edi
	movl $init, %esi
	jmp et_citire_loop

et_citire_loop:
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
	jle et_citire_loop

	popl %ebp
	ret

afisare:
	pushl %ebp
	movl %esp, %ebp

	movl $1, i
	movl $perm, %edi
	jmp et_afisare_loop

et_afisare_loop:
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
	jle et_afisare_loop

	call backslashN
	popl %ebp
	ret

bkt:
	pushl %ebp
	movl %esp, %ebp

	movl $1, curr
	jmp bkt_loop

bkt_loop:
	movl $init, %edi
	movl curr, %ecx
	movl (%edi, %ecx, 4), %eax

	cmp $0, %eax
	jne bkt_skip

	movl $perm, %edi
	movl curr, %ecx
	movl (%edi, %ecx, 4), %eax
	movl %eax, i # i = perm[curr]
	movl $0, (%edi, %ecx, 4) # perm[curr] = 0

	movl $f, %edi
	movl i, %ecx
	movl (%edi, %ecx, 4), %eax
	subl $1, %eax
	movl %eax, (%edi, %ecx, 4) # f[perm[curr] (initial)] -= 1

	addl $1, i # i = perm[curr] (initial) + 1

	movl $0, elem
	jmp bkt_search

bkt_search:
	movl i, %eax
	cmp n, %eax
	jg bkt_go_back

	movl elem, %eax
	cmp $0, %eax
	jne bkt_add

	movl $f, %edi
	movl i, %ecx
	movl (%edi, %ecx, 4), %eax # eax = f[i]

	cmp $3, %eax
	jge bkt_search_next


bkt_next:
	incl curr # REMOVE

	movl curr, %eax
	cmp nrElem, %eax
	jle bkt_loop

	popl %ebp
	ret

bkt_skip:
	incl curr
	jmp bkt_next

bkt_search_next:
	incl i
	jmp bkt_search


.global main

main:
	call citire
	call bkt
	call afisare
	jmp et_exit

et_exit:
	pushl nrElem
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	call backslashN

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
