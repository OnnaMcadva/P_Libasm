; ------------------------------------------
; ft_strdup:
; Duplicates a string using malloc and ft_strcpy.
;
; Input:
;   rdi - pointer to the source null-terminated string
;
; Output:
;   rax - pointer to the newly allocated duplicate string,
;         or NULL on error (with errno = ENOMEM)
;
; Notes:
; - Uses custom ft_strlen to determine length
; - Allocates memory using malloc
; - Copies string using ft_strcpy
; - On malloc failure, sets errno to ENOMEM (12)
; ------------------------------------------

section .text
global ft_strdup
extern malloc
extern ft_strlen
extern ft_strcpy
extern ___error

ft_strdup:
    push rdi                ; Save source string pointer
    call ft_strlen          ; Get length of source string
    inc rax                 ; Add 1 for null terminator
    mov rdi, rax            ; Argument for malloc (size)
    call malloc             ; Allocate memory
    cmp rax, 0              ; Check if malloc failed
    je .error               ; Jump if error (rax == 0)
    mov rdi, rax            ; Destination pointer for ft_strcpy
    pop rsi                 ; Restore source string pointer
    call ft_strcpy          ; Copy string into allocated memory
    ret                     ; Return destination pointer

.error:
    pop rdi                 ; Restore rdi to clean stack
    call ___error           ; Get pointer to errno
    mov qword [rax], 12     ; Set errno = ENOMEM (12)
    mov rax, 0              ; Return NULL
    ret

