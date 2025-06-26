; --------------------------------------
; ft_write:
; A wrapper around the Linux write syscall (number 1)
;
; Input:
;   rdi - file descriptor (int fd)
;   rsi - buffer pointer  (const void *buf)
;   rdx - number of bytes (size_t count)
;
; Output:
;   rax - number of bytes written on success,
;         -1 on error (and sets errno accordingly)
;
; Notes:
; - Calls syscall directly.
; - Sets errno on failure using __errno_location.
; - Preserves error code using stack (push/pop).
; --------------------------------------

section .text
global ft_write
extern __errno_location

ft_write:
    mov rax, 1              ; syscall number for write
    syscall                 ; invoke kernel
    cmp rax, 0              ; check if rax < 0
    jl .error               ; jump to error handler
    ret                     ; return number of bytes written
.error:
    neg rax                 ; convert error code to positive
    push rax                ; save error code on stack
    call __errno_location wrt ..plt ; get pointer to errno via PLT
    pop rcx                 ; restore error code
    mov [rax], rcx          ; set errno = error code
    mov rax, -1             ; return -1 to signal error
    ret

section .note.GNU-stack noalloc noexec nowrite progbits