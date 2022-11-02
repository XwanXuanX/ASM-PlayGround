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
Select_Sort:
	;function prologue
	sub rsp, 8	; make room for a 8bytes local var
	push rbx
	push rbp
	push r12
	push r13
	; function body
	lea rbx, [rsi - 1]	; Arr_len - 1
	mov [rsp + 32], rbx
	xor rbx, rbx	; int i = 0
s_LP1:
	cmp rbx, [rsp + 32]
	jnl s_epilogue
	mov r12, rbx	; assume r12 is the smallest
	lea rbp, [rbx + 1]	; int j = i + 1
s_LP2:
	cmp rbp, rsi
	jnl s_LP2_end
	mov r13b, byte[rdi + rbp]
	cmp r13b, byte[rdi + r12]
	jnl s_cont1
	mov r12, rbp	; update smallest index
s_cont1:
	inc rbp
	jmp s_LP2
s_LP2_end:
	cmp r12, rbx
	je s_cont2
	mov r13b, byte[rdi + rbx]
	push r13
	mov r13b, byte[rdi + r12]
	mov byte[rdi + rbx], r13b
	pop r13
	mov byte[rdi + r12], r13b
s_cont2:
	inc rbx
	jmp s_LP1
s_epilogue:
	pop r13
	pop r12
	pop rbp
	pop rbx
	add rsp, 8
	ret

Print:
	; function prologue
	push rbx	; counter
	push r12	; tmp var
	push rbp	; output pointer
	; function body
	mov rbp, rdx
	xor rbx, rbx	; int i = 0
p_LP:
	cmp rbx, rsi
	je p_epilogue
	mov r12b, byte[rdi + rbx]
	add r12, 0x30	; add zero
	mov byte[rbp], r12b
	inc rbp
	mov byte[rbp], 32
	inc rbp
	inc rbx
	jmp p_LP
p_epilogue:
	mov byte[rbp], 10
	; function epilogue
	pop rbp
	pop r12
	pop rbx
	ret

_start:
	; Select_Sort function takes two parameters
	mov rdi, Arr		; the pointer to the first element in the array
	mov rsi, Arr_len	; the length of the array
	call Select_Sort

	; Print function takes three parameters
	mov rdi, Arr		; the pointer to the arr first element
	mov rsi, Arr_len	; the length of the array
	mov rdx, output		; the pointer to the output first element
	call Print

	; invoke syscall
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