.section ".rodata"
.align 3
fone:
    .double 1.0
    .double 0.0
    .globl saturate
    .align 2
saturate:
    addis %r3,%r2, fone@ha
    addi %r3,%r3, fone@l
    lfd %f2,0(%r3)
    fcmpu %cr0,%f1,%f2
    bgt move
    lfd %f2,8(%r3)
    fcmpu %cr0,%f1,%f2
    blt move
    blr
move:
    mr %f1,%f2
    blr
