.data
	formatScanf: .asciz "%s"

	chDelim: .asciz " "
	str: .space 1000
	res: .space 4
	nr: .space 4
	formatPrintf: .asciz "%s\n"
	formatPrintfNr: .asciz "%d\n"
	formatPrintfCh: .asciz "%c\n"

	x: .space 4
	y: .space 4
	rezultat: .space 4

	a: .asciz "add"
	s: .asciz "sub"
	m: .asciz "mul"
	d: .asciz "div"

	aux: .space 4

.text

.global main

main:
	pushl $str
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl str
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80

