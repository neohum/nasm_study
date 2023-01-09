
<details>
  <summary>01-helloworld</summary>

# 01-helloworld

## working code

- filename : helloworld.asm

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
- or : nasm -f macho64 -o echo.o echo.asm 
- $ld -macosx_version_min 13.1 -e _main -static helloworld.o

- or : ld -o echo echo.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main
- or : ld -o echo echo.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch x86_64
- $./a.out 

</details> 

<details>
  <summary>02-stack-frame</summary>


# 02-stack-frame

## working cord
- filename: sum.c

```
#include <stdio.h>

int sum(int a, int b) {
  return a + b;
}

int main(void) {
  int c = sum(1, 2);
  return c;
}
```


## comman line
- $clang -S -fno-stack-protector -z execstack -o sum.asm sum.c 

## c code exec
- $gcc -o sum sum.c
- $./sum

</details>


<details>
  <summary>03-echo</summary>

## 03-echo
```
; Echo program that waits for user to enter a character and than echoing it.
; NASM assembly for Mac OS X x64.

section .data
	msg_enter:	db	"Please, enter a char: "
	.len:		equ	$ - msg_enter
	msg_entered:	db	"You have entered: "
	.len:		equ	$ - msg_entered

section .bss
	char:		resb	1	; reserve one byte for one char

section .text
	global		_main
_main:
	; show message
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, msg_enter		; rsi is where the kernel expects to find the address of the message
	mov	rdx, msg_enter.len	; and rdx is where the kernel expects to find the length of the message 
	syscall

	; read char
	mov	rax, 0x2000003		; put the read-system-call-code into register rax
	mov	rdi, 0			; tell kernel to use stdin
	mov	rsi, char		; address of storage, declared in section .bss
	mov	rdx, 4			; get 2 bytes from the kernel's buffer (one for the carriage return)
	syscall

	; show message
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, msg_entered	; rsi is where the kernel expects to find the address of the message
	mov	rdx, msg_entered.len	; and rdx is where the kernel expects to find the length of the message 
	syscall

	; show char
	mov	rax, 0x2000004		; put the write-system-call-code into register rax
	mov	rdi, 1			; tell kernel to use stdout
	mov	rsi, char		; address of storage of char
	mov	rdx, 4			; the second byte is to apply the carriage return expected in the string
	syscall

	; exit system call
	mov	rax, 0x2000001		; exit system call
	xor	rdi, rdi		; equivalent to "mov rdi, 0", however xor is preferred pattern on modern
					; CPUs
	syscall
  ```
  - nasm -f macho64 echotest.asm
  - or : nasm -f macho64 echotest.o echotest.asm      
  - $ld -o echotest echotest.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch x86_64
  - or : ld -macosx_version_min 13.1 -e _main -static echotest.o

</details>

