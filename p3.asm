.data
  n: .space 4
  v: .space 80
  doi: .long 2
  elemCurent: .space 4
  sum: .long 0

  formatScanf: .asciz "%d"
  formatPrintf: .asciz "suma este %d"
.text

.global main

main:
  pushl $n
  pushl $formatScanf
  call scanf
  popl %ebx
  popl %ebx

  movl $v, %edi
  xorl %ecx, %ecx

et_for:
  cmp n, %ecx
  je exit

  pushl %ecx

  pushl $elemCurent
  pushl $formatScanf
  call scanf
  popl %ebx
  popl %ebx

  popl %ecx

  movl elemCurent, %ebx
  movl %ebx, (%edi, %ecx, 4)

  movl (%edi, %ecx, 4), %eax
  xorl %edx, %edx
  divl doi

  cmp $0, %edx
  je este_par

cont:
  incl %ecx
  jmp et_for

este_par:
  movl (%edi, %ecx, 4), %ebx
  addl %ebx, sum
  jmp cont


exit:
  pushl sum
  pushl $formatPrintf
  call printf
  popl %ebx
  popl %ebx

  movl $1, %eax
  xorl %ebx, %ebx
  int $0x80
