## working code

- filenaem : helloworld.asm

```
global _main
 
   section .text
_main:
   mov rax, 0x2000004
   mov rdi, 1
   mov rsi, message
   mov rdx, 13
   syscall
   mov rax, 0x02000001
   xor rdi, rdi
   syscall
 
   section .data
message:
   db "Hello, world!", 10
```

## comman line
- $nasm -f macho64 helloworld.asm
- $ld -macosx_version_min 13.1 -e _main -static helloworld.o
- $./a.out 