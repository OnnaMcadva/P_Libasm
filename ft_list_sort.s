section .text
    global ft_list_sort

; void ft_list_sort(t_list **begin_list, int (*cmp)());
; Sorts a singly linked list using bubble sort.
; Swaps the 'data' fields, not the node pointers.
; Fixed version - properly terminates after full pass without swaps

ft_list_sort:
    push rbx
    push r12
    push r13
    push r14
    push r15                ; Added for swap tracking

    mov rbx, rdi            ; rbx = begin_list
    mov r12, rsi            ; r12 = cmp function

    cmp qword [rbx], 0      ; if (*begin_list == NULL)
    je .exit

.outer_loop:
    xor r15, r15            ; swap flag = 0 (no swaps yet)
    mov r13, [rbx]          ; r13 = current node

.inner_loop:
    mov r14, [r13 + 8]      ; r14 = current->next
    test r14, r14
    je .end_inner_loop      ; if next == NULL, end inner loop

    ; Prepare and call cmp function
    push r13                ; Save current node pointer
    push r14                ; Save next node pointer
    mov rdi, [r13]          ; rdi = current->data
    mov rsi, [r14]          ; rsi = next->data
    call r12                ; call cmp(current->data, next->data)
    pop r14                 ; Restore next node pointer
    pop r13                 ; Restore current node pointer

    cmp eax, 0
    jle .no_swap            ; if cmp <= 0, don't swap

    ; Perform swap
    mov rcx, [r13]          ; rcx = current->data
    mov rdx, [r14]          ; rdx = next->data
    mov [r13], rdx          ; current->data = next->data
    mov [r14], rcx          ; next->data = current->data
    mov r15, 1              ; Set swap flag (swaps occurred)

.no_swap:
    mov r13, r14            ; advance: current = current->next
    jmp .inner_loop

.end_inner_loop:
    test r15, r15           ; Check if any swaps occurred
    jnz .outer_loop         ; If swaps occurred, do another pass

.exit:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

section .note.GNU-stack noalloc noexec nowrite progbits