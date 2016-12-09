#enlargeをシンボルテーブルに追加し、103b.cから見えるようにする。
    .globl enlarge
#enlargeの開始位置。
enlarge:
    #x>=0なら、x_addに分岐。それ以外ならx<0なので-1する。
    cmpwi %r3, 0
    #cr0をみて、x>=0ならx_addに分岐。
    bge x_add
    #%r3 = %r3 - 1;
    subi %r3,%r3,1
    #return;
    blr
#x_addの開始位置。
x_add:
    #%r3 = %r3 + 1;
    addi %r3,%r3,1
    #return;
    blr
