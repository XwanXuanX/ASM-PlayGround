; This asm program is a better version of select_sort.asm
; Author: Wanxuan Li
; Date: 2022-10-30

	global _start

	section .data
Arr	db 2, 4, 1, 5, 6, 3, 7, 9
Arr_len	equ $ - Arr

	section .bss
output	resb 30
out_len	equ 30

	section .text
Select_Sort_Plus:
	; function prologue
	push rbx	; left bound
	push rbp	; right bound
	push r12	; min index
	push r13	; max index
	push r14	; tmp index
	push r15	; tmp value
	; function body
	mov rbx, 0			; ileft = 0
	lea rbp, [rsi - 1]	; iright = n - 1
s_LP1:
	cmp rbx, rbp	; while (ileft < iright)
	jnl s_epilogue
	mov r12, rbx	; min = ileft
	mov r13, rbx	; max = ileft
	mov r14, rbx	; tmp = ileft
s_LP2:
	cmp r14, rbp
	jg s_LP2_end
	mov r15b, byte[rdi + r12]	; find min value
	cmp r15b, byte[rdi + r14]	; compare min val with current val
	jle s_cont1
	mov r12, r14				; if greater, update min index
s_cont1:
	mov r15b, byte[rdi + r13]	; find max value
	cmp r15b, byte[rdi + r14]	; compare max val with current val
	jge s_cont2
	mov r13, r14				; if greater, update max index
s_cont2:
	inc r14
	jmp s_LP2
s_LP2_end:
	cmp r12, rbx
	je s_cont3
	mov r15b, byte[rdi + r12]
	push r15
	mov r15b, byte[rdi + rbx]
	mov byte[rdi + r12], r15b
	pop r15
	mov byte[rdi + rbx], r15b
s_cont3:
	cmp r13, rbx
	jne s_cont4
	mov r13, r12
s_cont4:
	cmp r13, rbp
	je s_cont5
	mov r15b, byte[rdi + r13]
	push r15
	mov r15b, byte[rdi + rbp]
	mov byte[rdi + r13], r15b
	pop r15
	mov byte[rdi + rbp], r15b
s_cont5:
	inc rbx
	dec rbp
	jmp s_LP1
s_epilogue:
	; function epilogue
	pop r15
	pop r14
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
	; Select_Sort_Plus takes two parameters
	mov rdi, Arr		; The pointer to the first element in the Arr
	mov rsi, Arr_len	; The length of Arr
	call Select_Sort_Plus

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