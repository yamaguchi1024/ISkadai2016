    .globl prime_factor
prime_factor:
    li %r4,2
loop:
    divw %r5,%r3,%r4
    mullw %r5,%r5,%r4
    bne cont
    mr %r3,%r4
    blr
cont:
    addi %r4,%r4,1

