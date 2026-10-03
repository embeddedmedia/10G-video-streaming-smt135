
build/app.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:
f9000000:	00005197          	auipc	gp,0x5
f9000004:	13018193          	addi	gp,gp,304 # f9005130 <__global_pointer$>

f9000008 <init>:
f9000008:	00006117          	auipc	sp,0x6
f900000c:	9b810113          	addi	sp,sp,-1608 # f90059c0 <__freertos_irq_stack_top>
f9000010:	00004517          	auipc	a0,0x4
f9000014:	e5c50513          	addi	a0,a0,-420 # f9003e6c <_data>
f9000018:	00004597          	auipc	a1,0x4
f900001c:	e5458593          	addi	a1,a1,-428 # f9003e6c <_data>
f9000020:	84418613          	addi	a2,gp,-1980 # f9004974 <__bss_start>
f9000024:	00c5fc63          	bgeu	a1,a2,f900003c <init+0x34>
f9000028:	00052283          	lw	t0,0(a0)
f900002c:	0055a023          	sw	t0,0(a1)
f9000030:	00450513          	addi	a0,a0,4
f9000034:	00458593          	addi	a1,a1,4
f9000038:	fec5e8e3          	bltu	a1,a2,f9000028 <init+0x20>
f900003c:	84418513          	addi	a0,gp,-1980 # f9004974 <__bss_start>
f9000040:	88818593          	addi	a1,gp,-1912 # f90049b8 <_end>
f9000044:	00b57863          	bgeu	a0,a1,f9000054 <init+0x4c>
f9000048:	00052023          	sw	zero,0(a0)
f900004c:	00450513          	addi	a0,a0,4
f9000050:	feb56ce3          	bltu	a0,a1,f9000048 <init+0x40>
f9000054:	010000ef          	jal	ra,f9000064 <__libc_init_array>
f9000058:	1bc000ef          	jal	ra,f9000214 <main>

f900005c <mainDone>:
f900005c:	0000006f          	j	f900005c <mainDone>

f9000060 <_init>:
f9000060:	00008067          	ret

Disassembly of section .text:

f9000064 <__libc_init_array>:
f9000064:	ff010113          	addi	sp,sp,-16
f9000068:	00812423          	sw	s0,8(sp)
f900006c:	01212023          	sw	s2,0(sp)
f9000070:	00004417          	auipc	s0,0x4
f9000074:	dfc40413          	addi	s0,s0,-516 # f9003e6c <_data>
f9000078:	00004917          	auipc	s2,0x4
f900007c:	df490913          	addi	s2,s2,-524 # f9003e6c <_data>
f9000080:	40890933          	sub	s2,s2,s0
f9000084:	00112623          	sw	ra,12(sp)
f9000088:	00912223          	sw	s1,4(sp)
f900008c:	40295913          	srai	s2,s2,0x2
f9000090:	00090e63          	beqz	s2,f90000ac <__libc_init_array+0x48>
f9000094:	00000493          	li	s1,0
f9000098:	00042783          	lw	a5,0(s0)
f900009c:	00148493          	addi	s1,s1,1
f90000a0:	00440413          	addi	s0,s0,4
f90000a4:	000780e7          	jalr	a5
f90000a8:	fe9918e3          	bne	s2,s1,f9000098 <__libc_init_array+0x34>
f90000ac:	00004417          	auipc	s0,0x4
f90000b0:	dc040413          	addi	s0,s0,-576 # f9003e6c <_data>
f90000b4:	00004917          	auipc	s2,0x4
f90000b8:	db890913          	addi	s2,s2,-584 # f9003e6c <_data>
f90000bc:	40890933          	sub	s2,s2,s0
f90000c0:	40295913          	srai	s2,s2,0x2
f90000c4:	00090e63          	beqz	s2,f90000e0 <__libc_init_array+0x7c>
f90000c8:	00000493          	li	s1,0
f90000cc:	00042783          	lw	a5,0(s0)
f90000d0:	00148493          	addi	s1,s1,1
f90000d4:	00440413          	addi	s0,s0,4
f90000d8:	000780e7          	jalr	a5
f90000dc:	fe9918e3          	bne	s2,s1,f90000cc <__libc_init_array+0x68>
f90000e0:	00c12083          	lw	ra,12(sp)
f90000e4:	00812403          	lw	s0,8(sp)
f90000e8:	00412483          	lw	s1,4(sp)
f90000ec:	00012903          	lw	s2,0(sp)
f90000f0:	01010113          	addi	sp,sp,16
f90000f4:	00008067          	ret

f90000f8 <memcpy>:
f90000f8:	00a5c7b3          	xor	a5,a1,a0
f90000fc:	0037f793          	andi	a5,a5,3
f9000100:	00c508b3          	add	a7,a0,a2
f9000104:	06079263          	bnez	a5,f9000168 <memcpy+0x70>
f9000108:	00300793          	li	a5,3
f900010c:	04c7fe63          	bgeu	a5,a2,f9000168 <memcpy+0x70>
f9000110:	00357793          	andi	a5,a0,3
f9000114:	00050713          	mv	a4,a0
f9000118:	06079863          	bnez	a5,f9000188 <memcpy+0x90>
f900011c:	ffc8f613          	andi	a2,a7,-4
f9000120:	fe060793          	addi	a5,a2,-32
f9000124:	08f76c63          	bltu	a4,a5,f90001bc <memcpy+0xc4>
f9000128:	02c77c63          	bgeu	a4,a2,f9000160 <memcpy+0x68>
f900012c:	00058693          	mv	a3,a1
f9000130:	00070793          	mv	a5,a4
f9000134:	0006a803          	lw	a6,0(a3)
f9000138:	00478793          	addi	a5,a5,4
f900013c:	00468693          	addi	a3,a3,4
f9000140:	ff07ae23          	sw	a6,-4(a5)
f9000144:	fec7e8e3          	bltu	a5,a2,f9000134 <memcpy+0x3c>
f9000148:	fff60793          	addi	a5,a2,-1
f900014c:	40e787b3          	sub	a5,a5,a4
f9000150:	ffc7f793          	andi	a5,a5,-4
f9000154:	00478793          	addi	a5,a5,4
f9000158:	00f70733          	add	a4,a4,a5
f900015c:	00f585b3          	add	a1,a1,a5
f9000160:	01176863          	bltu	a4,a7,f9000170 <memcpy+0x78>
f9000164:	00008067          	ret
f9000168:	00050713          	mv	a4,a0
f900016c:	ff157ce3          	bgeu	a0,a7,f9000164 <memcpy+0x6c>
f9000170:	0005c783          	lbu	a5,0(a1)
f9000174:	00170713          	addi	a4,a4,1
f9000178:	00158593          	addi	a1,a1,1
f900017c:	fef70fa3          	sb	a5,-1(a4)
f9000180:	ff1768e3          	bltu	a4,a7,f9000170 <memcpy+0x78>
f9000184:	00008067          	ret
f9000188:	0005c683          	lbu	a3,0(a1)
f900018c:	00170713          	addi	a4,a4,1
f9000190:	00377793          	andi	a5,a4,3
f9000194:	fed70fa3          	sb	a3,-1(a4)
f9000198:	00158593          	addi	a1,a1,1
f900019c:	f80780e3          	beqz	a5,f900011c <memcpy+0x24>
f90001a0:	0005c683          	lbu	a3,0(a1)
f90001a4:	00170713          	addi	a4,a4,1
f90001a8:	00377793          	andi	a5,a4,3
f90001ac:	fed70fa3          	sb	a3,-1(a4)
f90001b0:	00158593          	addi	a1,a1,1
f90001b4:	fc079ae3          	bnez	a5,f9000188 <memcpy+0x90>
f90001b8:	f65ff06f          	j	f900011c <memcpy+0x24>
f90001bc:	0005a683          	lw	a3,0(a1)
f90001c0:	0045a283          	lw	t0,4(a1)
f90001c4:	0085af83          	lw	t6,8(a1)
f90001c8:	00c5af03          	lw	t5,12(a1)
f90001cc:	0105ae83          	lw	t4,16(a1)
f90001d0:	0145ae03          	lw	t3,20(a1)
f90001d4:	0185a303          	lw	t1,24(a1)
f90001d8:	01c5a803          	lw	a6,28(a1)
f90001dc:	02458593          	addi	a1,a1,36
f90001e0:	00d72023          	sw	a3,0(a4)
f90001e4:	ffc5a683          	lw	a3,-4(a1)
f90001e8:	00572223          	sw	t0,4(a4)
f90001ec:	01f72423          	sw	t6,8(a4)
f90001f0:	01e72623          	sw	t5,12(a4)
f90001f4:	01d72823          	sw	t4,16(a4)
f90001f8:	01c72a23          	sw	t3,20(a4)
f90001fc:	00672c23          	sw	t1,24(a4)
f9000200:	01072e23          	sw	a6,28(a4)
f9000204:	02470713          	addi	a4,a4,36
f9000208:	fed72e23          	sw	a3,-4(a4)
f900020c:	faf768e3          	bltu	a4,a5,f90001bc <memcpy+0xc4>
f9000210:	f19ff06f          	j	f9000128 <memcpy+0x30>

f9000214 <main>:
f9000214:	f9004537          	lui	a0,0xf9004
f9000218:	ff010113          	addi	sp,sp,-16
f900021c:	24c50513          	addi	a0,a0,588 # f900424c <__freertos_irq_stack_top+0xffffe88c>
f9000220:	00112623          	sw	ra,12(sp)
f9000224:	00812423          	sw	s0,8(sp)
f9000228:	00912223          	sw	s1,4(sp)
f900022c:	01212023          	sw	s2,0(sp)
f9000230:	73c000ef          	jal	ra,f900096c <_putchar_s>
f9000234:	00a00513          	li	a0,10
f9000238:	718000ef          	jal	ra,f9000950 <_putchar>
f900023c:	00d00513          	li	a0,13
f9000240:	710000ef          	jal	ra,f9000950 <_putchar>
f9000244:	479000ef          	jal	ra,f9000ebc <init>
f9000248:	f8b0c7b7          	lui	a5,0xf8b0c
f900024c:	ff87a703          	lw	a4,-8(a5) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f9000250:	05f5e7b7          	lui	a5,0x5f5e
f9000254:	10078793          	addi	a5,a5,256 # 5f5e100 <__stack_size+0x5f5d100>
f9000258:	00f70733          	add	a4,a4,a5
f900025c:	f8b0c6b7          	lui	a3,0xf8b0c
f9000260:	ff86a783          	lw	a5,-8(a3) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f9000264:	40f707b3          	sub	a5,a4,a5
f9000268:	fe07dce3          	bgez	a5,f9000260 <main+0x4c>
f900026c:	000f4437          	lui	s0,0xf4
f9000270:	4a5000ef          	jal	ra,f9000f14 <print_menu>
f9000274:	f8010937          	lui	s2,0xf8010
f9000278:	f8b0c4b7          	lui	s1,0xf8b0c
f900027c:	24040413          	addi	s0,s0,576 # f4240 <__stack_size+0xf3240>
f9000280:	00492783          	lw	a5,4(s2) # f8010004 <__freertos_irq_stack_top+0xff00a644>
f9000284:	0187d793          	srli	a5,a5,0x18
f9000288:	00079e63          	bnez	a5,f90002a4 <main+0x90>
f900028c:	ff84a703          	lw	a4,-8(s1) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f9000290:	00870733          	add	a4,a4,s0
f9000294:	ff84a783          	lw	a5,-8(s1)
f9000298:	40f707b3          	sub	a5,a4,a5
f900029c:	fe07dce3          	bgez	a5,f9000294 <main+0x80>
f90002a0:	fe1ff06f          	j	f9000280 <main+0x6c>
f90002a4:	579000ef          	jal	ra,f900101c <console_main>
f90002a8:	fd9ff06f          	j	f9000280 <main+0x6c>

f90002ac <_putchar>:
f90002ac:	f8010737          	lui	a4,0xf8010
f90002b0:	00472783          	lw	a5,4(a4) # f8010004 <__freertos_irq_stack_top+0xff00a644>
f90002b4:	0107d793          	srli	a5,a5,0x10
f90002b8:	0ff7f793          	andi	a5,a5,255
f90002bc:	fe078ae3          	beqz	a5,f90002b0 <_putchar+0x4>
f90002c0:	00a72023          	sw	a0,0(a4)
f90002c4:	00008067          	ret

f90002c8 <bsp_printf>:
f90002c8:	f8010113          	addi	sp,sp,-128
f90002cc:	05312623          	sw	s3,76(sp)
f90002d0:	05412423          	sw	s4,72(sp)
f90002d4:	06f12a23          	sw	a5,116(sp)
f90002d8:	f90049b7          	lui	s3,0xf9004
f90002dc:	06410793          	addi	a5,sp,100
f90002e0:	f9004a37          	lui	s4,0xf9004
f90002e4:	05212823          	sw	s2,80(sp)
f90002e8:	05512223          	sw	s5,68(sp)
f90002ec:	05612023          	sw	s6,64(sp)
f90002f0:	03712e23          	sw	s7,60(sp)
f90002f4:	03812c23          	sw	s8,56(sp)
f90002f8:	04112e23          	sw	ra,92(sp)
f90002fc:	04812c23          	sw	s0,88(sp)
f9000300:	04912a23          	sw	s1,84(sp)
f9000304:	03912a23          	sw	s9,52(sp)
f9000308:	00050a93          	mv	s5,a0
f900030c:	06b12223          	sw	a1,100(sp)
f9000310:	06c12423          	sw	a2,104(sp)
f9000314:	06d12623          	sw	a3,108(sp)
f9000318:	06e12823          	sw	a4,112(sp)
f900031c:	07012c23          	sw	a6,120(sp)
f9000320:	07112e23          	sw	a7,124(sp)
f9000324:	00f12623          	sw	a5,12(sp)
f9000328:	00000913          	li	s2,0
f900032c:	02500b13          	li	s6,37
f9000330:	06300b93          	li	s7,99
f9000334:	f9004c37          	lui	s8,0xf9004
f9000338:	fec98993          	addi	s3,s3,-20 # f9003fec <__freertos_irq_stack_top+0xffffe62c>
f900033c:	000a0a13          	mv	s4,s4
f9000340:	012a87b3          	add	a5,s5,s2
f9000344:	0007c503          	lbu	a0,0(a5)
f9000348:	02051c63          	bnez	a0,f9000380 <bsp_printf+0xb8>
f900034c:	05c12083          	lw	ra,92(sp)
f9000350:	05812403          	lw	s0,88(sp)
f9000354:	05412483          	lw	s1,84(sp)
f9000358:	05012903          	lw	s2,80(sp)
f900035c:	04c12983          	lw	s3,76(sp)
f9000360:	04812a03          	lw	s4,72(sp)
f9000364:	04412a83          	lw	s5,68(sp)
f9000368:	04012b03          	lw	s6,64(sp)
f900036c:	03c12b83          	lw	s7,60(sp)
f9000370:	03812c03          	lw	s8,56(sp)
f9000374:	03412c83          	lw	s9,52(sp)
f9000378:	08010113          	addi	sp,sp,128
f900037c:	00008067          	ret
f9000380:	03651e63          	bne	a0,s6,f90003bc <bsp_printf+0xf4>
f9000384:	07300713          	li	a4,115
f9000388:	06400693          	li	a3,100
f900038c:	05800613          	li	a2,88
f9000390:	07800593          	li	a1,120
f9000394:	06600513          	li	a0,102
f9000398:	00190913          	addi	s2,s2,1
f900039c:	012a87b3          	add	a5,s5,s2
f90003a0:	0007c783          	lbu	a5,0(a5)
f90003a4:	02078e63          	beqz	a5,f90003e0 <bsp_printf+0x118>
f90003a8:	01779e63          	bne	a5,s7,f90003c4 <bsp_printf+0xfc>
f90003ac:	00c12783          	lw	a5,12(sp)
f90003b0:	0007c503          	lbu	a0,0(a5)
f90003b4:	00478713          	addi	a4,a5,4
f90003b8:	00e12623          	sw	a4,12(sp)
f90003bc:	ef1ff0ef          	jal	ra,f90002ac <_putchar>
f90003c0:	0200006f          	j	f90003e0 <bsp_printf+0x118>
f90003c4:	02e79863          	bne	a5,a4,f90003f4 <bsp_printf+0x12c>
f90003c8:	00c12783          	lw	a5,12(sp)
f90003cc:	0007a403          	lw	s0,0(a5)
f90003d0:	00478713          	addi	a4,a5,4
f90003d4:	00e12623          	sw	a4,12(sp)
f90003d8:	00044503          	lbu	a0,0(s0)
f90003dc:	00051663          	bnez	a0,f90003e8 <bsp_printf+0x120>
f90003e0:	00190913          	addi	s2,s2,1
f90003e4:	f5dff06f          	j	f9000340 <bsp_printf+0x78>
f90003e8:	00140413          	addi	s0,s0,1
f90003ec:	ec1ff0ef          	jal	ra,f90002ac <_putchar>
f90003f0:	fe9ff06f          	j	f90003d8 <bsp_printf+0x110>
f90003f4:	06d79263          	bne	a5,a3,f9000458 <bsp_printf+0x190>
f90003f8:	00c12783          	lw	a5,12(sp)
f90003fc:	0007a483          	lw	s1,0(a5)
f9000400:	00478713          	addi	a4,a5,4
f9000404:	00e12623          	sw	a4,12(sp)
f9000408:	0004d863          	bgez	s1,f9000418 <bsp_printf+0x150>
f900040c:	02d00513          	li	a0,45
f9000410:	e9dff0ef          	jal	ra,f90002ac <_putchar>
f9000414:	409004b3          	neg	s1,s1
f9000418:	01010413          	addi	s0,sp,16
f900041c:	00040c93          	mv	s9,s0
f9000420:	00a00713          	li	a4,10
f9000424:	00049e63          	bnez	s1,f9000440 <bsp_printf+0x178>
f9000428:	01940c63          	beq	s0,s9,f9000440 <bsp_printf+0x178>
f900042c:	fff40413          	addi	s0,s0,-1
f9000430:	00044503          	lbu	a0,0(s0)
f9000434:	e79ff0ef          	jal	ra,f90002ac <_putchar>
f9000438:	ff941ae3          	bne	s0,s9,f900042c <bsp_printf+0x164>
f900043c:	fa5ff06f          	j	f90003e0 <bsp_printf+0x118>
f9000440:	02e4e7b3          	rem	a5,s1,a4
f9000444:	00140413          	addi	s0,s0,1
f9000448:	03078793          	addi	a5,a5,48
f900044c:	fef40fa3          	sb	a5,-1(s0)
f9000450:	02e4c4b3          	div	s1,s1,a4
f9000454:	fd1ff06f          	j	f9000424 <bsp_printf+0x15c>
f9000458:	02c79e63          	bne	a5,a2,f9000494 <bsp_printf+0x1cc>
f900045c:	00c12783          	lw	a5,12(sp)
f9000460:	01c00413          	li	s0,28
f9000464:	ffc00493          	li	s1,-4
f9000468:	0007ac83          	lw	s9,0(a5)
f900046c:	00478713          	addi	a4,a5,4
f9000470:	00e12623          	sw	a4,12(sp)
f9000474:	008cd7b3          	srl	a5,s9,s0
f9000478:	00f7f793          	andi	a5,a5,15
f900047c:	00fa07b3          	add	a5,s4,a5
f9000480:	0007c503          	lbu	a0,0(a5)
f9000484:	ffc40413          	addi	s0,s0,-4
f9000488:	e25ff0ef          	jal	ra,f90002ac <_putchar>
f900048c:	fe9414e3          	bne	s0,s1,f9000474 <bsp_printf+0x1ac>
f9000490:	f51ff06f          	j	f90003e0 <bsp_printf+0x118>
f9000494:	02b79e63          	bne	a5,a1,f90004d0 <bsp_printf+0x208>
f9000498:	00c12783          	lw	a5,12(sp)
f900049c:	01c00413          	li	s0,28
f90004a0:	ffc00493          	li	s1,-4
f90004a4:	0007ac83          	lw	s9,0(a5)
f90004a8:	00478713          	addi	a4,a5,4
f90004ac:	00e12623          	sw	a4,12(sp)
f90004b0:	008cd7b3          	srl	a5,s9,s0
f90004b4:	00f7f793          	andi	a5,a5,15
f90004b8:	00f987b3          	add	a5,s3,a5
f90004bc:	0007c503          	lbu	a0,0(a5)
f90004c0:	ffc40413          	addi	s0,s0,-4
f90004c4:	de9ff0ef          	jal	ra,f90002ac <_putchar>
f90004c8:	fe9414e3          	bne	s0,s1,f90004b0 <bsp_printf+0x1e8>
f90004cc:	f15ff06f          	j	f90003e0 <bsp_printf+0x118>
f90004d0:	eca794e3          	bne	a5,a0,f9000398 <bsp_printf+0xd0>
f90004d4:	fa0c0413          	addi	s0,s8,-96 # f9003fa0 <__freertos_irq_stack_top+0xffffe5e0>
f90004d8:	00c0006f          	j	f90004e4 <bsp_printf+0x21c>
f90004dc:	00140413          	addi	s0,s0,1
f90004e0:	dcdff0ef          	jal	ra,f90002ac <_putchar>
f90004e4:	00044503          	lbu	a0,0(s0)
f90004e8:	fe051ae3          	bnez	a0,f90004dc <bsp_printf+0x214>
f90004ec:	ef5ff06f          	j	f90003e0 <bsp_printf+0x118>

f90004f0 <read_apb_reg>:
f90004f0:	f81007b7          	lui	a5,0xf8100
f90004f4:	00f50533          	add	a0,a0,a5
f90004f8:	00052503          	lw	a0,0(a0)
f90004fc:	00008067          	ret

f9000500 <write_apb_reg>:
f9000500:	f81007b7          	lui	a5,0xf8100
f9000504:	00f585b3          	add	a1,a1,a5
f9000508:	00a5a023          	sw	a0,0(a1)
f900050c:	00008067          	ret

f9000510 <update_video_timing>:
f9000510:	00052703          	lw	a4,0(a0)
f9000514:	f81007b7          	lui	a5,0xf8100
f9000518:	02e7a223          	sw	a4,36(a5) # f8100024 <__freertos_irq_stack_top+0xff0fa664>
f900051c:	00852703          	lw	a4,8(a0)
f9000520:	02e7a423          	sw	a4,40(a5)
f9000524:	00c52703          	lw	a4,12(a0)
f9000528:	02e7a623          	sw	a4,44(a5)
f900052c:	00452703          	lw	a4,4(a0)
f9000530:	02e7a823          	sw	a4,48(a5)
f9000534:	01052703          	lw	a4,16(a0)
f9000538:	02e7aa23          	sw	a4,52(a5)
f900053c:	01852703          	lw	a4,24(a0)
f9000540:	02e7ac23          	sw	a4,56(a5)
f9000544:	01c52703          	lw	a4,28(a0)
f9000548:	02e7ae23          	sw	a4,60(a5)
f900054c:	01452703          	lw	a4,20(a0)
f9000550:	04e7a023          	sw	a4,64(a5)
f9000554:	02052703          	lw	a4,32(a0)
f9000558:	04e7a223          	sw	a4,68(a5)
f900055c:	02452703          	lw	a4,36(a0)
f9000560:	04e7a423          	sw	a4,72(a5)
f9000564:	00008067          	ret

f9000568 <reg_init>:
f9000568:	fa010113          	addi	sp,sp,-96
f900056c:	04912a23          	sw	s1,84(sp)
f9000570:	05212823          	sw	s2,80(sp)
f9000574:	04112e23          	sw	ra,92(sp)
f9000578:	04812c23          	sw	s0,88(sp)
f900057c:	05312623          	sw	s3,76(sp)
f9000580:	05412423          	sw	s4,72(sp)
f9000584:	05512223          	sw	s5,68(sp)
f9000588:	05612023          	sw	s6,64(sp)
f900058c:	03712e23          	sw	s7,60(sp)
f9000590:	03812c23          	sw	s8,56(sp)
f9000594:	f82007b7          	lui	a5,0xf8200
f9000598:	0007a423          	sw	zero,8(a5) # f8200008 <__freertos_irq_stack_top+0xff1fa648>
f900059c:	f8100737          	lui	a4,0xf8100
f90005a0:	02072023          	sw	zero,32(a4) # f8100020 <__freertos_irq_stack_top+0xff0fa660>
f90005a4:	04072623          	sw	zero,76(a4)
f90005a8:	00100713          	li	a4,1
f90005ac:	00e7a423          	sw	a4,8(a5)
f90005b0:	f8b0c7b7          	lui	a5,0xf8b0c
f90005b4:	ff87a703          	lw	a4,-8(a5) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f90005b8:	05f5e7b7          	lui	a5,0x5f5e
f90005bc:	ac1064b7          	lui	s1,0xac106
f90005c0:	10078793          	addi	a5,a5,256 # 5f5e100 <__stack_size+0x5f5d100>
f90005c4:	41448913          	addi	s2,s1,1044 # ac106414 <__freertos_irq_stack_top+0xb3100a54>
f90005c8:	00f70733          	add	a4,a4,a5
f90005cc:	40a48493          	addi	s1,s1,1034
f90005d0:	f8b0c6b7          	lui	a3,0xf8b0c
f90005d4:	ff86a783          	lw	a5,-8(a3) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f90005d8:	40f707b3          	sub	a5,a4,a5
f90005dc:	fe07dce3          	bgez	a5,f90005d4 <reg_init+0x6c>
f90005e0:	f9004537          	lui	a0,0xf9004
f90005e4:	f8100437          	lui	s0,0xf8100
f90005e8:	01450513          	addi	a0,a0,20 # f9004014 <__freertos_irq_stack_top+0xffffe654>
f90005ec:	cddff0ef          	jal	ra,f90002c8 <bsp_printf>
f90005f0:	05242823          	sw	s2,80(s0) # f8100050 <__freertos_irq_stack_top+0xff0fa690>
f90005f4:	04942a23          	sw	s1,84(s0)
f90005f8:	04942c23          	sw	s1,88(s0)
f90005fc:	4d200793          	li	a5,1234
f9000600:	04f42e23          	sw	a5,92(s0)
f9000604:	4d300793          	li	a5,1235
f9000608:	06f42023          	sw	a5,96(s0)
f900060c:	f90045b7          	lui	a1,0xf9004
f9000610:	46000793          	li	a5,1120
f9000614:	06f42a23          	sw	a5,116(s0)
f9000618:	02800613          	li	a2,40
f900061c:	e7058593          	addi	a1,a1,-400 # f9003e70 <__freertos_irq_stack_top+0xffffe4b0>
f9000620:	00010513          	mv	a0,sp
f9000624:	ad5ff0ef          	jal	ra,f90000f8 <memcpy>
f9000628:	00010513          	mv	a0,sp
f900062c:	ee5ff0ef          	jal	ra,f9000510 <update_video_timing>
f9000630:	00100793          	li	a5,1
f9000634:	04f42623          	sw	a5,76(s0)
f9000638:	f9004937          	lui	s2,0xf9004
f900063c:	02f42023          	sw	a5,32(s0)
f9000640:	f8100ab7          	lui	s5,0xf8100
f9000644:	00000413          	li	s0,0
f9000648:	f9004b37          	lui	s6,0xf9004
f900064c:	fec90913          	addi	s2,s2,-20 # f9003fec <__freertos_irq_stack_top+0xffffe62c>
f9000650:	ffc00b93          	li	s7,-4
f9000654:	f9004a37          	lui	s4,0xf9004
f9000658:	01900993          	li	s3,25
f900065c:	00241793          	slli	a5,s0,0x2
f9000660:	015787b3          	add	a5,a5,s5
f9000664:	00040593          	mv	a1,s0
f9000668:	038b0513          	addi	a0,s6,56 # f9004038 <__freertos_irq_stack_top+0xffffe678>
f900066c:	0007ac03          	lw	s8,0(a5)
f9000670:	01c00493          	li	s1,28
f9000674:	c55ff0ef          	jal	ra,f90002c8 <bsp_printf>
f9000678:	009c57b3          	srl	a5,s8,s1
f900067c:	00f7f793          	andi	a5,a5,15
f9000680:	00f907b3          	add	a5,s2,a5
f9000684:	0007c503          	lbu	a0,0(a5)
f9000688:	ffc48493          	addi	s1,s1,-4
f900068c:	c21ff0ef          	jal	ra,f90002ac <_putchar>
f9000690:	ff7494e3          	bne	s1,s7,f9000678 <reg_init+0x110>
f9000694:	058a0513          	addi	a0,s4,88 # f9004058 <__freertos_irq_stack_top+0xffffe698>
f9000698:	00140413          	addi	s0,s0,1
f900069c:	c2dff0ef          	jal	ra,f90002c8 <bsp_printf>
f90006a0:	fb341ee3          	bne	s0,s3,f900065c <reg_init+0xf4>
f90006a4:	f9004537          	lui	a0,0xf9004
f90006a8:	04c50513          	addi	a0,a0,76 # f900404c <__freertos_irq_stack_top+0xffffe68c>
f90006ac:	c1dff0ef          	jal	ra,f90002c8 <bsp_printf>
f90006b0:	f8b0c7b7          	lui	a5,0xf8b0c
f90006b4:	ff87a703          	lw	a4,-8(a5) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f90006b8:	004c57b7          	lui	a5,0x4c5
f90006bc:	b4078793          	addi	a5,a5,-1216 # 4c4b40 <__stack_size+0x4c3b40>
f90006c0:	00f70733          	add	a4,a4,a5
f90006c4:	f8b0c6b7          	lui	a3,0xf8b0c
f90006c8:	ff86a783          	lw	a5,-8(a3) # f8b0bff8 <__freertos_irq_stack_top+0xffb06638>
f90006cc:	40f707b3          	sub	a5,a4,a5
f90006d0:	fe07dce3          	bgez	a5,f90006c8 <reg_init+0x160>
f90006d4:	05c12083          	lw	ra,92(sp)
f90006d8:	05812403          	lw	s0,88(sp)
f90006dc:	05412483          	lw	s1,84(sp)
f90006e0:	05012903          	lw	s2,80(sp)
f90006e4:	04c12983          	lw	s3,76(sp)
f90006e8:	04812a03          	lw	s4,72(sp)
f90006ec:	04412a83          	lw	s5,68(sp)
f90006f0:	04012b03          	lw	s6,64(sp)
f90006f4:	03c12b83          	lw	s7,60(sp)
f90006f8:	03812c03          	lw	s8,56(sp)
f90006fc:	06010113          	addi	sp,sp,96
f9000700:	00008067          	ret

f9000704 <Reg_Out32>:
f9000704:	00b52023          	sw	a1,0(a0)
f9000708:	00008067          	ret

f900070c <Reg_In32>:
f900070c:	00052503          	lw	a0,0(a0)
f9000710:	00008067          	ret

f9000714 <assert>:
f9000714:	02051c63          	bnez	a0,f900074c <assert+0x38>
f9000718:	f90047b7          	lui	a5,0xf9004
f900071c:	0d478793          	addi	a5,a5,212 # f90040d4 <__freertos_irq_stack_top+0xffffe714>
f9000720:	f8010637          	lui	a2,0xf8010
f9000724:	01c0006f          	j	f9000740 <assert+0x2c>
f9000728:	00178793          	addi	a5,a5,1
f900072c:	00462703          	lw	a4,4(a2) # f8010004 <__freertos_irq_stack_top+0xff00a644>
f9000730:	01075713          	srli	a4,a4,0x10
f9000734:	0ff77713          	andi	a4,a4,255
f9000738:	fe070ae3          	beqz	a4,f900072c <assert+0x18>
f900073c:	00d62023          	sw	a3,0(a2)
f9000740:	0007c683          	lbu	a3,0(a5)
f9000744:	fe0692e3          	bnez	a3,f9000728 <assert+0x14>
f9000748:	0000006f          	j	f9000748 <assert+0x34>
f900074c:	00008067          	ret

f9000750 <isp_set_color_balance>:
f9000750:	f81007b7          	lui	a5,0xf8100
f9000754:	00a7a423          	sw	a0,8(a5) # f8100008 <__freertos_irq_stack_top+0xff0fa648>
f9000758:	00b7a623          	sw	a1,12(a5)
f900075c:	00c7a823          	sw	a2,16(a5)
f9000760:	00008067          	ret

f9000764 <isp_get_expose_avg>:
f9000764:	f81007b7          	lui	a5,0xf8100
f9000768:	0007a503          	lw	a0,0(a5) # f8100000 <__freertos_irq_stack_top+0xff0fa640>
f900076c:	0047a783          	lw	a5,4(a5)
f9000770:	02f55533          	divu	a0,a0,a5
f9000774:	00008067          	ret

