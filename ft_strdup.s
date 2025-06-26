section .text
global ft_strdup
extern malloc
extern ft_strlen
extern ft_strcpy
extern __errno_location

ft_strdup:
    push rdi                ; Save the input string pointer on the stack
    call ft_strlen          ; Get the length of the input string
    inc rax                 ; +1 for the null terminator
    mov rdi, rax            ; malloc argument: number of bytes to allocate
    call malloc wrt ..plt   ; Allocate memory via PLT
    test rax, rax           ; Check if malloc returned NULL
    je .error               ; Jump to error handler if allocation failed
    mov rdi, rax            ; Destination pointer for ft_strcpy (new buffer)
    pop rsi                 ; Restore the original string pointer (source)
    call ft_strcpy          ; Copy the string into the new memory
    ret                     ; Return the pointer to the duplicated string

.error:
    pop rdi                 ; Clean up the stack
    call __errno_location wrt ..plt ; Get the address of errno via PLT
    mov dword [rax], 12     ; Set errno to ENOMEM (12)
    xor rax, rax            ; Return NULL (rax = 0)
    ret

section .note.GNU-stack noalloc noexec nowrite progbits