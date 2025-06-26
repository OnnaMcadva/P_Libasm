; --------------------------------------
; ft_read:
; A wrapper around the Linux read syscall (number 0)
;
; Input:
;   rdi - file descriptor (int fd)
;   rsi - buffer pointer  (void *buf)
;   rdx - number of bytes to read (size_t count)
;
; Output:
;   rax - number of bytes read on success,
;         -1 on error (and sets errno accordingly)
;
; Notes:
; - Calls syscall directly.
; - Sets errno on failure using ___error.
; - Preserves error code using stack (push/pop).
; --------------------------------------

section .text
global ft_read
extern ___error

ft_read:
    mov rax, 0              ; syscall number for read
    syscall                 ; invoke kernel
    cmp rax, 0              ; check for error (rax < 0)
    jl .error               ; jump if error occurred
    ret                     ; return bytes read
.error:
    neg rax                 ; convert error code to positive
    push rax                ; save error code
    call ___error           ; get pointer to errno
    pop rcx                 ; restore error code
    mov [rax], rcx          ; set errno = saved error code
    mov rax, -1             ; return -1 on error
    ret