f9000778 <isp_update_gain>:
f9000778:	fe010113          	addi	sp,sp,-32
f900077c:	00112e23          	sw	ra,28(sp)
f9000780:	00812c23          	sw	s0,24(sp)
f9000784:	00912a23          	sw	s1,20(sp)
f9000788:	01212823          	sw	s2,16(sp)
f900078c:	01312623          	sw	s3,12(sp)
f9000790:	01412423          	sw	s4,8(sp)
f9000794:	01512223          	sw	s5,4(sp)
f9000798:	fcdff0ef          	jal	ra,f9000764 <isp_get_expose_avg>
f900079c:	86018493          	addi	s1,gp,-1952 # f9004990 <exp_pid>
f90007a0:	4ec030ef          	jal	ra,f9003c8c <__floatunsisf>
f90007a4:	00050593          	mv	a1,a0
f90007a8:	00c4a503          	lw	a0,12(s1)
f90007ac:	86018413          	addi	s0,gp,-1952 # f9004990 <exp_pid>
f90007b0:	7f5020ef          	jal	ra,f90037a4 <__subsf3>
f90007b4:	0144a983          	lw	s3,20(s1)
f90007b8:	00a4a823          	sw	a0,16(s1)
f90007bc:	00050913          	mv	s2,a0
f90007c0:	00098593          	mv	a1,s3
f90007c4:	7e1020ef          	jal	ra,f90037a4 <__subsf3>
f90007c8:	01c4a583          	lw	a1,28(s1)
f90007cc:	455020ef          	jal	ra,f9003420 <__mulsf3>
f90007d0:	0204a583          	lw	a1,32(s1)
f90007d4:	00050a13          	mv	s4,a0
f90007d8:	00090513          	mv	a0,s2
f90007dc:	445020ef          	jal	ra,f9003420 <__mulsf3>
f90007e0:	00050593          	mv	a1,a0
f90007e4:	000a0513          	mv	a0,s4
f90007e8:	64c020ef          	jal	ra,f9002e34 <__addsf3>
f90007ec:	00050a13          	mv	s4,a0
f90007f0:	00098593          	mv	a1,s3
f90007f4:	00098513          	mv	a0,s3
f90007f8:	63c020ef          	jal	ra,f9002e34 <__addsf3>
f90007fc:	00050593          	mv	a1,a0
f9000800:	00090513          	mv	a0,s2
f9000804:	7a1020ef          	jal	ra,f90037a4 <__subsf3>
f9000808:	0184a583          	lw	a1,24(s1)
f900080c:	628020ef          	jal	ra,f9002e34 <__addsf3>
f9000810:	0244a583          	lw	a1,36(s1)
f9000814:	40d020ef          	jal	ra,f9003420 <__mulsf3>
f9000818:	00050593          	mv	a1,a0
f900081c:	000a0513          	mv	a0,s4
f9000820:	614020ef          	jal	ra,f9002e34 <__addsf3>
f9000824:	0004aa03          	lw	s4,0(s1)
f9000828:	800004b7          	lui	s1,0x80000
f900082c:	00050a93          	mv	s5,a0
f9000830:	0144c4b3          	xor	s1,s1,s4
f9000834:	00048593          	mv	a1,s1
f9000838:	325020ef          	jal	ra,f900335c <__lesf2>
f900083c:	00054e63          	bltz	a0,f9000858 <isp_update_gain+0xe0>
f9000840:	000a0593          	mv	a1,s4
f9000844:	000a8513          	mv	a0,s5
f9000848:	251020ef          	jal	ra,f9003298 <__gesf2>
f900084c:	000a0493          	mv	s1,s4
f9000850:	00a04463          	bgtz	a0,f9000858 <isp_update_gain+0xe0>
f9000854:	000a8493          	mv	s1,s5
f9000858:	00842583          	lw	a1,8(s0)
f900085c:	00048513          	mv	a0,s1
f9000860:	800004b7          	lui	s1,0x80000
f9000864:	5d0020ef          	jal	ra,f9002e34 <__addsf3>
f9000868:	00442a03          	lw	s4,4(s0)
f900086c:	00050a93          	mv	s5,a0
f9000870:	0144c4b3          	xor	s1,s1,s4
f9000874:	00048593          	mv	a1,s1
f9000878:	2e5020ef          	jal	ra,f900335c <__lesf2>
f900087c:	00054e63          	bltz	a0,f9000898 <isp_update_gain+0x120>
f9000880:	000a0593          	mv	a1,s4
f9000884:	000a8513          	mv	a0,s5
f9000888:	211020ef          	jal	ra,f9003298 <__gesf2>
f900088c:	000a0493          	mv	s1,s4
f9000890:	00a04463          	bgtz	a0,f9000898 <isp_update_gain+0x120>
f9000894:	000a8493          	mv	s1,s5
f9000898:	00942423          	sw	s1,8(s0)
f900089c:	01342c23          	sw	s3,24(s0)
f90008a0:	01242a23          	sw	s2,20(s0)
f90008a4:	00048513          	mv	a0,s1
f90008a8:	380030ef          	jal	ra,f9003c28 <__fixunssfsi>
f90008ac:	01c12083          	lw	ra,28(sp)
f90008b0:	01812403          	lw	s0,24(sp)
f90008b4:	01412483          	lw	s1,20(sp)
f90008b8:	01012903          	lw	s2,16(sp)
f90008bc:	00c12983          	lw	s3,12(sp)
f90008c0:	00812a03          	lw	s4,8(sp)
f90008c4:	00412a83          	lw	s5,4(sp)
f90008c8:	02010113          	addi	sp,sp,32
f90008cc:	00008067          	ret

f90008d0 <isp_set_setpoint>:
f90008d0:	ff010113          	addi	sp,sp,-16
f90008d4:	00112623          	sw	ra,12(sp)
f90008d8:	3b4030ef          	jal	ra,f9003c8c <__floatunsisf>
f90008dc:	00c12083          	lw	ra,12(sp)
f90008e0:	86018793          	addi	a5,gp,-1952 # f9004990 <exp_pid>
f90008e4:	00a7a623          	sw	a0,12(a5)
f90008e8:	01010113          	addi	sp,sp,16
f90008ec:	00008067          	ret

f90008f0 <isp_init>:
f90008f0:	ff010113          	addi	sp,sp,-16
f90008f4:	00812423          	sw	s0,8(sp)
f90008f8:	86018413          	addi	s0,gp,-1952 # f9004990 <exp_pid>
f90008fc:	00912223          	sw	s1,4(sp)
f9000900:	00000493          	li	s1,0
f9000904:	00942423          	sw	s1,8(s0)
f9000908:	00112623          	sw	ra,12(sp)
f900090c:	380030ef          	jal	ra,f9003c8c <__floatunsisf>
f9000910:	8281a783          	lw	a5,-2008(gp) # f9004958 <fun_num.3352+0x18>
f9000914:	00942c23          	sw	s1,24(s0)
f9000918:	02942223          	sw	s1,36(s0)
f900091c:	00f42023          	sw	a5,0(s0)
f9000920:	82c1a783          	lw	a5,-2004(gp) # f900495c <fun_num.3352+0x1c>
f9000924:	00a42623          	sw	a0,12(s0)
f9000928:	00c12083          	lw	ra,12(sp)
f900092c:	00f42223          	sw	a5,4(s0)
f9000930:	8301a783          	lw	a5,-2000(gp) # f9004960 <fun_num.3352+0x20>
f9000934:	00412483          	lw	s1,4(sp)
f9000938:	00f42e23          	sw	a5,28(s0)
f900093c:	8341a783          	lw	a5,-1996(gp) # f9004964 <fun_num.3352+0x24>
f9000940:	02f42023          	sw	a5,32(s0)
f9000944:	00812403          	lw	s0,8(sp)
f9000948:	01010113          	addi	sp,sp,16
f900094c:	00008067          	ret

f9000950 <_putchar>:
f9000950:	f8010737          	lui	a4,0xf8010
f9000954:	00472783          	lw	a5,4(a4) # f8010004 <__freertos_irq_stack_top+0xff00a644>
f9000958:	0107d793          	srli	a5,a5,0x10
f900095c:	0ff7f793          	andi	a5,a5,255
f9000960:	fe078ae3          	beqz	a5,f9000954 <_putchar+0x4>
f9000964:	00a72023          	sw	a0,0(a4)
f9000968:	00008067          	ret

f900096c <_putchar_s>:
f900096c:	ff010113          	addi	sp,sp,-16
f9000970:	00812423          	sw	s0,8(sp)
f9000974:	00112623          	sw	ra,12(sp)
f9000978:	00050413          	mv	s0,a0
f900097c:	00044503          	lbu	a0,0(s0)
f9000980:	00051a63          	bnez	a0,f9000994 <_putchar_s+0x28>
f9000984:	00c12083          	lw	ra,12(sp)
f9000988:	00812403          	lw	s0,8(sp)
f900098c:	01010113          	addi	sp,sp,16
f9000990:	00008067          	ret
f9000994:	00140413          	addi	s0,s0,1
f9000998:	fb9ff0ef          	jal	ra,f9000950 <_putchar>
f900099c:	fe1ff06f          	j	f900097c <_putchar_s+0x10>

f90009a0 <bsp_printf>:
f90009a0:	f8010113          	addi	sp,sp,-128
f90009a4:	05312623          	sw	s3,76(sp)
f90009a8:	05412423          	sw	s4,72(sp)
f90009ac:	06f12a23          	sw	a5,116(sp)
f90009b0:	f90049b7          	lui	s3,0xf9004
f90009b4:	06410793          	addi	a5,sp,100
f90009b8:	f9004a37          	lui	s4,0xf9004
f90009bc:	05212823          	sw	s2,80(sp)
f90009c0:	05512223          	sw	s5,68(sp)
f90009c4:	05612023          	sw	s6,64(sp)
f90009c8:	03712e23          	sw	s7,60(sp)
f90009cc:	03812c23          	sw	s8,56(sp)
f90009d0:	04112e23          	sw	ra,92(sp)
f90009d4:	04812c23          	sw	s0,88(sp)
f90009d8:	04912a23          	sw	s1,84(sp)
f90009dc:	03912a23          	sw	s9,52(sp)
f90009e0:	00050a93          	mv	s5,a0
f90009e4:	06b12223          	sw	a1,100(sp)
f90009e8:	06c12423          	sw	a2,104(sp)
f90009ec:	06d12623          	sw	a3,108(sp)
f90009f0:	06e12823          	sw	a4,112(sp)
f90009f4:	07012c23          	sw	a6,120(sp)
f90009f8:	07112e23          	sw	a7,124(sp)
f90009fc:	00f12623          	sw	a5,12(sp)
f9000a00:	00000913          	li	s2,0
f9000a04:	02500b13          	li	s6,37
f9000a08:	06300b93          	li	s7,99
f9000a0c:	f9004c37          	lui	s8,0xf9004
f9000a10:	fec98993          	addi	s3,s3,-20 # f9003fec <__freertos_irq_stack_top+0xffffe62c>
f9000a14:	000a0a13          	mv	s4,s4
f9000a18:	012a87b3          	add	a5,s5,s2
f9000a1c:	0007c503          	lbu	a0,0(a5)
f9000a20:	02051c63          	bnez	a0,f9000a58 <bsp_printf+0xb8>
f9000a24:	05c12083          	lw	ra,92(sp)
f9000a28:	05812403          	lw	s0,88(sp)
f9000a2c:	05412483          	lw	s1,84(sp)
f9000a30:	05012903          	lw	s2,80(sp)
f9000a34:	04c12983          	lw	s3,76(sp)
f9000a38:	04812a03          	lw	s4,72(sp)
f9000a3c:	04412a83          	lw	s5,68(sp)
f9000a40:	04012b03          	lw	s6,64(sp)
f9000a44:	03c12b83          	lw	s7,60(sp)
f9000a48:	03812c03          	lw	s8,56(sp)
f9000a4c:	03412c83          	lw	s9,52(sp)
f9000a50:	08010113          	addi	sp,sp,128
f9000a54:	00008067          	ret
f9000a58:	03651e63          	bne	a0,s6,f9000a94 <bsp_printf+0xf4>
f9000a5c:	07300713          	li	a4,115
f9000a60:	06400693          	li	a3,100
f9000a64:	05800613          	li	a2,88
f9000a68:	07800593          	li	a1,120
f9000a6c:	06600513          	li	a0,102
f9000a70:	00190913          	addi	s2,s2,1
f9000a74:	012a87b3          	add	a5,s5,s2
f9000a78:	0007c783          	lbu	a5,0(a5)
f9000a7c:	08078263          	beqz	a5,f9000b00 <bsp_printf+0x160>
f9000a80:	01779e63          	bne	a5,s7,f9000a9c <bsp_printf+0xfc>
f9000a84:	00c12783          	lw	a5,12(sp)
f9000a88:	0007c503          	lbu	a0,0(a5)
f9000a8c:	00478713          	addi	a4,a5,4
f9000a90:	00e12623          	sw	a4,12(sp)
f9000a94:	ebdff0ef          	jal	ra,f9000950 <_putchar>
f9000a98:	0680006f          	j	f9000b00 <bsp_printf+0x160>
f9000a9c:	00e79e63          	bne	a5,a4,f9000ab8 <bsp_printf+0x118>
f9000aa0:	00c12783          	lw	a5,12(sp)
f9000aa4:	0007a503          	lw	a0,0(a5)
f9000aa8:	00478713          	addi	a4,a5,4
f9000aac:	00e12623          	sw	a4,12(sp)
f9000ab0:	ebdff0ef          	jal	ra,f900096c <_putchar_s>
f9000ab4:	04c0006f          	j	f9000b00 <bsp_printf+0x160>
f9000ab8:	06d79463          	bne	a5,a3,f9000b20 <bsp_printf+0x180>
f9000abc:	00c12783          	lw	a5,12(sp)
f9000ac0:	0007a483          	lw	s1,0(a5)
f9000ac4:	00478713          	addi	a4,a5,4
f9000ac8:	00e12623          	sw	a4,12(sp)
f9000acc:	0004d863          	bgez	s1,f9000adc <bsp_printf+0x13c>
f9000ad0:	02d00513          	li	a0,45
f9000ad4:	e7dff0ef          	jal	ra,f9000950 <_putchar>
f9000ad8:	409004b3          	neg	s1,s1
f9000adc:	01010413          	addi	s0,sp,16
f9000ae0:	00040c93          	mv	s9,s0
f9000ae4:	00a00713          	li	a4,10
f9000ae8:	02049063          	bnez	s1,f9000b08 <bsp_printf+0x168>
f9000aec:	01940e63          	beq	s0,s9,f9000b08 <bsp_printf+0x168>
f9000af0:	fff40413          	addi	s0,s0,-1
f9000af4:	00044503          	lbu	a0,0(s0)
f9000af8:	e59ff0ef          	jal	ra,f9000950 <_putchar>
f9000afc:	ff941ae3          	bne	s0,s9,f9000af0 <bsp_printf+0x150>
f9000b00:	00190913          	addi	s2,s2,1
f9000b04:	f15ff06f          	j	f9000a18 <bsp_printf+0x78>
f9000b08:	02e4e7b3          	rem	a5,s1,a4
f9000b0c:	00140413          	addi	s0,s0,1
f9000b10:	03078793          	addi	a5,a5,48
f9000b14:	fef40fa3          	sb	a5,-1(s0)
f9000b18:	02e4c4b3          	div	s1,s1,a4
f9000b1c:	fcdff06f          	j	f9000ae8 <bsp_printf+0x148>
f9000b20:	02c79e63          	bne	a5,a2,f9000b5c <bsp_printf+0x1bc>
f9000b24:	00c12783          	lw	a5,12(sp)
f9000b28:	01c00413          	li	s0,28
f9000b2c:	ffc00493          	li	s1,-4
f9000b30:	0007ac83          	lw	s9,0(a5)
f9000b34:	00478713          	addi	a4,a5,4
f9000b38:	00e12623          	sw	a4,12(sp)
f9000b3c:	008cd7b3          	srl	a5,s9,s0
f9000b40:	00f7f793          	andi	a5,a5,15
f9000b44:	00fa07b3          	add	a5,s4,a5
f9000b48:	0007c503          	lbu	a0,0(a5)
f9000b4c:	ffc40413          	addi	s0,s0,-4
f9000b50:	e01ff0ef          	jal	ra,f9000950 <_putchar>
f9000b54:	fe9414e3          	bne	s0,s1,f9000b3c <bsp_printf+0x19c>
f9000b58:	fa9ff06f          	j	f9000b00 <bsp_printf+0x160>
f9000b5c:	02b79e63          	bne	a5,a1,f9000b98 <bsp_printf+0x1f8>
f9000b60:	00c12783          	lw	a5,12(sp)
f9000b64:	01c00413          	li	s0,28
f9000b68:	ffc00493          	li	s1,-4
f9000b6c:	0007ac83          	lw	s9,0(a5)
f9000b70:	00478713          	addi	a4,a5,4
f9000b74:	00e12623          	sw	a4,12(sp)
f9000b78:	008cd7b3          	srl	a5,s9,s0
f9000b7c:	00f7f793          	andi	a5,a5,15
f9000b80:	00f987b3          	add	a5,s3,a5
f9000b84:	0007c503          	lbu	a0,0(a5)
f9000b88:	ffc40413          	addi	s0,s0,-4
f9000b8c:	dc5ff0ef          	jal	ra,f9000950 <_putchar>
f9000b90:	fe9414e3          	bne	s0,s1,f9000b78 <bsp_printf+0x1d8>
f9000b94:	f6dff06f          	j	f9000b00 <bsp_printf+0x160>
f9000b98:	eca79ce3          	bne	a5,a0,f9000a70 <bsp_printf+0xd0>
f9000b9c:	fa0c0513          	addi	a0,s8,-96 # f9003fa0 <__freertos_irq_stack_top+0xffffe5e0>
f9000ba0:	f11ff06f          	j	f9000ab0 <bsp_printf+0x110>

f9000ba4 <crash>:
f9000ba4:	00058613          	mv	a2,a1
f9000ba8:	00050593          	mv	a1,a0
f9000bac:	f9004537          	lui	a0,0xf9004
f9000bb0:	ff010113          	addi	sp,sp,-16
f9000bb4:	0e450513          	addi	a0,a0,228 # f90040e4 <__freertos_irq_stack_top+0xffffe724>
f9000bb8:	00112623          	sw	ra,12(sp)
f9000bbc:	de5ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000bc0:	0000006f          	j	f9000bc0 <crash+0x1c>

f9000bc4 <poll_host_settings>:
f9000bc4:	fe010113          	addi	sp,sp,-32
f9000bc8:	06400513          	li	a0,100
f9000bcc:	00112e23          	sw	ra,28(sp)
f9000bd0:	00812c23          	sw	s0,24(sp)
f9000bd4:	00912a23          	sw	s1,20(sp)
f9000bd8:	01212823          	sw	s2,16(sp)
f9000bdc:	01312623          	sw	s3,12(sp)
f9000be0:	01412423          	sw	s4,8(sp)
f9000be4:	01512223          	sw	s5,4(sp)
f9000be8:	01612023          	sw	s6,0(sp)
f9000bec:	905ff0ef          	jal	ra,f90004f0 <read_apb_reg>
f9000bf0:	00050b13          	mv	s6,a0
f9000bf4:	06800513          	li	a0,104
f9000bf8:	8f9ff0ef          	jal	ra,f90004f0 <read_apb_reg>
f9000bfc:	00050413          	mv	s0,a0
f9000c00:	06c00513          	li	a0,108
f9000c04:	8edff0ef          	jal	ra,f90004f0 <read_apb_reg>
f9000c08:	00050493          	mv	s1,a0
f9000c0c:	07000513          	li	a0,112
f9000c10:	8e1ff0ef          	jal	ra,f90004f0 <read_apb_reg>
f9000c14:	85c1a783          	lw	a5,-1956(gp) # f900498c <e_raw.3289>
f9000c18:	01679e63          	bne	a5,s6,f9000c34 <poll_host_settings+0x70>
f9000c1c:	8581a783          	lw	a5,-1960(gp) # f9004988 <r_raw.3290>
f9000c20:	00879a63          	bne	a5,s0,f9000c34 <poll_host_settings+0x70>
f9000c24:	8541a783          	lw	a5,-1964(gp) # f9004984 <g_raw.3291>
f9000c28:	00979663          	bne	a5,s1,f9000c34 <poll_host_settings+0x70>
f9000c2c:	8501a783          	lw	a5,-1968(gp) # f9004980 <b_raw.3292>
f9000c30:	0aa78863          	beq	a5,a0,f9000ce0 <poll_host_settings+0x11c>
f9000c34:	8481ac23          	sw	s0,-1960(gp) # f9004988 <r_raw.3290>
f9000c38:	8491aa23          	sw	s1,-1964(gp) # f9004984 <g_raw.3291>
f9000c3c:	84a1a823          	sw	a0,-1968(gp) # f9004980 <b_raw.3292>
f9000c40:	8561ae23          	sw	s6,-1956(gp) # f900498c <e_raw.3289>
f9000c44:	f8050513          	addi	a0,a0,-128
f9000c48:	12c020ef          	jal	ra,f9002d74 <__floatsidf>
f9000c4c:	8181a603          	lw	a2,-2024(gp) # f9004948 <fun_num.3352+0x8>
f9000c50:	81c1a683          	lw	a3,-2020(gp) # f900494c <fun_num.3352+0xc>
f9000c54:	12440413          	addi	s0,s0,292
f9000c58:	08048493          	addi	s1,s1,128 # 80000080 <__freertos_irq_stack_top+0x86ffa6c0>
f9000c5c:	241010ef          	jal	ra,f900269c <__muldf3>
f9000c60:	8201a603          	lw	a2,-2016(gp) # f9004950 <fun_num.3352+0x10>
f9000c64:	8241a683          	lw	a3,-2012(gp) # f9004954 <fun_num.3352+0x14>
f9000c68:	1b0010ef          	jal	ra,f9001e18 <__adddf3>
f9000c6c:	084020ef          	jal	ra,f9002cf0 <__fixdfsi>
f9000c70:	00050613          	mv	a2,a0
f9000c74:	00055463          	bgez	a0,f9000c7c <poll_host_settings+0xb8>
f9000c78:	00000613          	li	a2,0
f9000c7c:	00048593          	mv	a1,s1
f9000c80:	0004d463          	bgez	s1,f9000c88 <poll_host_settings+0xc4>
f9000c84:	00000593          	li	a1,0
f9000c88:	00040513          	mv	a0,s0
f9000c8c:	00045463          	bgez	s0,f9000c94 <poll_host_settings+0xd0>
f9000c90:	00000513          	li	a0,0
f9000c94:	abdff0ef          	jal	ra,f9000750 <isp_set_color_balance>
f9000c98:	000b0513          	mv	a0,s6
f9000c9c:	c35ff0ef          	jal	ra,f90008d0 <isp_set_setpoint>
f9000ca0:	01812403          	lw	s0,24(sp)
f9000ca4:	8501a703          	lw	a4,-1968(gp) # f9004980 <b_raw.3292>
f9000ca8:	8541a683          	lw	a3,-1964(gp) # f9004984 <g_raw.3291>
f9000cac:	8581a603          	lw	a2,-1960(gp) # f9004988 <r_raw.3290>
f9000cb0:	85c1a583          	lw	a1,-1956(gp) # f900498c <e_raw.3289>
f9000cb4:	01c12083          	lw	ra,28(sp)
f9000cb8:	01412483          	lw	s1,20(sp)
f9000cbc:	01012903          	lw	s2,16(sp)
f9000cc0:	00c12983          	lw	s3,12(sp)
f9000cc4:	00812a03          	lw	s4,8(sp)
f9000cc8:	00412a83          	lw	s5,4(sp)
f9000ccc:	00012b03          	lw	s6,0(sp)
f9000cd0:	f9004537          	lui	a0,0xf9004
f9000cd4:	10450513          	addi	a0,a0,260 # f9004104 <__freertos_irq_stack_top+0xffffe744>
f9000cd8:	02010113          	addi	sp,sp,32
f9000cdc:	cc5ff06f          	j	f90009a0 <bsp_printf>
f9000ce0:	01c12083          	lw	ra,28(sp)
f9000ce4:	01812403          	lw	s0,24(sp)
f9000ce8:	01412483          	lw	s1,20(sp)
f9000cec:	01012903          	lw	s2,16(sp)
f9000cf0:	00c12983          	lw	s3,12(sp)
f9000cf4:	00812a03          	lw	s4,8(sp)
f9000cf8:	00412a83          	lw	s5,4(sp)
f9000cfc:	00012b03          	lw	s6,0(sp)
f9000d00:	02010113          	addi	sp,sp,32
f9000d04:	00008067          	ret

f9000d08 <timer_handler>:
f9000d08:	ff010113          	addi	sp,sp,-16
f9000d0c:	00812423          	sw	s0,8(sp)
f9000d10:	84c1d503          	lhu	a0,-1972(gp) # f900497c <prev_dig_gain.3305>
f9000d14:	00112623          	sw	ra,12(sp)
f9000d18:	00912223          	sw	s1,4(sp)
f9000d1c:	a5dff0ef          	jal	ra,f9000778 <isp_update_gain>
f9000d20:	00050493          	mv	s1,a0
f9000d24:	a41ff0ef          	jal	ra,f9000764 <isp_get_expose_avg>
f9000d28:	8481a683          	lw	a3,-1976(gp) # f9004978 <count.3303>
f9000d2c:	00900613          	li	a2,9
f9000d30:	00078713          	mv	a4,a5
f9000d34:	00168693          	addi	a3,a3,1
f9000d38:	84d1a423          	sw	a3,-1976(gp) # f9004978 <count.3303>
f9000d3c:	02d66063          	bltu	a2,a3,f9000d5c <timer_handler+0x54>
f9000d40:	84c1d783          	lhu	a5,-1972(gp) # f900497c <prev_dig_gain.3305>
f9000d44:	409787b3          	sub	a5,a5,s1
f9000d48:	41f7d693          	srai	a3,a5,0x1f
f9000d4c:	00f6c7b3          	xor	a5,a3,a5
f9000d50:	40d787b3          	sub	a5,a5,a3
f9000d54:	00a00693          	li	a3,10
f9000d58:	00f6d463          	bge	a3,a5,f9000d60 <timer_handler+0x58>
f9000d5c:	8401a423          	sw	zero,-1976(gp) # f9004978 <count.3303>
f9000d60:	01049493          	slli	s1,s1,0x10
f9000d64:	0104d493          	srli	s1,s1,0x10
f9000d68:	00048593          	mv	a1,s1
f9000d6c:	21c00513          	li	a0,540
f9000d70:	6e8000ef          	jal	ra,f9001458 <PiCam_Gainfilter>
f9000d74:	84919623          	sh	s1,-1972(gp) # f900497c <prev_dig_gain.3305>
f9000d78:	00812403          	lw	s0,8(sp)
f9000d7c:	00c12083          	lw	ra,12(sp)
f9000d80:	00412483          	lw	s1,4(sp)
f9000d84:	01010113          	addi	sp,sp,16
f9000d88:	e3dff06f          	j	f9000bc4 <poll_host_settings>

f9000d8c <externalInterrupt>:
f9000d8c:	ff010113          	addi	sp,sp,-16
f9000d90:	00812423          	sw	s0,8(sp)
f9000d94:	00912223          	sw	s1,4(sp)
f9000d98:	00112623          	sw	ra,12(sp)
f9000d9c:	f8e00437          	lui	s0,0xf8e00
f9000da0:	01300493          	li	s1,19
f9000da4:	00442583          	lw	a1,4(s0) # f8e00004 <__freertos_irq_stack_top+0xffdfa644>
f9000da8:	00059c63          	bnez	a1,f9000dc0 <externalInterrupt+0x34>
f9000dac:	00c12083          	lw	ra,12(sp)
f9000db0:	00812403          	lw	s0,8(sp)
f9000db4:	00412483          	lw	s1,4(sp)
f9000db8:	01010113          	addi	sp,sp,16
f9000dbc:	00008067          	ret
f9000dc0:	00959863          	bne	a1,s1,f9000dd0 <externalInterrupt+0x44>
f9000dc4:	f45ff0ef          	jal	ra,f9000d08 <timer_handler>
f9000dc8:	00942223          	sw	s1,4(s0)
f9000dcc:	fd9ff06f          	j	f9000da4 <externalInterrupt+0x18>
f9000dd0:	f9004537          	lui	a0,0xf9004
f9000dd4:	15050513          	addi	a0,a0,336 # f9004150 <__freertos_irq_stack_top+0xffffe790>
f9000dd8:	dcdff0ef          	jal	ra,f9000ba4 <crash>

f9000ddc <trap>:
f9000ddc:	ff010113          	addi	sp,sp,-16
f9000de0:	00112623          	sw	ra,12(sp)
f9000de4:	342027f3          	csrr	a5,mcause
f9000de8:	00f7f593          	andi	a1,a5,15
f9000dec:	0007dc63          	bgez	a5,f9000e04 <trap+0x28>
f9000df0:	00b00793          	li	a5,11
f9000df4:	00f59863          	bne	a1,a5,f9000e04 <trap+0x28>
f9000df8:	00c12083          	lw	ra,12(sp)
f9000dfc:	01010113          	addi	sp,sp,16
f9000e00:	f8dff06f          	j	f9000d8c <externalInterrupt>
f9000e04:	f9004537          	lui	a0,0xf9004
f9000e08:	15850513          	addi	a0,a0,344 # f9004158 <__freertos_irq_stack_top+0xffffe798>
f9000e0c:	d99ff0ef          	jal	ra,f9000ba4 <crash>

f9000e10 <interrupt_set>:
f9000e10:	00100793          	li	a5,1
f9000e14:	00a797b3          	sll	a5,a5,a0
f9000e18:	00555513          	srli	a0,a0,0x5
f9000e1c:	f8c02737          	lui	a4,0xf8c02
f9000e20:	00251513          	slli	a0,a0,0x2
f9000e24:	00e50533          	add	a0,a0,a4
f9000e28:	00052703          	lw	a4,0(a0)
f9000e2c:	00058863          	beqz	a1,f9000e3c <interrupt_set+0x2c>
f9000e30:	00e7e7b3          	or	a5,a5,a4
f9000e34:	00f52023          	sw	a5,0(a0)
f9000e38:	00008067          	ret
f9000e3c:	fff7c793          	not	a5,a5
f9000e40:	00e7f7b3          	and	a5,a5,a4
f9000e44:	ff1ff06f          	j	f9000e34 <interrupt_set+0x24>

f9000e48 <interrupt_init>:
f9000e48:	ff010113          	addi	sp,sp,-16
f9000e4c:	00112623          	sw	ra,12(sp)
f9000e50:	f8e007b7          	lui	a5,0xf8e00
f9000e54:	0007a023          	sw	zero,0(a5) # f8e00000 <__freertos_irq_stack_top+0xffdfa640>
f9000e58:	f8c02737          	lui	a4,0xf8c02
f9000e5c:	00072783          	lw	a5,0(a4) # f8c02000 <__freertos_irq_stack_top+0xffbfc640>
f9000e60:	000806b7          	lui	a3,0x80
f9000e64:	f9004537          	lui	a0,0xf9004
f9000e68:	00d7e7b3          	or	a5,a5,a3
f9000e6c:	00f72023          	sw	a5,0(a4)
f9000e70:	f8c007b7          	lui	a5,0xf8c00
f9000e74:	00200713          	li	a4,2
f9000e78:	04e7a623          	sw	a4,76(a5) # f8c0004c <__freertos_irq_stack_top+0xffbfa68c>
f9000e7c:	16050513          	addi	a0,a0,352 # f9004160 <__freertos_irq_stack_top+0xffffe7a0>
f9000e80:	b21ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000e84:	f90027b7          	lui	a5,0xf9002
f9000e88:	8e878793          	addi	a5,a5,-1816 # f90018e8 <__freertos_irq_stack_top+0xffffbf28>
f9000e8c:	30579073          	csrw	mtvec,a5
f9000e90:	000017b7          	lui	a5,0x1
f9000e94:	80078793          	addi	a5,a5,-2048 # 800 <regnum_t6+0x7e1>
f9000e98:	3047a073          	csrs	mie,a5
f9000e9c:	000087b7          	lui	a5,0x8
f9000ea0:	80878793          	addi	a5,a5,-2040 # 7808 <__stack_size+0x6808>
f9000ea4:	30079073          	csrw	mstatus,a5
f9000ea8:	00c12083          	lw	ra,12(sp)
f9000eac:	f9004537          	lui	a0,0xf9004
f9000eb0:	17450513          	addi	a0,a0,372 # f9004174 <__freertos_irq_stack_top+0xffffe7b4>
f9000eb4:	01010113          	addi	sp,sp,16
f9000eb8:	ae9ff06f          	j	f90009a0 <bsp_printf>

f9000ebc <init>:
f9000ebc:	ff010113          	addi	sp,sp,-16
f9000ec0:	00112623          	sw	ra,12(sp)
f9000ec4:	ea4ff0ef          	jal	ra,f9000568 <reg_init>
f9000ec8:	2e8000ef          	jal	ra,f90011b0 <cam_i2c_init>
f9000ecc:	00100513          	li	a0,1
f9000ed0:	58c000ef          	jal	ra,f900145c <PiCam_init>
f9000ed4:	25800613          	li	a2,600
f9000ed8:	10000593          	li	a1,256
f9000edc:	1a400513          	li	a0,420
f9000ee0:	871ff0ef          	jal	ra,f9000750 <isp_set_color_balance>
f9000ee4:	f9004537          	lui	a0,0xf9004
f9000ee8:	18c50513          	addi	a0,a0,396 # f900418c <__freertos_irq_stack_top+0xffffe7cc>
f9000eec:	ab5ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000ef0:	00000513          	li	a0,0
f9000ef4:	9fdff0ef          	jal	ra,f90008f0 <isp_init>
f9000ef8:	00989537          	lui	a0,0x989
f9000efc:	68050513          	addi	a0,a0,1664 # 989680 <__stack_size+0x988680>
f9000f00:	00000593          	li	a1,0
f9000f04:	195000ef          	jal	ra,f9001898 <initTimer>
f9000f08:	00c12083          	lw	ra,12(sp)
f9000f0c:	01010113          	addi	sp,sp,16
f9000f10:	f39ff06f          	j	f9000e48 <interrupt_init>

