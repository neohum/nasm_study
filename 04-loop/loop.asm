  global _start

  section .text
  
_start:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, 1

  syscall

  mov rax, 0x02000001
  xor rdi, rdi

  syscall

  section .data
msg: 
  db "A"