.globl  ntimes
#int ntimes(int n, int (*f)(int), int x);
ntimes:
#非揮発性レジスタの退避
    std %r31,-8(%r1)
    std %r30,-16(%r1)
    std %r29,-24(%r1)
#n,f,xを非揮発性レジスタに入れる
    mr %r29,%r3
    mr %r30,%r4
    mr %r31,%r5
    mflr %r0
    std %r0,16(%r1)
    stdu %r1,-64(%r1)
    mr %r3,%r31
loop:
    cmpdi %r29,0
    ble end
    mtctr %r30
    bctrl
    addi %r29,%r29,-1
    b loop
end:
    addi %r1,%r1,64
    ld %r0,16(%r1)
    mtlr %r0
    ld %r29,-24(%r1)
    ld %r30,-16(%r1)
    ld %r31,-8(%r1)
    blr
