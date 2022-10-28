; This asm program outputs a equilateral triangle to the console
; Author: Wanxuan Li
; Date: 2022-10-28

	global _start

	section .bss
mr:	equ 5		; number of rows
mc:	equ 9		; number of cols
output: resb 100	; reserved data seg
dsize:	equ $ - output	; size of output

	section .text
_start:
	mov rdx, output
	mov r9, 1	; r9: line counter
	mov r8, 0	; r8: char counter
line:
	mov r10, mr	; r10: space counter
	sub r10, r9	; r10 = number of spaces to be set
space:
	cmp r8, r10		; if char == space required -> cont
	je cont
	mov byte[rdx], 32	; 32 = space in ascii code
	inc rdx
	inc r8
	jmp space
cont:
	xor r8, r8	; mov r8, 0
	shl r10, 1	; r10 *= 2
	push r10
	mov r10, mc
	sub r10, [rsp]	; r10 = mc - r10 * 2
	add rsp, 16
star:
	mov byte[rdx], '*'
	inc rdx
	inc r8
	cmp r8, r10
	jne star
done:
	mov byte[rdx], 10
	inc rdx
	inc r9
	xor r8, r8
	cmp r9, mr
	jng line

	mov rax, 1
	mov rdi, rax
	mov rsi, output
	mov rdx, dsize
	syscall

	mov rax, 60
	xor rdi, rdi
	syscall
	ret
