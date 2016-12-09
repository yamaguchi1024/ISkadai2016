	.file	"102b.c"
	.abiversion 2
	.section	".toc","aw"
	.section	".text"
	.align 2
	.globl f
	.type	f, @function
f:
	std 31,-8(1)
	stdu 1,-64(1)
	mr 31,1
	mr 10,3
	mr 9,4
	stw 10,44(31)
	stw 9,40(31)
	lwz 10,44(31)
	lwz 9,40(31)
	mullw 9,10,9
	extsw 9,9
	cmpwi 7,9,0
	ble 7,.L2
	lwz 10,44(31)
	lwz 9,40(31)
	add 9,10,9
	extsw 9,9
	b .L3
.L2:
	lwz 10,44(31)
	lwz 9,40(31)
	subf 9,9,10
	extsw 9,9
.L3:
	mr 3,9
	addi 1,31,64
	ld 31,-8(1)
	blr
	.long 0
	.byte 0,0,0,0,128,1,0,1
	.size	f,.-f
	.ident	"GCC: (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
