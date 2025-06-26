section .text
	global ft_strlen

; | input:
; |   rdi = pointer to null-terminated string
; | output:
; |   rax = length of string (excluding null terminator)
ft_strlen:
	xor rax, rax             ; clear rax, length = 0
.loop:
	cmp byte [rdi + rax], 0  ; check if current byte is zero
	je .end                  ; if zero, jump to end
	inc rax                  ; increment length counter
	jmp .loop                ; repeat loop
.end:
	ret                      ; return with length in rax
 
section .note.GNU-stack noalloc noexec nowrite progbits