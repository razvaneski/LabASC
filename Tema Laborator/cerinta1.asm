.data
	formatScanf: .asciz "%s"
	formatPrintf: .asciz "%s\n"
	formatPrintfLinie: .asciz "%s"
	formatPrintfNr: .asciz "%d "
	endl: .asciz ""

	s16: .space 1000
	s2: .space 1000
	curr: .space 4
	prod: .space 4
	nr: .space 4

	val0: .asciz "0000"
	val1: .asciz "0001"
	val2: .asciz "0010"
	val3: .asciz "0011"
	val4: .asciz "0100"
	val5: .asciz "0101"
	val6: .asciz "0110"
	val7: .asciz "0111"
	val8: .asciz "1000"
	val9: .asciz "1001"
	valA: .asciz "1010" #10
	valB: .asciz "1011" #11
	valC: .asciz "1100" #12
	valD: .asciz "1101" #13
	valE: .asciz "1110" #14
	valF: .asciz "1111" #15

	text_div: .asciz "div "
	text_let: .asciz "let "
	text_add: .asciz "add "
	text_sub: .asciz "sub "
	text_mul: .asciz "mul "

	text_a: .asciz "a "
	text_b: .asciz "b "
	text_c: .asciz "c "
	text_d: .asciz "d "
	text_e: .asciz "e "
	text_f: .asciz "f "
	text_g: .asciz "g "
	text_h: .asciz "h "
	text_i: .asciz "i "
	text_j: .asciz "j "
	text_k: .asciz "k "
	text_l: .asciz "l "
	text_m: .asciz "m "
	text_n: .asciz "n "
	text_o: .asciz "o "
	text_p: .asciz "p "
	text_q: .asciz "q "
	text_r: .asciz "r "
	text_s: .asciz "s "
	text_t: .asciz "t "
	text_u: .asciz "u "
	text_v: .asciz "v "
	text_w: .asciz "w "
	text_x: .asciz "x "
	text_y: .asciz "y "
	text_z: .asciz "z "

.text

.global main

main:
	pushl $s16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	xorl %ecx, %ecx
	movl $s16, %edi

	jmp et_transf

et_transf:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je et_cont

	incl %ecx

	cmp $48, %al
	je et_0

	cmp $49, %al
	je et_1

	cmp $50, %al
	je et_2

	cmp $51, %al
	je et_3

	cmp $52, %al
	je et_4

	cmp $53, %al
	je et_5

	cmp $54, %al
	je et_6

	cmp $55, %al
	je et_7

	cmp $56, %al
	je et_8

	cmp $57, %al
	je et_9

	cmp $65, %al
	je et_A

	cmp $66, %al
	je et_B

	cmp $67, %al
	je et_C

	cmp $68, %al
	je et_D

	cmp $69, %al
	je et_E

	cmp $70, %al
	je et_F

et_0:
	pushl %ecx

	pushl $val0
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_1:
	pushl %ecx

	pushl $val1
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_2:
	pushl %ecx

	pushl $val2
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_3:
	pushl %ecx

	pushl $val3
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_4:
	pushl %ecx

	pushl $val4
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_5:
	pushl %ecx

	pushl $val5
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_6:
	pushl %ecx

	pushl $val6
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_7:
	pushl %ecx

	pushl $val7
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_8:
	pushl %ecx

	pushl $val8
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_9:
	pushl %ecx

	pushl $val9
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_A:
	pushl %ecx

	pushl $valA
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_B:
	pushl %ecx

	pushl $valB
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_C:
	pushl %ecx

	pushl $valC
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_D:
	pushl %ecx

	pushl $valD
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_E:
	pushl %ecx

	pushl $valE
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_F:
	pushl %ecx

	pushl $valF
	pushl $s2
	call strcat
	popl %ebx
	popl %ebx

	popl %ecx

	jmp et_transf

et_cont:
	movl $0, curr
	movl $s2, %edi

et_parcurgere:
	movl curr, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je exit

	addl $2, %ecx
	movb (%edi, %ecx, 1), %al

	cmp $49, %al
	je et_variabila

	movl curr, %ecx
	addl $1, %ecx
	movb (%edi, %ecx, 1), %al

	cmp $49, %al
	je et_operatie

	cmp $48, %al
	je et_intreg

	jmp et_parcurgere

et_variabila:
	movl curr, %ecx
	addl $12, %ecx
	movl $1, prod
	movl $0, nr

	jmp et_variabila_loop

	addl $12, curr
	jmp et_parcurgere

et_variabila_loop:
	subl $1, %ecx
	movl %ecx, %eax
	subl curr, %eax

	cmp $3, %eax
	je et_variabila_afisare

	pushl %edx

	xorl %edx, %edx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_variabila_adun
	
	xorl %edx, %edx
	movl prod, %eax
	movl $2, %ebx
	mul %ebx
	movl %eax, prod

	popl %edx
	jmp et_variabila_loop

