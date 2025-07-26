section .text
	global ft_strlen		 ; "global" is for main.c

; | input:
; |   rdi = pointer to null-terminated string (const char *s)
; | output:
; |   rax = length of string (size_t length)

ft_strlen:
	xor rax, rax             ; clear rax, length = 0
.loop:
	cmp byte [rdi + rax], 0  ; check if current byte is "\0"
	je .end                  ; "Jump if Equal", jump to end
	inc rax                  ; increment length counter
	jmp .loop                ; repeat loop
.end:
	ret                      ; return with length in rax
 
section .note.GNU-stack noalloc noexec nowrite progbits