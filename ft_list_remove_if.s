section .text
	global ft_list_remove_if
extern free
extern printf

; void ft_list_remove_if(t_list **begin_list, void *data_ref,
;                        int (*cmp)(), void (*free_fct)(void*));
; Removes all nodes from the list whose data matches data_ref (cmp == 0).
; Frees both the data using free_fct and the node using free().

ft_list_remove_if:
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov rbx, rdi        ; rbx = **begin_list
    mov r12, rsi        ; r12 = data_ref
    mov r13, rdx        ; r13 = cmp
    mov r14, rcx        ; r14 = free_fct

    mov r15, [rbx]      ; r15 = current node
    cmp r15, 0
    je .exit

; Remove matching head nodes
.remove_head:
    mov rdi, [r15]      ; rdi = current->data
    mov rsi, r12        ; rsi = data_ref
    call r13            ; cmp(current->data, data_ref)
    cmp rax, 0
    jne .continue_loop  ; if not equal, stop head removal

    mov rax, [r15 + 8]  ; rax = current->next
    mov [rbx], rax      ; *begin_list = next
    mov rdi, [r15]      ; rdi = current->data
    call r14            ; free_fct(current->data)
    mov rdi, r15
    call free WRT ..plt           ; free(current)
    mov r15, [rbx]      ; current = *begin_list
    test r15, r15
    jne .remove_head    ; continue removing from head

; Iterate through the rest of the list
.continue_loop:
    mov rbx, r15        ; rbx = prev
    mov r15, [r15 + 8]  ; r15 = current

.loop:
    test r15, r15
    je .exit

    mov rdi, [r15]      ; rdi = current->data
    mov rsi, r12
    call r13            ; cmp(current->data, data_ref)
    cmp rax, 0
    jne .advance

    mov rax, [r15 + 8]  ; rax = current->next
    mov [rbx + 8], rax  ; prev->next = current->next
    mov rdi, [r15]      ; rdi = current->data
    call r14            ; free_fct(current->data)
    mov rdi, r15
    call free WRT ..plt           ; free(current)
    mov r15, [rbx + 8]  ; current = prev->next
    jmp .loop

.advance:
    mov rbx, r15        ; prev = current
    mov r15, [r15 + 8]  ; current = current->next
    jmp .loop

.exit:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
