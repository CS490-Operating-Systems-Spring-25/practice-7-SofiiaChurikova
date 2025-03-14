.section .data
    buffer:
        .fill 256, 1, 0
    
    filename:
        .asciz "test_file.txt"
    
    content:
        .asciz "Hello test\n"
    
    content_len = . - content - 1
    
    read_buffer:
        .fill 256, 1, 0

.section .text
    .global _start

_start:
    ldr x0, =buffer
    mov x1, #256
    mov x8, #17
    svc #0
    
    mov x10, x0
    ldr x1, =buffer
    mov x2, #0
find_length:
    ldrb w3, [x1, x2]
    cbz w3, end_find_length
    add x2, x2, #1
    b find_length
end_find_length:
    
    mov x0, #1
    ldr x1, =buffer
    mov x8, #64
    svc #0
    
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0x41
    mov x3, #0644
    mov x8, #56
    svc #0
    
    mov x19, x0
    
    mov x0, x19
    ldr x1, =content
    mov x2, content_len
    mov x8, #64
    svc #0
    
    mov x0, x19
    mov x8, #57
    svc #0
    
    ldr x0, =filename
    mov x1, #0755
    mov x8, #52
    svc #0
    
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x8, #56
    svc #0
    
    mov x19, x0
    
    mov x0, x19
    ldr x1, =read_buffer
    mov x2, #256
    mov x8, #63
    svc #0
    
    mov x20, x0
    
    mov x0, x19
    mov x8, #57
    svc #0
    
    mov x0, #1
    ldr x1, =read_buffer
    mov x2, x20
    mov x8, #64
    svc #0
    
    mov x0, #1
    mov x8, #93
    svc #0
