section .text
	global ft_list_push_front
extern malloc

; void ft_list_push_front(t_list **begin_list, void *data)
; Allocates a new node and inserts it at the beginning of the list.

ft_list_push_front:
    push rbp
    mov rbp, rsp
    push rbx
    push r12

    mov rbx, rdi            ; rbx = begin_list (pointer to list head)
    mov r12, rsi            ; r12 = data to insert

    mov rdi, 16             ; sizeof(t_list) = 8 (data) + 8 (next)
    call malloc WRT ..plt   ; allocate new node
    test rax, rax
    je .fail                ; if malloc failed, do nothing

    mov [rax], r12          ; node->data = data
    mov rcx, [rbx]          ; rcx = *begin_list (current head)
    mov [rax + 8], rcx      ; node->next = current head
    mov [rbx], rax          ; *begin_list = new node

.fail:
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
