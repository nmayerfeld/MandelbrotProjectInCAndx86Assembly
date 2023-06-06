.section .data
.section .text
.global MBPixelCalc

MBPixelCalc:
    //deal with stack, set up all initial variables as 0;
    pushq %rbx
    pushq %rbp
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    pushq %rsp
    movl $0, %edx
    
    movq $0, %r11
    movl $0, %eax
    //make sure iteration <1000
    cmpq $0x3E8, %rax
    jge .L2
    jmp .L3
.L0:
    movq $0x1000000000000000,%r9
    cmpq %r9,%r8
    //if x^2+y^2(in %r8)>4, jump and return
    jg .L2
.L1:
    cmpq $0x3E8, %rax
    jge .L2
    //xtemp=x^2+y^2+x0
    movq %rbx, %r9
    subq %rbp,%r9
    addq %rdi, %r9

    //y=2xy+y0
    shrq $29, %rdx
    shrq $29, %r11
    imulq %rdx,%r11
    salq $1,%r11

    cmpq $1,%r15
    je .L16
.L19:
    addq %rsi,%r11
    //x=xtemp
    movq %r9,%rdx
    //increment iteration
    addq $1,%rax

    //compare x^2+y^2(in %r8) to4 and rerun loop if its less than
    jmp .L3
.L2:
    popq %rsp
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbp
    popq %rbx
    ret
.L3:
    movq $0, %r15
    //need to check if positive.  if not, make it positive and then bit shift by 29
    //If it is, bit shift right 29 and then multiply
    movq %rdx,%r12

    //can reuse this code
    movb $0,%cl
    cmpq $0,%r12

    // if negative, shift right until 1 at the end, counting how many shifted, then complement and add one, then shift back
    jl .L7

.L4:
    movq %r12, %rdx
    movq %rdx,%rbx
    shrq $29, %rbx
    imulq %rbx,%rbx

    movq %r11,%r12
    movb $0,%cl
    cmpq $0,%r12

    // if negative, shift right until 1 at the end, counting how many shifted, then complement and add one, then shift back
    jl .L11
.L5:
    movq %r12, %r11
    movq %r11,%rbp
    shrq $29, %rbp
    imulq %rbp,%rbp
    leaq (%rbx,%rbp,1),%r8
    jmp .L0

.L7:
    //check if final bit is a 1
    addq $1,%r15
    movq %r12,%r13
    andq $1,%r13
    cmpq $0,%r13
    jg .L9
.L8:
    addb $1,%cl
    shrq $1, %r12
    movq %r12,%r13
    andq $1,%r13
    cmpq $0,%r13
    je .L8
.L9:
    notq %r12
    addq $1,%r12
    shlq %cl,%r12
    jmp .L4
.L11:
    //check if final bit is a 1
    addq $1, %r15
    movq %r12,%r13
    andq $1,%r13
    cmpq $0,%r13
    jg .L13
.L12:
    addb $1,%cl
    shrq $1, %r12
    movq %r12,%r13
    andq $1,%r13
    cmpq $0,%r13
    je .L12
.L13:
    notq %r12
    addq $1,%r12
    shlq %cl,%r12
    jmp .L5
.L16:
    movq %r11, %r12
    movb $0,%cl
    movq %r12,%r13
    andq $1,%r13
    cmpq $0,%r13
    jg .L18
.L17:
    addb $1,%cl
    shrq $1, %r12
    movq %r12,%r13
    andq $1,%r13
    cmpq $0,%r13
    je .L17
.L18:
    notq %r12
    addq $1,%r12
    shlq %cl,%r12
    movq %r12, %r11
    jmp .L19














