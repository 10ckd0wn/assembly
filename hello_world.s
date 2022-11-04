format ELF64 executable
entry _start

new_line equ 0xA
msg db "hello world",new_line, 0


_start:
	mov rax, msg
	call print_string
	call exit

print_string:
	push rax
	push rbx
	push rcx
	push rdx
	mov rcx, rax
	call len_msg
	mov rdx, rax
	mov rax, 4
	mov rbx, 1
	int 0x80
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

len_msg:
	push rdx
	xor rdx, rdx
	.next_iter:
		cmp [rax+rdx], byte 0
		je .close
		inc rdx
		jmp .next_iter
	.close:
		mov rax, rdx
		pop rdx
		ret

exit:
	mov rax, 1
	mov rbx, 0
	int 0x80

