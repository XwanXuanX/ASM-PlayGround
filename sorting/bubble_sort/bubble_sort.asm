; This asm program implements bubble sort algorithm
; Author: Wanxuan Li
; Date: 2022-10-29

	global _start

	section .data
Arr	db 2, 1, 4, 3, 6, 4, 8
Arr_len	equ $ - Arr
Zero	equ 0x30

	section .bss
output	resb 20
out_len	equ 20

	section .text
_start:
	mov rdx, Arr
	; Bubble sort algorithm
	mov r8, (Arr_len - 2)	; int i = sizeof(Arr) / sizeof(byte) - 2
b_LP1:
	cmp r8, 0
	jl cont1
	xor r9, r9	; int j = 0
b_LP2:
	cmp r9, r8
	jg b_LP2_end
	mov r10b, [rdx + r9]		; arr[j]
	cmp r10b, byte[rdx + r9 + 1]	; arr[j + 1]
	jng b_cont
	push r10
	mov r10b, byte[rdx + r9 + 1]
	mov byte[rdx + r9], r10b	; arr[j] = arr[j + 1]
	pop r10
	mov byte[rdx + r9 + 1], r10b	; arr[j + 1] = arr[j]
b_cont:
	inc r9
	jmp b_LP2
b_LP2_end:
	dec r8
	jmp b_LP1
cont1:
	xor r8, r8		; i = 0
	mov rdi, output
o_LP:
	cmp r8, Arr_len
	je print
	mov r9b, byte[rdx + r8]
	add r9, Zero
	mov byte[rdi], r9b
	inc rdi
	mov byte[rdi], 32
	inc rdi
	inc r8
	jmp o_LP
print:
	mov byte[rdi], 10
	mov rax, 1
	mov rdi, rax
	mov rsi, output
	mov rdx, out_len
	syscall
	; Terminate safely
	mov rax, 60
	xor rdi, rdi
	syscall
	ret