et_variabila_adun:
	movl prod, %eax
	addl %eax, nr

	xorl %edx, %edx
	movl prod, %eax
	movl $2, %ebx
	mul %ebx
	movl %eax, prod

	popl %edx
	jmp et_variabila_loop

et_variabila_afisare:
	cmp $97, nr
	je et_afis_a

	cmp $98, nr
	je et_afis_b

	cmp $99, nr
	je et_afis_c

	cmp $100, nr
	je et_afis_d

	cmp $101, nr
	je et_afis_e

	cmp $102, nr
	je et_afis_f

	cmp $103, nr
	je et_afis_g

	cmp $104, nr
	je et_afis_h

	cmp $105, nr
	je et_afis_i

	cmp $106, nr
	je et_afis_j

	cmp $107, nr
	je et_afis_k

	cmp $108, nr
	je et_afis_l

	cmp $109, nr
	je et_afis_m

	cmp $110, nr
	je et_afis_n

	cmp $111, nr
	je et_afis_o

	cmp $112, nr
	je et_afis_p

	cmp $113, nr
	je et_afis_q

	cmp $114, nr
	je et_afis_r

	cmp $115, nr
	je et_afis_s

	cmp $116, nr
	je et_afis_t

	cmp $117, nr
	je et_afis_u

	cmp $118, nr
	je et_afis_v

	cmp $119, nr
	je et_afis_w

	cmp $120, nr
	je et_afis_x

	cmp $121, nr
	je et_afis_y

	cmp $122, nr
	je et_afis_z

	addl $12, curr
	jmp et_parcurgere

et_afis_a:

	pushl $text_a
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_b:

	pushl $text_b
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_c:

	pushl $text_c
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_d:

	pushl $text_d
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_e:

	pushl $text_e
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_f:

	pushl $text_f
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_g:

	pushl $text_g
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_h:

	pushl $text_h
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_i:

	pushl $text_i
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_j:

	pushl $text_j
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_k:

	pushl $text_k
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_l:

	pushl $text_l
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_m:

	pushl $text_m
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_n:

	pushl $text_n
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_o:

	pushl $text_o
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_p:

	pushl $text_p
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_q:

	pushl $text_q
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_r:

	pushl $text_r
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_s:

	pushl $text_s
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_t:

	pushl $text_t
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_u:

	pushl $text_u
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_v:

	pushl $text_v
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_w:

	pushl $text_w
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_x:

	pushl $text_x
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_y:

	pushl $text_y
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_afis_z:

	pushl $text_z
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_intreg:
	movl curr, %ecx
	addl $12, %ecx
	movl $1, prod
	movl $0, nr

	jmp et_intreg_loop

	addl $12, curr
	jmp et_parcurgere

et_intreg_loop:
	subl $1, %ecx
	movl %ecx, %eax
	subl curr, %eax

	cmp $3, %eax
	je et_intreg_afisare

	pushl %edx

	xorl %edx, %edx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_intreg_adun
	
	xorl %edx, %edx
	movl prod, %eax
	movl $2, %ebx
	mul %ebx
	movl %eax, prod

	popl %edx
	jmp et_intreg_loop

et_intreg_adun:
	movl prod, %eax
	addl %eax, nr

	xorl %edx, %edx
	movl prod, %eax
	movl $2, %ebx
	mul %ebx
	movl %eax, prod

	popl %edx
	jmp et_intreg_loop

et_intreg_afisare:
	movl curr, %ecx
	addl $3, %ecx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_intreg_minus

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx
	
	addl $12, curr
	jmp et_parcurgere

et_intreg_minus:
	pushl %edx
	xorl %edx, %edx

	movl nr, %eax
	imul $-1, %eax
	movl %eax, nr

	popl %edx

	pushl nr
	pushl $formatPrintfNr
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_operatie:
	movl curr, %ecx
	addl $9, %ecx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_div

	movl curr, %ecx
	addl $10, %ecx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_mul_sau_sub

	cmp $48, %al
	je et_add_sau_let

	addl $12, curr
	jmp et_parcurgere

et_div:
	pushl $text_div
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_mul_sau_sub:
	movl curr, %ecx
	addl $11, %ecx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_mul

	cmp $48, %al
	je et_sub

	addl $12, curr
	jmp et_parcurgere

et_mul:
	pushl $text_mul
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_sub:
	pushl $text_sub
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_add_sau_let:
	movl curr, %ecx
	addl $11, %ecx

	movb (%edi, %ecx, 1), %al
	cmp $49, %al
	je et_add

	cmp $48, %al
	je et_let

	addl $12, curr
	jmp et_parcurgere

et_add:
	pushl $text_add
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

et_let:
	pushl $text_let
	pushl $formatPrintfLinie
	call printf
	popl %ebx
	popl %ebx

	addl $12, curr
	jmp et_parcurgere

exit:
	pushl $endl
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