f9000f14 <print_menu>:
f9000f14:	f9004537          	lui	a0,0xf9004
f9000f18:	fe010113          	addi	sp,sp,-32
f9000f1c:	1a450513          	addi	a0,a0,420 # f90041a4 <__freertos_irq_stack_top+0xffffe7e4>
f9000f20:	00112e23          	sw	ra,28(sp)
f9000f24:	00812c23          	sw	s0,24(sp)
f9000f28:	00912a23          	sw	s1,20(sp)
f9000f2c:	01212823          	sw	s2,16(sp)
f9000f30:	01312623          	sw	s3,12(sp)
f9000f34:	01412423          	sw	s4,8(sp)
f9000f38:	a69ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f3c:	f9004537          	lui	a0,0xf9004
f9000f40:	1c450513          	addi	a0,a0,452 # f90041c4 <__freertos_irq_stack_top+0xffffe804>
f9000f44:	f90044b7          	lui	s1,0xf9004
f9000f48:	a59ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f4c:	e9848493          	addi	s1,s1,-360 # f9003e98 <__freertos_irq_stack_top+0xffffe4d8>
f9000f50:	00000913          	li	s2,0
f9000f54:	f9004a37          	lui	s4,0xf9004
f9000f58:	f9004437          	lui	s0,0xf9004
f9000f5c:	00600993          	li	s3,6
f9000f60:	00090593          	mv	a1,s2
f9000f64:	1e8a0513          	addi	a0,s4,488 # f90041e8 <__freertos_irq_stack_top+0xffffe828>
f9000f68:	a39ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f6c:	0284a503          	lw	a0,40(s1)
f9000f70:	00190913          	addi	s2,s2,1
f9000f74:	02c48493          	addi	s1,s1,44
f9000f78:	a29ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f7c:	05840513          	addi	a0,s0,88 # f9004058 <__freertos_irq_stack_top+0xffffe698>
f9000f80:	a21ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f84:	fd391ee3          	bne	s2,s3,f9000f60 <print_menu+0x4c>
f9000f88:	05840513          	addi	a0,s0,88
f9000f8c:	a15ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f90:	f9004537          	lui	a0,0xf9004
f9000f94:	1f050513          	addi	a0,a0,496 # f90041f0 <__freertos_irq_stack_top+0xffffe830>
f9000f98:	a09ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000f9c:	f90044b7          	lui	s1,0xf9004
f9000fa0:	06100593          	li	a1,97
f9000fa4:	20848513          	addi	a0,s1,520 # f9004208 <__freertos_irq_stack_top+0xffffe848>
f9000fa8:	9f9ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000fac:	f9005537          	lui	a0,0xf9005
f9000fb0:	90050513          	addi	a0,a0,-1792 # f9004900 <__freertos_irq_stack_top+0xffffef40>
f9000fb4:	9b9ff0ef          	jal	ra,f900096c <_putchar_s>
f9000fb8:	05840513          	addi	a0,s0,88
f9000fbc:	9e5ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000fc0:	06200593          	li	a1,98
f9000fc4:	20848513          	addi	a0,s1,520
f9000fc8:	9d9ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000fcc:	f9005537          	lui	a0,0xf9005
f9000fd0:	91450513          	addi	a0,a0,-1772 # f9004914 <__freertos_irq_stack_top+0xffffef54>
f9000fd4:	999ff0ef          	jal	ra,f900096c <_putchar_s>
f9000fd8:	05840513          	addi	a0,s0,88
f9000fdc:	9c5ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000fe0:	20848513          	addi	a0,s1,520
f9000fe4:	06300593          	li	a1,99
f9000fe8:	9b9ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9000fec:	f9005537          	lui	a0,0xf9005
f9000ff0:	92850513          	addi	a0,a0,-1752 # f9004928 <__freertos_irq_stack_top+0xffffef68>
f9000ff4:	979ff0ef          	jal	ra,f900096c <_putchar_s>
f9000ff8:	05840513          	addi	a0,s0,88
f9000ffc:	01812403          	lw	s0,24(sp)
f9001000:	01c12083          	lw	ra,28(sp)
f9001004:	01412483          	lw	s1,20(sp)
f9001008:	01012903          	lw	s2,16(sp)
f900100c:	00c12983          	lw	s3,12(sp)
f9001010:	00812a03          	lw	s4,8(sp)
f9001014:	02010113          	addi	sp,sp,32
f9001018:	989ff06f          	j	f90009a0 <bsp_printf>

f900101c <console_main>:
f900101c:	fb010113          	addi	sp,sp,-80
f9001020:	04112623          	sw	ra,76(sp)
f9001024:	04812423          	sw	s0,72(sp)
f9001028:	04912223          	sw	s1,68(sp)
f900102c:	05212023          	sw	s2,64(sp)
f9001030:	03312e23          	sw	s3,60(sp)
f9001034:	f8010737          	lui	a4,0xf8010
f9001038:	00472783          	lw	a5,4(a4) # f8010004 <__freertos_irq_stack_top+0xff00a644>
f900103c:	0187d793          	srli	a5,a5,0x18
f9001040:	fe078ce3          	beqz	a5,f9001038 <console_main+0x1c>
f9001044:	00072403          	lw	s0,0(a4)
f9001048:	84818223          	sb	s0,-1980(gp) # f9004974 <__bss_start>
f900104c:	0ff47413          	andi	s0,s0,255
f9001050:	fd040413          	addi	s0,s0,-48
f9001054:	8081a823          	sw	s0,-2032(gp) # f9004940 <fun_num.3352>
f9001058:	00500993          	li	s3,5
f900105c:	0c89e263          	bltu	s3,s0,f9001120 <console_main+0x104>
f9001060:	f9004537          	lui	a0,0xf9004
f9001064:	21050513          	addi	a0,a0,528 # f9004210 <__freertos_irq_stack_top+0xffffe850>
f9001068:	939ff0ef          	jal	ra,f90009a0 <bsp_printf>
f900106c:	02c00793          	li	a5,44
f9001070:	02f40433          	mul	s0,s0,a5
f9001074:	f90045b7          	lui	a1,0xf9004
f9001078:	e9858593          	addi	a1,a1,-360 # f9003e98 <__freertos_irq_stack_top+0xffffe4d8>
f900107c:	00858433          	add	s0,a1,s0
f9001080:	02842503          	lw	a0,40(s0)
f9001084:	91dff0ef          	jal	ra,f90009a0 <bsp_printf>
f9001088:	f9004537          	lui	a0,0xf9004
f900108c:	21c50513          	addi	a0,a0,540 # f900421c <__freertos_irq_stack_top+0xffffe85c>
f9001090:	911ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9001094:	f8c026b7          	lui	a3,0xf8c02
f9001098:	0006a783          	lw	a5,0(a3) # f8c02000 <__freertos_irq_stack_top+0xffbfc640>
f900109c:	fff80737          	lui	a4,0xfff80
f90010a0:	fff70713          	addi	a4,a4,-1 # fff7ffff <__freertos_irq_stack_top+0x6f7a63f>
f90010a4:	00e7f7b3          	and	a5,a5,a4
f90010a8:	00f6a023          	sw	a5,0(a3)
f90010ac:	02800613          	li	a2,40
f90010b0:	00040593          	mv	a1,s0
f90010b4:	00010513          	mv	a0,sp
f90010b8:	840ff0ef          	jal	ra,f90000f8 <memcpy>
f90010bc:	00010513          	mv	a0,sp
f90010c0:	c50ff0ef          	jal	ra,f9000510 <update_video_timing>
f90010c4:	8101a703          	lw	a4,-2032(gp) # f9004940 <fun_num.3352>
f90010c8:	02e9e463          	bltu	s3,a4,f90010f0 <console_main+0xd4>
f90010cc:	00100793          	li	a5,1
f90010d0:	00e797b3          	sll	a5,a5,a4
f90010d4:	0307f713          	andi	a4,a5,48
f90010d8:	0a071a63          	bnez	a4,f900118c <console_main+0x170>
f90010dc:	00c7f713          	andi	a4,a5,12
f90010e0:	02071063          	bnez	a4,f9001100 <console_main+0xe4>
f90010e4:	0037f793          	andi	a5,a5,3
f90010e8:	00100513          	li	a0,1
f90010ec:	00079c63          	bnez	a5,f9001104 <console_main+0xe8>
f90010f0:	f9004537          	lui	a0,0xf9004
f90010f4:	22450513          	addi	a0,a0,548 # f9004224 <__freertos_irq_stack_top+0xffffe864>
f90010f8:	8a9ff0ef          	jal	ra,f90009a0 <bsp_printf>
f90010fc:	00c0006f          	j	f9001108 <console_main+0xec>
f9001100:	00200513          	li	a0,2
f9001104:	358000ef          	jal	ra,f900145c <PiCam_init>
f9001108:	f8c02737          	lui	a4,0xf8c02
f900110c:	00072783          	lw	a5,0(a4) # f8c02000 <__freertos_irq_stack_top+0xffbfc640>
f9001110:	000806b7          	lui	a3,0x80
f9001114:	00d7e7b3          	or	a5,a5,a3
f9001118:	00f72023          	sw	a5,0(a4)
f900111c:	df9ff0ef          	jal	ra,f9000f14 <print_menu>
f9001120:	8441c403          	lbu	s0,-1980(gp) # f9004974 <__bss_start>
f9001124:	00200793          	li	a5,2
f9001128:	f9f40413          	addi	s0,s0,-97
f900112c:	8081a823          	sw	s0,-2032(gp) # f9004940 <fun_num.3352>
f9001130:	0687e263          	bltu	a5,s0,f9001194 <console_main+0x178>
f9001134:	f9004537          	lui	a0,0xf9004
f9001138:	21050513          	addi	a0,a0,528 # f9004210 <__freertos_irq_stack_top+0xffffe850>
f900113c:	865ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9001140:	01400793          	li	a5,20
f9001144:	02f407b3          	mul	a5,s0,a5
f9001148:	f9005537          	lui	a0,0xf9005
f900114c:	90050513          	addi	a0,a0,-1792 # f9004900 <__freertos_irq_stack_top+0xffffef40>
f9001150:	00f50533          	add	a0,a0,a5
f9001154:	84dff0ef          	jal	ra,f90009a0 <bsp_printf>
f9001158:	f9004537          	lui	a0,0xf9004
f900115c:	21c50513          	addi	a0,a0,540 # f900421c <__freertos_irq_stack_top+0xffffe85c>
f9001160:	841ff0ef          	jal	ra,f90009a0 <bsp_printf>
f9001164:	00040513          	mv	a0,s0
f9001168:	07c00593          	li	a1,124
f900116c:	b94ff0ef          	jal	ra,f9000500 <write_apb_reg>
f9001170:	04812403          	lw	s0,72(sp)
f9001174:	04c12083          	lw	ra,76(sp)
f9001178:	04412483          	lw	s1,68(sp)
f900117c:	04012903          	lw	s2,64(sp)
f9001180:	03c12983          	lw	s3,60(sp)
f9001184:	05010113          	addi	sp,sp,80
f9001188:	d8dff06f          	j	f9000f14 <print_menu>
f900118c:	00000513          	li	a0,0
f9001190:	f75ff06f          	j	f9001104 <console_main+0xe8>
f9001194:	04c12083          	lw	ra,76(sp)
f9001198:	04812403          	lw	s0,72(sp)
f900119c:	04412483          	lw	s1,68(sp)
f90011a0:	04012903          	lw	s2,64(sp)
f90011a4:	03c12983          	lw	s3,60(sp)
f90011a8:	05010113          	addi	sp,sp,80
f90011ac:	00008067          	ret

f90011b0 <cam_i2c_init>:
f90011b0:	f80167b7          	lui	a5,0xf8016
f90011b4:	00300713          	li	a4,3
f90011b8:	02e7a423          	sw	a4,40(a5) # f8016028 <__freertos_irq_stack_top+0xff010668>
f90011bc:	00018737          	lui	a4,0x18
f90011c0:	6a070713          	addi	a4,a4,1696 # 186a0 <__stack_size+0x176a0>
f90011c4:	02e7a623          	sw	a4,44(a5)
f90011c8:	0c800713          	li	a4,200
f90011cc:	02e7a823          	sw	a4,48(a5)
f90011d0:	1f400713          	li	a4,500
f90011d4:	04e7a823          	sw	a4,80(a5)
f90011d8:	04e7aa23          	sw	a4,84(a5)
f90011dc:	3e800713          	li	a4,1000
f90011e0:	04e7ac23          	sw	a4,88(a5)
f90011e4:	00008067          	ret

f90011e8 <i2c_txNackBlocking.constprop.0>:
f90011e8:	30100713          	li	a4,769
f90011ec:	f80167b7          	lui	a5,0xf8016
f90011f0:	00e7a223          	sw	a4,4(a5) # f8016004 <__freertos_irq_stack_top+0xff010644>
f90011f4:	f8016737          	lui	a4,0xf8016
f90011f8:	00472783          	lw	a5,4(a4) # f8016004 <__freertos_irq_stack_top+0xff010644>
f90011fc:	1007f793          	andi	a5,a5,256
f9001200:	fe079ce3          	bnez	a5,f90011f8 <i2c_txNackBlocking.constprop.0+0x10>
f9001204:	00008067          	ret

f9001208 <i2c_masterStartBlocking.constprop.4>:
f9001208:	21000713          	li	a4,528
f900120c:	f80167b7          	lui	a5,0xf8016
f9001210:	04e7a023          	sw	a4,64(a5) # f8016040 <__freertos_irq_stack_top+0xff010680>
f9001214:	f8016737          	lui	a4,0xf8016
f9001218:	04072783          	lw	a5,64(a4) # f8016040 <__freertos_irq_stack_top+0xff010680>
f900121c:	0107f793          	andi	a5,a5,16
f9001220:	fe079ce3          	bnez	a5,f9001218 <i2c_masterStartBlocking.constprop.4+0x10>
f9001224:	00008067          	ret

f9001228 <i2c_masterStopBlocking.constprop.2>:
f9001228:	42000713          	li	a4,1056
f900122c:	f80167b7          	lui	a5,0xf8016
f9001230:	04e7a023          	sw	a4,64(a5) # f8016040 <__freertos_irq_stack_top+0xff010680>
f9001234:	f8016737          	lui	a4,0xf8016
f9001238:	04072783          	lw	a5,64(a4) # f8016040 <__freertos_irq_stack_top+0xff010680>
f900123c:	0017f793          	andi	a5,a5,1
f9001240:	fe079ce3          	bnez	a5,f9001238 <i2c_masterStopBlocking.constprop.2+0x10>
f9001244:	00008067          	ret

f9001248 <PiCam_WriteRegData>:
f9001248:	fd010113          	addi	sp,sp,-48
f900124c:	02112623          	sw	ra,44(sp)
f9001250:	02812423          	sw	s0,40(sp)
f9001254:	02912223          	sw	s1,36(sp)
f9001258:	03212023          	sw	s2,32(sp)
f900125c:	01312e23          	sw	s3,28(sp)
f9001260:	00058913          	mv	s2,a1
f9001264:	00060993          	mv	s3,a2
f9001268:	00a12623          	sw	a0,12(sp)
f900126c:	f9dff0ef          	jal	ra,f9001208 <i2c_masterStartBlocking.constprop.4>
f9001270:	00c12503          	lw	a0,12(sp)
f9001274:	000014b7          	lui	s1,0x1
f9001278:	b0048493          	addi	s1,s1,-1280 # b00 <regnum_t6+0xae1>
f900127c:	00151513          	slli	a0,a0,0x1
f9001280:	0ff57513          	andi	a0,a0,255
f9001284:	f8016437          	lui	s0,0xf8016
f9001288:	00956533          	or	a0,a0,s1
f900128c:	00a42023          	sw	a0,0(s0) # f8016000 <__freertos_irq_stack_top+0xff010640>
f9001290:	f59ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f9001294:	00c42503          	lw	a0,12(s0)
f9001298:	0ff57513          	andi	a0,a0,255
f900129c:	00153513          	seqz	a0,a0
f90012a0:	c74ff0ef          	jal	ra,f9000714 <assert>
f90012a4:	00895793          	srli	a5,s2,0x8
f90012a8:	0097e7b3          	or	a5,a5,s1
f90012ac:	01079793          	slli	a5,a5,0x10
f90012b0:	0107d793          	srli	a5,a5,0x10
f90012b4:	00f42023          	sw	a5,0(s0)
f90012b8:	f31ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f90012bc:	00c42503          	lw	a0,12(s0)
f90012c0:	0ff97913          	andi	s2,s2,255
f90012c4:	00996933          	or	s2,s2,s1
f90012c8:	0ff57513          	andi	a0,a0,255
f90012cc:	00153513          	seqz	a0,a0
f90012d0:	c44ff0ef          	jal	ra,f9000714 <assert>
f90012d4:	01242023          	sw	s2,0(s0)
f90012d8:	f11ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f90012dc:	00c42503          	lw	a0,12(s0)
f90012e0:	0099e4b3          	or	s1,s3,s1
f90012e4:	0ff57513          	andi	a0,a0,255
f90012e8:	00153513          	seqz	a0,a0
f90012ec:	c28ff0ef          	jal	ra,f9000714 <assert>
f90012f0:	00942023          	sw	s1,0(s0)
f90012f4:	ef5ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f90012f8:	00c42503          	lw	a0,12(s0)
f90012fc:	0ff57513          	andi	a0,a0,255
f9001300:	00153513          	seqz	a0,a0
f9001304:	c10ff0ef          	jal	ra,f9000714 <assert>
f9001308:	02812403          	lw	s0,40(sp)
f900130c:	02c12083          	lw	ra,44(sp)
f9001310:	02412483          	lw	s1,36(sp)
f9001314:	02012903          	lw	s2,32(sp)
f9001318:	01c12983          	lw	s3,28(sp)
f900131c:	03010113          	addi	sp,sp,48
f9001320:	f09ff06f          	j	f9001228 <i2c_masterStopBlocking.constprop.2>

f9001324 <PiCam_ReadRegData>:
f9001324:	fe010113          	addi	sp,sp,-32
f9001328:	00912a23          	sw	s1,20(sp)
f900132c:	00050493          	mv	s1,a0
f9001330:	00112e23          	sw	ra,28(sp)
f9001334:	00812c23          	sw	s0,24(sp)
f9001338:	01212823          	sw	s2,16(sp)
f900133c:	01312623          	sw	s3,12(sp)
f9001340:	00058913          	mv	s2,a1
f9001344:	01412423          	sw	s4,8(sp)
f9001348:	00149493          	slli	s1,s1,0x1
f900134c:	ebdff0ef          	jal	ra,f9001208 <i2c_masterStartBlocking.constprop.4>
f9001350:	000019b7          	lui	s3,0x1
f9001354:	b0098a13          	addi	s4,s3,-1280 # b00 <regnum_t6+0xae1>
f9001358:	0ff4f793          	andi	a5,s1,255
f900135c:	f8016437          	lui	s0,0xf8016
f9001360:	0147e7b3          	or	a5,a5,s4
f9001364:	00f42023          	sw	a5,0(s0) # f8016000 <__freertos_irq_stack_top+0xff010640>
f9001368:	e81ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f900136c:	00c42503          	lw	a0,12(s0)
f9001370:	0014e493          	ori	s1,s1,1
f9001374:	0ff4f493          	andi	s1,s1,255
f9001378:	0ff57513          	andi	a0,a0,255
f900137c:	00153513          	seqz	a0,a0
f9001380:	b94ff0ef          	jal	ra,f9000714 <assert>
f9001384:	00895793          	srli	a5,s2,0x8
f9001388:	0147e7b3          	or	a5,a5,s4
f900138c:	01079793          	slli	a5,a5,0x10
f9001390:	0107d793          	srli	a5,a5,0x10
f9001394:	00f42023          	sw	a5,0(s0)
f9001398:	e51ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f900139c:	00c42503          	lw	a0,12(s0)
f90013a0:	0ff97913          	andi	s2,s2,255
f90013a4:	01496933          	or	s2,s2,s4
f90013a8:	0ff57513          	andi	a0,a0,255
f90013ac:	00153513          	seqz	a0,a0
f90013b0:	b64ff0ef          	jal	ra,f9000714 <assert>
f90013b4:	01242023          	sw	s2,0(s0)
f90013b8:	e31ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f90013bc:	00c42503          	lw	a0,12(s0)
f90013c0:	0144e4b3          	or	s1,s1,s4
f90013c4:	bff98993          	addi	s3,s3,-1025
f90013c8:	0ff57513          	andi	a0,a0,255
f90013cc:	00153513          	seqz	a0,a0
f90013d0:	b44ff0ef          	jal	ra,f9000714 <assert>
f90013d4:	e55ff0ef          	jal	ra,f9001228 <i2c_masterStopBlocking.constprop.2>
f90013d8:	e31ff0ef          	jal	ra,f9001208 <i2c_masterStartBlocking.constprop.4>
f90013dc:	00942023          	sw	s1,0(s0)
f90013e0:	e09ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f90013e4:	00c42503          	lw	a0,12(s0)
f90013e8:	0ff57513          	andi	a0,a0,255
f90013ec:	00153513          	seqz	a0,a0
f90013f0:	b24ff0ef          	jal	ra,f9000714 <assert>
f90013f4:	01342023          	sw	s3,0(s0)
f90013f8:	df1ff0ef          	jal	ra,f90011e8 <i2c_txNackBlocking.constprop.0>
f90013fc:	00c42503          	lw	a0,12(s0)
f9001400:	0ff57513          	andi	a0,a0,255
f9001404:	00a03533          	snez	a0,a0
f9001408:	b0cff0ef          	jal	ra,f9000714 <assert>
f900140c:	00842403          	lw	s0,8(s0)
f9001410:	e19ff0ef          	jal	ra,f9001228 <i2c_masterStopBlocking.constprop.2>
f9001414:	01c12083          	lw	ra,28(sp)
f9001418:	0ff47513          	andi	a0,s0,255
f900141c:	01812403          	lw	s0,24(sp)
f9001420:	01412483          	lw	s1,20(sp)
f9001424:	01012903          	lw	s2,16(sp)
f9001428:	00c12983          	lw	s3,12(sp)
f900142c:	00812a03          	lw	s4,8(sp)
f9001430:	02010113          	addi	sp,sp,32
f9001434:	00008067          	ret

f9001438 <AccessCommSeq>:
f9001438:	1b00006f          	j	f90015e8 <PiCamV3_AccessCommSeq>

f900143c <PiCam_Output_Size>:
f900143c:	1b00006f          	j	f90015ec <PiCamV3_Output_Size>

f9001440 <PiCam_Output_activePixel>:
f9001440:	1b00006f          	j	f90015f0 <PiCamV3_Output_activePixel>

f9001444 <PiCam_Output_activePixelX>:
f9001444:	1b00006f          	j	f90015f4 <PiCamV3_Output_activePixelX>

f9001448 <PiCam_Output_activePixelY>:
f9001448:	1b00006f          	j	f90015f8 <PiCamV3_Output_activePixelY>

f900144c <PiCam_SetBinningMode>:
f900144c:	1b00006f          	j	f90015fc <PiCamV3_SetBinningMode>

f9001450 <PiCam_Output_ColorBarSize>:
f9001450:	1b00006f          	j	f9001600 <PiCamV3_Output_ColorBarSize>

f9001454 <PiCam_TestPattern>:
f9001454:	1b00006f          	j	f9001604 <PiCamV3_TestPattern>

f9001458 <PiCam_Gainfilter>:
f9001458:	0180006f          	j	f9001470 <PiCamV3_Gainfilter>

f900145c <PiCam_init>:
f900145c:	06c0006f          	j	f90014c8 <PiCamV3_init>

f9001460 <PiCamV3_WriteRegData>:
f9001460:	00058613          	mv	a2,a1
f9001464:	00050593          	mv	a1,a0
f9001468:	01a00513          	li	a0,26
f900146c:	dddff06f          	j	f9001248 <PiCam_WriteRegData>

f9001470 <PiCamV3_Gainfilter>:
f9001470:	ff010113          	addi	sp,sp,-16
f9001474:	00812423          	sw	s0,8(sp)
f9001478:	00912223          	sw	s1,4(sp)
f900147c:	00050413          	mv	s0,a0
f9001480:	00058493          	mv	s1,a1
f9001484:	20e00513          	li	a0,526
f9001488:	0085d593          	srli	a1,a1,0x8
f900148c:	00112623          	sw	ra,12(sp)
f9001490:	fd1ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f9001494:	0ff4f593          	andi	a1,s1,255
f9001498:	20f00513          	li	a0,527
f900149c:	fc5ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f90014a0:	00845593          	srli	a1,s0,0x8
f90014a4:	20400513          	li	a0,516
f90014a8:	fb9ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f90014ac:	0ff47593          	andi	a1,s0,255
f90014b0:	00812403          	lw	s0,8(sp)
f90014b4:	00c12083          	lw	ra,12(sp)
f90014b8:	00412483          	lw	s1,4(sp)
f90014bc:	20500513          	li	a0,517
f90014c0:	01010113          	addi	sp,sp,16
f90014c4:	f9dff06f          	j	f9001460 <PiCamV3_WriteRegData>

f90014c8 <PiCamV3_init>:
f90014c8:	fe010113          	addi	sp,sp,-32
f90014cc:	00812c23          	sw	s0,24(sp)
f90014d0:	f9004437          	lui	s0,0xf9004
f90014d4:	01212823          	sw	s2,16(sp)
f90014d8:	26040913          	addi	s2,s0,608 # f9004260 <__freertos_irq_stack_top+0xffffe8a0>
f90014dc:	00912a23          	sw	s1,20(sp)
f90014e0:	01312623          	sw	s3,12(sp)
f90014e4:	01412423          	sw	s4,8(sp)
f90014e8:	00112e23          	sw	ra,28(sp)
f90014ec:	00050993          	mv	s3,a0
f90014f0:	0c090a13          	addi	s4,s2,192
f90014f4:	26040413          	addi	s0,s0,608
f90014f8:	f90044b7          	lui	s1,0xf9004
f90014fc:	00294583          	lbu	a1,2(s2)
f9001500:	00095503          	lhu	a0,0(s2)
f9001504:	00490913          	addi	s2,s2,4
f9001508:	f59ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f900150c:	ff4918e3          	bne	s2,s4,f90014fc <PiCamV3_init+0x34>
f9001510:	00100793          	li	a5,1
f9001514:	08f98a63          	beq	s3,a5,f90015a8 <PiCamV3_init+0xe0>
f9001518:	04098c63          	beqz	s3,f9001570 <PiCamV3_init+0xa8>
f900151c:	00200793          	li	a5,2
f9001520:	0af98463          	beq	s3,a5,f90015c8 <PiCamV3_init+0x100>
f9001524:	00000593          	li	a1,0
f9001528:	21c00513          	li	a0,540
f900152c:	f45ff0ef          	jal	ra,f9001470 <PiCamV3_Gainfilter>
f9001530:	00300593          	li	a1,3
f9001534:	20200513          	li	a0,514
f9001538:	f29ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f900153c:	00800593          	li	a1,8
f9001540:	20300513          	li	a0,515
f9001544:	f1dff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f9001548:	01812403          	lw	s0,24(sp)
f900154c:	01c12083          	lw	ra,28(sp)
f9001550:	01412483          	lw	s1,20(sp)
f9001554:	01012903          	lw	s2,16(sp)
f9001558:	00c12983          	lw	s3,12(sp)
f900155c:	00812a03          	lw	s4,8(sp)
f9001560:	00100593          	li	a1,1
f9001564:	10000513          	li	a0,256
f9001568:	02010113          	addi	sp,sp,32
f900156c:	ef5ff06f          	j	f9001460 <PiCamV3_WriteRegData>
f9001570:	32048493          	addi	s1,s1,800 # f9004320 <__freertos_irq_stack_top+0xffffe960>
f9001574:	22c40413          	addi	s0,s0,556
f9001578:	0024c583          	lbu	a1,2(s1)
f900157c:	0004d503          	lhu	a0,0(s1)
f9001580:	00448493          	addi	s1,s1,4
f9001584:	eddff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f9001588:	fe9418e3          	bne	s0,s1,f9001578 <PiCamV3_init+0xb0>
f900158c:	00100593          	li	a1,1
f9001590:	30e00513          	li	a0,782
f9001594:	ecdff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f9001598:	02e00593          	li	a1,46
f900159c:	30f00513          	li	a0,783
f90015a0:	ec1ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f90015a4:	f81ff06f          	j	f9001524 <PiCamV3_init+0x5c>
f90015a8:	22c40493          	addi	s1,s0,556
f90015ac:	39840413          	addi	s0,s0,920
f90015b0:	0024c583          	lbu	a1,2(s1)
f90015b4:	0004d503          	lhu	a0,0(s1)
f90015b8:	00448493          	addi	s1,s1,4
f90015bc:	ea5ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f90015c0:	fe9418e3          	bne	s0,s1,f90015b0 <PiCamV3_init+0xe8>
f90015c4:	f61ff06f          	j	f9001524 <PiCamV3_init+0x5c>
f90015c8:	39840493          	addi	s1,s0,920
f90015cc:	50440413          	addi	s0,s0,1284
f90015d0:	0024c583          	lbu	a1,2(s1)
f90015d4:	0004d503          	lhu	a0,0(s1)
f90015d8:	00448493          	addi	s1,s1,4
f90015dc:	e85ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f90015e0:	fe8498e3          	bne	s1,s0,f90015d0 <PiCamV3_init+0x108>
f90015e4:	f41ff06f          	j	f9001524 <PiCamV3_init+0x5c>

f90015e8 <PiCamV3_AccessCommSeq>:
f90015e8:	00008067          	ret

f90015ec <PiCamV3_Output_Size>:
f90015ec:	00008067          	ret

f90015f0 <PiCamV3_Output_activePixel>:
f90015f0:	00008067          	ret

f90015f4 <PiCamV3_Output_activePixelX>:
f90015f4:	00008067          	ret

f90015f8 <PiCamV3_Output_activePixelY>:
f90015f8:	00008067          	ret

f90015fc <PiCamV3_SetBinningMode>:
f90015fc:	00008067          	ret

f9001600 <PiCamV3_Output_ColorBarSize>:
f9001600:	00008067          	ret

f9001604 <PiCamV3_TestPattern>:
f9001604:	04050863          	beqz	a0,f9001654 <PiCamV3_TestPattern+0x50>
f9001608:	ff010113          	addi	sp,sp,-16
f900160c:	00812423          	sw	s0,8(sp)
f9001610:	60000513          	li	a0,1536
f9001614:	00058413          	mv	s0,a1
f9001618:	00000593          	li	a1,0
f900161c:	00112623          	sw	ra,12(sp)
f9001620:	e41ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f9001624:	00040593          	mv	a1,s0
f9001628:	60100513          	li	a0,1537
f900162c:	e35ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f9001630:	0ff00593          	li	a1,255
f9001634:	60200513          	li	a0,1538
f9001638:	e29ff0ef          	jal	ra,f9001460 <PiCamV3_WriteRegData>
f900163c:	00812403          	lw	s0,8(sp)
f9001640:	00c12083          	lw	ra,12(sp)
f9001644:	0ff00593          	li	a1,255
f9001648:	60300513          	li	a0,1539
f900164c:	01010113          	addi	sp,sp,16
f9001650:	e11ff06f          	j	f9001460 <PiCamV3_WriteRegData>
f9001654:	00008067          	ret

f9001658 <_putchar>:
f9001658:	f8010737          	lui	a4,0xf8010
f900165c:	00472783          	lw	a5,4(a4) # f8010004 <__freertos_irq_stack_top+0xff00a644>
f9001660:	0107d793          	srli	a5,a5,0x10
f9001664:	0ff7f793          	andi	a5,a5,255
f9001668:	fe078ae3          	beqz	a5,f900165c <_putchar+0x4>
f900166c:	00a72023          	sw	a0,0(a4)
f9001670:	00008067          	ret

