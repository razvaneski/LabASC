# Gasiti o explicatie detaliata a algoritmului, cat si o versiune recursiva in C aici:
# https://github.com/razvaneski/LabASC/blob/a0db3dc0af74c288791ce0b4ca1d4bc6e3c316c5/Tema_Laborator_2/algoritm.c

.data
	formatPrintf: .asciz "%d "
	formatNewline: .asciz "\n"
	formatScanf: .asciz "%d"

	n: .space 4
	m: .space 4
	nrElem: .space 4
	i: .space 4
	j: .space 4
	x: .space 4
	aux: .space 4
	curr: .space 4
	cnt: .space 4
	ok: .space 4
	poz: .space 4
	elem: .space 4

	perm: .zero 1000 # permutarea finala - vom stoca elementele fixate cu minus
	f: .zero 1000 # vector frecventa

.text

backslashN: # procedura pentru a afisa '\n'
	pushl %ebp
	movl %esp, %ebp

	pushl $formatNewline
	call printf
	popl %ebx

	popl %ebp
	ret

readproc: # procedura de citire
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

	movl aux, %ecx
	incl (%esi, %ecx, 4) # f[aux] += 1

	incl i
	movl i, %eax
	cmp nrElem, %eax
	jle readproc_loop

	popl %ebp
	ret

printproc: # procedura de afisare; se face inmultire cu -1 pt elementele negative
	pushl %ebp
	movl %esp, %ebp

	movl $1, i
	movl $perm, %edi
	jmp printproc_loop

printproc_loop:
	movl i, %ecx
	movl (%edi, %ecx, 4), %eax

	cmp $0, %eax
	jl printproc_negativ

	jmp printproc_continue

printproc_negativ:
	movl $-1, %ebx
	xorl %edx, %edx
	imull %ebx

printproc_continue:
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

check_elem: # verifica daca i este unic pe intervalul [j - m, j + m]
			# parametri: prin variabila i - valoarea care trebuie verificata
			#			 prin variabila j - pozitia unde trebuie sa testam
			# returneaza 0/1 prin %eax
	pushl %ebp
	movl %esp, %ebp

	movl $1, cnt
	movl $1, ok

check_left: # verificare pe intervalul [j - m, j)
	movl cnt, %eax
	cmp m, %eax
	jg check_next

	movl j, %eax
	subl cnt, %eax
	movl %eax, poz

	cmp $1, %eax
	jl check_next

	movl poz, %ecx
	movl (%edi, %ecx, 4), %eax

	movl i, %ebx

	cmp %eax, %ebx
	je check_fail

	movl $-1, %ecx
	xorl %edx, %edx
	imull %ecx

	cmp %eax, %ebx
	je check_fail

	incl cnt
	jmp check_left

check_next:
	movl $1, cnt
	jmp check_right

check_right: # verificare pe intervalul (j, j + m]
	movl cnt, %eax
	cmp m, %eax
	jg check_pass

	movl j, %eax
	addl cnt, %eax
	movl %eax, poz

	cmp nrElem, %eax
	jg check_pass

	movl poz, %ecx
	movl (%edi, %ecx, 4), %eax

	movl i, %ebx

	cmp %eax, %ebx
	je check_fail

	movl $-1, %ecx
	xorl %edx, %edx
	imull %ecx

	cmp %eax, %ebx

	je check_fail

	incl cnt
	jmp check_right

check_fail:
	movl $0, %eax
	popl %ebp
	ret

check_pass:
	movl $1, %eax
	popl %ebp
	ret

check_all: # verifica unicitatea elementelor, conform cerintei, pentru tot vectorul
		   # prin apelarea procedurii check_elem
	pushl %ebp
	movl %esp, %ebp

	movl $1, j

check_all_loop:
	movl j, %eax
	cmp nrElem, %eax
	jg check_all_pass

	movl j, %ecx
	movl (%edi, %ecx, 4), %eax
	movl %eax, i

	call check_elem
	cmp $0, %eax
	je check_all_fail

	incl j
	jmp check_all_loop

check_all_pass:
	movl $1, %eax
	popl %ebp
	ret

check_all_fail:
	movl $0, %eax
	popl %ebp
	ret

bkt_init: # vom returna 0 prin %eax, in cazul in care constatam ca nu exista solutie
	pushl %ebp
	movl %esp, %ebp

	movl $1, curr
	movl $perm, %edi
	movl $f, %esi
	jmp bkt

bkt:
	movl curr, %eax
	cmp nrElem, %eax
	jg bkt_exit

	movl curr, %ecx
	movl (%edi, %ecx, 4), %eax

	cmp $0, %eax
	jl bkt_skip

	movl %eax, i
	incl i # i = perm[curr] + 1
	decl (%esi, %eax, 4) # f[perm[curr]] -= 1
	movl $0, (%edi, %ecx, 4) # perm[curr] = 0
	movl $0, elem

	jmp bkt_loop

bkt_loop:
	movl i, %eax
	cmp n, %eax
	jg bkt_back

	movl elem, %eax
	cmp $0, %eax
	jne bkt_next

	movl i, %ecx
	movl (%esi, %ecx, 4), %eax
	cmp $3, %eax
	jl bkt_loop_check

	incl i
	jmp bkt_loop

bkt_loop_check:
	movl curr, %eax
	movl %eax, j

	call check_elem

	cmp $1, %eax
	je bkt_found

	incl i
	jmp bkt_loop

bkt_found:
	movl i, %eax
	movl %eax, elem
	jmp bkt_loop

bkt_skip: # curr += 1, bkt(curr)
	incl curr
	jmp bkt

bkt_next: # perm[curr] = elem, curr += 1
	movl curr, %ecx
	movl elem, %eax
	movl %eax, (%edi, %ecx, 4) # perm[curr] = elem

	movl elem, %ecx
	incl (%esi, %ecx, 4) # f[perm[curr]] += 1
	incl curr
	jmp bkt

bkt_back: # mergem inapoi in perm pana cand gasim primul element ne-fixat (adica >= 0)
	decl curr

	movl curr, %eax
	cmp $1, %eax
	jl bkt_impossible

	movl curr, %ecx
	movl (%edi, %ecx, 4), %eax

	cmp $0, %eax # daca perm[curr] < 0, mergem mai in spate
	jl bkt_back

	jmp bkt

bkt_exit:
	movl $1, %eax
	popl %ebp
	ret

bkt_impossible:
	movl $0, %eax
	popl %ebp
	ret


.global main

main:
	call readproc
	call bkt_init

	cmp $0, %eax
	je impossible_test

	call check_all

	cmp $0, %eax
	je impossible_test

	call printproc

	call backslashN
	jmp exit

impossible_test:
	pushl $-1
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	call backslashN
	jmp exit

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

