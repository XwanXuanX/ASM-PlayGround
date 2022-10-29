; This asm program implements insertion sort algorithm
; Author: Wanxuan Li
; Date: 2022-10-29

	global _start

	section .data
Arr	db 2, 4, 3, 6, 1, 7, 4, 6
Arr_len	equ $ - Arr
Zero	equ 0x30

	section .bss
output	resb 30
out_len	equ 30

	section .text
_start:
	mov rdx, Arr
	; insertion sort begin
	mov r8, 1	; int i = 1 (Arr[0] is already sorted)
i_LP1:
	cmp r8, Arr_len
	je cont
	mov al, byte[rdx + r8]	; al = key
	lea r9, [r8 - 1]	; int j = i - 1
i_LP2:
	cmp r9, 0
	jl i_LP2_end
	mov r10b, byte[rdx + r9]	; Arr[j]
	cmp r10b, al
	jng i_LP2_end
	mov byte[rdx + r9 + 1], r10b	; Arr[j + 1] = Arr[j]
	dec r9
	jmp i_LP2
i_LP2_end:
	mov byte[rdx + r9 + 1], al
	inc r8
	jmp i_LP1
cont:
	xor r8, r8
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
	; Ternimate safely
	mov rax, 60
	xor rdi, rdi
	syscall
	ret