f9001674 <bsp_printf.constprop.0>:
f9001674:	f8010113          	addi	sp,sp,-128
f9001678:	05312623          	sw	s3,76(sp)
f900167c:	05412423          	sw	s4,72(sp)
f9001680:	05512223          	sw	s5,68(sp)
f9001684:	06f12a23          	sw	a5,116(sp)
f9001688:	f90049b7          	lui	s3,0xf9004
f900168c:	06410793          	addi	a5,sp,100
f9001690:	f9004a37          	lui	s4,0xf9004
f9001694:	f9004ab7          	lui	s5,0xf9004
f9001698:	05212823          	sw	s2,80(sp)
f900169c:	05612023          	sw	s6,64(sp)
f90016a0:	03712e23          	sw	s7,60(sp)
f90016a4:	04112e23          	sw	ra,92(sp)
f90016a8:	04812c23          	sw	s0,88(sp)
f90016ac:	04912a23          	sw	s1,84(sp)
f90016b0:	03812c23          	sw	s8,56(sp)
f90016b4:	06b12223          	sw	a1,100(sp)
f90016b8:	06c12423          	sw	a2,104(sp)
f90016bc:	06d12623          	sw	a3,108(sp)
f90016c0:	06e12823          	sw	a4,112(sp)
f90016c4:	07012c23          	sw	a6,120(sp)
f90016c8:	07112e23          	sw	a7,124(sp)
f90016cc:	00f12623          	sw	a5,12(sp)
f90016d0:	00000913          	li	s2,0
f90016d4:	76498993          	addi	s3,s3,1892 # f9004764 <__freertos_irq_stack_top+0xffffeda4>
f90016d8:	02500b13          	li	s6,37
f90016dc:	f9004bb7          	lui	s7,0xf9004
f90016e0:	feca0a13          	addi	s4,s4,-20 # f9003fec <__freertos_irq_stack_top+0xffffe62c>
f90016e4:	000a8a93          	mv	s5,s5
f90016e8:	013907b3          	add	a5,s2,s3
f90016ec:	0007c503          	lbu	a0,0(a5)
f90016f0:	02051a63          	bnez	a0,f9001724 <bsp_printf.constprop.0+0xb0>
f90016f4:	05c12083          	lw	ra,92(sp)
f90016f8:	05812403          	lw	s0,88(sp)
f90016fc:	05412483          	lw	s1,84(sp)
f9001700:	05012903          	lw	s2,80(sp)
f9001704:	04c12983          	lw	s3,76(sp)
f9001708:	04812a03          	lw	s4,72(sp)
f900170c:	04412a83          	lw	s5,68(sp)
f9001710:	04012b03          	lw	s6,64(sp)
f9001714:	03c12b83          	lw	s7,60(sp)
f9001718:	03812c03          	lw	s8,56(sp)
f900171c:	08010113          	addi	sp,sp,128
f9001720:	00008067          	ret
f9001724:	05651063          	bne	a0,s6,f9001764 <bsp_printf.constprop.0+0xf0>
f9001728:	06300713          	li	a4,99
f900172c:	07300693          	li	a3,115
f9001730:	06400613          	li	a2,100
f9001734:	05800593          	li	a1,88
f9001738:	07800513          	li	a0,120
f900173c:	06600813          	li	a6,102
f9001740:	00190913          	addi	s2,s2,1
f9001744:	012987b3          	add	a5,s3,s2
f9001748:	0007c783          	lbu	a5,0(a5)
f900174c:	02078e63          	beqz	a5,f9001788 <bsp_printf.constprop.0+0x114>
f9001750:	00e79e63          	bne	a5,a4,f900176c <bsp_printf.constprop.0+0xf8>
f9001754:	00c12783          	lw	a5,12(sp)
f9001758:	0007c503          	lbu	a0,0(a5)
f900175c:	00478713          	addi	a4,a5,4
f9001760:	00e12623          	sw	a4,12(sp)
f9001764:	ef5ff0ef          	jal	ra,f9001658 <_putchar>
f9001768:	0200006f          	j	f9001788 <bsp_printf.constprop.0+0x114>
f900176c:	02d79863          	bne	a5,a3,f900179c <bsp_printf.constprop.0+0x128>
f9001770:	00c12783          	lw	a5,12(sp)
f9001774:	0007a403          	lw	s0,0(a5)
f9001778:	00478713          	addi	a4,a5,4
f900177c:	00e12623          	sw	a4,12(sp)
f9001780:	00044503          	lbu	a0,0(s0)
f9001784:	00051663          	bnez	a0,f9001790 <bsp_printf.constprop.0+0x11c>
f9001788:	00190913          	addi	s2,s2,1
f900178c:	f5dff06f          	j	f90016e8 <bsp_printf.constprop.0+0x74>
f9001790:	00140413          	addi	s0,s0,1
f9001794:	ec5ff0ef          	jal	ra,f9001658 <_putchar>
f9001798:	fe9ff06f          	j	f9001780 <bsp_printf.constprop.0+0x10c>
f900179c:	06c79263          	bne	a5,a2,f9001800 <bsp_printf.constprop.0+0x18c>
f90017a0:	00c12783          	lw	a5,12(sp)
f90017a4:	0007a483          	lw	s1,0(a5)
f90017a8:	00478713          	addi	a4,a5,4
f90017ac:	00e12623          	sw	a4,12(sp)
f90017b0:	0004d863          	bgez	s1,f90017c0 <bsp_printf.constprop.0+0x14c>
f90017b4:	02d00513          	li	a0,45
f90017b8:	ea1ff0ef          	jal	ra,f9001658 <_putchar>
f90017bc:	409004b3          	neg	s1,s1
f90017c0:	01010413          	addi	s0,sp,16
f90017c4:	00040c13          	mv	s8,s0
f90017c8:	00a00713          	li	a4,10
f90017cc:	00049e63          	bnez	s1,f90017e8 <bsp_printf.constprop.0+0x174>
f90017d0:	01840c63          	beq	s0,s8,f90017e8 <bsp_printf.constprop.0+0x174>
f90017d4:	fff40413          	addi	s0,s0,-1
f90017d8:	00044503          	lbu	a0,0(s0)
f90017dc:	e7dff0ef          	jal	ra,f9001658 <_putchar>
f90017e0:	ff841ae3          	bne	s0,s8,f90017d4 <bsp_printf.constprop.0+0x160>
f90017e4:	fa5ff06f          	j	f9001788 <bsp_printf.constprop.0+0x114>
f90017e8:	02e4e7b3          	rem	a5,s1,a4
f90017ec:	00140413          	addi	s0,s0,1
f90017f0:	03078793          	addi	a5,a5,48
f90017f4:	fef40fa3          	sb	a5,-1(s0)
f90017f8:	02e4c4b3          	div	s1,s1,a4
f90017fc:	fd1ff06f          	j	f90017cc <bsp_printf.constprop.0+0x158>
f9001800:	02b79e63          	bne	a5,a1,f900183c <bsp_printf.constprop.0+0x1c8>
f9001804:	00c12783          	lw	a5,12(sp)
f9001808:	01c00413          	li	s0,28
f900180c:	ffc00493          	li	s1,-4
f9001810:	0007ac03          	lw	s8,0(a5)
f9001814:	00478713          	addi	a4,a5,4
f9001818:	00e12623          	sw	a4,12(sp)
f900181c:	008c57b3          	srl	a5,s8,s0
f9001820:	00f7f793          	andi	a5,a5,15
f9001824:	00fa87b3          	add	a5,s5,a5
f9001828:	0007c503          	lbu	a0,0(a5)
f900182c:	ffc40413          	addi	s0,s0,-4
f9001830:	e29ff0ef          	jal	ra,f9001658 <_putchar>
f9001834:	fe9414e3          	bne	s0,s1,f900181c <bsp_printf.constprop.0+0x1a8>
f9001838:	f51ff06f          	j	f9001788 <bsp_printf.constprop.0+0x114>
f900183c:	02a79e63          	bne	a5,a0,f9001878 <bsp_printf.constprop.0+0x204>
f9001840:	00c12783          	lw	a5,12(sp)
f9001844:	01c00413          	li	s0,28
f9001848:	ffc00493          	li	s1,-4
f900184c:	0007ac03          	lw	s8,0(a5)
f9001850:	00478713          	addi	a4,a5,4
f9001854:	00e12623          	sw	a4,12(sp)
f9001858:	008c57b3          	srl	a5,s8,s0
f900185c:	00f7f793          	andi	a5,a5,15
f9001860:	00fa07b3          	add	a5,s4,a5
f9001864:	0007c503          	lbu	a0,0(a5)
f9001868:	ffc40413          	addi	s0,s0,-4
f900186c:	dedff0ef          	jal	ra,f9001658 <_putchar>
f9001870:	fe9414e3          	bne	s0,s1,f9001858 <bsp_printf.constprop.0+0x1e4>
f9001874:	f15ff06f          	j	f9001788 <bsp_printf.constprop.0+0x114>
f9001878:	ed0794e3          	bne	a5,a6,f9001740 <bsp_printf.constprop.0+0xcc>
f900187c:	fa0b8413          	addi	s0,s7,-96 # f9003fa0 <__freertos_irq_stack_top+0xffffe5e0>
f9001880:	00c0006f          	j	f900188c <bsp_printf.constprop.0+0x218>
f9001884:	00140413          	addi	s0,s0,1
f9001888:	dd1ff0ef          	jal	ra,f9001658 <_putchar>
f900188c:	00044503          	lbu	a0,0(s0)
f9001890:	fe051ae3          	bnez	a0,f9001884 <bsp_printf.constprop.0+0x210>
f9001894:	ef5ff06f          	j	f9001788 <bsp_printf.constprop.0+0x114>

f9001898 <initTimer>:
f9001898:	ff010113          	addi	sp,sp,-16
f900189c:	00812423          	sw	s0,8(sp)
f90018a0:	00112623          	sw	ra,12(sp)
f90018a4:	f8017437          	lui	s0,0xf8017
f90018a8:	06300793          	li	a5,99
f90018ac:	00f42023          	sw	a5,0(s0) # f8017000 <__freertos_irq_stack_top+0xff011640>
f90018b0:	000107b7          	lui	a5,0x10
f90018b4:	00278793          	addi	a5,a5,2 # 10002 <__stack_size+0xf002>
f90018b8:	04f42023          	sw	a5,64(s0)
f90018bc:	06400613          	li	a2,100
f90018c0:	00000693          	li	a3,0
f90018c4:	0b4000ef          	jal	ra,f9001978 <__udivdi3>
f90018c8:	fff50513          	addi	a0,a0,-1
f90018cc:	04a42223          	sw	a0,68(s0)
f90018d0:	00812403          	lw	s0,8(sp)
f90018d4:	00c12083          	lw	ra,12(sp)
f90018d8:	f9004537          	lui	a0,0xf9004
f90018dc:	76450513          	addi	a0,a0,1892 # f9004764 <__freertos_irq_stack_top+0xffffeda4>
f90018e0:	01010113          	addi	sp,sp,16
f90018e4:	d91ff06f          	j	f9001674 <bsp_printf.constprop.0>

f90018e8 <trap_entry>:
f90018e8:	fc010113          	addi	sp,sp,-64
f90018ec:	00112023          	sw	ra,0(sp)
f90018f0:	00512223          	sw	t0,4(sp)
f90018f4:	00612423          	sw	t1,8(sp)
f90018f8:	00712623          	sw	t2,12(sp)
f90018fc:	00a12823          	sw	a0,16(sp)
f9001900:	00b12a23          	sw	a1,20(sp)
f9001904:	00c12c23          	sw	a2,24(sp)
f9001908:	00d12e23          	sw	a3,28(sp)
f900190c:	02e12023          	sw	a4,32(sp)
f9001910:	02f12223          	sw	a5,36(sp)
f9001914:	03012423          	sw	a6,40(sp)
f9001918:	03112623          	sw	a7,44(sp)
f900191c:	03c12823          	sw	t3,48(sp)
f9001920:	03d12a23          	sw	t4,52(sp)
f9001924:	03e12c23          	sw	t5,56(sp)
f9001928:	03f12e23          	sw	t6,60(sp)
f900192c:	cb0ff0ef          	jal	ra,f9000ddc <trap>
f9001930:	00012083          	lw	ra,0(sp)
f9001934:	00412283          	lw	t0,4(sp)
f9001938:	00812303          	lw	t1,8(sp)
f900193c:	00c12383          	lw	t2,12(sp)
f9001940:	01012503          	lw	a0,16(sp)
f9001944:	01412583          	lw	a1,20(sp)
f9001948:	01812603          	lw	a2,24(sp)
f900194c:	01c12683          	lw	a3,28(sp)
f9001950:	02012703          	lw	a4,32(sp)
f9001954:	02412783          	lw	a5,36(sp)
f9001958:	02812803          	lw	a6,40(sp)
f900195c:	02c12883          	lw	a7,44(sp)
f9001960:	03012e03          	lw	t3,48(sp)
f9001964:	03412e83          	lw	t4,52(sp)
f9001968:	03812f03          	lw	t5,56(sp)
f900196c:	03c12f83          	lw	t6,60(sp)
f9001970:	04010113          	addi	sp,sp,64
f9001974:	30200073          	mret

f9001978 <__udivdi3>:
f9001978:	00068793          	mv	a5,a3
f900197c:	00060893          	mv	a7,a2
f9001980:	00050313          	mv	t1,a0
f9001984:	00058813          	mv	a6,a1
f9001988:	1a069663          	bnez	a3,f9001b34 <__udivdi3+0x1bc>
f900198c:	0cc5fc63          	bgeu	a1,a2,f9001a64 <__udivdi3+0xec>
f9001990:	00010737          	lui	a4,0x10
f9001994:	22e66463          	bltu	a2,a4,f9001bbc <__udivdi3+0x244>
f9001998:	010007b7          	lui	a5,0x1000
f900199c:	40f66a63          	bltu	a2,a5,f9001db0 <__udivdi3+0x438>
f90019a0:	01865693          	srli	a3,a2,0x18
f90019a4:	01800793          	li	a5,24
f90019a8:	00003717          	auipc	a4,0x3
f90019ac:	e5870713          	addi	a4,a4,-424 # f9004800 <__clz_tab>
f90019b0:	00d70733          	add	a4,a4,a3
f90019b4:	00074703          	lbu	a4,0(a4)
f90019b8:	00f707b3          	add	a5,a4,a5
f90019bc:	02000713          	li	a4,32
f90019c0:	40f70733          	sub	a4,a4,a5
f90019c4:	00070c63          	beqz	a4,f90019dc <__udivdi3+0x64>
f90019c8:	00e59833          	sll	a6,a1,a4
f90019cc:	00f557b3          	srl	a5,a0,a5
f90019d0:	00e618b3          	sll	a7,a2,a4
f90019d4:	0107e833          	or	a6,a5,a6
f90019d8:	00e51333          	sll	t1,a0,a4
f90019dc:	0108d613          	srli	a2,a7,0x10
f90019e0:	02c85533          	divu	a0,a6,a2
f90019e4:	01089693          	slli	a3,a7,0x10
f90019e8:	0106d693          	srli	a3,a3,0x10
f90019ec:	01035793          	srli	a5,t1,0x10
f90019f0:	02c87733          	remu	a4,a6,a2
f90019f4:	02a685b3          	mul	a1,a3,a0
f90019f8:	01071713          	slli	a4,a4,0x10
f90019fc:	00f76833          	or	a6,a4,a5
f9001a00:	00b87c63          	bgeu	a6,a1,f9001a18 <__udivdi3+0xa0>
f9001a04:	01180833          	add	a6,a6,a7
f9001a08:	fff50793          	addi	a5,a0,-1
f9001a0c:	01186463          	bltu	a6,a7,f9001a14 <__udivdi3+0x9c>
f9001a10:	3eb86863          	bltu	a6,a1,f9001e00 <__udivdi3+0x488>
f9001a14:	00078513          	mv	a0,a5
f9001a18:	40b80833          	sub	a6,a6,a1
f9001a1c:	02c85733          	divu	a4,a6,a2
f9001a20:	01031313          	slli	t1,t1,0x10
f9001a24:	01035313          	srli	t1,t1,0x10
f9001a28:	02c87833          	remu	a6,a6,a2
f9001a2c:	02e686b3          	mul	a3,a3,a4
f9001a30:	01081813          	slli	a6,a6,0x10
f9001a34:	00686833          	or	a6,a6,t1
f9001a38:	00d87e63          	bgeu	a6,a3,f9001a54 <__udivdi3+0xdc>
f9001a3c:	01088833          	add	a6,a7,a6
f9001a40:	fff70793          	addi	a5,a4,-1
f9001a44:	01186663          	bltu	a6,a7,f9001a50 <__udivdi3+0xd8>
f9001a48:	ffe70713          	addi	a4,a4,-2
f9001a4c:	00d86463          	bltu	a6,a3,f9001a54 <__udivdi3+0xdc>
f9001a50:	00078713          	mv	a4,a5
f9001a54:	01051513          	slli	a0,a0,0x10
f9001a58:	00e56533          	or	a0,a0,a4
f9001a5c:	00000593          	li	a1,0
f9001a60:	00008067          	ret
f9001a64:	00061663          	bnez	a2,f9001a70 <__udivdi3+0xf8>
f9001a68:	00100713          	li	a4,1
f9001a6c:	02c758b3          	divu	a7,a4,a2
f9001a70:	00010737          	lui	a4,0x10
f9001a74:	12e8e863          	bltu	a7,a4,f9001ba4 <__udivdi3+0x22c>
f9001a78:	010007b7          	lui	a5,0x1000
f9001a7c:	34f8e063          	bltu	a7,a5,f9001dbc <__udivdi3+0x444>
f9001a80:	0188d693          	srli	a3,a7,0x18
f9001a84:	01800793          	li	a5,24
f9001a88:	00003717          	auipc	a4,0x3
f9001a8c:	d7870713          	addi	a4,a4,-648 # f9004800 <__clz_tab>
f9001a90:	00d70733          	add	a4,a4,a3
f9001a94:	00074683          	lbu	a3,0(a4)
f9001a98:	00f686b3          	add	a3,a3,a5
f9001a9c:	02000793          	li	a5,32
f9001aa0:	40d787b3          	sub	a5,a5,a3
f9001aa4:	12079863          	bnez	a5,f9001bd4 <__udivdi3+0x25c>
f9001aa8:	01089e93          	slli	t4,a7,0x10
f9001aac:	41158733          	sub	a4,a1,a7
f9001ab0:	0108df13          	srli	t5,a7,0x10
f9001ab4:	010ede93          	srli	t4,t4,0x10
f9001ab8:	00100593          	li	a1,1
f9001abc:	01035793          	srli	a5,t1,0x10
f9001ac0:	03e75533          	divu	a0,a4,t5
f9001ac4:	03e77733          	remu	a4,a4,t5
f9001ac8:	03d506b3          	mul	a3,a0,t4
f9001acc:	01071713          	slli	a4,a4,0x10
f9001ad0:	00f767b3          	or	a5,a4,a5
f9001ad4:	00d7fc63          	bgeu	a5,a3,f9001aec <__udivdi3+0x174>
f9001ad8:	011787b3          	add	a5,a5,a7
f9001adc:	fff50713          	addi	a4,a0,-1
f9001ae0:	0117e463          	bltu	a5,a7,f9001ae8 <__udivdi3+0x170>
f9001ae4:	32d7e463          	bltu	a5,a3,f9001e0c <__udivdi3+0x494>
f9001ae8:	00070513          	mv	a0,a4
f9001aec:	40d787b3          	sub	a5,a5,a3
f9001af0:	03e7d733          	divu	a4,a5,t5
f9001af4:	01031313          	slli	t1,t1,0x10
f9001af8:	01035313          	srli	t1,t1,0x10
f9001afc:	03e7f7b3          	remu	a5,a5,t5
f9001b00:	03d70eb3          	mul	t4,a4,t4
f9001b04:	01079793          	slli	a5,a5,0x10
f9001b08:	0067e7b3          	or	a5,a5,t1
f9001b0c:	01d7fe63          	bgeu	a5,t4,f9001b28 <__udivdi3+0x1b0>
f9001b10:	00f887b3          	add	a5,a7,a5
f9001b14:	fff70693          	addi	a3,a4,-1
f9001b18:	0117e663          	bltu	a5,a7,f9001b24 <__udivdi3+0x1ac>
f9001b1c:	ffe70713          	addi	a4,a4,-2
f9001b20:	01d7e463          	bltu	a5,t4,f9001b28 <__udivdi3+0x1b0>
f9001b24:	00068713          	mv	a4,a3
f9001b28:	01051513          	slli	a0,a0,0x10
f9001b2c:	00e56533          	or	a0,a0,a4
f9001b30:	00008067          	ret
f9001b34:	04d5e863          	bltu	a1,a3,f9001b84 <__udivdi3+0x20c>
f9001b38:	000107b7          	lui	a5,0x10
f9001b3c:	04f6ea63          	bltu	a3,a5,f9001b90 <__udivdi3+0x218>
f9001b40:	010007b7          	lui	a5,0x1000
f9001b44:	26f6e063          	bltu	a3,a5,f9001da4 <__udivdi3+0x42c>
f9001b48:	0186d713          	srli	a4,a3,0x18
f9001b4c:	01800813          	li	a6,24
f9001b50:	00003797          	auipc	a5,0x3
f9001b54:	cb078793          	addi	a5,a5,-848 # f9004800 <__clz_tab>
f9001b58:	00e787b3          	add	a5,a5,a4
f9001b5c:	0007c703          	lbu	a4,0(a5)
f9001b60:	02000e13          	li	t3,32
f9001b64:	01070733          	add	a4,a4,a6
f9001b68:	40ee0e33          	sub	t3,t3,a4
f9001b6c:	100e1663          	bnez	t3,f9001c78 <__udivdi3+0x300>
f9001b70:	24b6ec63          	bltu	a3,a1,f9001dc8 <__udivdi3+0x450>
f9001b74:	00c53533          	sltu	a0,a0,a2
f9001b78:	00154513          	xori	a0,a0,1
f9001b7c:	00000593          	li	a1,0
f9001b80:	00008067          	ret
f9001b84:	00000593          	li	a1,0
f9001b88:	00000513          	li	a0,0
f9001b8c:	00008067          	ret
f9001b90:	0ff00793          	li	a5,255
f9001b94:	24d7f063          	bgeu	a5,a3,f9001dd4 <__udivdi3+0x45c>
f9001b98:	0086d713          	srli	a4,a3,0x8
f9001b9c:	00800813          	li	a6,8
f9001ba0:	fb1ff06f          	j	f9001b50 <__udivdi3+0x1d8>
f9001ba4:	0ff00713          	li	a4,255
f9001ba8:	00088693          	mv	a3,a7
f9001bac:	ed177ee3          	bgeu	a4,a7,f9001a88 <__udivdi3+0x110>
f9001bb0:	0088d693          	srli	a3,a7,0x8
f9001bb4:	00800793          	li	a5,8
f9001bb8:	ed1ff06f          	j	f9001a88 <__udivdi3+0x110>
f9001bbc:	0ff00713          	li	a4,255
f9001bc0:	00060693          	mv	a3,a2
f9001bc4:	dec772e3          	bgeu	a4,a2,f90019a8 <__udivdi3+0x30>
f9001bc8:	00865693          	srli	a3,a2,0x8
f9001bcc:	00800793          	li	a5,8
f9001bd0:	dd9ff06f          	j	f90019a8 <__udivdi3+0x30>
f9001bd4:	00f898b3          	sll	a7,a7,a5
f9001bd8:	00d5d633          	srl	a2,a1,a3
f9001bdc:	0108df13          	srli	t5,a7,0x10
f9001be0:	03e65e33          	divu	t3,a2,t5
f9001be4:	00f59733          	sll	a4,a1,a5
f9001be8:	00d556b3          	srl	a3,a0,a3
f9001bec:	00e6e733          	or	a4,a3,a4
f9001bf0:	01089e93          	slli	t4,a7,0x10
f9001bf4:	010ede93          	srli	t4,t4,0x10
f9001bf8:	00f51333          	sll	t1,a0,a5
f9001bfc:	01075593          	srli	a1,a4,0x10
f9001c00:	03e676b3          	remu	a3,a2,t5
f9001c04:	03ce87b3          	mul	a5,t4,t3
f9001c08:	01069693          	slli	a3,a3,0x10
f9001c0c:	00b6e6b3          	or	a3,a3,a1
f9001c10:	00f6fe63          	bgeu	a3,a5,f9001c2c <__udivdi3+0x2b4>
f9001c14:	011686b3          	add	a3,a3,a7
f9001c18:	fffe0613          	addi	a2,t3,-1
f9001c1c:	1d16ee63          	bltu	a3,a7,f9001df8 <__udivdi3+0x480>
f9001c20:	1cf6fc63          	bgeu	a3,a5,f9001df8 <__udivdi3+0x480>
f9001c24:	ffee0e13          	addi	t3,t3,-2
f9001c28:	011686b3          	add	a3,a3,a7
f9001c2c:	40f686b3          	sub	a3,a3,a5
f9001c30:	03e6d633          	divu	a2,a3,t5
f9001c34:	01071793          	slli	a5,a4,0x10
f9001c38:	0107d793          	srli	a5,a5,0x10
f9001c3c:	03e6f6b3          	remu	a3,a3,t5
f9001c40:	02ce8533          	mul	a0,t4,a2
f9001c44:	01069713          	slli	a4,a3,0x10
f9001c48:	00f76733          	or	a4,a4,a5
f9001c4c:	00a77e63          	bgeu	a4,a0,f9001c68 <__udivdi3+0x2f0>
f9001c50:	01170733          	add	a4,a4,a7
f9001c54:	fff60793          	addi	a5,a2,-1
f9001c58:	19176863          	bltu	a4,a7,f9001de8 <__udivdi3+0x470>
f9001c5c:	18a77663          	bgeu	a4,a0,f9001de8 <__udivdi3+0x470>
f9001c60:	ffe60613          	addi	a2,a2,-2
f9001c64:	01170733          	add	a4,a4,a7
f9001c68:	010e1593          	slli	a1,t3,0x10
f9001c6c:	40a70733          	sub	a4,a4,a0
f9001c70:	00c5e5b3          	or	a1,a1,a2
f9001c74:	e49ff06f          	j	f9001abc <__udivdi3+0x144>
f9001c78:	00e657b3          	srl	a5,a2,a4
f9001c7c:	01c696b3          	sll	a3,a3,t3
f9001c80:	00d7e6b3          	or	a3,a5,a3
f9001c84:	00e5d333          	srl	t1,a1,a4
f9001c88:	0106df13          	srli	t5,a3,0x10
f9001c8c:	03e357b3          	divu	a5,t1,t5
f9001c90:	01069e93          	slli	t4,a3,0x10
f9001c94:	010ede93          	srli	t4,t4,0x10
f9001c98:	01c59833          	sll	a6,a1,t3
f9001c9c:	00e55733          	srl	a4,a0,a4
f9001ca0:	01076833          	or	a6,a4,a6
f9001ca4:	01085893          	srli	a7,a6,0x10
f9001ca8:	01c61633          	sll	a2,a2,t3
f9001cac:	03e37333          	remu	t1,t1,t5
f9001cb0:	02fe85b3          	mul	a1,t4,a5
f9001cb4:	01031313          	slli	t1,t1,0x10
f9001cb8:	011368b3          	or	a7,t1,a7
f9001cbc:	00b8fe63          	bgeu	a7,a1,f9001cd8 <__udivdi3+0x360>
f9001cc0:	00d888b3          	add	a7,a7,a3
f9001cc4:	fff78713          	addi	a4,a5,-1
f9001cc8:	12d8e463          	bltu	a7,a3,f9001df0 <__udivdi3+0x478>
f9001ccc:	12b8f263          	bgeu	a7,a1,f9001df0 <__udivdi3+0x478>
f9001cd0:	ffe78793          	addi	a5,a5,-2
f9001cd4:	00d888b3          	add	a7,a7,a3
f9001cd8:	40b888b3          	sub	a7,a7,a1
f9001cdc:	03e8d733          	divu	a4,a7,t5
f9001ce0:	01081813          	slli	a6,a6,0x10
f9001ce4:	01085813          	srli	a6,a6,0x10
f9001ce8:	03e8f8b3          	remu	a7,a7,t5
f9001cec:	02ee8333          	mul	t1,t4,a4
f9001cf0:	01089893          	slli	a7,a7,0x10
f9001cf4:	0108e5b3          	or	a1,a7,a6
f9001cf8:	0065fe63          	bgeu	a1,t1,f9001d14 <__udivdi3+0x39c>
f9001cfc:	00d585b3          	add	a1,a1,a3
f9001d00:	fff70813          	addi	a6,a4,-1
f9001d04:	0cd5ee63          	bltu	a1,a3,f9001de0 <__udivdi3+0x468>
f9001d08:	0c65fc63          	bgeu	a1,t1,f9001de0 <__udivdi3+0x468>
f9001d0c:	ffe70713          	addi	a4,a4,-2
f9001d10:	00d585b3          	add	a1,a1,a3
f9001d14:	01079793          	slli	a5,a5,0x10
f9001d18:	00010f37          	lui	t5,0x10
f9001d1c:	00e7e7b3          	or	a5,a5,a4
f9001d20:	ffff0713          	addi	a4,t5,-1 # ffff <__stack_size+0xefff>
f9001d24:	00e7f6b3          	and	a3,a5,a4
f9001d28:	0107d893          	srli	a7,a5,0x10
f9001d2c:	00e67733          	and	a4,a2,a4
f9001d30:	01065613          	srli	a2,a2,0x10
f9001d34:	02e68eb3          	mul	t4,a3,a4
f9001d38:	406585b3          	sub	a1,a1,t1
f9001d3c:	02c686b3          	mul	a3,a3,a2
f9001d40:	010ed813          	srli	a6,t4,0x10
f9001d44:	02e88733          	mul	a4,a7,a4
f9001d48:	00e686b3          	add	a3,a3,a4
f9001d4c:	00d806b3          	add	a3,a6,a3
f9001d50:	02c88633          	mul	a2,a7,a2
f9001d54:	00e6f463          	bgeu	a3,a4,f9001d5c <__udivdi3+0x3e4>
f9001d58:	01e60633          	add	a2,a2,t5
f9001d5c:	0106d893          	srli	a7,a3,0x10
f9001d60:	00c88633          	add	a2,a7,a2
f9001d64:	02c5ea63          	bltu	a1,a2,f9001d98 <__udivdi3+0x420>
f9001d68:	00c58863          	beq	a1,a2,f9001d78 <__udivdi3+0x400>
f9001d6c:	00078513          	mv	a0,a5
f9001d70:	00000593          	li	a1,0
f9001d74:	00008067          	ret
f9001d78:	00010737          	lui	a4,0x10
f9001d7c:	fff70713          	addi	a4,a4,-1 # ffff <__stack_size+0xefff>
f9001d80:	00e6f6b3          	and	a3,a3,a4
f9001d84:	01069693          	slli	a3,a3,0x10
f9001d88:	00eefeb3          	and	t4,t4,a4
f9001d8c:	01c51533          	sll	a0,a0,t3
f9001d90:	01d686b3          	add	a3,a3,t4
f9001d94:	fcd57ce3          	bgeu	a0,a3,f9001d6c <__udivdi3+0x3f4>
f9001d98:	fff78513          	addi	a0,a5,-1
f9001d9c:	00000593          	li	a1,0
f9001da0:	00008067          	ret
f9001da4:	0106d713          	srli	a4,a3,0x10
f9001da8:	01000813          	li	a6,16
f9001dac:	da5ff06f          	j	f9001b50 <__udivdi3+0x1d8>
f9001db0:	01065693          	srli	a3,a2,0x10
f9001db4:	01000793          	li	a5,16
f9001db8:	bf1ff06f          	j	f90019a8 <__udivdi3+0x30>
f9001dbc:	0108d693          	srli	a3,a7,0x10
f9001dc0:	01000793          	li	a5,16
f9001dc4:	cc5ff06f          	j	f9001a88 <__udivdi3+0x110>
f9001dc8:	00000593          	li	a1,0
f9001dcc:	00100513          	li	a0,1
f9001dd0:	00008067          	ret
f9001dd4:	00068713          	mv	a4,a3
f9001dd8:	00000813          	li	a6,0
f9001ddc:	d75ff06f          	j	f9001b50 <__udivdi3+0x1d8>
f9001de0:	00080713          	mv	a4,a6
f9001de4:	f31ff06f          	j	f9001d14 <__udivdi3+0x39c>
f9001de8:	00078613          	mv	a2,a5
f9001dec:	e7dff06f          	j	f9001c68 <__udivdi3+0x2f0>
f9001df0:	00070793          	mv	a5,a4
f9001df4:	ee5ff06f          	j	f9001cd8 <__udivdi3+0x360>
f9001df8:	00060e13          	mv	t3,a2
f9001dfc:	e31ff06f          	j	f9001c2c <__udivdi3+0x2b4>
f9001e00:	ffe50513          	addi	a0,a0,-2
f9001e04:	01180833          	add	a6,a6,a7
f9001e08:	c11ff06f          	j	f9001a18 <__udivdi3+0xa0>
f9001e0c:	ffe50513          	addi	a0,a0,-2
f9001e10:	011787b3          	add	a5,a5,a7
f9001e14:	cd9ff06f          	j	f9001aec <__udivdi3+0x174>

