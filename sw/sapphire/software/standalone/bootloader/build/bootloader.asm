
build/bootloader.elf:     file format elf32-littleriscv


Disassembly of section .start:

f9000000 <_start>:
f9000000:	00008197          	auipc	gp,0x8
f9000004:	3e818193          	addi	gp,gp,1000 # f90083e8 <__global_pointer$>

f9000008 <init>:
f9000008:	89c18113          	addi	sp,gp,-1892 # f9007c84 <_sp>
f900000c:	00008517          	auipc	a0,0x8
f9000010:	bc850513          	addi	a0,a0,-1080 # f9007bd4 <_data>
f9000014:	00008597          	auipc	a1,0x8
f9000018:	bc058593          	addi	a1,a1,-1088 # f9007bd4 <_data>
f900001c:	81c18613          	addi	a2,gp,-2020 # f9007c04 <__bss_start>
f9000020:	00c5fc63          	bgeu	a1,a2,f9000038 <init+0x30>
f9000024:	00052283          	lw	t0,0(a0)
f9000028:	0055a023          	sw	t0,0(a1)
f900002c:	00450513          	addi	a0,a0,4
f9000030:	00458593          	addi	a1,a1,4
f9000034:	fec5e8e3          	bltu	a1,a2,f9000024 <init+0x1c>
f9000038:	81c18513          	addi	a0,gp,-2020 # f9007c04 <__bss_start>
f900003c:	82018593          	addi	a1,gp,-2016 # f9007c08 <_end>
f9000040:	00b57863          	bgeu	a0,a1,f9000050 <init+0x48>
f9000044:	00052023          	sw	zero,0(a0)
f9000048:	00450513          	addi	a0,a0,4
f900004c:	feb56ce3          	bltu	a0,a1,f9000044 <init+0x3c>
f9000050:	2f1070ef          	jal	ra,f9007b40 <__libc_init_array>
f9000054:	7ac070ef          	jal	ra,f9007800 <main>

f9000058 <mainDone>:
f9000058:	0000006f          	j	f9000058 <mainDone>

f900005c <_init>:
f900005c:	00008067          	ret

Disassembly of section .text:

f9007800 <main>:
f9007800:	12c0006f          	j	f900792c <bspMain>

f9007804 <spi_diselect.constprop.11>:
f9007804:	00010737          	lui	a4,0x10
f9007808:	f80146b7          	lui	a3,0xf8014
f900780c:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f9007810:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f9007814:	00e7f7b3          	and	a5,a5,a4
f9007818:	fe078ce3          	beqz	a5,f9007810 <spi_diselect.constprop.11+0xc>
f900781c:	000017b7          	lui	a5,0x1
f9007820:	80078793          	addi	a5,a5,-2048 # 800 <__stack_size+0x780>
f9007824:	00f6a023          	sw	a5,0(a3)
f9007828:	00008067          	ret

f900782c <spi_read.constprop.14>:
f900782c:	00010737          	lui	a4,0x10
f9007830:	f80146b7          	lui	a3,0xf8014
f9007834:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f9007838:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f900783c:	00e7f7b3          	and	a5,a5,a4
f9007840:	fe078ce3          	beqz	a5,f9007838 <spi_read.constprop.14+0xc>
f9007844:	20000793          	li	a5,512
f9007848:	00f6a023          	sw	a5,0(a3)
f900784c:	f8014737          	lui	a4,0xf8014
f9007850:	00472783          	lw	a5,4(a4) # f8014004 <__global_pointer$+0xff00bc1c>
f9007854:	0107d793          	srli	a5,a5,0x10
f9007858:	fe078ce3          	beqz	a5,f9007850 <spi_read.constprop.14+0x24>
f900785c:	00072503          	lw	a0,0(a4)
f9007860:	0ff57513          	andi	a0,a0,255
f9007864:	00008067          	ret

