section .text
    global _start
    global ft_strlen

; Функция ft_strlen (соответствует соглашению x86_64 System V ABI)
; Аргумент: rdi = указатель на строку
; Возвращает: rax = длина строки (без нуль-терминатора)
ft_strlen:
    xor rax, rax             ; Обнуляем rax (счётчик длины)
.loop:
    cmp byte [rdi + rax], 0  ; Сравниваем текущий символ с нулём
    je .end                  ; Если ноль — выходим
    inc rax                  ; Увеличиваем счётчик
    jmp .loop                ; Повторяем цикл
.end:
    ret                      ; Возвращаем длину в rax

; Главная функция (тест ft_strlen)
_start:
    mov rdi, str1            ; Загружаем адрес строки в rdi (1-й аргумент)
    call ft_strlen           ; Вызываем ft_strlen
    mov rdi, rax             ; Передаём длину как код возврата
    mov rax, 60              ; syscall 60 = exit
    syscall                  ; Завершаем программу

section .rodata
    str1 db "Hello", 0       ; Тестовая строка 1 (длина = 5)
    
; nasm -f elf64 ft_strlen_main.s -o ft_strlen_main.o
; ld ft_strlen_main.o -o ft_strlen
; ./ft_strlen
; echo $?  # Проверим код возврата (должно быть 5)