f9001e18 <__adddf3>:
f9001e18:	00100837          	lui	a6,0x100
f9001e1c:	fe010113          	addi	sp,sp,-32
f9001e20:	fff80813          	addi	a6,a6,-1 # fffff <__stack_size+0xfefff>
f9001e24:	00b87733          	and	a4,a6,a1
f9001e28:	00912a23          	sw	s1,20(sp)
f9001e2c:	00d87833          	and	a6,a6,a3
f9001e30:	0145d493          	srli	s1,a1,0x14
f9001e34:	0146d313          	srli	t1,a3,0x14
f9001e38:	00371e13          	slli	t3,a4,0x3
f9001e3c:	01312623          	sw	s3,12(sp)
f9001e40:	01d55713          	srli	a4,a0,0x1d
f9001e44:	00381813          	slli	a6,a6,0x3
f9001e48:	01d65793          	srli	a5,a2,0x1d
f9001e4c:	7ff4f493          	andi	s1,s1,2047
f9001e50:	7ff37313          	andi	t1,t1,2047
f9001e54:	00112e23          	sw	ra,28(sp)
f9001e58:	00812c23          	sw	s0,24(sp)
f9001e5c:	01212823          	sw	s2,16(sp)
f9001e60:	01f5d993          	srli	s3,a1,0x1f
f9001e64:	01f6de93          	srli	t4,a3,0x1f
f9001e68:	01c76733          	or	a4,a4,t3
f9001e6c:	00351f13          	slli	t5,a0,0x3
f9001e70:	0107e833          	or	a6,a5,a6
f9001e74:	00361f93          	slli	t6,a2,0x3
f9001e78:	40648e33          	sub	t3,s1,t1
f9001e7c:	1dd98463          	beq	s3,t4,f9002044 <__adddf3+0x22c>
f9001e80:	17c05863          	blez	t3,f9001ff0 <__adddf3+0x1d8>
f9001e84:	20030a63          	beqz	t1,f9002098 <__adddf3+0x280>
f9001e88:	008006b7          	lui	a3,0x800
f9001e8c:	7ff00793          	li	a5,2047
f9001e90:	00d86833          	or	a6,a6,a3
f9001e94:	40f48e63          	beq	s1,a5,f90022b0 <__adddf3+0x498>
f9001e98:	03800793          	li	a5,56
f9001e9c:	3dc7ca63          	blt	a5,t3,f9002270 <__adddf3+0x458>
f9001ea0:	01f00793          	li	a5,31
f9001ea4:	55c7c663          	blt	a5,t3,f90023f0 <__adddf3+0x5d8>
f9001ea8:	02000513          	li	a0,32
f9001eac:	41c50533          	sub	a0,a0,t3
f9001eb0:	01cfd7b3          	srl	a5,t6,t3
f9001eb4:	00a816b3          	sll	a3,a6,a0
f9001eb8:	00af9933          	sll	s2,t6,a0
f9001ebc:	00f6e6b3          	or	a3,a3,a5
f9001ec0:	01203933          	snez	s2,s2
f9001ec4:	01c857b3          	srl	a5,a6,t3
f9001ec8:	0126e933          	or	s2,a3,s2
f9001ecc:	40f70733          	sub	a4,a4,a5
f9001ed0:	412f0933          	sub	s2,t5,s2
f9001ed4:	012f37b3          	sltu	a5,t5,s2
f9001ed8:	40f70633          	sub	a2,a4,a5
f9001edc:	00861793          	slli	a5,a2,0x8
f9001ee0:	2a07d263          	bgez	a5,f9002184 <__adddf3+0x36c>
f9001ee4:	00800737          	lui	a4,0x800
f9001ee8:	fff70713          	addi	a4,a4,-1 # 7fffff <__stack_size+0x7fefff>
f9001eec:	00e67433          	and	s0,a2,a4
f9001ef0:	34040e63          	beqz	s0,f900224c <__adddf3+0x434>
f9001ef4:	00040513          	mv	a0,s0
f9001ef8:	6b9010ef          	jal	ra,f9003db0 <__clzsi2>
f9001efc:	ff850713          	addi	a4,a0,-8
f9001f00:	02000793          	li	a5,32
f9001f04:	40e787b3          	sub	a5,a5,a4
f9001f08:	00f957b3          	srl	a5,s2,a5
f9001f0c:	00e41633          	sll	a2,s0,a4
f9001f10:	00c7e7b3          	or	a5,a5,a2
f9001f14:	00e91933          	sll	s2,s2,a4
f9001f18:	30974c63          	blt	a4,s1,f9002230 <__adddf3+0x418>
f9001f1c:	40970533          	sub	a0,a4,s1
f9001f20:	00150613          	addi	a2,a0,1
f9001f24:	01f00713          	li	a4,31
f9001f28:	44c74663          	blt	a4,a2,f9002374 <__adddf3+0x55c>
f9001f2c:	02000713          	li	a4,32
f9001f30:	40c70733          	sub	a4,a4,a2
f9001f34:	00c956b3          	srl	a3,s2,a2
f9001f38:	00e91933          	sll	s2,s2,a4
f9001f3c:	00e79733          	sll	a4,a5,a4
f9001f40:	00d76733          	or	a4,a4,a3
f9001f44:	01203933          	snez	s2,s2
f9001f48:	01276933          	or	s2,a4,s2
f9001f4c:	00c7d633          	srl	a2,a5,a2
f9001f50:	00000493          	li	s1,0
f9001f54:	00797793          	andi	a5,s2,7
f9001f58:	02078063          	beqz	a5,f9001f78 <__adddf3+0x160>
f9001f5c:	00f97713          	andi	a4,s2,15
f9001f60:	00400793          	li	a5,4
f9001f64:	00f70a63          	beq	a4,a5,f9001f78 <__adddf3+0x160>
f9001f68:	00490713          	addi	a4,s2,4
f9001f6c:	01273933          	sltu	s2,a4,s2
f9001f70:	01260633          	add	a2,a2,s2
f9001f74:	00070913          	mv	s2,a4
f9001f78:	00861793          	slli	a5,a2,0x8
f9001f7c:	2007d863          	bgez	a5,f900218c <__adddf3+0x374>
f9001f80:	00148513          	addi	a0,s1,1
f9001f84:	7ff00793          	li	a5,2047
f9001f88:	00098593          	mv	a1,s3
f9001f8c:	24f50c63          	beq	a0,a5,f90021e4 <__adddf3+0x3cc>
f9001f90:	ff8007b7          	lui	a5,0xff800
f9001f94:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa63f>
f9001f98:	00f677b3          	and	a5,a2,a5
f9001f9c:	01d79893          	slli	a7,a5,0x1d
f9001fa0:	00395913          	srli	s2,s2,0x3
f9001fa4:	00979793          	slli	a5,a5,0x9
f9001fa8:	0128e8b3          	or	a7,a7,s2
f9001fac:	00c7d793          	srli	a5,a5,0xc
f9001fb0:	7ff57513          	andi	a0,a0,2047
f9001fb4:	00c79693          	slli	a3,a5,0xc
f9001fb8:	01451513          	slli	a0,a0,0x14
f9001fbc:	01c12083          	lw	ra,28(sp)
f9001fc0:	01812403          	lw	s0,24(sp)
f9001fc4:	00c6d693          	srli	a3,a3,0xc
f9001fc8:	01f59593          	slli	a1,a1,0x1f
f9001fcc:	00a6e6b3          	or	a3,a3,a0
f9001fd0:	00b6e6b3          	or	a3,a3,a1
f9001fd4:	01412483          	lw	s1,20(sp)
f9001fd8:	01012903          	lw	s2,16(sp)
f9001fdc:	00c12983          	lw	s3,12(sp)
f9001fe0:	00088513          	mv	a0,a7
f9001fe4:	00068593          	mv	a1,a3
f9001fe8:	02010113          	addi	sp,sp,32
f9001fec:	00008067          	ret
f9001ff0:	0c0e1463          	bnez	t3,f90020b8 <__adddf3+0x2a0>
f9001ff4:	00148313          	addi	t1,s1,1
f9001ff8:	7fe37313          	andi	t1,t1,2046
f9001ffc:	28031063          	bnez	t1,f900227c <__adddf3+0x464>
f9002000:	01e767b3          	or	a5,a4,t5
f9002004:	01f868b3          	or	a7,a6,t6
f9002008:	1e049663          	bnez	s1,f90021f4 <__adddf3+0x3dc>
f900200c:	4c078063          	beqz	a5,f90024cc <__adddf3+0x6b4>
f9002010:	50088863          	beqz	a7,f9002520 <__adddf3+0x708>
f9002014:	41ff0933          	sub	s2,t5,t6
f9002018:	410707b3          	sub	a5,a4,a6
f900201c:	012f3633          	sltu	a2,t5,s2
f9002020:	40c78633          	sub	a2,a5,a2
f9002024:	00861793          	slli	a5,a2,0x8
f9002028:	5a07d463          	bgez	a5,f90025d0 <__adddf3+0x7b8>
f900202c:	41ef8933          	sub	s2,t6,t5
f9002030:	40e807b3          	sub	a5,a6,a4
f9002034:	012fb633          	sltu	a2,t6,s2
f9002038:	40c78633          	sub	a2,a5,a2
f900203c:	000e8993          	mv	s3,t4
f9002040:	f15ff06f          	j	f9001f54 <__adddf3+0x13c>
f9002044:	0fc05a63          	blez	t3,f9002138 <__adddf3+0x320>
f9002048:	0c030863          	beqz	t1,f9002118 <__adddf3+0x300>
f900204c:	008006b7          	lui	a3,0x800
f9002050:	7ff00793          	li	a5,2047
f9002054:	00d86833          	or	a6,a6,a3
f9002058:	44f48e63          	beq	s1,a5,f90024b4 <__adddf3+0x69c>
f900205c:	03800793          	li	a5,56
f9002060:	15c7cc63          	blt	a5,t3,f90021b8 <__adddf3+0x3a0>
f9002064:	01f00793          	li	a5,31
f9002068:	3fc7da63          	bge	a5,t3,f900245c <__adddf3+0x644>
f900206c:	fe0e0913          	addi	s2,t3,-32
f9002070:	02000793          	li	a5,32
f9002074:	012856b3          	srl	a3,a6,s2
f9002078:	00fe0a63          	beq	t3,a5,f900208c <__adddf3+0x274>
f900207c:	04000913          	li	s2,64
f9002080:	41c90933          	sub	s2,s2,t3
f9002084:	01281933          	sll	s2,a6,s2
f9002088:	012fefb3          	or	t6,t6,s2
f900208c:	01f03933          	snez	s2,t6
f9002090:	00d96933          	or	s2,s2,a3
f9002094:	12c0006f          	j	f90021c0 <__adddf3+0x3a8>
f9002098:	01f867b3          	or	a5,a6,t6
f900209c:	22078663          	beqz	a5,f90022c8 <__adddf3+0x4b0>
f90020a0:	fffe0793          	addi	a5,t3,-1
f90020a4:	44078463          	beqz	a5,f90024ec <__adddf3+0x6d4>
f90020a8:	7ff00693          	li	a3,2047
f90020ac:	20de0263          	beq	t3,a3,f90022b0 <__adddf3+0x498>
f90020b0:	00078e13          	mv	t3,a5
f90020b4:	de5ff06f          	j	f9001e98 <__adddf3+0x80>
f90020b8:	409305b3          	sub	a1,t1,s1
f90020bc:	28049663          	bnez	s1,f9002348 <__adddf3+0x530>
f90020c0:	01e767b3          	or	a5,a4,t5
f90020c4:	3c078263          	beqz	a5,f9002488 <__adddf3+0x670>
f90020c8:	fff58793          	addi	a5,a1,-1
f90020cc:	50078c63          	beqz	a5,f90025e4 <__adddf3+0x7cc>
f90020d0:	7ff00693          	li	a3,2047
f90020d4:	28d58263          	beq	a1,a3,f9002358 <__adddf3+0x540>
f90020d8:	00078593          	mv	a1,a5
f90020dc:	03800793          	li	a5,56
f90020e0:	32b7ce63          	blt	a5,a1,f900241c <__adddf3+0x604>
f90020e4:	01f00793          	li	a5,31
f90020e8:	4ab7c263          	blt	a5,a1,f900258c <__adddf3+0x774>
f90020ec:	02000793          	li	a5,32
f90020f0:	40b787b3          	sub	a5,a5,a1
f90020f4:	00f71933          	sll	s2,a4,a5
f90020f8:	00bf56b3          	srl	a3,t5,a1
f90020fc:	00ff17b3          	sll	a5,t5,a5
f9002100:	00d96933          	or	s2,s2,a3
f9002104:	00f037b3          	snez	a5,a5
f9002108:	00b75733          	srl	a4,a4,a1
f900210c:	00f96933          	or	s2,s2,a5
f9002110:	40e80833          	sub	a6,a6,a4
f9002114:	3100006f          	j	f9002424 <__adddf3+0x60c>
f9002118:	01f867b3          	or	a5,a6,t6
f900211c:	3e078463          	beqz	a5,f9002504 <__adddf3+0x6ec>
f9002120:	fffe0793          	addi	a5,t3,-1
f9002124:	28078263          	beqz	a5,f90023a8 <__adddf3+0x590>
f9002128:	7ff00693          	li	a3,2047
f900212c:	38de0463          	beq	t3,a3,f90024b4 <__adddf3+0x69c>
f9002130:	00078e13          	mv	t3,a5
f9002134:	f29ff06f          	j	f900205c <__adddf3+0x244>
f9002138:	1a0e1663          	bnez	t3,f90022e4 <__adddf3+0x4cc>
f900213c:	00148693          	addi	a3,s1,1
f9002140:	7fe6f793          	andi	a5,a3,2046
f9002144:	3e079a63          	bnez	a5,f9002538 <__adddf3+0x720>
f9002148:	01e767b3          	or	a5,a4,t5
f900214c:	34049e63          	bnez	s1,f90024a8 <__adddf3+0x690>
f9002150:	4a078863          	beqz	a5,f9002600 <__adddf3+0x7e8>
f9002154:	01f867b3          	or	a5,a6,t6
f9002158:	3c078463          	beqz	a5,f9002520 <__adddf3+0x708>
f900215c:	01ff0933          	add	s2,t5,t6
f9002160:	010707b3          	add	a5,a4,a6
f9002164:	01e93f33          	sltu	t5,s2,t5
f9002168:	01e78633          	add	a2,a5,t5
f900216c:	00861793          	slli	a5,a2,0x8
f9002170:	0007da63          	bgez	a5,f9002184 <__adddf3+0x36c>
f9002174:	ff8007b7          	lui	a5,0xff800
f9002178:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa63f>
f900217c:	00f67633          	and	a2,a2,a5
f9002180:	00100493          	li	s1,1
f9002184:	00797793          	andi	a5,s2,7
f9002188:	dc079ae3          	bnez	a5,f9001f5c <__adddf3+0x144>
f900218c:	01d61793          	slli	a5,a2,0x1d
f9002190:	00395893          	srli	a7,s2,0x3
f9002194:	00f8e8b3          	or	a7,a7,a5
f9002198:	00365793          	srli	a5,a2,0x3
f900219c:	7ff00713          	li	a4,2047
f90021a0:	06e48a63          	beq	s1,a4,f9002214 <__adddf3+0x3fc>
f90021a4:	00c79793          	slli	a5,a5,0xc
f90021a8:	00c7d793          	srli	a5,a5,0xc
f90021ac:	7ff4f513          	andi	a0,s1,2047
f90021b0:	00098593          	mv	a1,s3
f90021b4:	e01ff06f          	j	f9001fb4 <__adddf3+0x19c>
f90021b8:	01f86933          	or	s2,a6,t6
f90021bc:	01203933          	snez	s2,s2
f90021c0:	01e90933          	add	s2,s2,t5
f90021c4:	01e937b3          	sltu	a5,s2,t5
f90021c8:	00e78633          	add	a2,a5,a4
f90021cc:	00861793          	slli	a5,a2,0x8
f90021d0:	fa07dae3          	bgez	a5,f9002184 <__adddf3+0x36c>
f90021d4:	00148493          	addi	s1,s1,1
f90021d8:	7ff00793          	li	a5,2047
f90021dc:	1ef49663          	bne	s1,a5,f90023c8 <__adddf3+0x5b0>
f90021e0:	00098593          	mv	a1,s3
f90021e4:	7ff00513          	li	a0,2047
f90021e8:	00000793          	li	a5,0
f90021ec:	00000893          	li	a7,0
f90021f0:	dc5ff06f          	j	f9001fb4 <__adddf3+0x19c>
f90021f4:	0a079c63          	bnez	a5,f90022ac <__adddf3+0x494>
f90021f8:	46088463          	beqz	a7,f9002660 <__adddf3+0x848>
f90021fc:	00361693          	slli	a3,a2,0x3
f9002200:	01d81793          	slli	a5,a6,0x1d
f9002204:	0036d693          	srli	a3,a3,0x3
f9002208:	00d7e8b3          	or	a7,a5,a3
f900220c:	000e8993          	mv	s3,t4
f9002210:	00385793          	srli	a5,a6,0x3
f9002214:	00f8e7b3          	or	a5,a7,a5
f9002218:	fc0784e3          	beqz	a5,f90021e0 <__adddf3+0x3c8>
f900221c:	00000593          	li	a1,0
f9002220:	7ff00513          	li	a0,2047
f9002224:	000807b7          	lui	a5,0x80
f9002228:	00000893          	li	a7,0
f900222c:	d89ff06f          	j	f9001fb4 <__adddf3+0x19c>
f9002230:	ff800637          	lui	a2,0xff800
f9002234:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa63f>
f9002238:	00c7f633          	and	a2,a5,a2
f900223c:	00797793          	andi	a5,s2,7
f9002240:	40e484b3          	sub	s1,s1,a4
f9002244:	d0079ce3          	bnez	a5,f9001f5c <__adddf3+0x144>
f9002248:	f45ff06f          	j	f900218c <__adddf3+0x374>
f900224c:	00090513          	mv	a0,s2
f9002250:	361010ef          	jal	ra,f9003db0 <__clzsi2>
f9002254:	01850713          	addi	a4,a0,24
f9002258:	01f00793          	li	a5,31
f900225c:	cae7d2e3          	bge	a5,a4,f9001f00 <__adddf3+0xe8>
f9002260:	ff850613          	addi	a2,a0,-8
f9002264:	00c917b3          	sll	a5,s2,a2
f9002268:	00000913          	li	s2,0
f900226c:	cadff06f          	j	f9001f18 <__adddf3+0x100>
f9002270:	01f86933          	or	s2,a6,t6
f9002274:	01203933          	snez	s2,s2
f9002278:	c59ff06f          	j	f9001ed0 <__adddf3+0xb8>
f900227c:	41ff0933          	sub	s2,t5,t6
f9002280:	41070633          	sub	a2,a4,a6
f9002284:	012f3433          	sltu	s0,t5,s2
f9002288:	40860433          	sub	s0,a2,s0
f900228c:	00841793          	slli	a5,s0,0x8
f9002290:	2c07cc63          	bltz	a5,f9002568 <__adddf3+0x750>
f9002294:	008968b3          	or	a7,s2,s0
f9002298:	c4089ce3          	bnez	a7,f9001ef0 <__adddf3+0xd8>
f900229c:	00000793          	li	a5,0
f90022a0:	00000993          	li	s3,0
f90022a4:	00000493          	li	s1,0
f90022a8:	efdff06f          	j	f90021a4 <__adddf3+0x38c>
f90022ac:	f60898e3          	bnez	a7,f900221c <__adddf3+0x404>
f90022b0:	00351513          	slli	a0,a0,0x3
f90022b4:	01d71793          	slli	a5,a4,0x1d
f90022b8:	00355513          	srli	a0,a0,0x3
f90022bc:	00a7e8b3          	or	a7,a5,a0
f90022c0:	00375793          	srli	a5,a4,0x3
f90022c4:	f51ff06f          	j	f9002214 <__adddf3+0x3fc>
f90022c8:	00351513          	slli	a0,a0,0x3
f90022cc:	01d71793          	slli	a5,a4,0x1d
f90022d0:	00355513          	srli	a0,a0,0x3
f90022d4:	00a7e8b3          	or	a7,a5,a0
f90022d8:	000e0493          	mv	s1,t3
f90022dc:	00375793          	srli	a5,a4,0x3
f90022e0:	ebdff06f          	j	f900219c <__adddf3+0x384>
f90022e4:	40930533          	sub	a0,t1,s1
f90022e8:	14048a63          	beqz	s1,f900243c <__adddf3+0x624>
f90022ec:	008006b7          	lui	a3,0x800
f90022f0:	7ff00793          	li	a5,2047
f90022f4:	00d76733          	or	a4,a4,a3
f90022f8:	38f30663          	beq	t1,a5,f9002684 <__adddf3+0x86c>
f90022fc:	03800793          	li	a5,56
f9002300:	28a7c063          	blt	a5,a0,f9002580 <__adddf3+0x768>
f9002304:	01f00793          	li	a5,31
f9002308:	32a7c663          	blt	a5,a0,f9002634 <__adddf3+0x81c>
f900230c:	02000793          	li	a5,32
f9002310:	40a787b3          	sub	a5,a5,a0
f9002314:	00f71933          	sll	s2,a4,a5
f9002318:	00af56b3          	srl	a3,t5,a0
f900231c:	00ff17b3          	sll	a5,t5,a5
f9002320:	00d96933          	or	s2,s2,a3
f9002324:	00f037b3          	snez	a5,a5
f9002328:	00a75733          	srl	a4,a4,a0
f900232c:	00f96933          	or	s2,s2,a5
f9002330:	00e80833          	add	a6,a6,a4
f9002334:	01f90933          	add	s2,s2,t6
f9002338:	01f937b3          	sltu	a5,s2,t6
f900233c:	01078633          	add	a2,a5,a6
f9002340:	00030493          	mv	s1,t1
f9002344:	e89ff06f          	j	f90021cc <__adddf3+0x3b4>
f9002348:	008006b7          	lui	a3,0x800
f900234c:	7ff00793          	li	a5,2047
f9002350:	00d76733          	or	a4,a4,a3
f9002354:	d8f314e3          	bne	t1,a5,f90020dc <__adddf3+0x2c4>
f9002358:	00361793          	slli	a5,a2,0x3
f900235c:	0037d793          	srli	a5,a5,0x3
f9002360:	01d81893          	slli	a7,a6,0x1d
f9002364:	0117e8b3          	or	a7,a5,a7
f9002368:	000e8993          	mv	s3,t4
f900236c:	00385793          	srli	a5,a6,0x3
f9002370:	ea5ff06f          	j	f9002214 <__adddf3+0x3fc>
f9002374:	fe150713          	addi	a4,a0,-31
f9002378:	02000693          	li	a3,32
f900237c:	00e7d733          	srl	a4,a5,a4
f9002380:	00d60a63          	beq	a2,a3,f9002394 <__adddf3+0x57c>
f9002384:	04000693          	li	a3,64
f9002388:	40c68633          	sub	a2,a3,a2
f900238c:	00c79633          	sll	a2,a5,a2
f9002390:	00c96933          	or	s2,s2,a2
f9002394:	01203933          	snez	s2,s2
f9002398:	00e96933          	or	s2,s2,a4
f900239c:	00000613          	li	a2,0
f90023a0:	00000493          	li	s1,0
f90023a4:	de1ff06f          	j	f9002184 <__adddf3+0x36c>
f90023a8:	01ff0933          	add	s2,t5,t6
f90023ac:	010707b3          	add	a5,a4,a6
f90023b0:	01e93633          	sltu	a2,s2,t5
f90023b4:	00c78633          	add	a2,a5,a2
f90023b8:	00861793          	slli	a5,a2,0x8
f90023bc:	00100493          	li	s1,1
f90023c0:	dc07d2e3          	bgez	a5,f9002184 <__adddf3+0x36c>
f90023c4:	00200493          	li	s1,2
f90023c8:	ff8007b7          	lui	a5,0xff800
f90023cc:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa63f>
f90023d0:	00f677b3          	and	a5,a2,a5
f90023d4:	00195713          	srli	a4,s2,0x1
f90023d8:	00197913          	andi	s2,s2,1
f90023dc:	01276933          	or	s2,a4,s2
f90023e0:	01f79893          	slli	a7,a5,0x1f
f90023e4:	0128e933          	or	s2,a7,s2
f90023e8:	0017d613          	srli	a2,a5,0x1
f90023ec:	b69ff06f          	j	f9001f54 <__adddf3+0x13c>
f90023f0:	fe0e0913          	addi	s2,t3,-32
f90023f4:	02000793          	li	a5,32
f90023f8:	012856b3          	srl	a3,a6,s2
f90023fc:	00fe0a63          	beq	t3,a5,f9002410 <__adddf3+0x5f8>
f9002400:	04000913          	li	s2,64
f9002404:	41c90933          	sub	s2,s2,t3
f9002408:	01281933          	sll	s2,a6,s2
f900240c:	012fefb3          	or	t6,t6,s2
f9002410:	01f03933          	snez	s2,t6
f9002414:	00d96933          	or	s2,s2,a3
f9002418:	ab9ff06f          	j	f9001ed0 <__adddf3+0xb8>
f900241c:	01e76933          	or	s2,a4,t5
f9002420:	01203933          	snez	s2,s2
f9002424:	412f8933          	sub	s2,t6,s2
f9002428:	012fb7b3          	sltu	a5,t6,s2
f900242c:	40f80633          	sub	a2,a6,a5
f9002430:	00030493          	mv	s1,t1
f9002434:	000e8993          	mv	s3,t4
f9002438:	aa5ff06f          	j	f9001edc <__adddf3+0xc4>
f900243c:	01e767b3          	or	a5,a4,t5
f9002440:	1c078c63          	beqz	a5,f9002618 <__adddf3+0x800>
f9002444:	fff50793          	addi	a5,a0,-1
f9002448:	22078463          	beqz	a5,f9002670 <__adddf3+0x858>
f900244c:	7ff00693          	li	a3,2047
f9002450:	16d50463          	beq	a0,a3,f90025b8 <__adddf3+0x7a0>
f9002454:	00078513          	mv	a0,a5
f9002458:	ea5ff06f          	j	f90022fc <__adddf3+0x4e4>
f900245c:	02000793          	li	a5,32
f9002460:	41c787b3          	sub	a5,a5,t3
f9002464:	00f816b3          	sll	a3,a6,a5
f9002468:	00ff9933          	sll	s2,t6,a5
f900246c:	01cfd633          	srl	a2,t6,t3
f9002470:	00c6e6b3          	or	a3,a3,a2
f9002474:	01203933          	snez	s2,s2
f9002478:	01c857b3          	srl	a5,a6,t3
f900247c:	0126e933          	or	s2,a3,s2
f9002480:	00f70733          	add	a4,a4,a5
f9002484:	d3dff06f          	j	f90021c0 <__adddf3+0x3a8>
f9002488:	00361793          	slli	a5,a2,0x3
f900248c:	0037d793          	srli	a5,a5,0x3
f9002490:	01d81893          	slli	a7,a6,0x1d
f9002494:	0117e8b3          	or	a7,a5,a7
f9002498:	00058493          	mv	s1,a1
f900249c:	00385793          	srli	a5,a6,0x3
f90024a0:	000e8993          	mv	s3,t4
f90024a4:	cf9ff06f          	j	f900219c <__adddf3+0x384>
f90024a8:	10078863          	beqz	a5,f90025b8 <__adddf3+0x7a0>
f90024ac:	01f86933          	or	s2,a6,t6
f90024b0:	d60916e3          	bnez	s2,f900221c <__adddf3+0x404>
f90024b4:	00351513          	slli	a0,a0,0x3
f90024b8:	01d71793          	slli	a5,a4,0x1d
f90024bc:	00355513          	srli	a0,a0,0x3
f90024c0:	00f568b3          	or	a7,a0,a5
f90024c4:	00375793          	srli	a5,a4,0x3
f90024c8:	d4dff06f          	j	f9002214 <__adddf3+0x3fc>
f90024cc:	10088663          	beqz	a7,f90025d8 <__adddf3+0x7c0>
f90024d0:	00361693          	slli	a3,a2,0x3
f90024d4:	01d81793          	slli	a5,a6,0x1d
f90024d8:	0036d693          	srli	a3,a3,0x3
f90024dc:	00d7e8b3          	or	a7,a5,a3
f90024e0:	000e8993          	mv	s3,t4
f90024e4:	00385793          	srli	a5,a6,0x3
f90024e8:	cbdff06f          	j	f90021a4 <__adddf3+0x38c>
f90024ec:	41ff0933          	sub	s2,t5,t6
f90024f0:	410707b3          	sub	a5,a4,a6
f90024f4:	012f3f33          	sltu	t5,t5,s2
f90024f8:	41e78633          	sub	a2,a5,t5
f90024fc:	00100493          	li	s1,1
f9002500:	9ddff06f          	j	f9001edc <__adddf3+0xc4>
f9002504:	00351513          	slli	a0,a0,0x3
f9002508:	01d71793          	slli	a5,a4,0x1d
f900250c:	00355513          	srli	a0,a0,0x3
f9002510:	00f568b3          	or	a7,a0,a5
f9002514:	000e0493          	mv	s1,t3
f9002518:	00375793          	srli	a5,a4,0x3
f900251c:	c81ff06f          	j	f900219c <__adddf3+0x384>
f9002520:	00351513          	slli	a0,a0,0x3
f9002524:	01d71793          	slli	a5,a4,0x1d
f9002528:	00355513          	srli	a0,a0,0x3
f900252c:	00a7e8b3          	or	a7,a5,a0
f9002530:	00375793          	srli	a5,a4,0x3
f9002534:	c71ff06f          	j	f90021a4 <__adddf3+0x38c>
f9002538:	7ff00793          	li	a5,2047
f900253c:	caf682e3          	beq	a3,a5,f90021e0 <__adddf3+0x3c8>
f9002540:	01ff0933          	add	s2,t5,t6
f9002544:	01e93633          	sltu	a2,s2,t5
f9002548:	010707b3          	add	a5,a4,a6
f900254c:	00c787b3          	add	a5,a5,a2
f9002550:	01f79893          	slli	a7,a5,0x1f
f9002554:	00195913          	srli	s2,s2,0x1
f9002558:	0128e933          	or	s2,a7,s2
f900255c:	0017d613          	srli	a2,a5,0x1
f9002560:	00068493          	mv	s1,a3
f9002564:	c21ff06f          	j	f9002184 <__adddf3+0x36c>
f9002568:	41ef8933          	sub	s2,t6,t5
f900256c:	40e80733          	sub	a4,a6,a4
f9002570:	012fb633          	sltu	a2,t6,s2
f9002574:	40c70433          	sub	s0,a4,a2
f9002578:	000e8993          	mv	s3,t4
f900257c:	975ff06f          	j	f9001ef0 <__adddf3+0xd8>
f9002580:	01e76933          	or	s2,a4,t5
f9002584:	01203933          	snez	s2,s2
f9002588:	dadff06f          	j	f9002334 <__adddf3+0x51c>
f900258c:	fe058793          	addi	a5,a1,-32
f9002590:	02000693          	li	a3,32
f9002594:	00f757b3          	srl	a5,a4,a5
f9002598:	00d58a63          	beq	a1,a3,f90025ac <__adddf3+0x794>
f900259c:	04000693          	li	a3,64
f90025a0:	40b685b3          	sub	a1,a3,a1
f90025a4:	00b71733          	sll	a4,a4,a1
f90025a8:	00ef6f33          	or	t5,t5,a4
f90025ac:	01e03933          	snez	s2,t5
f90025b0:	00f96933          	or	s2,s2,a5
f90025b4:	e71ff06f          	j	f9002424 <__adddf3+0x60c>
f90025b8:	00361793          	slli	a5,a2,0x3
f90025bc:	0037d793          	srli	a5,a5,0x3
f90025c0:	01d81893          	slli	a7,a6,0x1d
f90025c4:	0117e8b3          	or	a7,a5,a7
f90025c8:	00385793          	srli	a5,a6,0x3
f90025cc:	c49ff06f          	j	f9002214 <__adddf3+0x3fc>
f90025d0:	00c968b3          	or	a7,s2,a2
f90025d4:	ba0898e3          	bnez	a7,f9002184 <__adddf3+0x36c>
f90025d8:	00000793          	li	a5,0
f90025dc:	00000993          	li	s3,0
f90025e0:	bc5ff06f          	j	f90021a4 <__adddf3+0x38c>
f90025e4:	41ef8933          	sub	s2,t6,t5
f90025e8:	40e807b3          	sub	a5,a6,a4
f90025ec:	012fb633          	sltu	a2,t6,s2
f90025f0:	40c78633          	sub	a2,a5,a2
f90025f4:	000e8993          	mv	s3,t4
f90025f8:	00100493          	li	s1,1
f90025fc:	8e1ff06f          	j	f9001edc <__adddf3+0xc4>
f9002600:	00361693          	slli	a3,a2,0x3
f9002604:	01d81793          	slli	a5,a6,0x1d
f9002608:	0036d693          	srli	a3,a3,0x3
f900260c:	00d7e8b3          	or	a7,a5,a3
f9002610:	00385793          	srli	a5,a6,0x3
f9002614:	b91ff06f          	j	f90021a4 <__adddf3+0x38c>
f9002618:	00361693          	slli	a3,a2,0x3
f900261c:	01d81793          	slli	a5,a6,0x1d
f9002620:	0036d693          	srli	a3,a3,0x3
f9002624:	00d7e8b3          	or	a7,a5,a3
f9002628:	00050493          	mv	s1,a0
f900262c:	00385793          	srli	a5,a6,0x3
f9002630:	b6dff06f          	j	f900219c <__adddf3+0x384>
f9002634:	fe050793          	addi	a5,a0,-32
f9002638:	02000693          	li	a3,32
f900263c:	00f757b3          	srl	a5,a4,a5
f9002640:	00d50a63          	beq	a0,a3,f9002654 <__adddf3+0x83c>
f9002644:	04000693          	li	a3,64
f9002648:	40a68533          	sub	a0,a3,a0
f900264c:	00a71733          	sll	a4,a4,a0
f9002650:	00ef6f33          	or	t5,t5,a4
f9002654:	01e03933          	snez	s2,t5
f9002658:	00f96933          	or	s2,s2,a5
f900265c:	cd9ff06f          	j	f9002334 <__adddf3+0x51c>
f9002660:	00000593          	li	a1,0
f9002664:	7ff00513          	li	a0,2047
f9002668:	000807b7          	lui	a5,0x80
f900266c:	949ff06f          	j	f9001fb4 <__adddf3+0x19c>
f9002670:	01ff0933          	add	s2,t5,t6
f9002674:	010707b3          	add	a5,a4,a6
f9002678:	01f93633          	sltu	a2,s2,t6
f900267c:	00c78633          	add	a2,a5,a2
f9002680:	d39ff06f          	j	f90023b8 <__adddf3+0x5a0>
f9002684:	00361693          	slli	a3,a2,0x3
f9002688:	01d81793          	slli	a5,a6,0x1d
f900268c:	0036d693          	srli	a3,a3,0x3
f9002690:	00d7e8b3          	or	a7,a5,a3
f9002694:	00385793          	srli	a5,a6,0x3
f9002698:	b7dff06f          	j	f9002214 <__adddf3+0x3fc>

