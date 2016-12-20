    .globl swap_gt
swap_gt:
    #r3,r4はポインタなので、それぞれの内容をr5,r6にコピーする。
    ld %r5,0(%r3)
    ld %r6,0(%r4)
    #cmpをする。
    cmpd %r5,%r6
    #大きければ、つまりx-y>0ならばジャンプする。そうでなければ戻る。
    bgt swap
    blr
swap:
    #loadしたのと逆にストアする。
    stw %r5,0(%r4)
    stw %r6,0(%r3)
    blr

