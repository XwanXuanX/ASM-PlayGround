; This asm program implements insertion sort algorithm
; Author: Wanxuan Li
; Date: 2022-10-29

	global _start

	section .data
Arr	db 2, 4, 3, 6, 1, 7, 4, 6
Arr_len	equ $ - Arr

	section .bss
output	resb 30
out_len	equ 30

	section .text
Insert_Sort:
	; function prologue
	push rbx
	push rbp
	push r12
	push r13
	; function body
	mov rbx, 1	; int i = 1 (no elements before Arr[0])
i_LP1:
	cmp rbx, rsi
	je i_epilogue
	mov r12b, byte[rdi + rbx]	; r12b = key
	lea rbp, [rbx - 1]
i_LP2:
	cmp rbp, 0
	jl i_LP2_end
	mov r13b, byte[rdi + rbp]
	cmp r13b, r12b
	jng i_LP2_end
	mov byte[rdi + rbp + 1], r13b
	dec rbp
	jmp i_LP2
i_LP2_end:
	mov byte[rdi + rbp + 1], r12b
	inc rbx
	jmp i_LP1
i_epilogue:
	; function epilogue
	pop r13
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
	; Insert_Sort function takes two parameters
	mov rdi, Arr		; the pointer to the first element in Arr
	mov rsi, Arr_len	; the length of the array
	call Insert_Sort

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
	; Ternimate safely
	mov rax, 60
	xor rdi, rdi
	syscall
	ret