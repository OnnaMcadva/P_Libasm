; --------------------------------------
; ft_strcmp:
; Compares two null-terminated strings byte by byte.
;
; Input:
;   rdi - pointer to the first string (const char *s1)
;   rsi - pointer to the second string (const char *s2)
;
; Output:
;   rax - an integer less than, equal to, or greater than zero
;         if s1 is found to be less than, equal to, or greater than s2
;
; Notes:
; - Compares each byte as unsigned char.
; - Stops at the first differing byte or null terminator.
; - Uses caller-saved registers only (rax, rcx, rdx).
; --------------------------------------

section .text
global ft_strcmp

ft_strcmp:
    xor rax, rax            ; Clear return value (default = 0)
.loop:
    mov cl, [rdi]           ; Load byte from s1
    mov dl, [rsi]           ; Load byte from s2
    cmp cl, dl              ; Compare bytes
    jne .diff               ; If not equal, compute difference
    cmp cl, 0               ; End of strings?
    je .end                 ; If null byte, strings are equal
    inc rdi                 ; Advance to next byte
    inc rsi
    jmp .loop               ; Repeat
.diff:
    movzx rax, cl           ; Zero-extend unsigned byte from s1
    movzx rcx, dl           ; Zero-extend unsigned byte from s2
    sub rax, rcx            ; Compute (unsigned char)s1 - (unsigned char)s2
.end:
    ret                     ; Return result in rax

