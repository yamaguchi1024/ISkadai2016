    .globl swap_gt
swap_gt:
    #r3,r4はポインタなので、それぞれの内容をr5,r6にコピーする。
    lbz %r5,0(%r3)
    lbz %r6,0(%r4)
    #r7 <- r5 - r6をする。
    sub. %r7,%r5,%r6
    #大きければ、つまりx-y>0ならばジャンプする。そうでなければ戻る。
    bgt swap
    blr
swap:
    #loadしたのと逆にストアする。
    stw %r5,0(%r4)
    stw %r6,0(%r3)
    blr

