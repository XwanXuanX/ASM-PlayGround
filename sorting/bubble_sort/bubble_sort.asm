; This asm program implements bubble sort algorithm
; Author: Wanxuan Li
; Date: 2022-10-29

	global _start

	section .data
Arr	db 2, 1, 4, 3, 6, 4, 8
Arr_len	equ $ - Arr

	section .bss
output	resb 20
out_len	equ 20

	section .text
Bubble_Sort: ; Bubble_Sort(char* p_Arr, unsigned int size)
	; function prologue
	push rbx
	push rbp
	push r12
	; function body
	lea rbx, [rsi - 2]	; int i = Arr_len - 2
b_LP1:
	cmp rbx, 0
	jl b_epilogue
	xor rbp, rbp	; int j = 0
b_LP2:
	cmp rbp, rbx
	jg b_LP2_end
	mov r12b, byte[rdi + rbp]
	cmp r12b, byte[rdi + rbp + 1]
	jng b_cont
	push r12
	mov r12b, byte[rdi + rbp + 1]
	mov byte[rdi + rbp], r12b
	pop r12
	mov byte[rdi + rbp + 1], r12b
b_cont:
	inc rbp
	jmp b_LP2
b_LP2_end:
	dec rbx
	jmp b_LP1
	; function epilogue
b_epilogue:
	pop r12
	pop rbp
	pop rbx
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
	; BUbble sort function takes two parameters
	mov rdi, Arr		; the pointer to the arr first element
	mov rsi, Arr_len	; the length of the array
	call Bubble_Sort

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