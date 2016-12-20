    .globl mystrcat
mystrcat:
#戻り値のために、destの先頭のポインタを退避させておく。
    mr %r8,%r3
loop:
#r5<-M[r3+0]
    lbz %r5,0(%r3)
#r5がnull文字か調べる。
    cmpwi %r5,0
#null文字だったらジャンプ。
    beq copy
#null文字じゃなかったら、インクリメントしてnull文字が出てくるまで探す。
    addi %r3,%r3,1
    b loop
copy:
#r6<-M[r4+0]
    lbz %r6,0(%r4)
#M[r3+0]<-r6
    stb %r6,0(%r3)
#r6がnull文字ならジャンプ。
    cmpwi %r6,0
    beq rtn
#copyしているので、srcのnull文字が出てきてコピーが終わるまでポインタをインクリメントする。
    addi %r4,%r4,1
    addi %r3,%r3,1
    b copy
rtn:
#退避しておいたのを元に戻す。
    mr %r3,%r8
    blr 