f9007868 <spi_write.constprop.19>:
f9007868:	00010737          	lui	a4,0x10
f900786c:	f80146b7          	lui	a3,0xf8014
f9007870:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f9007874:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f9007878:	00e7f7b3          	and	a5,a5,a4
f900787c:	fe078ce3          	beqz	a5,f9007874 <spi_write.constprop.19+0xc>
f9007880:	10056513          	ori	a0,a0,256
f9007884:	00a6a023          	sw	a0,0(a3)
f9007888:	00008067          	ret

f900788c <spi_waitXferBusy.constprop.9>:
f900788c:	f8b0c7b7          	lui	a5,0xf8b0c
f9007890:	ff87a703          	lw	a4,-8(a5) # f8b0bff8 <__global_pointer$+0xffb03c10>
f9007894:	f8b0c6b7          	lui	a3,0xf8b0c
f9007898:	06470713          	addi	a4,a4,100
f900789c:	ff86a783          	lw	a5,-8(a3) # f8b0bff8 <__global_pointer$+0xffb03c10>
f90078a0:	40f707b3          	sub	a5,a4,a5
f90078a4:	fe07dce3          	bgez	a5,f900789c <spi_waitXferBusy.constprop.9+0x10>
f90078a8:	00010737          	lui	a4,0x10
f90078ac:	f8014637          	lui	a2,0xf8014
f90078b0:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f90078b4:	10000693          	li	a3,256
f90078b8:	00462783          	lw	a5,4(a2) # f8014004 <__global_pointer$+0xff00bc1c>
f90078bc:	00e7f7b3          	and	a5,a5,a4
f90078c0:	fed79ce3          	bne	a5,a3,f90078b8 <spi_waitXferBusy.constprop.9+0x2c>
f90078c4:	00008067          	ret

f90078c8 <bsp_print>:
f90078c8:	f80106b7          	lui	a3,0xf8010
f90078cc:	00054703          	lbu	a4,0(a0)
f90078d0:	04071063          	bnez	a4,f9007910 <bsp_print+0x48>
f90078d4:	f8010737          	lui	a4,0xf8010
f90078d8:	00472783          	lw	a5,4(a4) # f8010004 <__global_pointer$+0xff007c1c>
f90078dc:	0107d793          	srli	a5,a5,0x10
f90078e0:	0ff7f793          	andi	a5,a5,255
f90078e4:	fe078ae3          	beqz	a5,f90078d8 <bsp_print+0x10>
f90078e8:	00a00793          	li	a5,10
f90078ec:	00f72023          	sw	a5,0(a4)
f90078f0:	f8010737          	lui	a4,0xf8010
f90078f4:	00472783          	lw	a5,4(a4) # f8010004 <__global_pointer$+0xff007c1c>
f90078f8:	0107d793          	srli	a5,a5,0x10
f90078fc:	0ff7f793          	andi	a5,a5,255
f9007900:	fe078ae3          	beqz	a5,f90078f4 <bsp_print+0x2c>
f9007904:	00d00793          	li	a5,13
f9007908:	00f72023          	sw	a5,0(a4)
f900790c:	00008067          	ret
f9007910:	00150513          	addi	a0,a0,1
f9007914:	0046a783          	lw	a5,4(a3) # f8010004 <__global_pointer$+0xff007c1c>
f9007918:	0107d793          	srli	a5,a5,0x10
f900791c:	0ff7f793          	andi	a5,a5,255
f9007920:	fe078ae3          	beqz	a5,f9007914 <bsp_print+0x4c>
f9007924:	00e6a023          	sw	a4,0(a3)
f9007928:	fa5ff06f          	j	f90078cc <bsp_print+0x4>

