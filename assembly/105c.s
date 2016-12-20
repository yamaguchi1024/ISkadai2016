    .globl fib
fib:
    #fib(i)とfib(i+1)を初期化し、保存しておく。
    li %r4,1
    li %r5,1
loop:
    #r3をデクリメントしていき、1になったらretに飛ばしてreturn
    cmpwi %r3,1
    beq ret
    #r6<-r4+r5
    add %r6,%r4,%r5
    #r4<-r5
    mr %r4,%r5
    #r5<-r6
    mr %r5,%r6
    #r3をデクリメントする。
    subi %r3,%r3,1
    #loopする。
    b loop
ret:
    #r3に結果を入れる。
    mr %r3,%r4
    blr
