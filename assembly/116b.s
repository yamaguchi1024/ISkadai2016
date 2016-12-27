.abiversion 2
.section .data
buff:
    .space 100000
.section .text
.globl _start
_start:
main:
write:
    li %r0,4
    li %r3,1
    addis %r4,%r2,name@ha
    addi %r4,%r4,name@l
    li %r5,10
    sc

read:
    li %r0,3
    li %r3,0
    addis %r4,%r2,buff@ha
    addi %r4,%r4,buff@l
    li %r5,1
    sc
    blr

    

name:
    .string "Your name?"
hello:
    .string "Hello,"