f900269c <__muldf3>:
f900269c:	fc010113          	addi	sp,sp,-64
f90026a0:	0145d793          	srli	a5,a1,0x14
f90026a4:	02812c23          	sw	s0,56(sp)
f90026a8:	03212823          	sw	s2,48(sp)
f90026ac:	03412423          	sw	s4,40(sp)
f90026b0:	00c59413          	slli	s0,a1,0xc
f90026b4:	02112e23          	sw	ra,60(sp)
f90026b8:	02912a23          	sw	s1,52(sp)
f90026bc:	03312623          	sw	s3,44(sp)
f90026c0:	03512223          	sw	s5,36(sp)
f90026c4:	03612023          	sw	s6,32(sp)
f90026c8:	01712e23          	sw	s7,28(sp)
f90026cc:	7ff7f793          	andi	a5,a5,2047
f90026d0:	00050913          	mv	s2,a0
f90026d4:	00c45413          	srli	s0,s0,0xc
f90026d8:	01f5da13          	srli	s4,a1,0x1f
f90026dc:	14078c63          	beqz	a5,f9002834 <__muldf3+0x198>
f90026e0:	7ff00713          	li	a4,2047
f90026e4:	20e78863          	beq	a5,a4,f90028f4 <__muldf3+0x258>
f90026e8:	00341513          	slli	a0,s0,0x3
f90026ec:	01d95413          	srli	s0,s2,0x1d
f90026f0:	00a46433          	or	s0,s0,a0
f90026f4:	00800537          	lui	a0,0x800
f90026f8:	00a46433          	or	s0,s0,a0
f90026fc:	00391493          	slli	s1,s2,0x3
f9002700:	c0178b13          	addi	s6,a5,-1023 # 7fc01 <__stack_size+0x7ec01>
f9002704:	00000993          	li	s3,0
f9002708:	00000b93          	li	s7,0
f900270c:	0146d793          	srli	a5,a3,0x14
f9002710:	00c69913          	slli	s2,a3,0xc
f9002714:	7ff7f793          	andi	a5,a5,2047
f9002718:	00c95913          	srli	s2,s2,0xc
f900271c:	01f6da93          	srli	s5,a3,0x1f
f9002720:	18078263          	beqz	a5,f90028a4 <__muldf3+0x208>
f9002724:	7ff00713          	li	a4,2047
f9002728:	04e78c63          	beq	a5,a4,f9002780 <__muldf3+0xe4>
f900272c:	00391513          	slli	a0,s2,0x3
f9002730:	01d65913          	srli	s2,a2,0x1d
f9002734:	00a96933          	or	s2,s2,a0
f9002738:	c0178793          	addi	a5,a5,-1023
f900273c:	00800537          	lui	a0,0x800
f9002740:	00a96933          	or	s2,s2,a0
f9002744:	00361593          	slli	a1,a2,0x3
f9002748:	00fb0b33          	add	s6,s6,a5
f900274c:	00000813          	li	a6,0
f9002750:	015a46b3          	xor	a3,s4,s5
f9002754:	00f00793          	li	a5,15
f9002758:	00068513          	mv	a0,a3
f900275c:	001b0613          	addi	a2,s6,1
f9002760:	2137ec63          	bltu	a5,s3,f9002978 <__muldf3+0x2dc>
f9002764:	00002797          	auipc	a5,0x2
f9002768:	01c78793          	addi	a5,a5,28 # f9004780 <mode_2560x1440_regs+0x188>
f900276c:	00299993          	slli	s3,s3,0x2
f9002770:	00f989b3          	add	s3,s3,a5
f9002774:	0009a703          	lw	a4,0(s3)
f9002778:	00f70733          	add	a4,a4,a5
f900277c:	00070067          	jr	a4
f9002780:	00c965b3          	or	a1,s2,a2
f9002784:	7ffb0b13          	addi	s6,s6,2047
f9002788:	1c059063          	bnez	a1,f9002948 <__muldf3+0x2ac>
f900278c:	0029e993          	ori	s3,s3,2
f9002790:	00000913          	li	s2,0
f9002794:	00200813          	li	a6,2
f9002798:	fb9ff06f          	j	f9002750 <__muldf3+0xb4>
f900279c:	00000693          	li	a3,0
f90027a0:	7ff00793          	li	a5,2047
f90027a4:	00080437          	lui	s0,0x80
f90027a8:	00000493          	li	s1,0
f90027ac:	00c41413          	slli	s0,s0,0xc
f90027b0:	01479793          	slli	a5,a5,0x14
f90027b4:	00c45413          	srli	s0,s0,0xc
f90027b8:	01f69693          	slli	a3,a3,0x1f
f90027bc:	00f46433          	or	s0,s0,a5
f90027c0:	00d46433          	or	s0,s0,a3
f90027c4:	00040593          	mv	a1,s0
f90027c8:	03c12083          	lw	ra,60(sp)
f90027cc:	03812403          	lw	s0,56(sp)
f90027d0:	00048513          	mv	a0,s1
f90027d4:	03012903          	lw	s2,48(sp)
f90027d8:	03412483          	lw	s1,52(sp)
f90027dc:	02c12983          	lw	s3,44(sp)
f90027e0:	02812a03          	lw	s4,40(sp)
f90027e4:	02412a83          	lw	s5,36(sp)
f90027e8:	02012b03          	lw	s6,32(sp)
f90027ec:	01c12b83          	lw	s7,28(sp)
f90027f0:	04010113          	addi	sp,sp,64
f90027f4:	00008067          	ret
f90027f8:	000a8513          	mv	a0,s5
f90027fc:	00090413          	mv	s0,s2
f9002800:	00058493          	mv	s1,a1
f9002804:	00080b93          	mv	s7,a6
f9002808:	00200793          	li	a5,2
f900280c:	14fb8c63          	beq	s7,a5,f9002964 <__muldf3+0x2c8>
f9002810:	00300793          	li	a5,3
f9002814:	f8fb84e3          	beq	s7,a5,f900279c <__muldf3+0x100>
f9002818:	00100793          	li	a5,1
f900281c:	00050693          	mv	a3,a0
f9002820:	4cfb9463          	bne	s7,a5,f9002ce8 <__muldf3+0x64c>
f9002824:	00000793          	li	a5,0
f9002828:	00000413          	li	s0,0
f900282c:	00000493          	li	s1,0
f9002830:	f7dff06f          	j	f90027ac <__muldf3+0x110>
f9002834:	00a464b3          	or	s1,s0,a0
f9002838:	0e048e63          	beqz	s1,f9002934 <__muldf3+0x298>
f900283c:	00d12623          	sw	a3,12(sp)
f9002840:	00c12423          	sw	a2,8(sp)
f9002844:	38040863          	beqz	s0,f9002bd4 <__muldf3+0x538>
f9002848:	00040513          	mv	a0,s0
f900284c:	564010ef          	jal	ra,f9003db0 <__clzsi2>
f9002850:	00812603          	lw	a2,8(sp)
f9002854:	00c12683          	lw	a3,12(sp)
f9002858:	00050793          	mv	a5,a0
f900285c:	ff550593          	addi	a1,a0,-11 # 7ffff5 <__stack_size+0x7feff5>
f9002860:	01d00713          	li	a4,29
f9002864:	ff878493          	addi	s1,a5,-8
f9002868:	40b70733          	sub	a4,a4,a1
f900286c:	00941433          	sll	s0,s0,s1
f9002870:	00e95733          	srl	a4,s2,a4
f9002874:	00876433          	or	s0,a4,s0
f9002878:	009914b3          	sll	s1,s2,s1
f900287c:	c0d00b13          	li	s6,-1011
f9002880:	40fb0b33          	sub	s6,s6,a5
f9002884:	0146d793          	srli	a5,a3,0x14
f9002888:	00c69913          	slli	s2,a3,0xc
f900288c:	7ff7f793          	andi	a5,a5,2047
f9002890:	00000993          	li	s3,0
f9002894:	00000b93          	li	s7,0
f9002898:	00c95913          	srli	s2,s2,0xc
f900289c:	01f6da93          	srli	s5,a3,0x1f
f90028a0:	e80792e3          	bnez	a5,f9002724 <__muldf3+0x88>
f90028a4:	00c965b3          	or	a1,s2,a2
f90028a8:	06058463          	beqz	a1,f9002910 <__muldf3+0x274>
f90028ac:	2e090c63          	beqz	s2,f9002ba4 <__muldf3+0x508>
f90028b0:	00090513          	mv	a0,s2
f90028b4:	00c12423          	sw	a2,8(sp)
f90028b8:	4f8010ef          	jal	ra,f9003db0 <__clzsi2>
f90028bc:	00812603          	lw	a2,8(sp)
f90028c0:	00050793          	mv	a5,a0
f90028c4:	ff550693          	addi	a3,a0,-11
f90028c8:	01d00713          	li	a4,29
f90028cc:	ff878593          	addi	a1,a5,-8
f90028d0:	40d70733          	sub	a4,a4,a3
f90028d4:	00b91933          	sll	s2,s2,a1
f90028d8:	00e65733          	srl	a4,a2,a4
f90028dc:	01276933          	or	s2,a4,s2
f90028e0:	00b615b3          	sll	a1,a2,a1
f90028e4:	40fb07b3          	sub	a5,s6,a5
f90028e8:	c0d78b13          	addi	s6,a5,-1011
f90028ec:	00000813          	li	a6,0
f90028f0:	e61ff06f          	j	f9002750 <__muldf3+0xb4>
f90028f4:	00a464b3          	or	s1,s0,a0
f90028f8:	02049463          	bnez	s1,f9002920 <__muldf3+0x284>
f90028fc:	00000413          	li	s0,0
f9002900:	00800993          	li	s3,8
f9002904:	7ff00b13          	li	s6,2047
f9002908:	00200b93          	li	s7,2
f900290c:	e01ff06f          	j	f900270c <__muldf3+0x70>
f9002910:	0019e993          	ori	s3,s3,1
f9002914:	00000913          	li	s2,0
f9002918:	00100813          	li	a6,1
f900291c:	e35ff06f          	j	f9002750 <__muldf3+0xb4>
f9002920:	00050493          	mv	s1,a0
f9002924:	00c00993          	li	s3,12
f9002928:	7ff00b13          	li	s6,2047
f900292c:	00300b93          	li	s7,3
f9002930:	dddff06f          	j	f900270c <__muldf3+0x70>
f9002934:	00000413          	li	s0,0
f9002938:	00400993          	li	s3,4
f900293c:	00000b13          	li	s6,0
f9002940:	00100b93          	li	s7,1
f9002944:	dc9ff06f          	j	f900270c <__muldf3+0x70>
f9002948:	0039e993          	ori	s3,s3,3
f900294c:	00060593          	mv	a1,a2
f9002950:	00300813          	li	a6,3
f9002954:	dfdff06f          	j	f9002750 <__muldf3+0xb4>
f9002958:	00200793          	li	a5,2
f900295c:	000a0513          	mv	a0,s4
f9002960:	eafb98e3          	bne	s7,a5,f9002810 <__muldf3+0x174>
f9002964:	00050693          	mv	a3,a0
f9002968:	7ff00793          	li	a5,2047
f900296c:	00000413          	li	s0,0
f9002970:	00000493          	li	s1,0
f9002974:	e39ff06f          	j	f90027ac <__muldf3+0x110>
f9002978:	00010e37          	lui	t3,0x10
f900297c:	fffe0713          	addi	a4,t3,-1 # ffff <__stack_size+0xefff>
f9002980:	0104d793          	srli	a5,s1,0x10
f9002984:	0105d813          	srli	a6,a1,0x10
f9002988:	00e4f4b3          	and	s1,s1,a4
f900298c:	00e5f5b3          	and	a1,a1,a4
f9002990:	02958733          	mul	a4,a1,s1
f9002994:	02b78333          	mul	t1,a5,a1
f9002998:	01075513          	srli	a0,a4,0x10
f900299c:	029808b3          	mul	a7,a6,s1
f90029a0:	006888b3          	add	a7,a7,t1
f90029a4:	01150533          	add	a0,a0,a7
f90029a8:	03078f33          	mul	t5,a5,a6
f90029ac:	00657463          	bgeu	a0,t1,f90029b4 <__muldf3+0x318>
f90029b0:	01cf0f33          	add	t5,t5,t3
f90029b4:	00010eb7          	lui	t4,0x10
f90029b8:	fffe8893          	addi	a7,t4,-1 # ffff <__stack_size+0xefff>
f90029bc:	01095293          	srli	t0,s2,0x10
f90029c0:	01197933          	and	s2,s2,a7
f90029c4:	01157333          	and	t1,a0,a7
f90029c8:	01177733          	and	a4,a4,a7
f90029cc:	01031313          	slli	t1,t1,0x10
f90029d0:	029908b3          	mul	a7,s2,s1
f90029d4:	00e30333          	add	t1,t1,a4
f90029d8:	01055513          	srli	a0,a0,0x10
f90029dc:	03278fb3          	mul	t6,a5,s2
f90029e0:	0108de13          	srli	t3,a7,0x10
f90029e4:	029284b3          	mul	s1,t0,s1
f90029e8:	01f484b3          	add	s1,s1,t6
f90029ec:	009e04b3          	add	s1,t3,s1
f90029f0:	02578733          	mul	a4,a5,t0
f90029f4:	01f4f463          	bgeu	s1,t6,f90029fc <__muldf3+0x360>
f90029f8:	01d70733          	add	a4,a4,t4
f90029fc:	000109b7          	lui	s3,0x10
f9002a00:	fff98e13          	addi	t3,s3,-1 # ffff <__stack_size+0xefff>
f9002a04:	01c477b3          	and	a5,s0,t3
f9002a08:	01c4feb3          	and	t4,s1,t3
f9002a0c:	01045f93          	srli	t6,s0,0x10
f9002a10:	0104d493          	srli	s1,s1,0x10
f9002a14:	01c8f8b3          	and	a7,a7,t3
f9002a18:	02f583b3          	mul	t2,a1,a5
f9002a1c:	00e48e33          	add	t3,s1,a4
f9002a20:	010e9e93          	slli	t4,t4,0x10
f9002a24:	011e8eb3          	add	t4,t4,a7
f9002a28:	01d50533          	add	a0,a0,t4
f9002a2c:	02f80733          	mul	a4,a6,a5
f9002a30:	0103d893          	srli	a7,t2,0x10
f9002a34:	02bf85b3          	mul	a1,t6,a1
f9002a38:	00b70733          	add	a4,a4,a1
f9002a3c:	00e888b3          	add	a7,a7,a4
f9002a40:	03f80833          	mul	a6,a6,t6
f9002a44:	00b8f463          	bgeu	a7,a1,f9002a4c <__muldf3+0x3b0>
f9002a48:	01380833          	add	a6,a6,s3
f9002a4c:	00010737          	lui	a4,0x10
f9002a50:	fff70413          	addi	s0,a4,-1 # ffff <__stack_size+0xefff>
f9002a54:	0088f5b3          	and	a1,a7,s0
f9002a58:	0108d893          	srli	a7,a7,0x10
f9002a5c:	010888b3          	add	a7,a7,a6
f9002a60:	0083f3b3          	and	t2,t2,s0
f9002a64:	01059593          	slli	a1,a1,0x10
f9002a68:	02f90833          	mul	a6,s2,a5
f9002a6c:	007585b3          	add	a1,a1,t2
f9002a70:	032f8933          	mul	s2,t6,s2
f9002a74:	01085413          	srli	s0,a6,0x10
f9002a78:	02f287b3          	mul	a5,t0,a5
f9002a7c:	012787b3          	add	a5,a5,s2
f9002a80:	00f407b3          	add	a5,s0,a5
f9002a84:	03f28fb3          	mul	t6,t0,t6
f9002a88:	0127f463          	bgeu	a5,s2,f9002a90 <__muldf3+0x3f4>
f9002a8c:	00ef8fb3          	add	t6,t6,a4
f9002a90:	000102b7          	lui	t0,0x10
f9002a94:	fff28293          	addi	t0,t0,-1 # ffff <__stack_size+0xefff>
f9002a98:	0057f733          	and	a4,a5,t0
f9002a9c:	00587833          	and	a6,a6,t0
f9002aa0:	01071713          	slli	a4,a4,0x10
f9002aa4:	01e50533          	add	a0,a0,t5
f9002aa8:	01070733          	add	a4,a4,a6
f9002aac:	01d53eb3          	sltu	t4,a0,t4
f9002ab0:	01c70733          	add	a4,a4,t3
f9002ab4:	00b50533          	add	a0,a0,a1
f9002ab8:	01d70433          	add	s0,a4,t4
f9002abc:	00b535b3          	sltu	a1,a0,a1
f9002ac0:	01140833          	add	a6,s0,a7
f9002ac4:	00b80f33          	add	t5,a6,a1
f9002ac8:	01c73733          	sltu	a4,a4,t3
f9002acc:	01d43433          	sltu	s0,s0,t4
f9002ad0:	00876433          	or	s0,a4,s0
f9002ad4:	0107d793          	srli	a5,a5,0x10
f9002ad8:	011838b3          	sltu	a7,a6,a7
f9002adc:	00bf35b3          	sltu	a1,t5,a1
f9002ae0:	00f40433          	add	s0,s0,a5
f9002ae4:	00b8e5b3          	or	a1,a7,a1
f9002ae8:	00951493          	slli	s1,a0,0x9
f9002aec:	00b40433          	add	s0,s0,a1
f9002af0:	01f40433          	add	s0,s0,t6
f9002af4:	0064e4b3          	or	s1,s1,t1
f9002af8:	00941713          	slli	a4,s0,0x9
f9002afc:	009034b3          	snez	s1,s1
f9002b00:	017f5413          	srli	s0,t5,0x17
f9002b04:	01755513          	srli	a0,a0,0x17
f9002b08:	009f1793          	slli	a5,t5,0x9
f9002b0c:	00a4e4b3          	or	s1,s1,a0
f9002b10:	00876433          	or	s0,a4,s0
f9002b14:	00f4e4b3          	or	s1,s1,a5
f9002b18:	00741793          	slli	a5,s0,0x7
f9002b1c:	0207d063          	bgez	a5,f9002b3c <__muldf3+0x4a0>
f9002b20:	0014d793          	srli	a5,s1,0x1
f9002b24:	0014f493          	andi	s1,s1,1
f9002b28:	01f41713          	slli	a4,s0,0x1f
f9002b2c:	0097e4b3          	or	s1,a5,s1
f9002b30:	00e4e4b3          	or	s1,s1,a4
f9002b34:	00145413          	srli	s0,s0,0x1
f9002b38:	00060b13          	mv	s6,a2
f9002b3c:	3ffb0713          	addi	a4,s6,1023
f9002b40:	0ce05063          	blez	a4,f9002c00 <__muldf3+0x564>
f9002b44:	0074f793          	andi	a5,s1,7
f9002b48:	02078063          	beqz	a5,f9002b68 <__muldf3+0x4cc>
f9002b4c:	00f4f793          	andi	a5,s1,15
f9002b50:	00400613          	li	a2,4
f9002b54:	00c78a63          	beq	a5,a2,f9002b68 <__muldf3+0x4cc>
f9002b58:	00448793          	addi	a5,s1,4
f9002b5c:	0097b4b3          	sltu	s1,a5,s1
f9002b60:	00940433          	add	s0,s0,s1
f9002b64:	00078493          	mv	s1,a5
f9002b68:	00741793          	slli	a5,s0,0x7
f9002b6c:	0007da63          	bgez	a5,f9002b80 <__muldf3+0x4e4>
f9002b70:	ff0007b7          	lui	a5,0xff000
f9002b74:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0x5ffa63f>
f9002b78:	00f47433          	and	s0,s0,a5
f9002b7c:	400b0713          	addi	a4,s6,1024
f9002b80:	7fe00793          	li	a5,2046
f9002b84:	14e7ca63          	blt	a5,a4,f9002cd8 <__muldf3+0x63c>
f9002b88:	0034d793          	srli	a5,s1,0x3
f9002b8c:	01d41493          	slli	s1,s0,0x1d
f9002b90:	00941413          	slli	s0,s0,0x9
f9002b94:	00f4e4b3          	or	s1,s1,a5
f9002b98:	00c45413          	srli	s0,s0,0xc
f9002b9c:	7ff77793          	andi	a5,a4,2047
f9002ba0:	c0dff06f          	j	f90027ac <__muldf3+0x110>
f9002ba4:	00060513          	mv	a0,a2
f9002ba8:	00c12423          	sw	a2,8(sp)
f9002bac:	204010ef          	jal	ra,f9003db0 <__clzsi2>
f9002bb0:	01550693          	addi	a3,a0,21
f9002bb4:	01c00713          	li	a4,28
f9002bb8:	02050793          	addi	a5,a0,32
f9002bbc:	00812603          	lw	a2,8(sp)
f9002bc0:	d0d754e3          	bge	a4,a3,f90028c8 <__muldf3+0x22c>
f9002bc4:	ff850513          	addi	a0,a0,-8
f9002bc8:	00000593          	li	a1,0
f9002bcc:	00a61933          	sll	s2,a2,a0
f9002bd0:	d15ff06f          	j	f90028e4 <__muldf3+0x248>
f9002bd4:	1dc010ef          	jal	ra,f9003db0 <__clzsi2>
f9002bd8:	01550593          	addi	a1,a0,21
f9002bdc:	01c00713          	li	a4,28
f9002be0:	02050793          	addi	a5,a0,32
f9002be4:	00812603          	lw	a2,8(sp)
f9002be8:	00c12683          	lw	a3,12(sp)
f9002bec:	c6b75ae3          	bge	a4,a1,f9002860 <__muldf3+0x1c4>
f9002bf0:	ff850513          	addi	a0,a0,-8
f9002bf4:	00000493          	li	s1,0
f9002bf8:	00a91433          	sll	s0,s2,a0
f9002bfc:	c81ff06f          	j	f900287c <__muldf3+0x1e0>
f9002c00:	00100613          	li	a2,1
f9002c04:	40e60633          	sub	a2,a2,a4
f9002c08:	06071063          	bnez	a4,f9002c68 <__muldf3+0x5cc>
f9002c0c:	41eb0793          	addi	a5,s6,1054
f9002c10:	00f49733          	sll	a4,s1,a5
f9002c14:	00f417b3          	sll	a5,s0,a5
f9002c18:	00c4d4b3          	srl	s1,s1,a2
f9002c1c:	0097e4b3          	or	s1,a5,s1
f9002c20:	00e03733          	snez	a4,a4
f9002c24:	00e4e4b3          	or	s1,s1,a4
f9002c28:	0074f793          	andi	a5,s1,7
f9002c2c:	00c45633          	srl	a2,s0,a2
f9002c30:	02078063          	beqz	a5,f9002c50 <__muldf3+0x5b4>
f9002c34:	00f4f793          	andi	a5,s1,15
f9002c38:	00400713          	li	a4,4
f9002c3c:	00e78a63          	beq	a5,a4,f9002c50 <__muldf3+0x5b4>
f9002c40:	00448793          	addi	a5,s1,4
f9002c44:	0097b4b3          	sltu	s1,a5,s1
f9002c48:	00960633          	add	a2,a2,s1
f9002c4c:	00078493          	mv	s1,a5
f9002c50:	00861793          	slli	a5,a2,0x8
f9002c54:	0607d463          	bgez	a5,f9002cbc <__muldf3+0x620>
f9002c58:	00100793          	li	a5,1
f9002c5c:	00000413          	li	s0,0
f9002c60:	00000493          	li	s1,0
f9002c64:	b49ff06f          	j	f90027ac <__muldf3+0x110>
f9002c68:	03800793          	li	a5,56
f9002c6c:	bac7cce3          	blt	a5,a2,f9002824 <__muldf3+0x188>
f9002c70:	01f00793          	li	a5,31
f9002c74:	f8c7dce3          	bge	a5,a2,f9002c0c <__muldf3+0x570>
f9002c78:	fe100793          	li	a5,-31
f9002c7c:	40e78733          	sub	a4,a5,a4
f9002c80:	02000793          	li	a5,32
f9002c84:	00e45733          	srl	a4,s0,a4
f9002c88:	00f60863          	beq	a2,a5,f9002c98 <__muldf3+0x5fc>
f9002c8c:	43eb0793          	addi	a5,s6,1086
f9002c90:	00f417b3          	sll	a5,s0,a5
f9002c94:	00f4e4b3          	or	s1,s1,a5
f9002c98:	009034b3          	snez	s1,s1
f9002c9c:	00e4e4b3          	or	s1,s1,a4
f9002ca0:	0074f613          	andi	a2,s1,7
f9002ca4:	00000413          	li	s0,0
f9002ca8:	02060063          	beqz	a2,f9002cc8 <__muldf3+0x62c>
f9002cac:	00f4f793          	andi	a5,s1,15
f9002cb0:	00400713          	li	a4,4
f9002cb4:	00000613          	li	a2,0
f9002cb8:	f8e794e3          	bne	a5,a4,f9002c40 <__muldf3+0x5a4>
f9002cbc:	00961413          	slli	s0,a2,0x9
f9002cc0:	00c45413          	srli	s0,s0,0xc
f9002cc4:	01d61613          	slli	a2,a2,0x1d
f9002cc8:	0034d493          	srli	s1,s1,0x3
f9002ccc:	00c4e4b3          	or	s1,s1,a2
f9002cd0:	00000793          	li	a5,0
f9002cd4:	ad9ff06f          	j	f90027ac <__muldf3+0x110>
f9002cd8:	7ff00793          	li	a5,2047
f9002cdc:	00000413          	li	s0,0
f9002ce0:	00000493          	li	s1,0
f9002ce4:	ac9ff06f          	j	f90027ac <__muldf3+0x110>
f9002ce8:	00060b13          	mv	s6,a2
f9002cec:	e51ff06f          	j	f9002b3c <__muldf3+0x4a0>

f9002cf0 <__fixdfsi>:
f9002cf0:	0145d793          	srli	a5,a1,0x14
f9002cf4:	001006b7          	lui	a3,0x100
f9002cf8:	fff68713          	addi	a4,a3,-1 # fffff <__stack_size+0xfefff>
f9002cfc:	7ff7f793          	andi	a5,a5,2047
f9002d00:	3fe00613          	li	a2,1022
f9002d04:	00b77733          	and	a4,a4,a1
f9002d08:	01f5d593          	srli	a1,a1,0x1f
f9002d0c:	00f65e63          	bge	a2,a5,f9002d28 <__fixdfsi+0x38>
f9002d10:	41d00613          	li	a2,1053
f9002d14:	00f65e63          	bge	a2,a5,f9002d30 <__fixdfsi+0x40>
f9002d18:	80000537          	lui	a0,0x80000
f9002d1c:	fff54513          	not	a0,a0
f9002d20:	00a58533          	add	a0,a1,a0
f9002d24:	00008067          	ret
f9002d28:	00000513          	li	a0,0
f9002d2c:	00008067          	ret
f9002d30:	43300613          	li	a2,1075
f9002d34:	40f60633          	sub	a2,a2,a5
f9002d38:	01f00813          	li	a6,31
f9002d3c:	00d76733          	or	a4,a4,a3
f9002d40:	02c85063          	bge	a6,a2,f9002d60 <__fixdfsi+0x70>
f9002d44:	41300693          	li	a3,1043
f9002d48:	40f687b3          	sub	a5,a3,a5
f9002d4c:	00f757b3          	srl	a5,a4,a5
f9002d50:	40f00533          	neg	a0,a5
f9002d54:	fc059ce3          	bnez	a1,f9002d2c <__fixdfsi+0x3c>
f9002d58:	00078513          	mv	a0,a5
f9002d5c:	00008067          	ret
f9002d60:	bed78793          	addi	a5,a5,-1043
f9002d64:	00f717b3          	sll	a5,a4,a5
f9002d68:	00c55533          	srl	a0,a0,a2
f9002d6c:	00a7e7b3          	or	a5,a5,a0
f9002d70:	fe1ff06f          	j	f9002d50 <__fixdfsi+0x60>

f9002d74 <__floatsidf>:
f9002d74:	ff010113          	addi	sp,sp,-16
f9002d78:	00112623          	sw	ra,12(sp)
f9002d7c:	00812423          	sw	s0,8(sp)
f9002d80:	00912223          	sw	s1,4(sp)
f9002d84:	04050a63          	beqz	a0,f9002dd8 <__floatsidf+0x64>
f9002d88:	41f55793          	srai	a5,a0,0x1f
f9002d8c:	00a7c4b3          	xor	s1,a5,a0
f9002d90:	40f484b3          	sub	s1,s1,a5
f9002d94:	00050413          	mv	s0,a0
f9002d98:	00048513          	mv	a0,s1
f9002d9c:	014010ef          	jal	ra,f9003db0 <__clzsi2>
f9002da0:	41e00693          	li	a3,1054
f9002da4:	40a686b3          	sub	a3,a3,a0
f9002da8:	00a00793          	li	a5,10
f9002dac:	01f45413          	srli	s0,s0,0x1f
f9002db0:	7ff6f693          	andi	a3,a3,2047
f9002db4:	06a7c463          	blt	a5,a0,f9002e1c <__floatsidf+0xa8>
f9002db8:	00b00713          	li	a4,11
f9002dbc:	40a70733          	sub	a4,a4,a0
f9002dc0:	00e4d7b3          	srl	a5,s1,a4
f9002dc4:	01550513          	addi	a0,a0,21 # 80000015 <__freertos_irq_stack_top+0x86ffa655>
f9002dc8:	00c79793          	slli	a5,a5,0xc
f9002dcc:	00a494b3          	sll	s1,s1,a0
f9002dd0:	00c7d793          	srli	a5,a5,0xc
f9002dd4:	0140006f          	j	f9002de8 <__floatsidf+0x74>
f9002dd8:	00000413          	li	s0,0
f9002ddc:	00000693          	li	a3,0
f9002de0:	00000793          	li	a5,0
f9002de4:	00000493          	li	s1,0
f9002de8:	00c79793          	slli	a5,a5,0xc
f9002dec:	01469693          	slli	a3,a3,0x14
f9002df0:	00c7d793          	srli	a5,a5,0xc
f9002df4:	01f41413          	slli	s0,s0,0x1f
f9002df8:	00d7e7b3          	or	a5,a5,a3
f9002dfc:	0087e7b3          	or	a5,a5,s0
f9002e00:	00c12083          	lw	ra,12(sp)
f9002e04:	00812403          	lw	s0,8(sp)
f9002e08:	00048513          	mv	a0,s1
f9002e0c:	00078593          	mv	a1,a5
f9002e10:	00412483          	lw	s1,4(sp)
f9002e14:	01010113          	addi	sp,sp,16
f9002e18:	00008067          	ret
f9002e1c:	ff550513          	addi	a0,a0,-11
f9002e20:	00a497b3          	sll	a5,s1,a0
f9002e24:	00c79793          	slli	a5,a5,0xc
f9002e28:	00c7d793          	srli	a5,a5,0xc
f9002e2c:	00000493          	li	s1,0
f9002e30:	fb9ff06f          	j	f9002de8 <__floatsidf+0x74>

