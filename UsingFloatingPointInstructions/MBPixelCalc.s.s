.section .data
.section .text
.global MBPixelCalc

MBPixelCalc:
    pushq %rsp
    //clear registers
    xorpd %xmm3, %xmm3
    xorpd %xmm4, %xmm4
    xorpd %xmm5, %xmm5
    xorpd %xmm6, %xmm6
    xorpd %xmm7, %xmm7
    xorpd %xmm8, %xmm8

    //moving 4 into xmm9
    movq $0x4010000000000000, %rax
    pushq %rax
    movsd (%rsp),%xmm9
    popq %rax
    movl $0, %eax


    //make sure iteration <1000
    cmpq $1000, %rax
    jge .L2
    jmp .L3
.L0:
    ucomisd %xmm9,%xmm7
    //if x^2+y^2(in %xmm7)>4, jump and return
    ja .L2
.L1:
    //make sure iterations<1000
    cmpq $1000, %rax
    jge .L2
    //xtemp=x^2-y^2+x0
    movsd %xmm5,%xmm10
    subsd %xmm6,%xmm10
    addsd %xmm0, %xmm10


    //y=2xy+y0
    movq $0x4000000000000000, %r8
    pushq %r8
    movsd (%rsp), %xmm11
    popq %r8
    mulsd %xmm11, %xmm4
    mulsd %xmm3, %xmm4
    addsd %xmm1, %xmm4

    //x=xtemp
    movsd %xmm10,%xmm3

    //increment iteration
    addq $1,%rax
    jmp .L3

.L2:
    popq %rsp
    ret
.L3:
    //put x^2 in xmm5, y^2 in xmm6 and x^2+y^2 in xmm7
    xorpd %xmm5,%xmm5
    xorpd %xmm6, %xmm6
    movsd %xmm3,%xmm5
    mulsd %xmm5,%xmm5
    movsd %xmm4,%xmm6
    mulsd %xmm6, %xmm6

    xorpd %xmm7,%xmm7
    addsd %xmm6,%xmm7
    addsd %xmm5,%xmm7

    jmp .L0
