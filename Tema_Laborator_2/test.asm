.data
	vf: .space 201
	v: .space 801
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%s\n"
	semnafis: .asciz "-"
	prn: .asciz "%d "
	fscanf: .asciz "%d %d "
	randnou: .asciz "\n"
	qwert: .asciz "-1"
	indexSb2: .long 0
	suma: .long 0
	x: .space 4
	y: .space 4
	n: .space 4
	m: .space 4
	nr: .space 4
	q: .long -1
.text

.globl main

verificare:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ecx
	movl (%edi, %ecx, 4), %eax
	movl %eax, x
	xorl %eax, %eax
	
for_verificare_plus:
	incl %ecx
	cmp nr, %ecx
	jg inainte
	
	pushl %eax
	pushl %ebx
	movl (%edi, %ecx, 4), %eax
	cmp x, %eax
	je isnt_ok
	movl q, %ebx
	imul %ebx
	cmp x, %eax
	je isnt_ok
	popl %ebx
	popl %eax
	
	incl %eax
	cmp m, %eax
	jl for_verificare_plus

inainte:
	xorl %eax, %eax
	movl 8(%ebp), %ecx
	
for_verificare_minus:
	pushl %ebx
	pushl %ebx
	decl %ecx
	cmp $1, %ecx
	jl is_ok
	popl %ebx
	popl %ebx
	
	pushl %eax
	pushl %ebx
	movl (%edi, %ecx, 4), %eax
	cmp x, %eax
	je isnt_ok
	movl q, %ebx
	imul %ebx
	cmp x, %eax
	je isnt_ok
	popl %ebx
	popl %eax
	
	incl %eax
	cmp m, %eax
	jl for_verificare_minus
	
	pushl %eax
	pushl %ebx
is_ok:
	popl %ebx
	popl %eax
	movl $1, %eax
	popl %ebp
	ret
isnt_ok:
	popl %ebx
	popl %eax
	xorl %eax, %eax
	popl %ebp
	ret


bkt:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ecx
	movl (%edi, %ecx, 4), %eax 
	
	
	pushl %ebx
	cmp $0, %eax
	jl urmatorul
	
	
	// elementul curent in vector
	incl (%esi, %eax, 4) 
	// crestem aparitiilr posibile
	movl %eax, %ebx
	
diferit_de_0:
	incl %ebx 
	// urm val pt pozitia data
	movl %ebx, y
	movl (%esi, %ebx, 4), %eax
	cmp n, %ebx
	jg aia_e
	cmp $0, %eax
	jg ver
	jmp diferit_de_0
	

aia_e: // inseamna ca dam inapoi
	movl $0, %eax
	movl %eax, (%edi, %ecx, 4)
	movl %ecx, %eax
	decl %eax
	movl (%edi, %eax, 4), %ecx
	cmp $0, %ecx
	jl aia_e2
	popl %ebx
	popl %ebp
	ret
	
aia_e2:
	cmp $0, %eax
	je aia_e3
	decl %eax
	movl (%edi, %eax, 4), %ecx
	cmp $0, %ecx
	jl aia_e2
	popl %ebx
	popl %ebp
	ret
	
aia_e3:
	movl $-1, %eax
	popl %ebx
	popl %ebp
	ret
ver:
	movl y, %eax
	movl %eax, (%edi, %ecx, 4)
	decl (%esi, %eax, 4)
	pushl %ecx
	pushl %ebx
	pushl %ecx
	call verificare
	popl %ebx
	popl %ebx
	popl %ecx
	
	cmp $1, %eax
	je urmatorul
	jmp repeta
	
urmatorul:
	incl %ecx
	movl %ecx, %eax
	popl %ebx
	popl %ebp
	ret
	
repeta:
	movl %ecx, %eax
	popl %ebx
	popl %ebp
	ret
main:

citire:
	pushl $m
	pushl $n
	pushl $fscanf
	call scanf
	popl %ebx 
	popl %ebx
	
	movl n, %eax
	addl n, %eax
	addl n, %eax
	movl %eax, nr
	
	xorl %ecx, %ecx
	lea vf, %esi
	lea v, %edi
	
for_initializare:
	movl $3, (%esi, %ecx, 4)
	inc %ecx
	cmp n, %ecx
	jle for_initializare
	
	xorl %ecx, %ecx
	incl %ecx
	
for_citire:
	pushl %ecx
	pushl $x
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popl %ecx
	
	movl x, %eax		
	movl %eax, (%edi, %ecx, 4)
	movl (%edi, %ecx, 4), %ebx
	movl (%esi, %ebx, 4), %eax
	dec %eax 
	movl %eax, (%esi, %ebx, 4)
	
	movl x, %eax
	movl $-1, %ebx
	imul %ebx
	movl %eax, (%edi, %ecx, 4)
	
	inc %ecx
	cmp nr, %ecx
	jle for_citire
	
	 xorl %ecx, %ecx
	inc %ecx
	movl $1, %eax
	

	

exit:
	pushl %eax
	call bkt
	popl %ebx
	xorl %ecx, %ecx
	inc %ecx
	pushl %eax
for_afisare1:
	pushl %ecx
	pushl (%edi, %ecx, 4)
	pushl $prn
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	incl %ecx
	cmp nr, %ecx
	jle for_afisare1

	pushl $prn
	call printf
	popl %ebx
	
	pushl $randnou
	call printf
	popl %ebx
	
	popl %eax
	
	cmp $-1, %eax
	je nu_merge
	
	cmp nr, %eax
	jle exit
	
	jmp iesire
	

	/*pushl $2
	call bkt
	popl %ebx
	pushl %eax
	pushl $prn
	call printf
	popl %ebx
	popl %ebx
	
	pushl $2
	call bkt
	popl %ebx
	pushl %eax
	pushl $prn
	call printf
	popl %ebx
	popl %ebx*/

nu_merge:
	pushl $qwert
	call printf
	pop %ebx	
	
iesire:
	pushl $randnou
	call printf
	popl %ebx
	mov $0, %ebx
	mov $1, %eax
	int $0x80
