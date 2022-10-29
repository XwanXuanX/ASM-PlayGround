; This asm program outputs the pascal triangle to the console
; Author: Wanxuan Li
; Date: 2022-10-29

	global _start

	section .data
Zero	equ 0x30
Side	equ 5

	section .bss
Arr_2D	resb (Side * Side)
Arr_len	equ $ - Arr_2D
output 	resb 100
out_len	equ 100

	section .text
_start:
	; Initialize all array entry to be 1
	mov rdx, Arr_2D
	xor r8, r8
LP:
	cmp r8, Arr_len
	je cont1
	mov byte[rdx + r8], 0d01
	inc r8
	jmp LP
cont1:
	mov r8, 2	; row counter
s_LP1:
	cmp r8, Side
	je cont2
	mov r9, 1	; col counter
s_LP2:
	cmp r9, r8
	je s_LP2_end
	mov r10, r8
	imul r10, Side
	add r10, r9
	push r10
	lea r10, [r8 - 1]
	imul r10, Side
	add r10, r9
	mov r11b, [rdx + r10]
	lea r10, [r8 - 1]
	imul r10, Side
	add r10, r9
	add r11b, [rdx + r10 - 1]
	pop r10
	mov byte[rdx + r10], r11b
	inc r9
	jmp s_LP2
s_LP2_end:
	inc r8
	jmp s_LP1
cont2:
	xor r8, r8	; row counter
	mov rdi, output
p_LP1:
	cmp r8, Side
	je Print
	xor r9, r9	; col counter
p_LP2:
	cmp r9, r8
	jg p_LP2_end
	mov r10, r8
	imul r10, Side
	add r10, r9
	mov r11b, [rdx + r10]
	add r11b, Zero
	mov byte[rdi], r11b
	inc rdi
	mov byte[rdi], 0x20
	inc rdi
	inc r9
	jmp p_LP2
p_LP2_end:
	mov byte[rdi], 10
	inc rdi
	inc r8
	jmp p_LP1
Print:
	mov rax, 1
	mov rdi, rax
	mov rsi, output
	mov rdx, out_len
	syscall
	; safely exit
	mov rax, 60
	xor rdi, rdi
	syscall
	ret