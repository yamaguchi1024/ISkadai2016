#enlargeをシンボルテーブルに追加し、103b.cから見えるようにする。
    .globl enlarge
#enlargeの開始位置。
enlarge:
    #xを31ビット右シフトすると、x>=0のときは%r4==0,x<0の時は%r4==-1となる。
    extsw %r3,%r3
    srdi %r4,%r3,31
    extsw %r4,%r4
    #%r3=%r3+%r4。x<0の時は-1される。
    add %r3,%r3,%r4
    #%r4=%r4+1。
    addi %r4,%r4,1
    #%r3=%r3+%r4。x>=0の時は、+1されるが、x<0の時は%r4==0なのでそのまま。
    add %r3,%r3,%r4
    #return;
    blr
