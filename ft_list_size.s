section .text
	global ft_list_size

; int ft_list_size(t_list *begin_list)
; Returns the number of elements in the list.

ft_list_size:
    xor rax, rax            ; rax = counter = 0
.loop:
    test rdi, rdi           ; if (begin_list == NULL)
    je .done                ;     return counter
    inc rax                 ; counter++
    mov rdi, [rdi + 8]      ; begin_list = begin_list->next
    jmp .loop
.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
