.section .data
cwd: .space 1024
.section .text
.globl  print_cwd
print_cwd:
    mflr %r0
    std %r0,16(%r1)
    stdu %r1,-48(%r1)

    li %r0,182
    addis %r3,%r2,cwd@toc@ha
    addi %r3,%r3,cwd@toc@l
    li %r4,1024
    sc

    li %r0,4
    li %r3,1
    addis %r4,%r2,cwd@toc@ha
    addi %r4,%r4,cwd@toc@l
    li %r5,100
    sc

    blr

