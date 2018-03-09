; nasm -f elf64 strcpy.asm; gcc -o strcpy strcpy.o -no-pie
global main



SECTION .data
    data: db "jtjisgod", 0x00
    dest: times 1000 db 0x00



SECTION .text
    main:
        lea rdi, [dest]
        lea rsi, [data] ; mov rsi, data  -> data의 주솟값을 rsi에 넣어라!
        ; lea rsi, data -> data에서 8바이트를 가지고와서 rsi에 넣어라!
        ; mov rdx, 0
        call strcpy ; strcpy(dest, data) strncpy(dest, data, n)
        times 100 db 0x90
        ret
        
    strcpy: ; rax, rsi, rdi
        xor rax, rax
    strcpy_loop:
        mov al, byte[rsi]
        or al, al
        jz strcpy_end
        mov byte[rdi], al
        inc rdi
        inc rsi
        jmp strcpy_loop
    strcpy_end:
        ret