f900792c <bspMain>:
f900792c:	f9008537          	lui	a0,0xf9008
f9007930:	fe010113          	addi	sp,sp,-32
f9007934:	bd450513          	addi	a0,a0,-1068 # f9007bd4 <__global_pointer$+0xfffff7ec>
f9007938:	00112e23          	sw	ra,28(sp)
f900793c:	00812c23          	sw	s0,24(sp)
f9007940:	00912a23          	sw	s1,20(sp)
f9007944:	f85ff0ef          	jal	ra,f90078c8 <bsp_print>
f9007948:	f80147b7          	lui	a5,0xf8014
f900794c:	0007a423          	sw	zero,8(a5) # f8014008 <__global_pointer$+0xff00bc20>
f9007950:	00200713          	li	a4,2
f9007954:	02e7a023          	sw	a4,32(a5)
f9007958:	00500693          	li	a3,5
f900795c:	02d7a223          	sw	a3,36(a5)
f9007960:	02e7a423          	sw	a4,40(a5)
f9007964:	00700713          	li	a4,7
f9007968:	02e7a623          	sw	a4,44(a5)
f900796c:	f21ff0ef          	jal	ra,f900788c <spi_waitXferBusy.constprop.9>
f9007970:	e95ff0ef          	jal	ra,f9007804 <spi_diselect.constprop.11>
f9007974:	00010737          	lui	a4,0x10
f9007978:	f80146b7          	lui	a3,0xf8014
f900797c:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f9007980:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f9007984:	00e7f7b3          	and	a5,a5,a4
f9007988:	fe078ce3          	beqz	a5,f9007980 <bspMain+0x54>
f900798c:	000017b7          	lui	a5,0x1
f9007990:	88078793          	addi	a5,a5,-1920 # 880 <__stack_size+0x800>
f9007994:	00f6a023          	sw	a5,0(a3)
f9007998:	0ab00513          	li	a0,171
f900799c:	ecdff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f90079a0:	e65ff0ef          	jal	ra,f9007804 <spi_diselect.constprop.11>
f90079a4:	ee9ff0ef          	jal	ra,f900788c <spi_waitXferBusy.constprop.9>
f90079a8:	f8b0c7b7          	lui	a5,0xf8b0c
f90079ac:	ff87a703          	lw	a4,-8(a5) # f8b0bff8 <__global_pointer$+0xffb03c10>
f90079b0:	000027b7          	lui	a5,0x2
f90079b4:	71078793          	addi	a5,a5,1808 # 2710 <__stack_size+0x2690>
f90079b8:	00f70733          	add	a4,a4,a5
f90079bc:	f8b0c6b7          	lui	a3,0xf8b0c
f90079c0:	ff86a783          	lw	a5,-8(a3) # f8b0bff8 <__global_pointer$+0xffb03c10>
f90079c4:	40f707b3          	sub	a5,a4,a5
f90079c8:	fe07dce3          	bgez	a5,f90079c0 <bspMain+0x94>
f90079cc:	00010737          	lui	a4,0x10
f90079d0:	f80146b7          	lui	a3,0xf8014
f90079d4:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f90079d8:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f90079dc:	00e7f7b3          	and	a5,a5,a4
f90079e0:	fe078ce3          	beqz	a5,f90079d8 <bspMain+0xac>
f90079e4:	000017b7          	lui	a5,0x1
f90079e8:	88078793          	addi	a5,a5,-1920 # 880 <__stack_size+0x800>
f90079ec:	00f6a023          	sw	a5,0(a3)
f90079f0:	09000513          	li	a0,144
f90079f4:	e75ff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f90079f8:	00000513          	li	a0,0
f90079fc:	e6dff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007a00:	00000513          	li	a0,0
f9007a04:	e65ff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007a08:	00000513          	li	a0,0
f9007a0c:	e5dff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007a10:	e1dff0ef          	jal	ra,f900782c <spi_read.constprop.14>
f9007a14:	f8b0c7b7          	lui	a5,0xf8b0c
f9007a18:	ff87a703          	lw	a4,-8(a5) # f8b0bff8 <__global_pointer$+0xffb03c10>
f9007a1c:	000077b7          	lui	a5,0x7
f9007a20:	53078793          	addi	a5,a5,1328 # 7530 <__stack_size+0x74b0>
f9007a24:	00f70733          	add	a4,a4,a5
f9007a28:	f8b0c6b7          	lui	a3,0xf8b0c
f9007a2c:	ff86a783          	lw	a5,-8(a3) # f8b0bff8 <__global_pointer$+0xffb03c10>
f9007a30:	40f707b3          	sub	a5,a4,a5
f9007a34:	fe07dce3          	bgez	a5,f9007a2c <bspMain+0x100>
f9007a38:	00a12623          	sw	a0,12(sp)
f9007a3c:	dc9ff0ef          	jal	ra,f9007804 <spi_diselect.constprop.11>
f9007a40:	e4dff0ef          	jal	ra,f900788c <spi_waitXferBusy.constprop.9>
f9007a44:	00c12503          	lw	a0,12(sp)
f9007a48:	00010737          	lui	a4,0x10
f9007a4c:	f80146b7          	lui	a3,0xf8014
f9007a50:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f9007a54:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f9007a58:	00e7f7b3          	and	a5,a5,a4
f9007a5c:	fe078ce3          	beqz	a5,f9007a54 <bspMain+0x128>
f9007a60:	000017b7          	lui	a5,0x1
f9007a64:	88078793          	addi	a5,a5,-1920 # 880 <__stack_size+0x800>
f9007a68:	00f6a023          	sw	a5,0(a3)
f9007a6c:	09d00793          	li	a5,157
f9007a70:	0cf50463          	beq	a0,a5,f9007b38 <bspMain+0x20c>
f9007a74:	0c200793          	li	a5,194
f9007a78:	00f51663          	bne	a0,a5,f9007a84 <bspMain+0x158>
f9007a7c:	0e900513          	li	a0,233
f9007a80:	de9ff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007a84:	d81ff0ef          	jal	ra,f9007804 <spi_diselect.constprop.11>
f9007a88:	e05ff0ef          	jal	ra,f900788c <spi_waitXferBusy.constprop.9>
f9007a8c:	00010737          	lui	a4,0x10
f9007a90:	f80146b7          	lui	a3,0xf8014
f9007a94:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xff7f>
f9007a98:	0046a783          	lw	a5,4(a3) # f8014004 <__global_pointer$+0xff00bc1c>
f9007a9c:	00e7f7b3          	and	a5,a5,a4
f9007aa0:	fe078ce3          	beqz	a5,f9007a98 <bspMain+0x16c>
f9007aa4:	000017b7          	lui	a5,0x1
f9007aa8:	88078793          	addi	a5,a5,-1920 # 880 <__stack_size+0x800>
f9007aac:	00f6a023          	sw	a5,0(a3)
f9007ab0:	00b00513          	li	a0,11
f9007ab4:	db5ff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007ab8:	08000513          	li	a0,128
f9007abc:	dadff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007ac0:	00000513          	li	a0,0
f9007ac4:	da5ff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007ac8:	00000513          	li	a0,0
f9007acc:	d9dff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007ad0:	00000513          	li	a0,0
f9007ad4:	f90084b7          	lui	s1,0xf9008
f9007ad8:	d91ff0ef          	jal	ra,f9007868 <spi_write.constprop.19>
f9007adc:	f9000437          	lui	s0,0xf9000
f9007ae0:	80048493          	addi	s1,s1,-2048 # f9007800 <__global_pointer$+0xfffff418>
f9007ae4:	d49ff0ef          	jal	ra,f900782c <spi_read.constprop.14>
f9007ae8:	00a40023          	sb	a0,0(s0) # f9000000 <__global_pointer$+0xffff7c18>
f9007aec:	00140413          	addi	s0,s0,1
f9007af0:	fe941ae3          	bne	s0,s1,f9007ae4 <bspMain+0x1b8>
f9007af4:	d11ff0ef          	jal	ra,f9007804 <spi_diselect.constprop.11>
f9007af8:	0000100f          	fence.i
f9007afc:	00000013          	nop
f9007b00:	00000013          	nop
f9007b04:	00000013          	nop
f9007b08:	00000013          	nop
f9007b0c:	00000013          	nop
f9007b10:	00000013          	nop
f9007b14:	f9008537          	lui	a0,0xf9008
f9007b18:	be850513          	addi	a0,a0,-1048 # f9007be8 <__global_pointer$+0xfffff800>
f9007b1c:	dadff0ef          	jal	ra,f90078c8 <bsp_print>
f9007b20:	01812403          	lw	s0,24(sp)
f9007b24:	01c12083          	lw	ra,28(sp)
f9007b28:	01412483          	lw	s1,20(sp)
f9007b2c:	f9000337          	lui	t1,0xf9000
f9007b30:	02010113          	addi	sp,sp,32
f9007b34:	00030067          	jr	t1 # f9000000 <__global_pointer$+0xffff7c18>
f9007b38:	02900513          	li	a0,41
f9007b3c:	f45ff06f          	j	f9007a80 <bspMain+0x154>

