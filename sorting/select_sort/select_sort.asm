; This asm program implements select sort algorithm
; Author: Wanxuan Li
; Date: 2022-10-30

	global _start

	section .data
Arr	db 3, 2, 5, 4, 6, 7, 2, 9
Arr_len	equ $ - Arr

	section .bss
output 	resb 30
out_len	equ 30

	section .text
_start:
	mov rdx, Arr
	; select sort begin
	xor r8, r8	; int i = 0
s_LP1:
	cmp r8, (Arr_len - 1)
	jnl cont
	mov r10, r8	; r10 = smallest index = i
	lea r9, [r8 + 1]	; int j = i + 1
s_LP2:
	cmp r9, Arr_len
	jnl s_LP2_end
	mov al, byte[rdx + r9]	; al = Arr[j]
	cmp al, byte[rdx + r10]
	jnl s_cont1
	mov r10, r9
s_cont1:
	inc r9
	jmp s_LP2
s_LP2_end:
	cmp r10, r8
	je s_cont2
	mov al, byte[rdx + r8]
	push rax
	mov al, byte[rdx + r10]
	mov byte[rdx + r8], al
	pop rax
	mov byte[rdx + r10], al
s_cont2:
	inc r8
	jmp s_LP1
cont:
	xor r8, r8
	mov rdi, output
o_LP:
	cmp r8, Arr_len
	jnl print
	mov r9b, byte[rdx + r8]
	add r9b, 0x30
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