#.data section
.data
#4バイト境界にパディング
.align 2
msg:
    .string "Hello, world!"
    .align 2
    .globl hello
hello:
#r3の上位16ビットにロードする。
    lis %r3,msg@ha
#r3の下位6ビットにロードする(加算することによって)
    addi %r3,%r3,msg@l
    blr