Disassembly of section .text.__libc_init_array:

f9007b40 <__libc_init_array>:
f9007b40:	ff010113          	addi	sp,sp,-16
f9007b44:	00812423          	sw	s0,8(sp)
f9007b48:	01212023          	sw	s2,0(sp)
f9007b4c:	00000417          	auipc	s0,0x0
f9007b50:	08840413          	addi	s0,s0,136 # f9007bd4 <_data>
f9007b54:	00000917          	auipc	s2,0x0
f9007b58:	08090913          	addi	s2,s2,128 # f9007bd4 <_data>
f9007b5c:	40890933          	sub	s2,s2,s0
f9007b60:	00112623          	sw	ra,12(sp)
f9007b64:	00912223          	sw	s1,4(sp)
f9007b68:	40295913          	srai	s2,s2,0x2
f9007b6c:	00090e63          	beqz	s2,f9007b88 <__libc_init_array+0x48>
f9007b70:	00000493          	li	s1,0
f9007b74:	00042783          	lw	a5,0(s0)
f9007b78:	00148493          	addi	s1,s1,1
f9007b7c:	00440413          	addi	s0,s0,4
f9007b80:	000780e7          	jalr	a5
f9007b84:	fe9918e3          	bne	s2,s1,f9007b74 <__libc_init_array+0x34>
f9007b88:	00000417          	auipc	s0,0x0
f9007b8c:	04c40413          	addi	s0,s0,76 # f9007bd4 <_data>
f9007b90:	00000917          	auipc	s2,0x0
f9007b94:	04490913          	addi	s2,s2,68 # f9007bd4 <_data>
f9007b98:	40890933          	sub	s2,s2,s0
f9007b9c:	40295913          	srai	s2,s2,0x2
f9007ba0:	00090e63          	beqz	s2,f9007bbc <__libc_init_array+0x7c>
f9007ba4:	00000493          	li	s1,0
f9007ba8:	00042783          	lw	a5,0(s0)
f9007bac:	00148493          	addi	s1,s1,1
f9007bb0:	00440413          	addi	s0,s0,4
f9007bb4:	000780e7          	jalr	a5
f9007bb8:	fe9918e3          	bne	s2,s1,f9007ba8 <__libc_init_array+0x68>
f9007bbc:	00c12083          	lw	ra,12(sp)
f9007bc0:	00812403          	lw	s0,8(sp)
f9007bc4:	00412483          	lw	s1,4(sp)
f9007bc8:	00012903          	lw	s2,0(sp)
f9007bcc:	01010113          	addi	sp,sp,16
f9007bd0:	00008067          	ret