f9002e34 <__addsf3>:
f9002e34:	ff010113          	addi	sp,sp,-16
f9002e38:	00800737          	lui	a4,0x800
f9002e3c:	fff70713          	addi	a4,a4,-1 # 7fffff <__stack_size+0x7fefff>
f9002e40:	0175d813          	srli	a6,a1,0x17
f9002e44:	00912223          	sw	s1,4(sp)
f9002e48:	01755493          	srli	s1,a0,0x17
f9002e4c:	00a77333          	and	t1,a4,a0
f9002e50:	0ff4f493          	andi	s1,s1,255
f9002e54:	00b776b3          	and	a3,a4,a1
f9002e58:	01212023          	sw	s2,0(sp)
f9002e5c:	0ff87813          	andi	a6,a6,255
f9002e60:	01f55913          	srli	s2,a0,0x1f
f9002e64:	00112623          	sw	ra,12(sp)
f9002e68:	00812423          	sw	s0,8(sp)
f9002e6c:	01f5d593          	srli	a1,a1,0x1f
f9002e70:	00030793          	mv	a5,t1
f9002e74:	00048513          	mv	a0,s1
f9002e78:	00090613          	mv	a2,s2
f9002e7c:	00331e13          	slli	t3,t1,0x3
f9002e80:	00369e93          	slli	t4,a3,0x3
f9002e84:	410488b3          	sub	a7,s1,a6
f9002e88:	12b90663          	beq	s2,a1,f9002fb4 <__addsf3+0x180>
f9002e8c:	0f105a63          	blez	a7,f9002f80 <__addsf3+0x14c>
f9002e90:	18080863          	beqz	a6,f9003020 <__addsf3+0x1ec>
f9002e94:	0ff00793          	li	a5,255
f9002e98:	1af48063          	beq	s1,a5,f9003038 <__addsf3+0x204>
f9002e9c:	040007b7          	lui	a5,0x4000
f9002ea0:	00feeeb3          	or	t4,t4,a5
f9002ea4:	01b00793          	li	a5,27
f9002ea8:	3117ce63          	blt	a5,a7,f90031c4 <__addsf3+0x390>
f9002eac:	02000793          	li	a5,32
f9002eb0:	411787b3          	sub	a5,a5,a7
f9002eb4:	00fe97b3          	sll	a5,t4,a5
f9002eb8:	011ed8b3          	srl	a7,t4,a7
f9002ebc:	00f037b3          	snez	a5,a5
f9002ec0:	00f8e7b3          	or	a5,a7,a5
f9002ec4:	40fe07b3          	sub	a5,t3,a5
f9002ec8:	00579713          	slli	a4,a5,0x5
f9002ecc:	20075063          	bgez	a4,f90030cc <__addsf3+0x298>
f9002ed0:	04000437          	lui	s0,0x4000
f9002ed4:	fff40413          	addi	s0,s0,-1 # 3ffffff <__stack_size+0x3ffefff>
f9002ed8:	0087f433          	and	s0,a5,s0
f9002edc:	00040513          	mv	a0,s0
f9002ee0:	6d1000ef          	jal	ra,f9003db0 <__clzsi2>
f9002ee4:	ffb50513          	addi	a0,a0,-5
f9002ee8:	00a417b3          	sll	a5,s0,a0
f9002eec:	20954c63          	blt	a0,s1,f9003104 <__addsf3+0x2d0>
f9002ef0:	40950533          	sub	a0,a0,s1
f9002ef4:	00150413          	addi	s0,a0,1
f9002ef8:	02000713          	li	a4,32
f9002efc:	40870733          	sub	a4,a4,s0
f9002f00:	00e79733          	sll	a4,a5,a4
f9002f04:	00e03733          	snez	a4,a4
f9002f08:	0087d7b3          	srl	a5,a5,s0
f9002f0c:	00e7e7b3          	or	a5,a5,a4
f9002f10:	00000493          	li	s1,0
f9002f14:	0077f713          	andi	a4,a5,7
f9002f18:	00070a63          	beqz	a4,f9002f2c <__addsf3+0xf8>
f9002f1c:	00f7f713          	andi	a4,a5,15
f9002f20:	00400693          	li	a3,4
f9002f24:	00d70463          	beq	a4,a3,f9002f2c <__addsf3+0xf8>
f9002f28:	00478793          	addi	a5,a5,4 # 4000004 <__stack_size+0x3fff004>
f9002f2c:	00579713          	slli	a4,a5,0x5
f9002f30:	1a075263          	bgez	a4,f90030d4 <__addsf3+0x2a0>
f9002f34:	00148493          	addi	s1,s1,1
f9002f38:	0ff00713          	li	a4,255
f9002f3c:	00090613          	mv	a2,s2
f9002f40:	1ae48c63          	beq	s1,a4,f90030f8 <__addsf3+0x2c4>
f9002f44:	00679793          	slli	a5,a5,0x6
f9002f48:	0097d793          	srli	a5,a5,0x9
f9002f4c:	0ff4f513          	andi	a0,s1,255
f9002f50:	00c12083          	lw	ra,12(sp)
f9002f54:	00812403          	lw	s0,8(sp)
f9002f58:	00979793          	slli	a5,a5,0x9
f9002f5c:	01751493          	slli	s1,a0,0x17
f9002f60:	0097d513          	srli	a0,a5,0x9
f9002f64:	00956533          	or	a0,a0,s1
f9002f68:	01f61613          	slli	a2,a2,0x1f
f9002f6c:	00412483          	lw	s1,4(sp)
f9002f70:	00012903          	lw	s2,0(sp)
f9002f74:	00c56533          	or	a0,a0,a2
f9002f78:	01010113          	addi	sp,sp,16
f9002f7c:	00008067          	ret
f9002f80:	0c089663          	bnez	a7,f900304c <__addsf3+0x218>
f9002f84:	00148713          	addi	a4,s1,1
f9002f88:	0fe77713          	andi	a4,a4,254
f9002f8c:	18071a63          	bnez	a4,f9003120 <__addsf3+0x2ec>
f9002f90:	2a049663          	bnez	s1,f900323c <__addsf3+0x408>
f9002f94:	260e0c63          	beqz	t3,f900320c <__addsf3+0x3d8>
f9002f98:	fa0e8ce3          	beqz	t4,f9002f50 <__addsf3+0x11c>
f9002f9c:	41de07b3          	sub	a5,t3,t4
f9002fa0:	00579713          	slli	a4,a5,0x5
f9002fa4:	2a075c63          	bgez	a4,f900325c <__addsf3+0x428>
f9002fa8:	41ce87b3          	sub	a5,t4,t3
f9002fac:	00058913          	mv	s2,a1
f9002fb0:	f65ff06f          	j	f9002f14 <__addsf3+0xe0>
f9002fb4:	0d105e63          	blez	a7,f9003090 <__addsf3+0x25c>
f9002fb8:	0a080e63          	beqz	a6,f9003074 <__addsf3+0x240>
f9002fbc:	0ff00793          	li	a5,255
f9002fc0:	06f48c63          	beq	s1,a5,f9003038 <__addsf3+0x204>
f9002fc4:	040007b7          	lui	a5,0x4000
f9002fc8:	00feeeb3          	or	t4,t4,a5
f9002fcc:	01b00793          	li	a5,27
f9002fd0:	2717ce63          	blt	a5,a7,f900324c <__addsf3+0x418>
f9002fd4:	02000793          	li	a5,32
f9002fd8:	411787b3          	sub	a5,a5,a7
f9002fdc:	00fe97b3          	sll	a5,t4,a5
f9002fe0:	011ed8b3          	srl	a7,t4,a7
f9002fe4:	00f037b3          	snez	a5,a5
f9002fe8:	00f8e7b3          	or	a5,a7,a5
f9002fec:	01c787b3          	add	a5,a5,t3
f9002ff0:	00579713          	slli	a4,a5,0x5
f9002ff4:	0c075c63          	bgez	a4,f90030cc <__addsf3+0x298>
f9002ff8:	00148493          	addi	s1,s1,1
f9002ffc:	0ff00713          	li	a4,255
f9003000:	0ee48c63          	beq	s1,a4,f90030f8 <__addsf3+0x2c4>
f9003004:	7e0006b7          	lui	a3,0x7e000
f9003008:	0017d713          	srli	a4,a5,0x1
f900300c:	fff68693          	addi	a3,a3,-1 # 7dffffff <__stack_size+0x7dffefff>
f9003010:	0017f793          	andi	a5,a5,1
f9003014:	00d77733          	and	a4,a4,a3
f9003018:	00f767b3          	or	a5,a4,a5
f900301c:	ef9ff06f          	j	f9002f14 <__addsf3+0xe0>
f9003020:	0a0e8c63          	beqz	t4,f90030d8 <__addsf3+0x2a4>
f9003024:	fff88893          	addi	a7,a7,-1
f9003028:	41de07b3          	sub	a5,t3,t4
f900302c:	e8088ee3          	beqz	a7,f9002ec8 <__addsf3+0x94>
f9003030:	0ff00793          	li	a5,255
f9003034:	e6f498e3          	bne	s1,a5,f9002ea4 <__addsf3+0x70>
f9003038:	0a030e63          	beqz	t1,f90030f4 <__addsf3+0x2c0>
f900303c:	00000613          	li	a2,0
f9003040:	0ff00513          	li	a0,255
f9003044:	004007b7          	lui	a5,0x400
f9003048:	f09ff06f          	j	f9002f50 <__addsf3+0x11c>
f900304c:	40980733          	sub	a4,a6,s1
f9003050:	12049a63          	bnez	s1,f9003184 <__addsf3+0x350>
f9003054:	180e0e63          	beqz	t3,f90031f0 <__addsf3+0x3bc>
f9003058:	fff70713          	addi	a4,a4,-1
f900305c:	20070863          	beqz	a4,f900326c <__addsf3+0x438>
f9003060:	0ff00793          	li	a5,255
f9003064:	12f81863          	bne	a6,a5,f9003194 <__addsf3+0x360>
f9003068:	00058913          	mv	s2,a1
f900306c:	00068313          	mv	t1,a3
f9003070:	fc9ff06f          	j	f9003038 <__addsf3+0x204>
f9003074:	060e8263          	beqz	t4,f90030d8 <__addsf3+0x2a4>
f9003078:	fff88893          	addi	a7,a7,-1
f900307c:	01de07b3          	add	a5,t3,t4
f9003080:	f60888e3          	beqz	a7,f9002ff0 <__addsf3+0x1bc>
f9003084:	0ff00793          	li	a5,255
f9003088:	f4f492e3          	bne	s1,a5,f9002fcc <__addsf3+0x198>
f900308c:	fadff06f          	j	f9003038 <__addsf3+0x204>
f9003090:	0a089863          	bnez	a7,f9003140 <__addsf3+0x30c>
f9003094:	00148493          	addi	s1,s1,1
f9003098:	0fe4f713          	andi	a4,s1,254
f900309c:	18071063          	bnez	a4,f900321c <__addsf3+0x3e8>
f90030a0:	16051063          	bnez	a0,f9003200 <__addsf3+0x3cc>
f90030a4:	1c0e0c63          	beqz	t3,f900327c <__addsf3+0x448>
f90030a8:	ea0e84e3          	beqz	t4,f9002f50 <__addsf3+0x11c>
f90030ac:	01de07b3          	add	a5,t3,t4
f90030b0:	00579713          	slli	a4,a5,0x5
f90030b4:	00000493          	li	s1,0
f90030b8:	00075a63          	bgez	a4,f90030cc <__addsf3+0x298>
f90030bc:	fc000737          	lui	a4,0xfc000
f90030c0:	fff70713          	addi	a4,a4,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa63f>
f90030c4:	00e7f7b3          	and	a5,a5,a4
f90030c8:	00100493          	li	s1,1
f90030cc:	0077f713          	andi	a4,a5,7
f90030d0:	e40716e3          	bnez	a4,f9002f1c <__addsf3+0xe8>
f90030d4:	0037d313          	srli	t1,a5,0x3
f90030d8:	0ff00793          	li	a5,255
f90030dc:	f4f48ee3          	beq	s1,a5,f9003038 <__addsf3+0x204>
f90030e0:	00931793          	slli	a5,t1,0x9
f90030e4:	0097d793          	srli	a5,a5,0x9
f90030e8:	0ff4f513          	andi	a0,s1,255
f90030ec:	00090613          	mv	a2,s2
f90030f0:	e61ff06f          	j	f9002f50 <__addsf3+0x11c>
f90030f4:	00090613          	mv	a2,s2
f90030f8:	0ff00513          	li	a0,255
f90030fc:	00000793          	li	a5,0
f9003100:	e51ff06f          	j	f9002f50 <__addsf3+0x11c>
f9003104:	fc000737          	lui	a4,0xfc000
f9003108:	fff70713          	addi	a4,a4,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa63f>
f900310c:	00e7f7b3          	and	a5,a5,a4
f9003110:	0077f713          	andi	a4,a5,7
f9003114:	40a484b3          	sub	s1,s1,a0
f9003118:	e00712e3          	bnez	a4,f9002f1c <__addsf3+0xe8>
f900311c:	fb9ff06f          	j	f90030d4 <__addsf3+0x2a0>
f9003120:	41de0433          	sub	s0,t3,t4
f9003124:	00541793          	slli	a5,s0,0x5
f9003128:	1007c463          	bltz	a5,f9003230 <__addsf3+0x3fc>
f900312c:	da0418e3          	bnez	s0,f9002edc <__addsf3+0xa8>
f9003130:	00000613          	li	a2,0
f9003134:	00000513          	li	a0,0
f9003138:	00000793          	li	a5,0
f900313c:	e15ff06f          	j	f9002f50 <__addsf3+0x11c>
f9003140:	40980733          	sub	a4,a6,s1
f9003144:	08048463          	beqz	s1,f90031cc <__addsf3+0x398>
f9003148:	0ff00793          	li	a5,255
f900314c:	f2f800e3          	beq	a6,a5,f900306c <__addsf3+0x238>
f9003150:	040007b7          	lui	a5,0x4000
f9003154:	00fe6e33          	or	t3,t3,a5
f9003158:	01b00793          	li	a5,27
f900315c:	12e7ca63          	blt	a5,a4,f9003290 <__addsf3+0x45c>
f9003160:	02000793          	li	a5,32
f9003164:	40e787b3          	sub	a5,a5,a4
f9003168:	00fe17b3          	sll	a5,t3,a5
f900316c:	00ee5733          	srl	a4,t3,a4
f9003170:	00f037b3          	snez	a5,a5
f9003174:	00f767b3          	or	a5,a4,a5
f9003178:	01d787b3          	add	a5,a5,t4
f900317c:	00080493          	mv	s1,a6
f9003180:	e71ff06f          	j	f9002ff0 <__addsf3+0x1bc>
f9003184:	0ff00793          	li	a5,255
f9003188:	eef800e3          	beq	a6,a5,f9003068 <__addsf3+0x234>
f900318c:	040007b7          	lui	a5,0x4000
f9003190:	00fe6e33          	or	t3,t3,a5
f9003194:	01b00793          	li	a5,27
f9003198:	0ae7ce63          	blt	a5,a4,f9003254 <__addsf3+0x420>
f900319c:	02000693          	li	a3,32
f90031a0:	40e686b3          	sub	a3,a3,a4
f90031a4:	00de16b3          	sll	a3,t3,a3
f90031a8:	00ee57b3          	srl	a5,t3,a4
f90031ac:	00d03733          	snez	a4,a3
f90031b0:	00e7e7b3          	or	a5,a5,a4
f90031b4:	40fe87b3          	sub	a5,t4,a5
f90031b8:	00080493          	mv	s1,a6
f90031bc:	00058913          	mv	s2,a1
f90031c0:	d09ff06f          	j	f9002ec8 <__addsf3+0x94>
f90031c4:	00100793          	li	a5,1
f90031c8:	cfdff06f          	j	f9002ec4 <__addsf3+0x90>
f90031cc:	0a0e0c63          	beqz	t3,f9003284 <__addsf3+0x450>
f90031d0:	fff70713          	addi	a4,a4,-1
f90031d4:	01de07b3          	add	a5,t3,t4
f90031d8:	00080493          	mv	s1,a6
f90031dc:	e0070ae3          	beqz	a4,f9002ff0 <__addsf3+0x1bc>
f90031e0:	0ff00793          	li	a5,255
f90031e4:	f6f81ae3          	bne	a6,a5,f9003158 <__addsf3+0x324>
f90031e8:	00068313          	mv	t1,a3
f90031ec:	e4dff06f          	j	f9003038 <__addsf3+0x204>
f90031f0:	00068313          	mv	t1,a3
f90031f4:	00080493          	mv	s1,a6
f90031f8:	00058913          	mv	s2,a1
f90031fc:	eddff06f          	j	f90030d8 <__addsf3+0x2a4>
f9003200:	e60e06e3          	beqz	t3,f900306c <__addsf3+0x238>
f9003204:	e20e8ae3          	beqz	t4,f9003038 <__addsf3+0x204>
f9003208:	e35ff06f          	j	f900303c <__addsf3+0x208>
f900320c:	040e8a63          	beqz	t4,f9003260 <__addsf3+0x42c>
f9003210:	00058613          	mv	a2,a1
f9003214:	00068793          	mv	a5,a3
f9003218:	d39ff06f          	j	f9002f50 <__addsf3+0x11c>
f900321c:	0ff00793          	li	a5,255
f9003220:	ecf48ce3          	beq	s1,a5,f90030f8 <__addsf3+0x2c4>
f9003224:	01de07b3          	add	a5,t3,t4
f9003228:	0017d793          	srli	a5,a5,0x1
f900322c:	ea1ff06f          	j	f90030cc <__addsf3+0x298>
f9003230:	41ce8433          	sub	s0,t4,t3
f9003234:	00058913          	mv	s2,a1
f9003238:	ca5ff06f          	j	f9002edc <__addsf3+0xa8>
f900323c:	fc0e14e3          	bnez	t3,f9003204 <__addsf3+0x3d0>
f9003240:	de0e8ee3          	beqz	t4,f900303c <__addsf3+0x208>
f9003244:	00058913          	mv	s2,a1
f9003248:	e25ff06f          	j	f900306c <__addsf3+0x238>
f900324c:	00100793          	li	a5,1
f9003250:	d9dff06f          	j	f9002fec <__addsf3+0x1b8>
f9003254:	00100793          	li	a5,1
f9003258:	f5dff06f          	j	f90031b4 <__addsf3+0x380>
f900325c:	e60798e3          	bnez	a5,f90030cc <__addsf3+0x298>
f9003260:	00000613          	li	a2,0
f9003264:	00000793          	li	a5,0
f9003268:	ce9ff06f          	j	f9002f50 <__addsf3+0x11c>
f900326c:	41ce87b3          	sub	a5,t4,t3
f9003270:	00080493          	mv	s1,a6
f9003274:	00058913          	mv	s2,a1
f9003278:	c51ff06f          	j	f9002ec8 <__addsf3+0x94>
f900327c:	00068793          	mv	a5,a3
f9003280:	cd1ff06f          	j	f9002f50 <__addsf3+0x11c>
f9003284:	00068313          	mv	t1,a3
f9003288:	00080493          	mv	s1,a6
f900328c:	e4dff06f          	j	f90030d8 <__addsf3+0x2a4>
f9003290:	00100793          	li	a5,1
f9003294:	ee5ff06f          	j	f9003178 <__addsf3+0x344>

f9003298 <__gesf2>:
f9003298:	01755693          	srli	a3,a0,0x17
f900329c:	008007b7          	lui	a5,0x800
f90032a0:	fff78793          	addi	a5,a5,-1 # 7fffff <__stack_size+0x7fefff>
f90032a4:	0175d613          	srli	a2,a1,0x17
f90032a8:	0ff6f693          	andi	a3,a3,255
f90032ac:	0ff00813          	li	a6,255
f90032b0:	00a7f8b3          	and	a7,a5,a0
f90032b4:	01f55713          	srli	a4,a0,0x1f
f90032b8:	00b7f7b3          	and	a5,a5,a1
f90032bc:	0ff67613          	andi	a2,a2,255
f90032c0:	01f5d513          	srli	a0,a1,0x1f
f90032c4:	03068a63          	beq	a3,a6,f90032f8 <__gesf2+0x60>
f90032c8:	03060263          	beq	a2,a6,f90032ec <__gesf2+0x54>
f90032cc:	02069a63          	bnez	a3,f9003300 <__gesf2+0x68>
f90032d0:	00061463          	bnez	a2,f90032d8 <__gesf2+0x40>
f90032d4:	04078a63          	beqz	a5,f9003328 <__gesf2+0x90>
f90032d8:	04088263          	beqz	a7,f900331c <__gesf2+0x84>
f90032dc:	06a70063          	beq	a4,a0,f900333c <__gesf2+0xa4>
f90032e0:	00100513          	li	a0,1
f90032e4:	02071e63          	bnez	a4,f9003320 <__gesf2+0x88>
f90032e8:	00008067          	ret
f90032ec:	fe0780e3          	beqz	a5,f90032cc <__gesf2+0x34>
f90032f0:	ffe00513          	li	a0,-2
f90032f4:	00008067          	ret
f90032f8:	fe089ce3          	bnez	a7,f90032f0 <__gesf2+0x58>
f90032fc:	02d60c63          	beq	a2,a3,f9003334 <__gesf2+0x9c>
f9003300:	00061463          	bnez	a2,f9003308 <__gesf2+0x70>
f9003304:	fc078ee3          	beqz	a5,f90032e0 <__gesf2+0x48>
f9003308:	fca71ce3          	bne	a4,a0,f90032e0 <__gesf2+0x48>
f900330c:	02d65a63          	bge	a2,a3,f9003340 <__gesf2+0xa8>
f9003310:	00051863          	bnez	a0,f9003320 <__gesf2+0x88>
f9003314:	00100513          	li	a0,1
f9003318:	00008067          	ret
f900331c:	fc0516e3          	bnez	a0,f90032e8 <__gesf2+0x50>
f9003320:	fff00513          	li	a0,-1
f9003324:	00008067          	ret
f9003328:	00000513          	li	a0,0
f900332c:	fa089ae3          	bnez	a7,f90032e0 <__gesf2+0x48>
f9003330:	00008067          	ret
f9003334:	fc078ae3          	beqz	a5,f9003308 <__gesf2+0x70>
f9003338:	fb9ff06f          	j	f90032f0 <__gesf2+0x58>
f900333c:	00000693          	li	a3,0
f9003340:	00c6c863          	blt	a3,a2,f9003350 <__gesf2+0xb8>
f9003344:	f917eee3          	bltu	a5,a7,f90032e0 <__gesf2+0x48>
f9003348:	00000513          	li	a0,0
f900334c:	f8f8fee3          	bgeu	a7,a5,f90032e8 <__gesf2+0x50>
f9003350:	fc0708e3          	beqz	a4,f9003320 <__gesf2+0x88>
f9003354:	00070513          	mv	a0,a4
f9003358:	00008067          	ret

f900335c <__lesf2>:
f900335c:	01755693          	srli	a3,a0,0x17
f9003360:	008007b7          	lui	a5,0x800
f9003364:	fff78793          	addi	a5,a5,-1 # 7fffff <__stack_size+0x7fefff>
f9003368:	0175d613          	srli	a2,a1,0x17
f900336c:	0ff6f693          	andi	a3,a3,255
f9003370:	0ff00813          	li	a6,255
f9003374:	00a7f8b3          	and	a7,a5,a0
f9003378:	01f55713          	srli	a4,a0,0x1f
f900337c:	00b7f7b3          	and	a5,a5,a1
f9003380:	0ff67613          	andi	a2,a2,255
f9003384:	01f5d513          	srli	a0,a1,0x1f
f9003388:	05068263          	beq	a3,a6,f90033cc <__lesf2+0x70>
f900338c:	01060e63          	beq	a2,a6,f90033a8 <__lesf2+0x4c>
f9003390:	04069263          	bnez	a3,f90033d4 <__lesf2+0x78>
f9003394:	02061063          	bnez	a2,f90033b4 <__lesf2+0x58>
f9003398:	00079e63          	bnez	a5,f90033b4 <__lesf2+0x58>
f900339c:	00000513          	li	a0,0
f90033a0:	00089e63          	bnez	a7,f90033bc <__lesf2+0x60>
f90033a4:	00008067          	ret
f90033a8:	fe0784e3          	beqz	a5,f9003390 <__lesf2+0x34>
f90033ac:	00200513          	li	a0,2
f90033b0:	00008067          	ret
f90033b4:	02088e63          	beqz	a7,f90033f0 <__lesf2+0x94>
f90033b8:	04a70463          	beq	a4,a0,f9003400 <__lesf2+0xa4>
f90033bc:	00100513          	li	a0,1
f90033c0:	fe0702e3          	beqz	a4,f90033a4 <__lesf2+0x48>
f90033c4:	fff00513          	li	a0,-1
f90033c8:	00008067          	ret
f90033cc:	fe0890e3          	bnez	a7,f90033ac <__lesf2+0x50>
f90033d0:	02d60463          	beq	a2,a3,f90033f8 <__lesf2+0x9c>
f90033d4:	00061463          	bnez	a2,f90033dc <__lesf2+0x80>
f90033d8:	fe0782e3          	beqz	a5,f90033bc <__lesf2+0x60>
f90033dc:	fea710e3          	bne	a4,a0,f90033bc <__lesf2+0x60>
f90033e0:	02d65263          	bge	a2,a3,f9003404 <__lesf2+0xa8>
f90033e4:	fe0510e3          	bnez	a0,f90033c4 <__lesf2+0x68>
f90033e8:	00100513          	li	a0,1
f90033ec:	00008067          	ret
f90033f0:	fc050ae3          	beqz	a0,f90033c4 <__lesf2+0x68>
f90033f4:	00008067          	ret
f90033f8:	fe0782e3          	beqz	a5,f90033dc <__lesf2+0x80>
f90033fc:	fb1ff06f          	j	f90033ac <__lesf2+0x50>
f9003400:	00000693          	li	a3,0
f9003404:	00c6c863          	blt	a3,a2,f9003414 <__lesf2+0xb8>
f9003408:	fb17eae3          	bltu	a5,a7,f90033bc <__lesf2+0x60>
f900340c:	00000513          	li	a0,0
f9003410:	f8f8fae3          	bgeu	a7,a5,f90033a4 <__lesf2+0x48>
f9003414:	fa0708e3          	beqz	a4,f90033c4 <__lesf2+0x68>
f9003418:	00070513          	mv	a0,a4
f900341c:	00008067          	ret

f9003420 <__mulsf3>:
f9003420:	fd010113          	addi	sp,sp,-48
f9003424:	02812423          	sw	s0,40(sp)
f9003428:	01755413          	srli	s0,a0,0x17
f900342c:	01312e23          	sw	s3,28(sp)
f9003430:	01412c23          	sw	s4,24(sp)
f9003434:	00951993          	slli	s3,a0,0x9
f9003438:	02112623          	sw	ra,44(sp)
f900343c:	02912223          	sw	s1,36(sp)
f9003440:	03212023          	sw	s2,32(sp)
f9003444:	01512a23          	sw	s5,20(sp)
f9003448:	01612823          	sw	s6,16(sp)
f900344c:	0ff47413          	andi	s0,s0,255
f9003450:	0099d993          	srli	s3,s3,0x9
f9003454:	01f55a13          	srli	s4,a0,0x1f
f9003458:	12040063          	beqz	s0,f9003578 <__mulsf3+0x158>
f900345c:	0ff00793          	li	a5,255
f9003460:	14f40863          	beq	s0,a5,f90035b0 <__mulsf3+0x190>
f9003464:	00399793          	slli	a5,s3,0x3
f9003468:	04000737          	lui	a4,0x4000
f900346c:	00e7e9b3          	or	s3,a5,a4
f9003470:	f8140413          	addi	s0,s0,-127
f9003474:	00000493          	li	s1,0
f9003478:	00000b13          	li	s6,0
f900347c:	0175d713          	srli	a4,a1,0x17
f9003480:	00959a93          	slli	s5,a1,0x9
f9003484:	0ff77713          	andi	a4,a4,255
f9003488:	009ada93          	srli	s5,s5,0x9
f900348c:	01f5d913          	srli	s2,a1,0x1f
f9003490:	10070863          	beqz	a4,f90035a0 <__mulsf3+0x180>
f9003494:	0ff00793          	li	a5,255
f9003498:	04f70663          	beq	a4,a5,f90034e4 <__mulsf3+0xc4>
f900349c:	003a9a93          	slli	s5,s5,0x3
f90034a0:	f8170713          	addi	a4,a4,-127 # 3ffff81 <__stack_size+0x3ffef81>
f90034a4:	040007b7          	lui	a5,0x4000
f90034a8:	00faeab3          	or	s5,s5,a5
f90034ac:	00e40433          	add	s0,s0,a4
f90034b0:	00000613          	li	a2,0
f90034b4:	012a4533          	xor	a0,s4,s2
f90034b8:	00f00793          	li	a5,15
f90034bc:	00050693          	mv	a3,a0
f90034c0:	00140593          	addi	a1,s0,1
f90034c4:	1897e263          	bltu	a5,s1,f9003648 <__mulsf3+0x228>
f90034c8:	00001717          	auipc	a4,0x1
f90034cc:	2f870713          	addi	a4,a4,760 # f90047c0 <mode_2560x1440_regs+0x1c8>
f90034d0:	00249493          	slli	s1,s1,0x2
f90034d4:	00e484b3          	add	s1,s1,a4
f90034d8:	0004a783          	lw	a5,0(s1)
f90034dc:	00e787b3          	add	a5,a5,a4
f90034e0:	00078067          	jr	a5 # 4000000 <__stack_size+0x3fff000>
f90034e4:	0ff40413          	addi	s0,s0,255
f90034e8:	120a9c63          	bnez	s5,f9003620 <__mulsf3+0x200>
f90034ec:	0024e493          	ori	s1,s1,2
f90034f0:	00200613          	li	a2,2
f90034f4:	fc1ff06f          	j	f90034b4 <__mulsf3+0x94>
f90034f8:	00000513          	li	a0,0
f90034fc:	0ff00713          	li	a4,255
f9003500:	004007b7          	lui	a5,0x400
f9003504:	02c12083          	lw	ra,44(sp)
f9003508:	02812403          	lw	s0,40(sp)
f900350c:	00979793          	slli	a5,a5,0x9
f9003510:	01771713          	slli	a4,a4,0x17
f9003514:	0097d793          	srli	a5,a5,0x9
f9003518:	01f51513          	slli	a0,a0,0x1f
f900351c:	00e7e7b3          	or	a5,a5,a4
f9003520:	02412483          	lw	s1,36(sp)
f9003524:	02012903          	lw	s2,32(sp)
f9003528:	01c12983          	lw	s3,28(sp)
f900352c:	01812a03          	lw	s4,24(sp)
f9003530:	01412a83          	lw	s5,20(sp)
f9003534:	01012b03          	lw	s6,16(sp)
f9003538:	00a7e533          	or	a0,a5,a0
f900353c:	03010113          	addi	sp,sp,48
f9003540:	00008067          	ret
f9003544:	00090693          	mv	a3,s2
f9003548:	000a8993          	mv	s3,s5
f900354c:	00060b13          	mv	s6,a2
f9003550:	00200793          	li	a5,2
f9003554:	0efb0263          	beq	s6,a5,f9003638 <__mulsf3+0x218>
f9003558:	00300793          	li	a5,3
f900355c:	f8fb0ee3          	beq	s6,a5,f90034f8 <__mulsf3+0xd8>
f9003560:	00100793          	li	a5,1
f9003564:	00068513          	mv	a0,a3
f9003568:	22fb1463          	bne	s6,a5,f9003790 <__mulsf3+0x370>
f900356c:	00000713          	li	a4,0
f9003570:	00000793          	li	a5,0
f9003574:	f91ff06f          	j	f9003504 <__mulsf3+0xe4>
f9003578:	06099e63          	bnez	s3,f90035f4 <__mulsf3+0x1d4>
f900357c:	0175d713          	srli	a4,a1,0x17
f9003580:	00959a93          	slli	s5,a1,0x9
f9003584:	0ff77713          	andi	a4,a4,255
f9003588:	00400493          	li	s1,4
f900358c:	00000413          	li	s0,0
f9003590:	00100b13          	li	s6,1
f9003594:	009ada93          	srli	s5,s5,0x9
f9003598:	01f5d913          	srli	s2,a1,0x1f
f900359c:	ee071ce3          	bnez	a4,f9003494 <__mulsf3+0x74>
f90035a0:	020a9263          	bnez	s5,f90035c4 <__mulsf3+0x1a4>
f90035a4:	0014e493          	ori	s1,s1,1
f90035a8:	00100613          	li	a2,1
f90035ac:	f09ff06f          	j	f90034b4 <__mulsf3+0x94>
f90035b0:	02099a63          	bnez	s3,f90035e4 <__mulsf3+0x1c4>
f90035b4:	00800493          	li	s1,8
f90035b8:	0ff00413          	li	s0,255
f90035bc:	00200b13          	li	s6,2
f90035c0:	ebdff06f          	j	f900347c <__mulsf3+0x5c>
f90035c4:	000a8513          	mv	a0,s5
f90035c8:	7e8000ef          	jal	ra,f9003db0 <__clzsi2>
f90035cc:	ffb50793          	addi	a5,a0,-5
f90035d0:	40a40433          	sub	s0,s0,a0
f90035d4:	00fa9ab3          	sll	s5,s5,a5
f90035d8:	f8a40413          	addi	s0,s0,-118
f90035dc:	00000613          	li	a2,0
f90035e0:	ed5ff06f          	j	f90034b4 <__mulsf3+0x94>
f90035e4:	00c00493          	li	s1,12
f90035e8:	0ff00413          	li	s0,255
f90035ec:	00300b13          	li	s6,3
f90035f0:	e8dff06f          	j	f900347c <__mulsf3+0x5c>
f90035f4:	00098513          	mv	a0,s3
f90035f8:	00b12623          	sw	a1,12(sp)
f90035fc:	7b4000ef          	jal	ra,f9003db0 <__clzsi2>
f9003600:	ffb50793          	addi	a5,a0,-5
f9003604:	f8a00413          	li	s0,-118
f9003608:	00f999b3          	sll	s3,s3,a5
f900360c:	40a40433          	sub	s0,s0,a0
f9003610:	00000493          	li	s1,0
f9003614:	00000b13          	li	s6,0
f9003618:	00c12583          	lw	a1,12(sp)
f900361c:	e61ff06f          	j	f900347c <__mulsf3+0x5c>
f9003620:	0034e493          	ori	s1,s1,3
f9003624:	00300613          	li	a2,3
f9003628:	e8dff06f          	j	f90034b4 <__mulsf3+0x94>
f900362c:	00200793          	li	a5,2
f9003630:	000a0693          	mv	a3,s4
f9003634:	f2fb12e3          	bne	s6,a5,f9003558 <__mulsf3+0x138>
f9003638:	00068513          	mv	a0,a3
f900363c:	0ff00713          	li	a4,255
f9003640:	00000793          	li	a5,0
f9003644:	ec1ff06f          	j	f9003504 <__mulsf3+0xe4>
f9003648:	00010337          	lui	t1,0x10
f900364c:	fff30693          	addi	a3,t1,-1 # ffff <__stack_size+0xefff>
f9003650:	0109d613          	srli	a2,s3,0x10
f9003654:	010ad893          	srli	a7,s5,0x10
f9003658:	00d9f7b3          	and	a5,s3,a3
f900365c:	00dafab3          	and	s5,s5,a3
f9003660:	03578833          	mul	a6,a5,s5
f9003664:	02f889b3          	mul	s3,a7,a5
f9003668:	01085713          	srli	a4,a6,0x10
f900366c:	03560ab3          	mul	s5,a2,s5
f9003670:	015989b3          	add	s3,s3,s5
f9003674:	01370733          	add	a4,a4,s3
f9003678:	03160633          	mul	a2,a2,a7
f900367c:	01577463          	bgeu	a4,s5,f9003684 <__mulsf3+0x264>
f9003680:	00660633          	add	a2,a2,t1
f9003684:	000107b7          	lui	a5,0x10
f9003688:	fff78793          	addi	a5,a5,-1 # ffff <__stack_size+0xefff>
f900368c:	00f776b3          	and	a3,a4,a5
f9003690:	00f87833          	and	a6,a6,a5
f9003694:	01069693          	slli	a3,a3,0x10
f9003698:	010686b3          	add	a3,a3,a6
f900369c:	00669993          	slli	s3,a3,0x6
f90036a0:	01075793          	srli	a5,a4,0x10
f90036a4:	013039b3          	snez	s3,s3
f90036a8:	01a6d693          	srli	a3,a3,0x1a
f90036ac:	00c787b3          	add	a5,a5,a2
f90036b0:	00679793          	slli	a5,a5,0x6
f90036b4:	00d9e6b3          	or	a3,s3,a3
f90036b8:	00d7e9b3          	or	s3,a5,a3
f90036bc:	00499793          	slli	a5,s3,0x4
f90036c0:	0007da63          	bgez	a5,f90036d4 <__mulsf3+0x2b4>
f90036c4:	0019d713          	srli	a4,s3,0x1
f90036c8:	0019f793          	andi	a5,s3,1
f90036cc:	00f769b3          	or	s3,a4,a5
f90036d0:	00058413          	mv	s0,a1
f90036d4:	07f40713          	addi	a4,s0,127
f90036d8:	04e05663          	blez	a4,f9003724 <__mulsf3+0x304>
f90036dc:	0079f793          	andi	a5,s3,7
f90036e0:	00078a63          	beqz	a5,f90036f4 <__mulsf3+0x2d4>
f90036e4:	00f9f793          	andi	a5,s3,15
f90036e8:	00400693          	li	a3,4
f90036ec:	00d78463          	beq	a5,a3,f90036f4 <__mulsf3+0x2d4>
f90036f0:	00498993          	addi	s3,s3,4
f90036f4:	00499793          	slli	a5,s3,0x4
f90036f8:	0007da63          	bgez	a5,f900370c <__mulsf3+0x2ec>
f90036fc:	f80007b7          	lui	a5,0xf8000
f9003700:	fff78793          	addi	a5,a5,-1 # f7ffffff <__freertos_irq_stack_top+0xfeffa63f>
f9003704:	00f9f9b3          	and	s3,s3,a5
f9003708:	08040713          	addi	a4,s0,128
f900370c:	0fe00793          	li	a5,254
f9003710:	06e7ca63          	blt	a5,a4,f9003784 <__mulsf3+0x364>
f9003714:	00699793          	slli	a5,s3,0x6
f9003718:	0097d793          	srli	a5,a5,0x9
f900371c:	0ff77713          	andi	a4,a4,255
f9003720:	de5ff06f          	j	f9003504 <__mulsf3+0xe4>
f9003724:	00100793          	li	a5,1
f9003728:	40e786b3          	sub	a3,a5,a4
f900372c:	00070a63          	beqz	a4,f9003740 <__mulsf3+0x320>
f9003730:	01b00613          	li	a2,27
f9003734:	00000713          	li	a4,0
f9003738:	00000793          	li	a5,0
f900373c:	dcd644e3          	blt	a2,a3,f9003504 <__mulsf3+0xe4>
f9003740:	09e40713          	addi	a4,s0,158
f9003744:	00e99733          	sll	a4,s3,a4
f9003748:	00e03733          	snez	a4,a4
f900374c:	00d9d7b3          	srl	a5,s3,a3
f9003750:	00e7e7b3          	or	a5,a5,a4
f9003754:	0077f713          	andi	a4,a5,7
f9003758:	00070a63          	beqz	a4,f900376c <__mulsf3+0x34c>
f900375c:	00f7f713          	andi	a4,a5,15
f9003760:	00400693          	li	a3,4
f9003764:	00d70463          	beq	a4,a3,f900376c <__mulsf3+0x34c>
f9003768:	00478793          	addi	a5,a5,4
f900376c:	00579713          	slli	a4,a5,0x5
f9003770:	02074463          	bltz	a4,f9003798 <__mulsf3+0x378>
f9003774:	00679793          	slli	a5,a5,0x6
f9003778:	0097d793          	srli	a5,a5,0x9
f900377c:	00000713          	li	a4,0
f9003780:	d85ff06f          	j	f9003504 <__mulsf3+0xe4>
f9003784:	0ff00713          	li	a4,255
f9003788:	00000793          	li	a5,0
f900378c:	d79ff06f          	j	f9003504 <__mulsf3+0xe4>
f9003790:	00058413          	mv	s0,a1
f9003794:	f41ff06f          	j	f90036d4 <__mulsf3+0x2b4>
f9003798:	00100713          	li	a4,1
f900379c:	00000793          	li	a5,0
f90037a0:	d65ff06f          	j	f9003504 <__mulsf3+0xe4>

