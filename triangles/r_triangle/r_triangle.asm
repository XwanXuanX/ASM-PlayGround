; This simple asm program prints a triangle to the console
; Author: Wanxuan Li
; Date: 2022-10-28

	global _start

	section .bss	; .bss section holds uninitialized data seg
ml:	equ 8		; lines of triangle
output: resb 44		; reserved data seg
dsize:	equ $ - output	; length of reserved data seg = 44

	section .text
_start:
	mov rdx, output		; rdx = address of 1st element of output seg
	mov r9, 1		; initialize line counter to 1
	mov r8, 0		; initialize star counter to 0
line:
	mov byte[rdx], '*'	; add a star to output seg
	inc rdx			; increse address by 1 BYTE
	inc r8			; increase star counter by 1
	cmp r9, r8		; if star counter != line counter
	jne line
newLine:
	mov byte[rdx], 0d10	; add '\n' = 10 to output seg
	inc rdx			; increse address by 1 BYTE
	inc r9			; increase line counter by 1
	xor r8, r8		; set star counter to 0
	cmp r9, ml		; if line counter != max lines
	jne line
done:
	mov rax, 1		; syscall number
	mov rdi, rax
	mov rsi, output
	mov rdx, dsize
	syscall
	mov rax, 0d60		; ternimate program safely
	xor rdi, rdi		; clear return values
	syscall
	ret