; nasm -f elf64 atoi.asm; gcc -o atoi atoi.o -no-pie
global main



SECTION .data
    data: dd "12345", 0x00
    dest: times 1000 dd 0x00



SECTION .text
    main:
        lea rdi, [data]
        call atoi
        times 100 nop
        ret
    
    atoi :
        push rdi
        push rsi
        push rcx
        push rdx
        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx
        xor rdx, rdx
        xor r8, r8
        call strlen
        mov rdx, rax
        dec rdi
        add rdi, rdx
    atoi_loop :
        or rdx, rdx
        jz atoi_end

        ; mov al, byte

        push rdi
        mov rdi, 10
        mov rsi, rcx
        call square ; rax = 10 ** rcx
        pop rdi
        mov rbx, rax

        xor rax, rax
        mov al, byte[rdi]
        sub al, 48
        push rdx
        mul rbx ; bl = (char *)rdi
        pop rdx

        add r8, rax ; rdx += (char *)rdi + 10 ** i

        dec rdi
        inc rcx
        dec rdx
        jmp atoi_loop
    atoi_end :
        pop rdx
        pop rcx
        pop rsi
        pop rdi
        mov rax, r8
        ret
    ; atoi:
    ;     push rdi
    ;     push rbx
    ;     push rcx
    ;     push rsi
    ;     xor rcx, rcx
    ;     ; inc rcx
    ;     xor rax, rax

    ;     push rdi
    ;     call strlen
    ;     pop rdi
    ;     mov rsi, rdi
    ;     add rsi, rax
    ; atoi_loop:
    ;     cmp rdi, rsi
    ;     je atoi_end

    ;     ; mov bl, 10
    ;     ; mov rax, rcx
    ;     ; mul bl
    ;     ; mov rcx, rax

    ;     mov rdi, 10
    ;     mov rsi, rcx
    ;     call square
    ;     mov rcx, rax

    ;     mov al, byte[rsi]
    ;     sub al, 48
    ;     mul rcx
    ;     add rbx, rax

    ;     dec rsi
    ;     jmp atoi_loop
    ; atoi_end:
    ;     mov rax, rbx
    ;     pop rsi
    ;     pop rcx
    ;     pop rbx
    ;     pop rdi
    ;     ret



    strlen:
        push rdi
        push rcx
        push rdx
        xor rax, rax
        xor rcx, rcx
    strlen_loop:
        mov al, byte[rdi]
        or al, al
        jz strlen_end
        inc rcx
        inc rdi
        jmp strlen_loop
    strlen_end:
        mov rax, rcx
        pop rdx
        pop rcx
        pop rdi
        ret



    square:
        xor rax, rax
        inc rax
        or rsi, rsi
        jz square_zero
        push rbx
        push rcx
        push rdx
        mov rcx, rsi
    square_loop:
        mov rdx, rdi
        or rcx, rcx
        jz square_end
        mul rdx
        dec rcx
        jmp square_loop
    square_zero:
        ret
    square_end:
        pop rdx
        pop rcx
        pop rbx
        ret





















