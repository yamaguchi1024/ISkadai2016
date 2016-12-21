.globl fib
fib:
    cmpdi %r3,0
    beqlr
    mflr %r0
    std %r0,16(%r1)
    stdu %r1,-32(%r1)
    subi %r4,%r3,1
    mullw %r3,%r3,%r4
    bl fib
    addi %r1,%r1,32
    ld %r0,16(%r1)
    mtlr %r0
    blr
