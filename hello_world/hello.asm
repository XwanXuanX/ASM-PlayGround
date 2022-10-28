; This simple asm program outputs "Hello World!" to the console
; Author: Wanxuan Li
; Date: 2022-10-28

	global _start

	section .data
msg:	db "Hello World!", 10 ; 10 = '\n'
len:	equ $ - msg	; $ = the address of next instruction

	section .text
_start:
	mov rdx, len
	mov rsi, msg
	mov rax, 1
	mov rdi, rax
	syscall

	; Terminate safely
	mov rax, 60
	xor rdi, rdi
	syscall
	ret