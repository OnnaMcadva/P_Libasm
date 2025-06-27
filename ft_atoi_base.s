section .text
	global ft_atoi_base
extern ft_strlen

; int ft_atoi_base(const char *str, const char *base)
; Converts the string `str` into an integer using the numeral system defined by `base`.

ft_atoi_base:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi            ; r12 <- str
    mov r13, rsi            ; r13 <- base
    xor r14, r14            ; r14 = result = 0
    xor r15, r15            ; r15 = sign (1 = positive, -1 = negative)

    ; Validate base
    mov rdi, r13
    call ft_strlen
    cmp rax, 2              ; base must contain at least 2 characters
    jl .error
    mov rbx, rax            ; rbx = base_len

    ; Check base validity: no duplicates, no '+', '-', or whitespaces
    mov rsi, r13
.validate_base_loop:
    mov al, [rsi]
    cmp al, 0
    je .base_validated
    cmp al, ' '
    je .error
    cmp al, '+'
    je .error
    cmp al, '-'
    je .error
    mov rcx, rsi
    inc rcx
.check_duplicates:
    cmp byte [rcx], 0
    je .next_char
    cmp al, [rcx]
    je .error               ; Duplicate character in base
    inc rcx
    jmp .check_duplicates
.next_char:
    inc rsi
    jmp .validate_base_loop
.base_validated:

    ; Skip leading whitespaces in input string
    mov rsi, r12
.skip_whitespace:
    mov al, [rsi]
    cmp al, ' '
    je .skip
    cmp al, 9               ; '\t'
    je .skip
    cmp al, 10              ; '\n'
    je .skip
    cmp al, 11              ; '\v'
    je .skip
    cmp al, 12              ; '\f'
    je .skip
    cmp al, 13              ; '\r'
    je .skip
    jmp .check_sign
.skip:
    inc rsi
    jmp .skip_whitespace

.check_sign:
    mov r15, 1              ; Assume positive
    cmp byte [rsi], '-'
    jne .check_plus
    mov r15, -1             ; Set sign to negative
    inc rsi
    jmp .parse_loop
.check_plus:
    cmp byte [rsi], '+'
    jne .parse_loop
    inc rsi

.parse_loop:
    ; rsi points to start of numeric part
    mov r12, rsi
    xor rcx, rcx            ; rcx = input index
.convert:
    movzx rdx, byte [r12 + rcx]
    test rdx, rdx
    je .apply_sign          ; end of string

    ; Search rdx in base
    mov rsi, r13            ; rsi = base
    xor r8, r8              ; r8 = base index
.find_in_base:
    cmp byte [rsi + r8], 0
    je .apply_sign          ; not found: invalid char
    cmp dl, [rsi + r8]
    je .valid_digit
    inc r8
    jmp .find_in_base

.valid_digit:
    cmp r8, rbx
    jae .apply_sign         ; out of range (shouldn't happen)
    imul r14, rbx           ; result *= base_len
    add r14, r8             ; result += base_index
    inc rcx
    jmp .convert

.apply_sign:
    imul r14, r15           ; apply sign
    mov rax, r14            ; return value
    jmp .exit

.error:
    xor rax, rax            ; return 0 on error

.exit:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
