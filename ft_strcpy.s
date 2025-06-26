section .text
	global ft_strcpy

; --------------------------------------
; ft_strcpy:
; Copies a null-terminated string from src (rsi) to dst (rdi).
; 
; Input:
;   rdi - destination buffer (char *dst)
;   rsi - source string     (const char *src)
; Output:
;   rax - returns the pointer to the destination (same as rdi)
;
; Notes:
; - This function copies each byte from the source to the destination
;   until it encounters the null terminator (0 byte).
; - The return value matches the C standard: it returns the original dst.
; - dl is used as a temporary register to store the current byte.
; --------------------------------------

ft_strcpy:
	mov rax, rdi           ; Save the original dst to return at the end

.loop:
	mov dl, byte [rsi]     ; Load current byte from src
	mov byte [rdi], dl     ; Store it in dst
	inc rdi                ; Move to next dst position
	inc rsi                ; Move to next src position
	cmp dl, 0              ; Check for null terminator
	jne .loop              ; If not null, continue loop
	ret                    ; Return original dst (stored in rax)

