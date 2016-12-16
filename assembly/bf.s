	.file	"bf.c"
	.abiversion 2
	.section	".toc","aw"
	.section	".text"
	.section	.rodata
	.align 3
.LC1:
	.string	"%s"
	.section	".toc","aw"
.LC2:
	.quad	.L7
	.section	".text"
	.align 2
	.globl bf
	.type	bf, @function
bf:
0:	addis 2,12,.TOC.-0b@ha
	addi 2,2,.TOC.-0b@l
	.localentry	bf,.-bf
	mflr 0
	std 0,16(1)
	std 31,-8(1)
	lis 0,0xffff
	ori 0,0,0x1510
	stdux 1,1,0
	mr 31,1
	addis 8,31,0x1
	ld 9,-28688(13)
	std 9,-5416(8)
	li 9,0
	li 10,0
	addi 9,31,-5408
	stw 10,5508(9)
	li 10,0
	addi 9,31,-5408
	stw 10,5524(9)
	li 10,0
	addi 9,31,-5408
	stw 10,5512(9)
	li 10,0
	addi 9,31,-5408
	stw 10,5516(9)
	addi 9,31,-5408
	addi 9,9,5528
	mr 4,9
	addis 3,2,.LC1@toc@ha
	addi 3,3,.LC1@toc@l
	bl __isoc99_scanf
	nop
	addi 9,31,-5408
	addi 9,9,5528
	mr 3,9
	bl strlen
	nop
	mr 10,3
	addi 9,31,-5408
	stw 10,5524(9)
	li 10,0
	addi 9,31,-5408
	stw 10,5520(9)
	b .L2