f90037a4 <__subsf3>:
f90037a4:	00800737          	lui	a4,0x800
f90037a8:	ff010113          	addi	sp,sp,-16
f90037ac:	fff70713          	addi	a4,a4,-1 # 7fffff <__stack_size+0x7fefff>
f90037b0:	01755693          	srli	a3,a0,0x17
f90037b4:	0175d813          	srli	a6,a1,0x17
f90037b8:	00a777b3          	and	a5,a4,a0
f90037bc:	0ff6f693          	andi	a3,a3,255
f90037c0:	01f55e93          	srli	t4,a0,0x1f
f90037c4:	00b77633          	and	a2,a4,a1
f90037c8:	00912223          	sw	s1,4(sp)
f90037cc:	01212023          	sw	s2,0(sp)
f90037d0:	0ff87813          	andi	a6,a6,255
f90037d4:	00112623          	sw	ra,12(sp)
f90037d8:	00812423          	sw	s0,8(sp)
f90037dc:	0ff00313          	li	t1,255
f90037e0:	00078e13          	mv	t3,a5
f90037e4:	00068913          	mv	s2,a3
f90037e8:	000e8493          	mv	s1,t4
f90037ec:	00379f13          	slli	t5,a5,0x3
f90037f0:	01f5d593          	srli	a1,a1,0x1f
f90037f4:	00361513          	slli	a0,a2,0x3
f90037f8:	410688b3          	sub	a7,a3,a6
f90037fc:	14680063          	beq	a6,t1,f900393c <__subsf3+0x198>
f9003800:	0015c593          	xori	a1,a1,1
f9003804:	14be8c63          	beq	t4,a1,f900395c <__subsf3+0x1b8>
f9003808:	0f105e63          	blez	a7,f9003904 <__subsf3+0x160>
f900380c:	12081e63          	bnez	a6,f9003948 <__subsf3+0x1a4>
f9003810:	24050a63          	beqz	a0,f9003a64 <__subsf3+0x2c0>
f9003814:	fff88893          	addi	a7,a7,-1
f9003818:	40af07b3          	sub	a5,t5,a0
f900381c:	02088863          	beqz	a7,f900384c <__subsf3+0xa8>
f9003820:	0ff00793          	li	a5,255
f9003824:	1cf68463          	beq	a3,a5,f90039ec <__subsf3+0x248>
f9003828:	01b00793          	li	a5,27
f900382c:	3317c263          	blt	a5,a7,f9003b50 <__subsf3+0x3ac>
f9003830:	02000713          	li	a4,32
f9003834:	41170733          	sub	a4,a4,a7
f9003838:	00e51733          	sll	a4,a0,a4
f900383c:	011557b3          	srl	a5,a0,a7
f9003840:	00e03733          	snez	a4,a4
f9003844:	00e7e7b3          	or	a5,a5,a4
f9003848:	40ff07b3          	sub	a5,t5,a5
f900384c:	00579713          	slli	a4,a5,0x5
f9003850:	20075463          	bgez	a4,f9003a58 <__subsf3+0x2b4>
f9003854:	04000437          	lui	s0,0x4000
f9003858:	fff40413          	addi	s0,s0,-1 # 3ffffff <__stack_size+0x3ffefff>
f900385c:	0087f433          	and	s0,a5,s0
f9003860:	00040513          	mv	a0,s0
f9003864:	54c000ef          	jal	ra,f9003db0 <__clzsi2>
f9003868:	ffb50513          	addi	a0,a0,-5
f900386c:	00a417b3          	sll	a5,s0,a0
f9003870:	23254063          	blt	a0,s2,f9003a90 <__subsf3+0x2ec>
f9003874:	41250533          	sub	a0,a0,s2
f9003878:	00150413          	addi	s0,a0,1
f900387c:	02000713          	li	a4,32
f9003880:	40870733          	sub	a4,a4,s0
f9003884:	00e79733          	sll	a4,a5,a4
f9003888:	00e03733          	snez	a4,a4
f900388c:	0087d7b3          	srl	a5,a5,s0
f9003890:	00e7e7b3          	or	a5,a5,a4
f9003894:	00000913          	li	s2,0
f9003898:	0077f713          	andi	a4,a5,7
f900389c:	00070a63          	beqz	a4,f90038b0 <__subsf3+0x10c>
f90038a0:	00f7f713          	andi	a4,a5,15
f90038a4:	00400693          	li	a3,4
f90038a8:	00d70463          	beq	a4,a3,f90038b0 <__subsf3+0x10c>
f90038ac:	00478793          	addi	a5,a5,4
f90038b0:	00579713          	slli	a4,a5,0x5
f90038b4:	1a075663          	bgez	a4,f9003a60 <__subsf3+0x2bc>
f90038b8:	00190693          	addi	a3,s2,1
f90038bc:	0ff00713          	li	a4,255
f90038c0:	0014fe93          	andi	t4,s1,1
f90038c4:	1ce68063          	beq	a3,a4,f9003a84 <__subsf3+0x2e0>
f90038c8:	00679793          	slli	a5,a5,0x6
f90038cc:	0097d793          	srli	a5,a5,0x9
f90038d0:	0ff6f693          	andi	a3,a3,255
f90038d4:	00979793          	slli	a5,a5,0x9
f90038d8:	00c12083          	lw	ra,12(sp)
f90038dc:	00812403          	lw	s0,8(sp)
f90038e0:	0097d513          	srli	a0,a5,0x9
f90038e4:	01769693          	slli	a3,a3,0x17
f90038e8:	01fe9793          	slli	a5,t4,0x1f
f90038ec:	00d56533          	or	a0,a0,a3
f90038f0:	00412483          	lw	s1,4(sp)
f90038f4:	00012903          	lw	s2,0(sp)
f90038f8:	00f56533          	or	a0,a0,a5
f90038fc:	01010113          	addi	sp,sp,16
f9003900:	00008067          	ret
f9003904:	0c089263          	bnez	a7,f90039c8 <__subsf3+0x224>
f9003908:	00168713          	addi	a4,a3,1
f900390c:	0fe77713          	andi	a4,a4,254
f9003910:	18071e63          	bnez	a4,f9003aac <__subsf3+0x308>
f9003914:	2a069a63          	bnez	a3,f9003bc8 <__subsf3+0x424>
f9003918:	280f0063          	beqz	t5,f9003b98 <__subsf3+0x3f4>
f900391c:	fa050ce3          	beqz	a0,f90038d4 <__subsf3+0x130>
f9003920:	40af07b3          	sub	a5,t5,a0
f9003924:	00579713          	slli	a4,a5,0x5
f9003928:	2c075063          	bgez	a4,f9003be8 <__subsf3+0x444>
f900392c:	41e507b3          	sub	a5,a0,t5
f9003930:	00000913          	li	s2,0
f9003934:	00058493          	mv	s1,a1
f9003938:	f61ff06f          	j	f9003898 <__subsf3+0xf4>
f900393c:	ec0502e3          	beqz	a0,f9003800 <__subsf3+0x5c>
f9003940:	0cbe8e63          	beq	t4,a1,f9003a1c <__subsf3+0x278>
f9003944:	fd1050e3          	blez	a7,f9003904 <__subsf3+0x160>
f9003948:	0ff00793          	li	a5,255
f900394c:	0af68063          	beq	a3,a5,f90039ec <__subsf3+0x248>
f9003950:	040007b7          	lui	a5,0x4000
f9003954:	00f56533          	or	a0,a0,a5
f9003958:	ed1ff06f          	j	f9003828 <__subsf3+0x84>
f900395c:	0d105063          	blez	a7,f9003a1c <__subsf3+0x278>
f9003960:	0a080063          	beqz	a6,f9003a00 <__subsf3+0x25c>
f9003964:	0ff00793          	li	a5,255
f9003968:	08f68263          	beq	a3,a5,f90039ec <__subsf3+0x248>
f900396c:	040007b7          	lui	a5,0x4000
f9003970:	00f56533          	or	a0,a0,a5
f9003974:	01b00793          	li	a5,27
f9003978:	2717c063          	blt	a5,a7,f9003bd8 <__subsf3+0x434>
f900397c:	02000713          	li	a4,32
f9003980:	41170733          	sub	a4,a4,a7
f9003984:	00e51733          	sll	a4,a0,a4
f9003988:	011557b3          	srl	a5,a0,a7
f900398c:	00e03733          	snez	a4,a4
f9003990:	00e7e7b3          	or	a5,a5,a4
f9003994:	01e787b3          	add	a5,a5,t5
f9003998:	00579713          	slli	a4,a5,0x5
f900399c:	0a075e63          	bgez	a4,f9003a58 <__subsf3+0x2b4>
f90039a0:	00190913          	addi	s2,s2,1
f90039a4:	0ff00713          	li	a4,255
f90039a8:	0ce90e63          	beq	s2,a4,f9003a84 <__subsf3+0x2e0>
f90039ac:	7e0006b7          	lui	a3,0x7e000
f90039b0:	0017d713          	srli	a4,a5,0x1
f90039b4:	fff68693          	addi	a3,a3,-1 # 7dffffff <__stack_size+0x7dffefff>
f90039b8:	0017f793          	andi	a5,a5,1
f90039bc:	00d77733          	and	a4,a4,a3
f90039c0:	00f767b3          	or	a5,a4,a5
f90039c4:	ed5ff06f          	j	f9003898 <__subsf3+0xf4>
f90039c8:	40d80733          	sub	a4,a6,a3
f90039cc:	14069263          	bnez	a3,f9003b10 <__subsf3+0x36c>
f90039d0:	1a0f0663          	beqz	t5,f9003b7c <__subsf3+0x3d8>
f90039d4:	fff70713          	addi	a4,a4,-1
f90039d8:	22070263          	beqz	a4,f9003bfc <__subsf3+0x458>
f90039dc:	0ff00793          	li	a5,255
f90039e0:	14f81063          	bne	a6,a5,f9003b20 <__subsf3+0x37c>
f90039e4:	00058493          	mv	s1,a1
f90039e8:	00060e13          	mv	t3,a2
f90039ec:	080e0a63          	beqz	t3,f9003a80 <__subsf3+0x2dc>
f90039f0:	00000e93          	li	t4,0
f90039f4:	0ff00693          	li	a3,255
f90039f8:	004007b7          	lui	a5,0x400
f90039fc:	ed9ff06f          	j	f90038d4 <__subsf3+0x130>
f9003a00:	06050263          	beqz	a0,f9003a64 <__subsf3+0x2c0>
f9003a04:	fff88893          	addi	a7,a7,-1
f9003a08:	00af07b3          	add	a5,t5,a0
f9003a0c:	f80886e3          	beqz	a7,f9003998 <__subsf3+0x1f4>
f9003a10:	0ff00793          	li	a5,255
f9003a14:	f6f690e3          	bne	a3,a5,f9003974 <__subsf3+0x1d0>
f9003a18:	fd5ff06f          	j	f90039ec <__subsf3+0x248>
f9003a1c:	0a089863          	bnez	a7,f9003acc <__subsf3+0x328>
f9003a20:	00168913          	addi	s2,a3,1
f9003a24:	0fe97713          	andi	a4,s2,254
f9003a28:	18071063          	bnez	a4,f9003ba8 <__subsf3+0x404>
f9003a2c:	16069063          	bnez	a3,f9003b8c <__subsf3+0x3e8>
f9003a30:	1c0f0e63          	beqz	t5,f9003c0c <__subsf3+0x468>
f9003a34:	ea0500e3          	beqz	a0,f90038d4 <__subsf3+0x130>
f9003a38:	00af07b3          	add	a5,t5,a0
f9003a3c:	00579713          	slli	a4,a5,0x5
f9003a40:	00000913          	li	s2,0
f9003a44:	00075a63          	bgez	a4,f9003a58 <__subsf3+0x2b4>
f9003a48:	fc000737          	lui	a4,0xfc000
f9003a4c:	fff70713          	addi	a4,a4,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa63f>
f9003a50:	00e7f7b3          	and	a5,a5,a4
f9003a54:	00100913          	li	s2,1
f9003a58:	0077f713          	andi	a4,a5,7
f9003a5c:	e40712e3          	bnez	a4,f90038a0 <__subsf3+0xfc>
f9003a60:	0037de13          	srli	t3,a5,0x3
f9003a64:	0ff00793          	li	a5,255
f9003a68:	f8f902e3          	beq	s2,a5,f90039ec <__subsf3+0x248>
f9003a6c:	009e1793          	slli	a5,t3,0x9
f9003a70:	0097d793          	srli	a5,a5,0x9
f9003a74:	0ff97693          	andi	a3,s2,255
f9003a78:	0014fe93          	andi	t4,s1,1
f9003a7c:	e59ff06f          	j	f90038d4 <__subsf3+0x130>
f9003a80:	0014fe93          	andi	t4,s1,1
f9003a84:	0ff00693          	li	a3,255
f9003a88:	00000793          	li	a5,0
f9003a8c:	e49ff06f          	j	f90038d4 <__subsf3+0x130>
f9003a90:	fc000737          	lui	a4,0xfc000
f9003a94:	fff70713          	addi	a4,a4,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa63f>
f9003a98:	00e7f7b3          	and	a5,a5,a4
f9003a9c:	0077f713          	andi	a4,a5,7
f9003aa0:	40a90933          	sub	s2,s2,a0
f9003aa4:	de071ee3          	bnez	a4,f90038a0 <__subsf3+0xfc>
f9003aa8:	fb9ff06f          	j	f9003a60 <__subsf3+0x2bc>
f9003aac:	40af0433          	sub	s0,t5,a0
f9003ab0:	00541793          	slli	a5,s0,0x5
f9003ab4:	1007c463          	bltz	a5,f9003bbc <__subsf3+0x418>
f9003ab8:	da0414e3          	bnez	s0,f9003860 <__subsf3+0xbc>
f9003abc:	00000e93          	li	t4,0
f9003ac0:	00000693          	li	a3,0
f9003ac4:	00000793          	li	a5,0
f9003ac8:	e0dff06f          	j	f90038d4 <__subsf3+0x130>
f9003acc:	40d80733          	sub	a4,a6,a3
f9003ad0:	08068463          	beqz	a3,f9003b58 <__subsf3+0x3b4>
f9003ad4:	0ff00793          	li	a5,255
f9003ad8:	f0f808e3          	beq	a6,a5,f90039e8 <__subsf3+0x244>
f9003adc:	040007b7          	lui	a5,0x4000
f9003ae0:	00ff6f33          	or	t5,t5,a5
f9003ae4:	01b00793          	li	a5,27
f9003ae8:	12e7cc63          	blt	a5,a4,f9003c20 <__subsf3+0x47c>
f9003aec:	02000793          	li	a5,32
f9003af0:	40e787b3          	sub	a5,a5,a4
f9003af4:	00ff17b3          	sll	a5,t5,a5
f9003af8:	00ef5733          	srl	a4,t5,a4
f9003afc:	00f037b3          	snez	a5,a5
f9003b00:	00f76733          	or	a4,a4,a5
f9003b04:	00a707b3          	add	a5,a4,a0
f9003b08:	00080913          	mv	s2,a6
f9003b0c:	e8dff06f          	j	f9003998 <__subsf3+0x1f4>
f9003b10:	0ff00793          	li	a5,255
f9003b14:	ecf808e3          	beq	a6,a5,f90039e4 <__subsf3+0x240>
f9003b18:	040007b7          	lui	a5,0x4000
f9003b1c:	00ff6f33          	or	t5,t5,a5
f9003b20:	01b00793          	li	a5,27
f9003b24:	0ae7ce63          	blt	a5,a4,f9003be0 <__subsf3+0x43c>
f9003b28:	02000793          	li	a5,32
f9003b2c:	40e787b3          	sub	a5,a5,a4
f9003b30:	00ff17b3          	sll	a5,t5,a5
f9003b34:	00ef5733          	srl	a4,t5,a4
f9003b38:	00f037b3          	snez	a5,a5
f9003b3c:	00f767b3          	or	a5,a4,a5
f9003b40:	40f507b3          	sub	a5,a0,a5
f9003b44:	00080913          	mv	s2,a6
f9003b48:	00058493          	mv	s1,a1
f9003b4c:	d01ff06f          	j	f900384c <__subsf3+0xa8>
f9003b50:	00100793          	li	a5,1
f9003b54:	cf5ff06f          	j	f9003848 <__subsf3+0xa4>
f9003b58:	0a0f0e63          	beqz	t5,f9003c14 <__subsf3+0x470>
f9003b5c:	fff70713          	addi	a4,a4,-1
f9003b60:	00af07b3          	add	a5,t5,a0
f9003b64:	00080913          	mv	s2,a6
f9003b68:	e20708e3          	beqz	a4,f9003998 <__subsf3+0x1f4>
f9003b6c:	0ff00793          	li	a5,255
f9003b70:	f6f81ae3          	bne	a6,a5,f9003ae4 <__subsf3+0x340>
f9003b74:	00060e13          	mv	t3,a2
f9003b78:	e75ff06f          	j	f90039ec <__subsf3+0x248>
f9003b7c:	00060e13          	mv	t3,a2
f9003b80:	00080913          	mv	s2,a6
f9003b84:	00058493          	mv	s1,a1
f9003b88:	eddff06f          	j	f9003a64 <__subsf3+0x2c0>
f9003b8c:	e40f0ee3          	beqz	t5,f90039e8 <__subsf3+0x244>
f9003b90:	e4050ee3          	beqz	a0,f90039ec <__subsf3+0x248>
f9003b94:	e5dff06f          	j	f90039f0 <__subsf3+0x24c>
f9003b98:	04050c63          	beqz	a0,f9003bf0 <__subsf3+0x44c>
f9003b9c:	00058e93          	mv	t4,a1
f9003ba0:	00060793          	mv	a5,a2
f9003ba4:	d31ff06f          	j	f90038d4 <__subsf3+0x130>
f9003ba8:	0ff00793          	li	a5,255
f9003bac:	ecf90ce3          	beq	s2,a5,f9003a84 <__subsf3+0x2e0>
f9003bb0:	00af07b3          	add	a5,t5,a0
f9003bb4:	0017d793          	srli	a5,a5,0x1
f9003bb8:	ea1ff06f          	j	f9003a58 <__subsf3+0x2b4>
f9003bbc:	41e50433          	sub	s0,a0,t5
f9003bc0:	00058493          	mv	s1,a1
f9003bc4:	c9dff06f          	j	f9003860 <__subsf3+0xbc>
f9003bc8:	fc0f14e3          	bnez	t5,f9003b90 <__subsf3+0x3ec>
f9003bcc:	e20502e3          	beqz	a0,f90039f0 <__subsf3+0x24c>
f9003bd0:	00058493          	mv	s1,a1
f9003bd4:	e15ff06f          	j	f90039e8 <__subsf3+0x244>
f9003bd8:	00100793          	li	a5,1
f9003bdc:	db9ff06f          	j	f9003994 <__subsf3+0x1f0>
f9003be0:	00100793          	li	a5,1
f9003be4:	f5dff06f          	j	f9003b40 <__subsf3+0x39c>
f9003be8:	00000913          	li	s2,0
f9003bec:	e60796e3          	bnez	a5,f9003a58 <__subsf3+0x2b4>
f9003bf0:	00000e93          	li	t4,0
f9003bf4:	00000793          	li	a5,0
f9003bf8:	cddff06f          	j	f90038d4 <__subsf3+0x130>
f9003bfc:	41e507b3          	sub	a5,a0,t5
f9003c00:	00080913          	mv	s2,a6
f9003c04:	00058493          	mv	s1,a1
f9003c08:	c45ff06f          	j	f900384c <__subsf3+0xa8>
f9003c0c:	00060793          	mv	a5,a2
f9003c10:	cc5ff06f          	j	f90038d4 <__subsf3+0x130>
f9003c14:	00060e13          	mv	t3,a2
f9003c18:	00080913          	mv	s2,a6
f9003c1c:	e49ff06f          	j	f9003a64 <__subsf3+0x2c0>
f9003c20:	00100713          	li	a4,1
f9003c24:	ee1ff06f          	j	f9003b04 <__subsf3+0x360>

f9003c28 <__fixunssfsi>:
f9003c28:	01755713          	srli	a4,a0,0x17
f9003c2c:	00800637          	lui	a2,0x800
f9003c30:	fff60793          	addi	a5,a2,-1 # 7fffff <__stack_size+0x7fefff>
f9003c34:	0ff77713          	andi	a4,a4,255
f9003c38:	07e00593          	li	a1,126
f9003c3c:	00a7f6b3          	and	a3,a5,a0
f9003c40:	01f55793          	srli	a5,a0,0x1f
f9003c44:	00000513          	li	a0,0
f9003c48:	00e5f663          	bgeu	a1,a4,f9003c54 <__fixunssfsi+0x2c>
f9003c4c:	00078663          	beqz	a5,f9003c58 <__fixunssfsi+0x30>
f9003c50:	00008067          	ret
f9003c54:	00008067          	ret
f9003c58:	09e00793          	li	a5,158
f9003c5c:	fff00513          	li	a0,-1
f9003c60:	fee7e8e3          	bltu	a5,a4,f9003c50 <__fixunssfsi+0x28>
f9003c64:	09500593          	li	a1,149
f9003c68:	00c6e7b3          	or	a5,a3,a2
f9003c6c:	00e5d863          	bge	a1,a4,f9003c7c <__fixunssfsi+0x54>
f9003c70:	f6a70713          	addi	a4,a4,-150
f9003c74:	00e79533          	sll	a0,a5,a4
f9003c78:	00008067          	ret
f9003c7c:	09600513          	li	a0,150
f9003c80:	40e50733          	sub	a4,a0,a4
f9003c84:	00e7d533          	srl	a0,a5,a4
f9003c88:	00008067          	ret

f9003c8c <__floatunsisf>:
f9003c8c:	ff010113          	addi	sp,sp,-16
f9003c90:	00112623          	sw	ra,12(sp)
f9003c94:	00812423          	sw	s0,8(sp)
f9003c98:	04050c63          	beqz	a0,f9003cf0 <__floatunsisf+0x64>
f9003c9c:	00050413          	mv	s0,a0
f9003ca0:	110000ef          	jal	ra,f9003db0 <__clzsi2>
f9003ca4:	09e00793          	li	a5,158
f9003ca8:	40a78733          	sub	a4,a5,a0
f9003cac:	09600793          	li	a5,150
f9003cb0:	06e7c463          	blt	a5,a4,f9003d18 <__floatunsisf+0x8c>
f9003cb4:	00800693          	li	a3,8
f9003cb8:	0ff77793          	andi	a5,a4,255
f9003cbc:	00a6d663          	bge	a3,a0,f9003cc8 <__floatunsisf+0x3c>
f9003cc0:	ff850513          	addi	a0,a0,-8
f9003cc4:	00a41433          	sll	s0,s0,a0
f9003cc8:	00941413          	slli	s0,s0,0x9
f9003ccc:	00945413          	srli	s0,s0,0x9
f9003cd0:	00941413          	slli	s0,s0,0x9
f9003cd4:	00945513          	srli	a0,s0,0x9
f9003cd8:	00c12083          	lw	ra,12(sp)
f9003cdc:	00812403          	lw	s0,8(sp)
f9003ce0:	01779793          	slli	a5,a5,0x17
f9003ce4:	00f56533          	or	a0,a0,a5
f9003ce8:	01010113          	addi	sp,sp,16
f9003cec:	00008067          	ret
f9003cf0:	00000413          	li	s0,0
f9003cf4:	00941413          	slli	s0,s0,0x9
f9003cf8:	00945513          	srli	a0,s0,0x9
f9003cfc:	00c12083          	lw	ra,12(sp)
f9003d00:	00812403          	lw	s0,8(sp)
f9003d04:	00000793          	li	a5,0
f9003d08:	01779793          	slli	a5,a5,0x17
f9003d0c:	00f56533          	or	a0,a0,a5
f9003d10:	01010113          	addi	sp,sp,16
f9003d14:	00008067          	ret
f9003d18:	09900793          	li	a5,153
f9003d1c:	02e7d063          	bge	a5,a4,f9003d3c <__floatunsisf+0xb0>
f9003d20:	01b50793          	addi	a5,a0,27
f9003d24:	00500693          	li	a3,5
f9003d28:	00f417b3          	sll	a5,s0,a5
f9003d2c:	40a686b3          	sub	a3,a3,a0
f9003d30:	00f037b3          	snez	a5,a5
f9003d34:	00d45433          	srl	s0,s0,a3
f9003d38:	0087e433          	or	s0,a5,s0
f9003d3c:	00500793          	li	a5,5
f9003d40:	00a7d663          	bge	a5,a0,f9003d4c <__floatunsisf+0xc0>
f9003d44:	ffb50793          	addi	a5,a0,-5
f9003d48:	00f41433          	sll	s0,s0,a5
f9003d4c:	fc0006b7          	lui	a3,0xfc000
f9003d50:	fff68693          	addi	a3,a3,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa63f>
f9003d54:	00747793          	andi	a5,s0,7
f9003d58:	00d47633          	and	a2,s0,a3
f9003d5c:	02078463          	beqz	a5,f9003d84 <__floatunsisf+0xf8>
f9003d60:	00f47793          	andi	a5,s0,15
f9003d64:	00400593          	li	a1,4
f9003d68:	00b78e63          	beq	a5,a1,f9003d84 <__floatunsisf+0xf8>
f9003d6c:	00460613          	addi	a2,a2,4
f9003d70:	00561793          	slli	a5,a2,0x5
f9003d74:	0007d863          	bgez	a5,f9003d84 <__floatunsisf+0xf8>
f9003d78:	09f00793          	li	a5,159
f9003d7c:	00d67633          	and	a2,a2,a3
f9003d80:	40a78733          	sub	a4,a5,a0
f9003d84:	00661413          	slli	s0,a2,0x6
f9003d88:	00945413          	srli	s0,s0,0x9
f9003d8c:	00941413          	slli	s0,s0,0x9
f9003d90:	00945513          	srli	a0,s0,0x9
f9003d94:	00c12083          	lw	ra,12(sp)
f9003d98:	00812403          	lw	s0,8(sp)
f9003d9c:	0ff77793          	andi	a5,a4,255
f9003da0:	01779793          	slli	a5,a5,0x17
f9003da4:	00f56533          	or	a0,a0,a5
f9003da8:	01010113          	addi	sp,sp,16
f9003dac:	00008067          	ret

f9003db0 <__clzsi2>:
f9003db0:	000107b7          	lui	a5,0x10
f9003db4:	04f57463          	bgeu	a0,a5,f9003dfc <__clzsi2+0x4c>
f9003db8:	0ff00793          	li	a5,255
f9003dbc:	02000713          	li	a4,32
f9003dc0:	00a7ee63          	bltu	a5,a0,f9003ddc <__clzsi2+0x2c>
f9003dc4:	00001797          	auipc	a5,0x1
f9003dc8:	a3c78793          	addi	a5,a5,-1476 # f9004800 <__clz_tab>
f9003dcc:	00a787b3          	add	a5,a5,a0
f9003dd0:	0007c503          	lbu	a0,0(a5)
f9003dd4:	40a70533          	sub	a0,a4,a0
f9003dd8:	00008067          	ret
f9003ddc:	00855513          	srli	a0,a0,0x8
f9003de0:	00001797          	auipc	a5,0x1
f9003de4:	a2078793          	addi	a5,a5,-1504 # f9004800 <__clz_tab>
f9003de8:	00a787b3          	add	a5,a5,a0
f9003dec:	0007c503          	lbu	a0,0(a5)
f9003df0:	01800713          	li	a4,24
f9003df4:	40a70533          	sub	a0,a4,a0
f9003df8:	00008067          	ret
f9003dfc:	010007b7          	lui	a5,0x1000
f9003e00:	02f56263          	bltu	a0,a5,f9003e24 <__clzsi2+0x74>
f9003e04:	01855513          	srli	a0,a0,0x18
f9003e08:	00001797          	auipc	a5,0x1
f9003e0c:	9f878793          	addi	a5,a5,-1544 # f9004800 <__clz_tab>
f9003e10:	00a787b3          	add	a5,a5,a0
f9003e14:	0007c503          	lbu	a0,0(a5)
f9003e18:	00800713          	li	a4,8
f9003e1c:	40a70533          	sub	a0,a4,a0
f9003e20:	00008067          	ret
f9003e24:	01055513          	srli	a0,a0,0x10
f9003e28:	00001797          	auipc	a5,0x1
f9003e2c:	9d878793          	addi	a5,a5,-1576 # f9004800 <__clz_tab>
f9003e30:	00a787b3          	add	a5,a5,a0
f9003e34:	0007c503          	lbu	a0,0(a5)
f9003e38:	01000713          	li	a4,16
f9003e3c:	40a70533          	sub	a0,a4,a0
f9003e40:	00008067          	ret
