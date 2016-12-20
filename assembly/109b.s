.globl puts_twice
puts_twice:
    mflr %r0
    std %r0,16(%r1)
    stdu %r1,-112(%r1)
    bl puts
    nop
    bl puts 
    blr
    nop
    la %r1,112(%r1)
    ld %r0,16(%r1)
    mtlr %r0
    blr
