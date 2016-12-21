.globl dot
dot:
    mr %r7,0
    mr %r6,0
    li %f1,0
dot2:    
    lfdx %f2,%r4,%r6
    lfdx %f3,%r5,%r6
    fmul %f4,%f2,%f3
    fadd %f1,%f1,%f4
    addi %r6,%r6,8
    addi %r7,%r7,1
    cmpw %r7,%r3
    beqlr
    bl dot2
