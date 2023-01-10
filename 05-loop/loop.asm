  global _start

  section .text
  
_start:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, 1
  mov r10, 1

agian:
  cmp r10, 100
  je done

  syscall

  mov rax, 0x2000004
  inc r10
  jmp again

done:
  mov rax, 0x02000001
  mov rdi, 0
  syscall

  section .data
msg: 
  db "A"