.L3:
	addi 9,31,-5408
	lwa 9,5520(9)
	li 10,0
	ori 10,10,0xeae0
	add 10,10,31
	add 9,10,9
	li 10,0
	stb 10,-30008(9)
	addi 9,31,-5408
	lwz 9,5520(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5520(9)
.L2:
	addi 9,31,-5408
	lwz 9,5520(9)
	cmpwi 7,9,29999
	ble 7,.L3
	b .L4
.L25:
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	extsw 9,9
	addi 9,9,-43
	cmplwi 7,9,50
	bgt 7,.L5
	rldicl 9,9,0,32
	sldi 10,9,2
	addis 8,2,.LC2@toc@ha
	ld 9,.LC2@toc@l(8)
	add 9,10,9
	lwz 10,0(9)
	addis 8,2,.LC2@toc@ha
	ld 9,.LC2@toc@l(8)
	extsw 10,10
	add 9,10,9
	mtctr 9
	bctr
	.p2align 2
	.align 2
.L7:
	.long .L6-.L7
	.long .L8-.L7
	.long .L9-.L7
	.long .L10-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L11-.L7
	.long .L5-.L7
	.long .L12-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L5-.L7
	.long .L13-.L7
	.long .L5-.L7
	.long .L14-.L7
.L12:
	addi 9,31,-5408
	lwz 9,5512(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5512(9)
	b .L5
.L11:
	addi 9,31,-5408
	lwz 9,5512(9)
	addi 10,9,-1
	addi 9,31,-5408
	stw 10,5512(9)
	b .L5
.L6:
	addi 9,31,-5408
	lwa 9,5512(9)
	li 8,0
	ori 8,8,0xeae0
	add 8,8,31
	add 9,8,9
	lbz 9,-30008(9)
	addi 9,9,1
	rlwinm 10,9,0,0xff
	addi 9,31,-5408
	lwa 9,5512(9)
	li 8,0
	ori 8,8,0xeae0
	add 8,8,31
	add 9,8,9
	stb 10,-30008(9)
	b .L5
.L9:
	addi 9,31,-5408
	lwa 9,5512(9)
	li 10,0
	ori 10,10,0xeae0
	add 10,10,31
	add 9,10,9
	lbz 9,-30008(9)
	addi 9,9,-1
	rlwinm 10,9,0,0xff
	addi 9,31,-5408
	lwa 9,5512(9)
	li 8,0
	ori 8,8,0xeae0
	add 8,8,31
	add 9,8,9
	stb 10,-30008(9)
	b .L5
.L10:
	addi 9,31,-5408
	lwa 9,5512(9)
	li 10,0
	ori 10,10,0xeae0
	add 10,10,31
	add 9,10,9
	lbz 9,-30008(9)
	extsw 9,9
	mr 3,9
	bl putchar
	nop
	b .L5
.L8:
	bl getchar
	nop
	mr 9,3
	rlwinm 10,9,0,0xff
	addi 9,31,-5408
	lwa 9,5512(9)
	li 8,0
	ori 8,8,0xeae0
	add 8,8,31
	add 9,8,9
	stb 10,-30008(9)
	b .L5
.L13:
	addi 9,31,-5408
	lwa 9,5512(9)
	li 10,0
	ori 10,10,0xeae0
	add 10,10,31
	add 9,10,9
	lbz 9,-30008(9)
	cmpdi 7,9,0
	bne 7,.L27
	addi 9,31,-5408
	lwz 9,5508(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5508(9)
	b .L16
.L19:
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	cmplwi 7,9,91
	bne 7,.L17
	addi 9,31,-5408
	lwz 9,5516(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5516(9)
.L17:
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	cmplwi 7,9,93
	bne 7,.L18
	addi 9,31,-5408
	lwz 9,5516(9)
	addi 10,9,-1
	addi 9,31,-5408
	stw 10,5516(9)
.L18:
	addi 9,31,-5408
	lwz 9,5508(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5508(9)
.L16:
	addi 9,31,-5408
	lwz 9,5516(9)
	cmpwi 7,9,0
	bgt 7,.L19
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	cmplwi 7,9,93
	bne 7,.L19
	b .L27
.L14:
	addi 9,31,-5408
	lwa 9,5512(9)
	li 8,0
	ori 8,8,0xeae0
	add 8,8,31
	add 9,8,9
	lbz 9,-30008(9)
	cmpdi 7,9,0
	beq 7,.L28
	addi 9,31,-5408
	lwz 9,5508(9)
	addi 10,9,-1
	addi 9,31,-5408
	stw 10,5508(9)
	b .L21
.L24:
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	cmplwi 7,9,93
	bne 7,.L22
	addi 9,31,-5408
	lwz 9,5516(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5516(9)
.L22:
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	cmplwi 7,9,91
	bne 7,.L23
	addi 9,31,-5408
	lwz 9,5516(9)
	addi 10,9,-1
	addi 9,31,-5408
	stw 10,5516(9)
.L23:
	addi 9,31,-5408
	lwz 9,5508(9)
	addi 10,9,-1
	addi 9,31,-5408
	stw 10,5508(9)
.L21:
	addi 9,31,-5408
	lwz 9,5516(9)
	cmpwi 7,9,0
	bgt 7,.L24
	addi 9,31,-5408
	lwa 9,5508(9)
	addi 10,31,-5408
	addi 10,10,5528
	add 9,10,9
	lbz 9,0(9)
	cmplwi 7,9,91
	bne 7,.L24
	addi 9,31,-5408
	lwz 9,5508(9)
	addi 10,9,-1
	addi 9,31,-5408
	stw 10,5508(9)
	b .L28
.L27:
	nop
	b .L5
.L28:
	nop
.L5:
	addi 9,31,-5408
	lwz 9,5508(9)
	addi 10,9,1
	addi 9,31,-5408
	stw 10,5508(9)
.L4:
	addi 9,31,-5408
	lwz 10,5508(9)
	addi 9,31,-5408
	lwz 9,5524(9)
	cmpw 7,10,9
	blt 7,.L25
	nop
	addis 9,31,0x1
	ld 10,-5416(9)
	ld 9,-28688(13)
	cmpld 7,10,9
	li 10,0
	li 9,0
	beq 7,.L26
	bl __stack_chk_fail
	nop
.L26:
	ld 1,0(1)
	ld 0,16(1)
	mtlr 0
	ld 31,-8(1)
	blr
	.long 0
	.byte 0,0,0,1,128,1,0,1
	.size	bf,.-bf
	.align 2
	.globl main
	.type	main, @function
main:
0:	addis 2,12,.TOC.-0b@ha
	addi 2,2,.TOC.-0b@l
	.localentry	main,.-main
	mflr 0
	std 0,16(1)
	std 31,-8(1)
	stdu 1,-128(1)
	mr 31,1
	mr 9,3
	std 4,96(31)
	stw 9,108(31)
	bl bf
	li 9,0
	mr 3,9
	addi 1,31,128
	ld 0,16(1)
	mtlr 0
	ld 31,-8(1)
	blr
	.long 0
	.byte 0,0,0,1,128,1,0,1
	.size	main,.-main
	.ident	"GCC: (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
