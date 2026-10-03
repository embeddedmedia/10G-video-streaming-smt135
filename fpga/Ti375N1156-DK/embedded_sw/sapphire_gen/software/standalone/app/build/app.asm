
build/app.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
f9000000:	00005197          	auipc	gp,0x5
f9000004:	5c818193          	addi	gp,gp,1480 # f90055c8 <__global_pointer$>

f9000008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
f9000008:	00006117          	auipc	sp,0x6
f900000c:	e5810113          	addi	sp,sp,-424 # f9005e60 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
f9000010:	00004517          	auipc	a0,0x4
f9000014:	28050513          	addi	a0,a0,640 # f9004290 <_data>
	la a1, _data
f9000018:	00004597          	auipc	a1,0x4
f900001c:	27858593          	addi	a1,a1,632 # f9004290 <_data>
	la a2, _edata
f9000020:	00005617          	auipc	a2,0x5
f9000024:	df460613          	addi	a2,a2,-524 # f9004e14 <input.1>
	bgeu a1, a2, 2f
f9000028:	00c5fc63          	bgeu	a1,a2,f9000040 <init+0x38>
1:
	lw t0, (a0)
f900002c:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
f9000030:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
f9000034:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
f9000038:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
f900003c:	fec5e8e3          	bltu	a1,a2,f900002c <init+0x24>
2:

	/* Clear bss section */
	la a0, __bss_start
f9000040:	00005517          	auipc	a0,0x5
f9000044:	dd450513          	addi	a0,a0,-556 # f9004e14 <input.1>
	la a1, _end
f9000048:	00005597          	auipc	a1,0x5
f900004c:	e1058593          	addi	a1,a1,-496 # f9004e58 <_end>
	bgeu a0, a1, 2f
f9000050:	00b57863          	bgeu	a0,a1,f9000060 <init+0x58>
1:
	sw zero, (a0)
f9000054:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
f9000058:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
f900005c:	feb56ce3          	bltu	a0,a1,f9000054 <init+0x4c>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
f9000060:	010000ef          	jal	f9000070 <__libc_init_array>
#endif

	call main
f9000064:	0a0000ef          	jal	f9000104 <main>

f9000068 <mainDone>:
mainDone:
    j mainDone
f9000068:	0000006f          	j	f9000068 <mainDone>

f900006c <_init>:


	.globl _init
_init:
    ret
f900006c:	00008067          	ret

Disassembly of section .text:

f9000070 <__libc_init_array>:
f9000070:	ff010113          	addi	sp,sp,-16
f9000074:	00812423          	sw	s0,8(sp)
f9000078:	01212023          	sw	s2,0(sp)
f900007c:	00004797          	auipc	a5,0x4
f9000080:	21478793          	addi	a5,a5,532 # f9004290 <_data>
f9000084:	00004417          	auipc	s0,0x4
f9000088:	20c40413          	addi	s0,s0,524 # f9004290 <_data>
f900008c:	00112623          	sw	ra,12(sp)
f9000090:	00912223          	sw	s1,4(sp)
f9000094:	40878933          	sub	s2,a5,s0
f9000098:	02878063          	beq	a5,s0,f90000b8 <__libc_init_array+0x48>
f900009c:	40295913          	srai	s2,s2,0x2
f90000a0:	00000493          	li	s1,0
f90000a4:	00042783          	lw	a5,0(s0)
f90000a8:	00148493          	addi	s1,s1,1
f90000ac:	00440413          	addi	s0,s0,4
f90000b0:	000780e7          	jalr	a5
f90000b4:	ff24e8e3          	bltu	s1,s2,f90000a4 <__libc_init_array+0x34>
f90000b8:	00004797          	auipc	a5,0x4
f90000bc:	1d878793          	addi	a5,a5,472 # f9004290 <_data>
f90000c0:	00004417          	auipc	s0,0x4
f90000c4:	1d040413          	addi	s0,s0,464 # f9004290 <_data>
f90000c8:	40878933          	sub	s2,a5,s0
f90000cc:	40295913          	srai	s2,s2,0x2
f90000d0:	00878e63          	beq	a5,s0,f90000ec <__libc_init_array+0x7c>
f90000d4:	00000493          	li	s1,0
f90000d8:	00042783          	lw	a5,0(s0)
f90000dc:	00148493          	addi	s1,s1,1
f90000e0:	00440413          	addi	s0,s0,4
f90000e4:	000780e7          	jalr	a5
f90000e8:	ff24e8e3          	bltu	s1,s2,f90000d8 <__libc_init_array+0x68>
f90000ec:	00c12083          	lw	ra,12(sp)
f90000f0:	00812403          	lw	s0,8(sp)
f90000f4:	00412483          	lw	s1,4(sp)
f90000f8:	00012903          	lw	s2,0(sp)
f90000fc:	01010113          	addi	sp,sp,16
f9000100:	00008067          	ret

f9000104 <main>:
        print_menu();
    }
}

//////////////////////////////////////////////////////////////////////////////6//
void main() {
f9000104:	ff010113          	addi	sp,sp,-16
f9000108:	00112623          	sw	ra,12(sp)
    u32 speed;
    bsp_init();
f900010c:	4f5000ef          	jal	f9000e00 <bsp_init>
    bsp_printf("Video Streaming 10G\r\n");
f9000110:	f9004537          	lui	a0,0xf9004
f9000114:	5dc50513          	addi	a0,a0,1500 # f90045dc <_data+0x34c>
f9000118:	5cd000ef          	jal	f9000ee4 <bsp_printf>
	init();
f900011c:	20c010ef          	jal	f9001328 <init>
    bsp_uDelay(1000*1000);
f9000120:	f8b00637          	lui	a2,0xf8b00
f9000124:	05f5e5b7          	lui	a1,0x5f5e
f9000128:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f900012c:	000f4537          	lui	a0,0xf4
f9000130:	24050513          	addi	a0,a0,576 # f4240 <__stack_size+0xf3240>
f9000134:	269000ef          	jal	f9000b9c <clint_uDelay>
    print_menu();
f9000138:	26c010ef          	jal	f90013a4 <print_menu>
f900013c:	0080006f          	j	f9000144 <main+0x40>
    while(1) {
        while (uart_readOccupancy(BSP_UART_TERMINAL))
        {
            console_main();
f9000140:	348010ef          	jal	f9001488 <console_main>
        while (uart_readOccupancy(BSP_UART_TERMINAL))
f9000144:	f8010537          	lui	a0,0xf8010
f9000148:	1a9000ef          	jal	f9000af0 <uart_readOccupancy>
f900014c:	fe051ae3          	bnez	a0,f9000140 <main+0x3c>
        }
        bsp_uDelay(10*1000);
f9000150:	f8b00637          	lui	a2,0xf8b00
f9000154:	05f5e5b7          	lui	a1,0x5f5e
f9000158:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f900015c:	00002537          	lui	a0,0x2
f9000160:	71050513          	addi	a0,a0,1808 # 2710 <__stack_size+0x1710>
f9000164:	239000ef          	jal	f9000b9c <clint_uDelay>
        while (uart_readOccupancy(BSP_UART_TERMINAL))
f9000168:	fddff06f          	j	f9000144 <main+0x40>

f900016c <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
f900016c:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f9000170:	01055513          	srli	a0,a0,0x10
    }
f9000174:	0ff57513          	zext.b	a0,a0
f9000178:	00008067          	ret

f900017c <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
f900017c:	ff010113          	addi	sp,sp,-16
f9000180:	00112623          	sw	ra,12(sp)
f9000184:	00812423          	sw	s0,8(sp)
f9000188:	00912223          	sw	s1,4(sp)
f900018c:	00050413          	mv	s0,a0
f9000190:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9000194:	00040513          	mv	a0,s0
f9000198:	fd5ff0ef          	jal	f900016c <uart_writeAvailability>
f900019c:	fe050ce3          	beqz	a0,f9000194 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f90001a0:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
f90001a4:	00c12083          	lw	ra,12(sp)
f90001a8:	00812403          	lw	s0,8(sp)
f90001ac:	00412483          	lw	s1,4(sp)
f90001b0:	01010113          	addi	sp,sp,16
f90001b4:	00008067          	ret

f90001b8 <clint_uDelay>:
*          and the time limit is non-negative, indicating that the delay has
*          not yet elapsed.
*
******************************************************************************/
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
f90001b8:	000f47b7          	lui	a5,0xf4
f90001bc:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf3240>
f90001c0:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
f90001c4:	0000c7b7          	lui	a5,0xc
f90001c8:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0xaff8>
f90001cc:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
f90001d0:	00062783          	lw	a5,0(a2) # f8b00000 <__stack_size+0xf8aff000>
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
f90001d4:	02a585b3          	mul	a1,a1,a0
f90001d8:	00f58733          	add	a4,a1,a5
f90001dc:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
f90001e0:	40f707b3          	sub	a5,a4,a5
f90001e4:	fe07dce3          	bgez	a5,f90001dc <clint_uDelay+0x24>
f90001e8:	00008067          	ret

f90001ec <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
f90001ec:	ff010113          	addi	sp,sp,-16
f90001f0:	00112623          	sw	ra,12(sp)
f90001f4:	00050593          	mv	a1,a0
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
f90001f8:	f8010537          	lui	a0,0xf8010
f90001fc:	f81ff0ef          	jal	f900017c <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f9000200:	00c12083          	lw	ra,12(sp)
f9000204:	01010113          	addi	sp,sp,16
f9000208:	00008067          	ret

f900020c <_putchar_s>:

    static void _putchar_s(char *p)
    {
f900020c:	ff010113          	addi	sp,sp,-16
f9000210:	00112623          	sw	ra,12(sp)
f9000214:	00812423          	sw	s0,8(sp)
f9000218:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
f900021c:	00c0006f          	j	f9000228 <_putchar_s+0x1c>
            _putchar(*(p++));
f9000220:	00140413          	addi	s0,s0,1
f9000224:	fc9ff0ef          	jal	f90001ec <_putchar>
        while (*p)
f9000228:	00044503          	lbu	a0,0(s0)
f900022c:	fe051ae3          	bnez	a0,f9000220 <_putchar_s+0x14>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f9000230:	00c12083          	lw	ra,12(sp)
f9000234:	00812403          	lw	s0,8(sp)
f9000238:	01010113          	addi	sp,sp,16
f900023c:	00008067          	ret

f9000240 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
f9000240:	ff010113          	addi	sp,sp,-16
f9000244:	00112623          	sw	ra,12(sp)
f9000248:	00812423          	sw	s0,8(sp)
f900024c:	00912223          	sw	s1,4(sp)
f9000250:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000254:	01c00413          	li	s0,28
f9000258:	0240006f          	j	f900027c <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
f900025c:	0084d733          	srl	a4,s1,s0
f9000260:	00f77713          	andi	a4,a4,15
f9000264:	f90047b7          	lui	a5,0xf9004
f9000268:	29078793          	addi	a5,a5,656 # f9004290 <_data>
f900026c:	00e787b3          	add	a5,a5,a4
f9000270:	0007c503          	lbu	a0,0(a5)
f9000274:	f79ff0ef          	jal	f90001ec <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000278:	ffc40413          	addi	s0,s0,-4
f900027c:	fe0450e3          	bgez	s0,f900025c <bsp_printHex+0x1c>
        }
    }
f9000280:	00c12083          	lw	ra,12(sp)
f9000284:	00812403          	lw	s0,8(sp)
f9000288:	00412483          	lw	s1,4(sp)
f900028c:	01010113          	addi	sp,sp,16
f9000290:	00008067          	ret

f9000294 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
f9000294:	ff010113          	addi	sp,sp,-16
f9000298:	00112623          	sw	ra,12(sp)
f900029c:	00812423          	sw	s0,8(sp)
f90002a0:	00912223          	sw	s1,4(sp)
f90002a4:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f90002a8:	01c00413          	li	s0,28
f90002ac:	0240006f          	j	f90002d0 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
f90002b0:	0084d733          	srl	a4,s1,s0
f90002b4:	00f77713          	andi	a4,a4,15
f90002b8:	f90047b7          	lui	a5,0xf9004
f90002bc:	2a478793          	addi	a5,a5,676 # f90042a4 <_data+0x14>
f90002c0:	00e787b3          	add	a5,a5,a4
f90002c4:	0007c503          	lbu	a0,0(a5)
f90002c8:	f25ff0ef          	jal	f90001ec <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f90002cc:	ffc40413          	addi	s0,s0,-4
f90002d0:	fe0450e3          	bgez	s0,f90002b0 <bsp_printHex_lower+0x1c>

        }
    }
f90002d4:	00c12083          	lw	ra,12(sp)
f90002d8:	00812403          	lw	s0,8(sp)
f90002dc:	00412483          	lw	s1,4(sp)
f90002e0:	01010113          	addi	sp,sp,16
f90002e4:	00008067          	ret

f90002e8 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
f90002e8:	ff010113          	addi	sp,sp,-16
f90002ec:	00112623          	sw	ra,12(sp)
        _putchar(c);
f90002f0:	0ff57513          	zext.b	a0,a0
f90002f4:	ef9ff0ef          	jal	f90001ec <_putchar>
    }
f90002f8:	00c12083          	lw	ra,12(sp)
f90002fc:	01010113          	addi	sp,sp,16
f9000300:	00008067          	ret

f9000304 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
f9000304:	ff010113          	addi	sp,sp,-16
f9000308:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
f900030c:	f01ff0ef          	jal	f900020c <_putchar_s>
    }
f9000310:	00c12083          	lw	ra,12(sp)
f9000314:	01010113          	addi	sp,sp,16
f9000318:	00008067          	ret

f900031c <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
f900031c:	fd010113          	addi	sp,sp,-48
f9000320:	02112623          	sw	ra,44(sp)
f9000324:	02812423          	sw	s0,40(sp)
f9000328:	02912223          	sw	s1,36(sp)
f900032c:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
f9000330:	00054663          	bltz	a0,f900033c <bsp_printf_d+0x20>
    {
f9000334:	00010413          	mv	s0,sp
f9000338:	02c0006f          	j	f9000364 <bsp_printf_d+0x48>
            bsp_printf_c('-');
f900033c:	02d00513          	li	a0,45
f9000340:	fa9ff0ef          	jal	f90002e8 <bsp_printf_c>
            val = -val;
f9000344:	409004b3          	neg	s1,s1
f9000348:	fedff06f          	j	f9000334 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
f900034c:	00a00713          	li	a4,10
f9000350:	02e4e7b3          	rem	a5,s1,a4
f9000354:	03078793          	addi	a5,a5,48
f9000358:	00f40023          	sb	a5,0(s0)
            val = val / 10;
f900035c:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
f9000360:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
f9000364:	fe0494e3          	bnez	s1,f900034c <bsp_printf_d+0x30>
f9000368:	00010793          	mv	a5,sp
f900036c:	fef400e3          	beq	s0,a5,f900034c <bsp_printf_d+0x30>
        }
        while (p != buffer)
f9000370:	00010793          	mv	a5,sp
f9000374:	00f40a63          	beq	s0,a5,f9000388 <bsp_printf_d+0x6c>
            bsp_printf_c(*(--p));
f9000378:	fff40413          	addi	s0,s0,-1
f900037c:	00044503          	lbu	a0,0(s0)
f9000380:	f69ff0ef          	jal	f90002e8 <bsp_printf_c>
f9000384:	fedff06f          	j	f9000370 <bsp_printf_d+0x54>
    }
f9000388:	02c12083          	lw	ra,44(sp)
f900038c:	02812403          	lw	s0,40(sp)
f9000390:	02412483          	lw	s1,36(sp)
f9000394:	03010113          	addi	sp,sp,48
f9000398:	00008067          	ret

f900039c <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
f900039c:	ff010113          	addi	sp,sp,-16
f90003a0:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
f90003a4:	00000713          	li	a4,0
f90003a8:	00700793          	li	a5,7
f90003ac:	02e7c063          	blt	a5,a4,f90003cc <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f90003b0:	00271693          	slli	a3,a4,0x2
f90003b4:	ff000793          	li	a5,-16
f90003b8:	00d797b3          	sll	a5,a5,a3
f90003bc:	00f577b3          	and	a5,a0,a5
f90003c0:	00078663          	beqz	a5,f90003cc <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
f90003c4:	00170713          	addi	a4,a4,1
f90003c8:	fe1ff06f          	j	f90003a8 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
f90003cc:	ec9ff0ef          	jal	f9000294 <bsp_printHex_lower>
    }
f90003d0:	00c12083          	lw	ra,12(sp)
f90003d4:	01010113          	addi	sp,sp,16
f90003d8:	00008067          	ret

f90003dc <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
f90003dc:	ff010113          	addi	sp,sp,-16
f90003e0:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
f90003e4:	00000713          	li	a4,0
f90003e8:	00700793          	li	a5,7
f90003ec:	02e7c063          	blt	a5,a4,f900040c <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f90003f0:	00271693          	slli	a3,a4,0x2
f90003f4:	ff000793          	li	a5,-16
f90003f8:	00d797b3          	sll	a5,a5,a3
f90003fc:	00f577b3          	and	a5,a0,a5
f9000400:	00078663          	beqz	a5,f900040c <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
f9000404:	00170713          	addi	a4,a4,1
f9000408:	fe1ff06f          	j	f90003e8 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
f900040c:	e35ff0ef          	jal	f9000240 <bsp_printHex>
        }
f9000410:	00c12083          	lw	ra,12(sp)
f9000414:	01010113          	addi	sp,sp,16
f9000418:	00008067          	ret

f900041c <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
f900041c:	fc010113          	addi	sp,sp,-64
f9000420:	00112e23          	sw	ra,28(sp)
f9000424:	00812c23          	sw	s0,24(sp)
f9000428:	00912a23          	sw	s1,20(sp)
f900042c:	00050493          	mv	s1,a0
f9000430:	02b12223          	sw	a1,36(sp)
f9000434:	02c12423          	sw	a2,40(sp)
f9000438:	02d12623          	sw	a3,44(sp)
f900043c:	02e12823          	sw	a4,48(sp)
f9000440:	02f12a23          	sw	a5,52(sp)
f9000444:	03012c23          	sw	a6,56(sp)
f9000448:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
f900044c:	02410793          	addi	a5,sp,36
f9000450:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
f9000454:	00000413          	li	s0,0
f9000458:	01c0006f          	j	f9000474 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
f900045c:	00c12783          	lw	a5,12(sp)
f9000460:	00478713          	addi	a4,a5,4
f9000464:	00e12623          	sw	a4,12(sp)
f9000468:	0007a503          	lw	a0,0(a5)
f900046c:	e7dff0ef          	jal	f90002e8 <bsp_printf_c>
        for (i = 0; format[i]; i++)
f9000470:	00140413          	addi	s0,s0,1
f9000474:	008487b3          	add	a5,s1,s0
f9000478:	0007c503          	lbu	a0,0(a5)
f900047c:	0a050e63          	beqz	a0,f9000538 <bsp_printf+0x11c>
            if (format[i] == '%') {
f9000480:	02500793          	li	a5,37
f9000484:	06f50e63          	beq	a0,a5,f9000500 <bsp_printf+0xe4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
f9000488:	e61ff0ef          	jal	f90002e8 <bsp_printf_c>
f900048c:	fe5ff06f          	j	f9000470 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
f9000490:	00c12783          	lw	a5,12(sp)
f9000494:	00478713          	addi	a4,a5,4
f9000498:	00e12623          	sw	a4,12(sp)
f900049c:	0007a503          	lw	a0,0(a5)
f90004a0:	e65ff0ef          	jal	f9000304 <bsp_printf_s>
                        break;
f90004a4:	fcdff06f          	j	f9000470 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
f90004a8:	00c12783          	lw	a5,12(sp)
f90004ac:	00478713          	addi	a4,a5,4
f90004b0:	00e12623          	sw	a4,12(sp)
f90004b4:	0007a503          	lw	a0,0(a5)
f90004b8:	e65ff0ef          	jal	f900031c <bsp_printf_d>
                        break;
f90004bc:	fb5ff06f          	j	f9000470 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
f90004c0:	00c12783          	lw	a5,12(sp)
f90004c4:	00478713          	addi	a4,a5,4
f90004c8:	00e12623          	sw	a4,12(sp)
f90004cc:	0007a503          	lw	a0,0(a5)
f90004d0:	f0dff0ef          	jal	f90003dc <bsp_printf_X>
                        break;
f90004d4:	f9dff06f          	j	f9000470 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
f90004d8:	00c12783          	lw	a5,12(sp)
f90004dc:	00478713          	addi	a4,a5,4
f90004e0:	00e12623          	sw	a4,12(sp)
f90004e4:	0007a503          	lw	a0,0(a5)
f90004e8:	eb5ff0ef          	jal	f900039c <bsp_printf_x>
                        break;
f90004ec:	f85ff06f          	j	f9000470 <bsp_printf+0x54>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
f90004f0:	f9004537          	lui	a0,0xf9004
f90004f4:	2b850513          	addi	a0,a0,696 # f90042b8 <_data+0x28>
f90004f8:	e0dff0ef          	jal	f9000304 <bsp_printf_s>
                        break;
f90004fc:	f75ff06f          	j	f9000470 <bsp_printf+0x54>
                while (format[++i]) {
f9000500:	00140413          	addi	s0,s0,1
f9000504:	008487b3          	add	a5,s1,s0
f9000508:	0007c783          	lbu	a5,0(a5)
f900050c:	f60782e3          	beqz	a5,f9000470 <bsp_printf+0x54>
                    if (format[i] == 'c') {
f9000510:	fa878793          	addi	a5,a5,-88
f9000514:	0ff7f693          	zext.b	a3,a5
f9000518:	02000713          	li	a4,32
f900051c:	fed762e3          	bltu	a4,a3,f9000500 <bsp_printf+0xe4>
f9000520:	00269793          	slli	a5,a3,0x2
f9000524:	f9004737          	lui	a4,0xf9004
f9000528:	61070713          	addi	a4,a4,1552 # f9004610 <_data+0x380>
f900052c:	00e787b3          	add	a5,a5,a4
f9000530:	0007a783          	lw	a5,0(a5)
f9000534:	00078067          	jr	a5

        va_end(ap);
    }
f9000538:	01c12083          	lw	ra,28(sp)
f900053c:	01812403          	lw	s0,24(sp)
f9000540:	01412483          	lw	s1,20(sp)
f9000544:	04010113          	addi	sp,sp,64
f9000548:	00008067          	ret

f900054c <read_apb_reg>:
        bsp_printf("written: %x\r\n", base_addr + config[i].reg);
    }
}

u32 read_apb_reg(u32 reg) {
    return read_u32(APB_SLAVE + reg);
f900054c:	f81007b7          	lui	a5,0xf8100
f9000550:	00f50533          	add	a0,a0,a5
f9000554:	00052503          	lw	a0,0(a0)
}
f9000558:	00008067          	ret

f900055c <write_apb_reg>:

void write_apb_reg(u32 data, u32 reg) {
    write_u32(data, APB_SLAVE + reg);
f900055c:	f81007b7          	lui	a5,0xf8100
f9000560:	00f585b3          	add	a1,a1,a5
        *((volatile u32*) address) = data;
f9000564:	00a5a023          	sw	a0,0(a1)
}
f9000568:	00008067          	ret

f900056c <update_video_timing>:

void update_video_timing(VideoTiming_t config) {
    write_u32(config.max_hres, APB_SLAVE + REG_MAX_HRES);
f900056c:	00052703          	lw	a4,0(a0)
f9000570:	f81007b7          	lui	a5,0xf8100
f9000574:	02e7a223          	sw	a4,36(a5) # f8100024 <__stack_size+0xf80ff024>
    write_u32(config.hsp, APB_SLAVE + REG_HSP);
f9000578:	00852703          	lw	a4,8(a0)
f900057c:	f81007b7          	lui	a5,0xf8100
f9000580:	02e7a423          	sw	a4,40(a5) # f8100028 <__stack_size+0xf80ff028>
    write_u32(config.hbp, APB_SLAVE + REG_HBP);
f9000584:	00c52703          	lw	a4,12(a0)
f9000588:	f81007b7          	lui	a5,0xf8100
f900058c:	02e7a623          	sw	a4,44(a5) # f810002c <__stack_size+0xf80ff02c>
    write_u32(config.hact, APB_SLAVE + REG_HACT);
f9000590:	00452703          	lw	a4,4(a0)
f9000594:	f81007b7          	lui	a5,0xf8100
f9000598:	02e7a823          	sw	a4,48(a5) # f8100030 <__stack_size+0xf80ff030>
    write_u32(config.hfp, APB_SLAVE + REG_HFP);
f900059c:	01052703          	lw	a4,16(a0)
f90005a0:	f81007b7          	lui	a5,0xf8100
f90005a4:	02e7aa23          	sw	a4,52(a5) # f8100034 <__stack_size+0xf80ff034>
    write_u32(config.vsp, APB_SLAVE + REG_VSP);
f90005a8:	01852703          	lw	a4,24(a0)
f90005ac:	f81007b7          	lui	a5,0xf8100
f90005b0:	02e7ac23          	sw	a4,56(a5) # f8100038 <__stack_size+0xf80ff038>
    write_u32(config.vbp, APB_SLAVE + REG_VBP);
f90005b4:	01c52703          	lw	a4,28(a0)
f90005b8:	f81007b7          	lui	a5,0xf8100
f90005bc:	02e7ae23          	sw	a4,60(a5) # f810003c <__stack_size+0xf80ff03c>
    write_u32(config.max_vres, APB_SLAVE + REG_MAX_VRES);
f90005c0:	01452703          	lw	a4,20(a0)
f90005c4:	f81007b7          	lui	a5,0xf8100
f90005c8:	04e7a023          	sw	a4,64(a5) # f8100040 <__stack_size+0xf80ff040>
    write_u32(config.vfp, APB_SLAVE + REG_VFP);
f90005cc:	02052703          	lw	a4,32(a0)
f90005d0:	f81007b7          	lui	a5,0xf8100
f90005d4:	04e7a223          	sw	a4,68(a5) # f8100044 <__stack_size+0xf80ff044>
    write_u32(config.pcnt, APB_SLAVE + REG_PCNT);
f90005d8:	02452703          	lw	a4,36(a0)
f90005dc:	f81007b7          	lui	a5,0xf8100
f90005e0:	04e7a423          	sw	a4,72(a5) # f8100048 <__stack_size+0xf80ff048>
}
f90005e4:	00008067          	ret

f90005e8 <reg_init>:

void reg_init() {
f90005e8:	fb010113          	addi	sp,sp,-80
f90005ec:	04112623          	sw	ra,76(sp)
f90005f0:	04812423          	sw	s0,72(sp)
f90005f4:	04912223          	sw	s1,68(sp)
f90005f8:	05212023          	sw	s2,64(sp)
f90005fc:	03312e23          	sw	s3,60(sp)
f9000600:	03412c23          	sw	s4,56(sp)
f9000604:	03512a23          	sw	s5,52(sp)
    IPv4 local_ip = {.data = {20, 100, 16, 172}};
f9000608:	ffff0437          	lui	s0,0xffff0
f900060c:	0ff40413          	addi	s0,s0,255 # ffff00ff <__freertos_irq_stack_top+0x6fea29f>
f9000610:	01447913          	andi	s2,s0,20
f9000614:	000066b7          	lui	a3,0x6
f9000618:	40068693          	addi	a3,a3,1024 # 6400 <__stack_size+0x5400>
f900061c:	00d96933          	or	s2,s2,a3
f9000620:	ff010737          	lui	a4,0xff010
f9000624:	fff70713          	addi	a4,a4,-1 # ff00ffff <__freertos_irq_stack_top+0x600a19f>
f9000628:	00e97933          	and	s2,s2,a4
f900062c:	001005b7          	lui	a1,0x100
f9000630:	00b96933          	or	s2,s2,a1
f9000634:	010007b7          	lui	a5,0x1000
f9000638:	fff78793          	addi	a5,a5,-1 # ffffff <__stack_size+0xffefff>
f900063c:	00f97933          	and	s2,s2,a5
f9000640:	ac000637          	lui	a2,0xac000
f9000644:	00c96933          	or	s2,s2,a2
    IPv4 dest_ip = {.data = {10, 100, 16, 172}};
f9000648:	00a47493          	andi	s1,s0,10
f900064c:	00d4e4b3          	or	s1,s1,a3
f9000650:	00e4f4b3          	and	s1,s1,a4
f9000654:	00b4e4b3          	or	s1,s1,a1
f9000658:	00f4f4b3          	and	s1,s1,a5
f900065c:	00c4e4b3          	or	s1,s1,a2
f9000660:	f82007b7          	lui	a5,0xf8200
f9000664:	0007a423          	sw	zero,8(a5) # f8200008 <__stack_size+0xf81ff008>
f9000668:	f81009b7          	lui	s3,0xf8100
f900066c:	0209a023          	sw	zero,32(s3) # f8100020 <__stack_size+0xf80ff020>
f9000670:	f8100a37          	lui	s4,0xf8100
f9000674:	040a2623          	sw	zero,76(s4) # f810004c <__stack_size+0xf80ff04c>
f9000678:	00100a93          	li	s5,1
f900067c:	0157a423          	sw	s5,8(a5)

    write_u32(0, SERDES_APB_SLAVE + 8); // assert soft reset
    write_u32(0, APB_SLAVE + REG_VIDEO_RSTN);
    write_u32(0, APB_SLAVE + REG_HDMI_RESET);
    write_u32(1, SERDES_APB_SLAVE + 8); // deassert soft reset
    bsp_uDelay(1000*1000);  // WARNING: a long delay is need here
f9000680:	f8b00637          	lui	a2,0xf8b00
f9000684:	05f5e5b7          	lui	a1,0x5f5e
f9000688:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f900068c:	000f4537          	lui	a0,0xf4
f9000690:	24050513          	addi	a0,a0,576 # f4240 <__stack_size+0xf3240>
f9000694:	b25ff0ef          	jal	f90001b8 <clint_uDelay>

    bsp_printf("network initialization started\r\n");
f9000698:	f9004537          	lui	a0,0xf9004
f900069c:	30450513          	addi	a0,a0,772 # f9004304 <_data+0x74>
f90006a0:	d7dff0ef          	jal	f900041c <bsp_printf>
f90006a4:	f81007b7          	lui	a5,0xf8100
f90006a8:	0527a823          	sw	s2,80(a5) # f8100050 <__stack_size+0xf80ff050>
f90006ac:	f81007b7          	lui	a5,0xf8100
f90006b0:	0497aa23          	sw	s1,84(a5) # f8100054 <__stack_size+0xf80ff054>
f90006b4:	f81007b7          	lui	a5,0xf8100
f90006b8:	0497ac23          	sw	s1,88(a5) # f8100058 <__stack_size+0xf80ff058>
f90006bc:	f81007b7          	lui	a5,0xf8100
f90006c0:	4d200713          	li	a4,1234
f90006c4:	04e7ae23          	sw	a4,92(a5) # f810005c <__stack_size+0xf80ff05c>
f90006c8:	f81007b7          	lui	a5,0xf8100
f90006cc:	4d300713          	li	a4,1235
f90006d0:	06e7a023          	sw	a4,96(a5) # f8100060 <__stack_size+0xf80ff060>
f90006d4:	f81007b7          	lui	a5,0xf8100
f90006d8:	46000713          	li	a4,1120
f90006dc:	06e7aa23          	sw	a4,116(a5) # f8100074 <__stack_size+0xf80ff074>
    write_u32(gateway.ip, APB_SLAVE + REG_GATEWAY_IP);
    write_u32(dest_ip.ip, APB_SLAVE + REG_DEST_IP);
    write_u32(1234, APB_SLAVE + REG_SOURCE_PORT);
    write_u32(1235, APB_SLAVE + REG_DEST_PORT);
    write_u32(floor((9000 - 20 - 8 - 8 - 4)/8), APB_SLAVE + REG_MSS);
    update_video_timing(timing_1080p30);
f90006e0:	f90047b7          	lui	a5,0xf9004
f90006e4:	79c78793          	addi	a5,a5,1948 # f900479c <timing_1080p30>
f90006e8:	0007ae03          	lw	t3,0(a5)
f90006ec:	0047a303          	lw	t1,4(a5)
f90006f0:	0087a883          	lw	a7,8(a5)
f90006f4:	00c7a803          	lw	a6,12(a5)
f90006f8:	0107a503          	lw	a0,16(a5)
f90006fc:	0147a583          	lw	a1,20(a5)
f9000700:	0187a603          	lw	a2,24(a5)
f9000704:	01c7a683          	lw	a3,28(a5)
f9000708:	0207a703          	lw	a4,32(a5)
f900070c:	0247a783          	lw	a5,36(a5)
f9000710:	01c12023          	sw	t3,0(sp)
f9000714:	00612223          	sw	t1,4(sp)
f9000718:	01112423          	sw	a7,8(sp)
f900071c:	01012623          	sw	a6,12(sp)
f9000720:	00a12823          	sw	a0,16(sp)
f9000724:	00b12a23          	sw	a1,20(sp)
f9000728:	00c12c23          	sw	a2,24(sp)
f900072c:	00d12e23          	sw	a3,28(sp)
f9000730:	02e12023          	sw	a4,32(sp)
f9000734:	02f12223          	sw	a5,36(sp)
f9000738:	00010513          	mv	a0,sp
f900073c:	e31ff0ef          	jal	f900056c <update_video_timing>
f9000740:	055a2623          	sw	s5,76(s4)
f9000744:	0359a023          	sw	s5,32(s3)
    write_u32(1, APB_SLAVE + REG_HDMI_RESET);
    write_u32(1, APB_SLAVE + REG_VIDEO_RSTN);

    for (int i=0 ; i<25 ; ++i) {
f9000748:	00000413          	li	s0,0
f900074c:	03c0006f          	j	f9000788 <reg_init+0x1a0>
        u32 val = read_u32(APB_SLAVE + i*4);
f9000750:	00241793          	slli	a5,s0,0x2
f9000754:	f8100737          	lui	a4,0xf8100
f9000758:	00e787b3          	add	a5,a5,a4
        return *((volatile u32*) address);
f900075c:	0007a483          	lw	s1,0(a5)
        bsp_printf("reg %d readback: ", i);
f9000760:	00040593          	mv	a1,s0
f9000764:	f9004537          	lui	a0,0xf9004
f9000768:	32850513          	addi	a0,a0,808 # f9004328 <_data+0x98>
f900076c:	cb1ff0ef          	jal	f900041c <bsp_printf>
        bsp_printf_x(val);
f9000770:	00048513          	mv	a0,s1
f9000774:	c29ff0ef          	jal	f900039c <bsp_printf_x>
        bsp_printf("\r\n");
f9000778:	f9004537          	lui	a0,0xf9004
f900077c:	33c50513          	addi	a0,a0,828 # f900433c <_data+0xac>
f9000780:	c9dff0ef          	jal	f900041c <bsp_printf>
    for (int i=0 ; i<25 ; ++i) {
f9000784:	00140413          	addi	s0,s0,1
f9000788:	01800793          	li	a5,24
f900078c:	fc87d2e3          	bge	a5,s0,f9000750 <reg_init+0x168>
    }

    bsp_printf("initialized!\r\n");
f9000790:	f9004537          	lui	a0,0xf9004
f9000794:	34050513          	addi	a0,a0,832 # f9004340 <_data+0xb0>
f9000798:	c85ff0ef          	jal	f900041c <bsp_printf>
    bsp_uDelay(50*1000);
f900079c:	f8b00637          	lui	a2,0xf8b00
f90007a0:	05f5e5b7          	lui	a1,0x5f5e
f90007a4:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f90007a8:	0000c537          	lui	a0,0xc
f90007ac:	35050513          	addi	a0,a0,848 # c350 <__stack_size+0xb350>
f90007b0:	a09ff0ef          	jal	f90001b8 <clint_uDelay>
f90007b4:	04c12083          	lw	ra,76(sp)
f90007b8:	04812403          	lw	s0,72(sp)
f90007bc:	04412483          	lw	s1,68(sp)
f90007c0:	04012903          	lw	s2,64(sp)
f90007c4:	03c12983          	lw	s3,60(sp)
f90007c8:	03812a03          	lw	s4,56(sp)
f90007cc:	03412a83          	lw	s5,52(sp)
f90007d0:	05010113          	addi	sp,sp,80
f90007d4:	00008067          	ret

f90007d8 <uart_writeAvailability>:
f90007d8:	00452503          	lw	a0,4(a0)
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f90007dc:	01055513          	srli	a0,a0,0x10
    }
f90007e0:	0ff57513          	zext.b	a0,a0
f90007e4:	00008067          	ret

f90007e8 <uart_write>:
    static void uart_write(u32 reg, char data){
f90007e8:	ff010113          	addi	sp,sp,-16
f90007ec:	00112623          	sw	ra,12(sp)
f90007f0:	00812423          	sw	s0,8(sp)
f90007f4:	00912223          	sw	s1,4(sp)
f90007f8:	00050413          	mv	s0,a0
f90007fc:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9000800:	00040513          	mv	a0,s0
f9000804:	fd5ff0ef          	jal	f90007d8 <uart_writeAvailability>
f9000808:	fe050ce3          	beqz	a0,f9000800 <uart_write+0x18>
        *((volatile u32*) address) = data;
f900080c:	00942023          	sw	s1,0(s0)
    }
f9000810:	00c12083          	lw	ra,12(sp)
f9000814:	00812403          	lw	s0,8(sp)
f9000818:	00412483          	lw	s1,4(sp)
f900081c:	01010113          	addi	sp,sp,16
f9000820:	00008067          	ret

f9000824 <uart_writeStr>:
*
* @note    The function iterates through each character of the string and writes
*          them one by one to the UART buffer using the uart_write function.
*
******************************************************************************/
    static void uart_writeStr(u32 reg, const char* str){
f9000824:	ff010113          	addi	sp,sp,-16
f9000828:	00112623          	sw	ra,12(sp)
f900082c:	00812423          	sw	s0,8(sp)
f9000830:	00912223          	sw	s1,4(sp)
f9000834:	00050493          	mv	s1,a0
f9000838:	00058413          	mv	s0,a1
        while(*str) uart_write(reg, *str++);
f900083c:	0100006f          	j	f900084c <uart_writeStr+0x28>
f9000840:	00140413          	addi	s0,s0,1
f9000844:	00048513          	mv	a0,s1
f9000848:	fa1ff0ef          	jal	f90007e8 <uart_write>
f900084c:	00044583          	lbu	a1,0(s0)
f9000850:	fe0598e3          	bnez	a1,f9000840 <uart_writeStr+0x1c>
    }
f9000854:	00c12083          	lw	ra,12(sp)
f9000858:	00812403          	lw	s0,8(sp)
f900085c:	00412483          	lw	s1,4(sp)
f9000860:	01010113          	addi	sp,sp,16
f9000864:	00008067          	ret

f9000868 <assert>:
    return read_u32(addr);
}


void assert(int cond){
    if(!cond) {
f9000868:	00050463          	beqz	a0,f9000870 <assert+0x8>
f900086c:	00008067          	ret
void assert(int cond){
f9000870:	ff010113          	addi	sp,sp,-16
f9000874:	00112623          	sw	ra,12(sp)
        uart_writeStr(BSP_UART_TERMINAL, "Assert failure\n");
f9000878:	f90045b7          	lui	a1,0xf9004
f900087c:	3c858593          	addi	a1,a1,968 # f90043c8 <_data+0x138>
f9000880:	f8010537          	lui	a0,0xf8010
f9000884:	fa1ff0ef          	jal	f9000824 <uart_writeStr>
        while(1);
f9000888:	0000006f          	j	f9000888 <assert+0x20>

f900088c <clamp>:
    u32 cnt = read_u32(ISP_APB + 4);
    // *4 because 1 cycle = 4 pixels
    return sum/cnt;
}

static float clamp(float val, float min, float max) {
f900088c:	ff010113          	addi	sp,sp,-16
f9000890:	00112623          	sw	ra,12(sp)
f9000894:	00812423          	sw	s0,8(sp)
f9000898:	00912223          	sw	s1,4(sp)
f900089c:	01212023          	sw	s2,0(sp)
f90008a0:	00050493          	mv	s1,a0
f90008a4:	00058413          	mv	s0,a1
f90008a8:	00060913          	mv	s2,a2
    return val < min ? min : val > max ? max : val;
f90008ac:	615020ef          	jal	f90036c0 <__lesf2>
f90008b0:	00054c63          	bltz	a0,f90008c8 <clamp+0x3c>
f90008b4:	00090593          	mv	a1,s2
f90008b8:	00048513          	mv	a0,s1
f90008bc:	53d020ef          	jal	f90035f8 <__gesf2>
f90008c0:	02a05263          	blez	a0,f90008e4 <clamp+0x58>
f90008c4:	00090413          	mv	s0,s2
}
f90008c8:	00040513          	mv	a0,s0
f90008cc:	00c12083          	lw	ra,12(sp)
f90008d0:	00812403          	lw	s0,8(sp)
f90008d4:	00412483          	lw	s1,4(sp)
f90008d8:	00012903          	lw	s2,0(sp)
f90008dc:	01010113          	addi	sp,sp,16
f90008e0:	00008067          	ret
    return val < min ? min : val > max ? max : val;
f90008e4:	00048413          	mv	s0,s1
f90008e8:	fe1ff06f          	j	f90008c8 <clamp+0x3c>

f90008ec <update_incremental>:

static u32 update_incremental(PidIncremental *pid, u32 point) {
f90008ec:	fe010113          	addi	sp,sp,-32
f90008f0:	00112e23          	sw	ra,28(sp)
f90008f4:	00812c23          	sw	s0,24(sp)
f90008f8:	00912a23          	sw	s1,20(sp)
f90008fc:	01212823          	sw	s2,16(sp)
f9000900:	01312623          	sw	s3,12(sp)
f9000904:	01412423          	sw	s4,8(sp)
f9000908:	00050413          	mv	s0,a0
    pid->err = pid->set_point - point;
f900090c:	00c52483          	lw	s1,12(a0) # f801000c <__stack_size+0xf800f00c>
f9000910:	00058513          	mv	a0,a1
f9000914:	7dc030ef          	jal	f90040f0 <__floatunsisf>
f9000918:	00050593          	mv	a1,a0
f900091c:	00048513          	mv	a0,s1
f9000920:	250030ef          	jal	f9003b70 <__subsf3>
f9000924:	00050493          	mv	s1,a0
f9000928:	00a42823          	sw	a0,16(s0)

    float increment_val = 
        pid->kp*(pid->err - pid->err_next) + 
f900092c:	01c42983          	lw	s3,28(s0)
f9000930:	01442903          	lw	s2,20(s0)
f9000934:	00090593          	mv	a1,s2
f9000938:	238030ef          	jal	f9003b70 <__subsf3>
f900093c:	00050593          	mv	a1,a0
f9000940:	00098513          	mv	a0,s3
f9000944:	64d020ef          	jal	f9003790 <__mulsf3>
f9000948:	00050993          	mv	s3,a0
        pid->ki*pid->err + 
f900094c:	02042583          	lw	a1,32(s0)
f9000950:	00048513          	mv	a0,s1
f9000954:	63d020ef          	jal	f9003790 <__mulsf3>
f9000958:	00050593          	mv	a1,a0
        pid->kp*(pid->err - pid->err_next) + 
f900095c:	00098513          	mv	a0,s3
f9000960:	7c0020ef          	jal	f9003120 <__addsf3>
f9000964:	00050993          	mv	s3,a0
        pid->kd*(pid->err - 2 * pid->err_next + pid->err_last);
f9000968:	02442a03          	lw	s4,36(s0)
f900096c:	00090593          	mv	a1,s2
f9000970:	00090513          	mv	a0,s2
f9000974:	7ac020ef          	jal	f9003120 <__addsf3>
f9000978:	00050593          	mv	a1,a0
f900097c:	00048513          	mv	a0,s1
f9000980:	1f0030ef          	jal	f9003b70 <__subsf3>
f9000984:	01842583          	lw	a1,24(s0)
f9000988:	798020ef          	jal	f9003120 <__addsf3>
f900098c:	00050593          	mv	a1,a0
f9000990:	000a0513          	mv	a0,s4
f9000994:	5fd020ef          	jal	f9003790 <__mulsf3>
f9000998:	00050593          	mv	a1,a0
    float increment_val = 
f900099c:	00098513          	mv	a0,s3
f90009a0:	780020ef          	jal	f9003120 <__addsf3>

    increment_val = clamp(increment_val, -1*pid->incr_limit, pid->incr_limit);
f90009a4:	00042603          	lw	a2,0(s0)
f90009a8:	800009b7          	lui	s3,0x80000
f90009ac:	00c9c5b3          	xor	a1,s3,a2
f90009b0:	eddff0ef          	jal	f900088c <clamp>
f90009b4:	00050593          	mv	a1,a0
    pid->actual_val += increment_val;
f90009b8:	00842503          	lw	a0,8(s0)
f90009bc:	764020ef          	jal	f9003120 <__addsf3>
f90009c0:	00a42423          	sw	a0,8(s0)
    pid->actual_val = clamp(pid->actual_val, -1*pid->output_limit, pid->output_limit);
f90009c4:	00442603          	lw	a2,4(s0)
f90009c8:	00c9c5b3          	xor	a1,s3,a2
f90009cc:	ec1ff0ef          	jal	f900088c <clamp>
f90009d0:	00a42423          	sw	a0,8(s0)
    
    pid->err_last = pid->err_next;
f90009d4:	01242c23          	sw	s2,24(s0)
    pid->err_next = pid->err;
f90009d8:	00942a23          	sw	s1,20(s0)
    return pid->actual_val;
f90009dc:	6b4030ef          	jal	f9004090 <__fixunssfsi>
}
f90009e0:	01c12083          	lw	ra,28(sp)
f90009e4:	01812403          	lw	s0,24(sp)
f90009e8:	01412483          	lw	s1,20(sp)
f90009ec:	01012903          	lw	s2,16(sp)
f90009f0:	00c12983          	lw	s3,12(sp)
f90009f4:	00812a03          	lw	s4,8(sp)
f90009f8:	02010113          	addi	sp,sp,32
f90009fc:	00008067          	ret

f9000a00 <isp_set_color_balance>:
f9000a00:	f81007b7          	lui	a5,0xf8100
f9000a04:	00a7a423          	sw	a0,8(a5) # f8100008 <__stack_size+0xf80ff008>
f9000a08:	f81007b7          	lui	a5,0xf8100
f9000a0c:	00b7a623          	sw	a1,12(a5) # f810000c <__stack_size+0xf80ff00c>
f9000a10:	f81007b7          	lui	a5,0xf8100
f9000a14:	00c7a823          	sw	a2,16(a5) # f8100010 <__stack_size+0xf80ff010>
}
f9000a18:	00008067          	ret

f9000a1c <isp_get_expose_avg>:
        return *((volatile u32*) address);
f9000a1c:	f81007b7          	lui	a5,0xf8100
f9000a20:	0007a503          	lw	a0,0(a5) # f8100000 <__stack_size+0xf80ff000>
f9000a24:	00478793          	addi	a5,a5,4
f9000a28:	0007a783          	lw	a5,0(a5)
}
f9000a2c:	02f55533          	divu	a0,a0,a5
f9000a30:	00008067          	ret

f9000a34 <isp_update_gain>:
        output[i] = output[i-1] + (alpha*(input[i] - output[i-1])); 
    }
    return output[points-1];
}     

u32 isp_update_gain(u32 current_gain) {
f9000a34:	ff010113          	addi	sp,sp,-16
f9000a38:	00112623          	sw	ra,12(sp)
    // incremental pid
    static float input[10];
    static float output[10];
    u32 avg = isp_get_expose_avg();
f9000a3c:	fe1ff0ef          	jal	f9000a1c <isp_get_expose_avg>
f9000a40:	00050593          	mv	a1,a0
    // memcpy(input, input+1, sizeof(float)*9);
    // input[9] = avg;
    // s32 avg_filter = lowPassFrequency(input, output, 10);

    return update_incremental(&exp_pid, avg);
f9000a44:	86818513          	addi	a0,gp,-1944 # f9004e30 <exp_pid>
f9000a48:	ea5ff0ef          	jal	f90008ec <update_incremental>
}
f9000a4c:	00c12083          	lw	ra,12(sp)
f9000a50:	01010113          	addi	sp,sp,16
f9000a54:	00008067          	ret

f9000a58 <isp_set_setpoint>:
//         }
//         bsp_printf("\r\n");
//     }
// }

void isp_set_setpoint(u32 exp_setpoint) {
f9000a58:	ff010113          	addi	sp,sp,-16
f9000a5c:	00112623          	sw	ra,12(sp)
f9000a60:	00812423          	sw	s0,8(sp)
    exp_pid.set_point = exp_setpoint;
f9000a64:	68c030ef          	jal	f90040f0 <__floatunsisf>
f9000a68:	86818413          	addi	s0,gp,-1944 # f9004e30 <exp_pid>
f9000a6c:	00a42623          	sw	a0,12(s0)
}
f9000a70:	00c12083          	lw	ra,12(sp)
f9000a74:	00812403          	lw	s0,8(sp)
f9000a78:	01010113          	addi	sp,sp,16
f9000a7c:	00008067          	ret

f9000a80 <isp_init>:

void isp_init(u32 exp_setpoint) {
f9000a80:	ff010113          	addi	sp,sp,-16
f9000a84:	00112623          	sw	ra,12(sp)
f9000a88:	00812423          	sw	s0,8(sp)
f9000a8c:	00912223          	sw	s1,4(sp)
    exp_pid.actual_val=0.0;
f9000a90:	86818413          	addi	s0,gp,-1944 # f9004e30 <exp_pid>
f9000a94:	00000493          	li	s1,0
f9000a98:	00942423          	sw	s1,8(s0)
    exp_pid.set_point=exp_setpoint;
f9000a9c:	654030ef          	jal	f90040f0 <__floatunsisf>
f9000aa0:	00a42623          	sw	a0,12(s0)
    exp_pid.incr_limit = 1000.0;
f9000aa4:	8281a783          	lw	a5,-2008(gp) # f9004df0 <fun_num.0+0x18>
f9000aa8:	00f42023          	sw	a5,0(s0)
    exp_pid.output_limit = 4000.0;
f9000aac:	82c1a783          	lw	a5,-2004(gp) # f9004df4 <fun_num.0+0x1c>
f9000ab0:	00f42223          	sw	a5,4(s0)
    exp_pid.err_last = 0.0;
f9000ab4:	00942c23          	sw	s1,24(s0)
    // exp_pid.acc_err = 0.0;
    exp_pid.kp = 1.50;
f9000ab8:	8301a783          	lw	a5,-2000(gp) # f9004df8 <fun_num.0+0x20>
f9000abc:	00f42e23          	sw	a5,28(s0)
    exp_pid.ki = 1.00;
f9000ac0:	8341a783          	lw	a5,-1996(gp) # f9004dfc <fun_num.0+0x24>
f9000ac4:	02f42023          	sw	a5,32(s0)
    exp_pid.kd = 0.00;
f9000ac8:	02942223          	sw	s1,36(s0)
}
f9000acc:	00c12083          	lw	ra,12(sp)
f9000ad0:	00812403          	lw	s0,8(sp)
f9000ad4:	00412483          	lw	s1,4(sp)
f9000ad8:	01010113          	addi	sp,sp,16
f9000adc:	00008067          	ret

f9000ae0 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
f9000ae0:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f9000ae4:	01055513          	srli	a0,a0,0x10
    }
f9000ae8:	0ff57513          	zext.b	a0,a0
f9000aec:	00008067          	ret

f9000af0 <uart_readOccupancy>:
f9000af0:	00452503          	lw	a0,4(a0)
*          of occupied spaces for reading data from bits 31 to 24.
*
******************************************************************************/
    static u32 uart_readOccupancy(u32 reg){
        return read_u32(reg + UART_STATUS) >> 24;
    }
f9000af4:	01855513          	srli	a0,a0,0x18
f9000af8:	00008067          	ret

f9000afc <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
f9000afc:	ff010113          	addi	sp,sp,-16
f9000b00:	00112623          	sw	ra,12(sp)
f9000b04:	00812423          	sw	s0,8(sp)
f9000b08:	00912223          	sw	s1,4(sp)
f9000b0c:	00050413          	mv	s0,a0
f9000b10:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9000b14:	00040513          	mv	a0,s0
f9000b18:	fc9ff0ef          	jal	f9000ae0 <uart_writeAvailability>
f9000b1c:	fe050ce3          	beqz	a0,f9000b14 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f9000b20:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
f9000b24:	00c12083          	lw	ra,12(sp)
f9000b28:	00812403          	lw	s0,8(sp)
f9000b2c:	00412483          	lw	s1,4(sp)
f9000b30:	01010113          	addi	sp,sp,16
f9000b34:	00008067          	ret

f9000b38 <uart_read>:
* @note    The function waits until there is data available in the UART buffer
*          for reading. Once data is available, it reads the character data from
*          the UART data register and returns it.
*
******************************************************************************/
    static char uart_read(u32 reg){
f9000b38:	ff010113          	addi	sp,sp,-16
f9000b3c:	00112623          	sw	ra,12(sp)
f9000b40:	00812423          	sw	s0,8(sp)
f9000b44:	00050413          	mv	s0,a0
        while(uart_readOccupancy(reg) == 0);
f9000b48:	00040513          	mv	a0,s0
f9000b4c:	fa5ff0ef          	jal	f9000af0 <uart_readOccupancy>
f9000b50:	fe050ce3          	beqz	a0,f9000b48 <uart_read+0x10>
        return *((volatile u32*) address);
f9000b54:	00042503          	lw	a0,0(s0)
        return read_u32(reg + UART_DATA);
    }
f9000b58:	0ff57513          	zext.b	a0,a0
f9000b5c:	00c12083          	lw	ra,12(sp)
f9000b60:	00812403          	lw	s0,8(sp)
f9000b64:	01010113          	addi	sp,sp,16
f9000b68:	00008067          	ret

f9000b6c <uart_applyConfig>:
*          value using data length, parity, and stop bit settings from the configuration
*          structure, and writes this value to the UART frame configuration register.
*
******************************************************************************/
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
f9000b6c:	00c5a783          	lw	a5,12(a1)
        *((volatile u32*) address) = data;
f9000b70:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
f9000b74:	0005a783          	lw	a5,0(a1)
f9000b78:	fff78793          	addi	a5,a5,-1
f9000b7c:	0045a703          	lw	a4,4(a1)
f9000b80:	00871713          	slli	a4,a4,0x8
f9000b84:	00e7e7b3          	or	a5,a5,a4
f9000b88:	0085a703          	lw	a4,8(a1)
f9000b8c:	01071713          	slli	a4,a4,0x10
f9000b90:	00e7e7b3          	or	a5,a5,a4
f9000b94:	00f52623          	sw	a5,12(a0)
    }
f9000b98:	00008067          	ret

f9000b9c <clint_uDelay>:
*          and the time limit is non-negative, indicating that the delay has
*          not yet elapsed.
*
******************************************************************************/
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
f9000b9c:	000f47b7          	lui	a5,0xf4
f9000ba0:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf3240>
f9000ba4:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
f9000ba8:	0000c7b7          	lui	a5,0xc
f9000bac:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0xaff8>
f9000bb0:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
f9000bb4:	00062783          	lw	a5,0(a2) # f8b00000 <__stack_size+0xf8aff000>
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
f9000bb8:	02a585b3          	mul	a1,a1,a0
f9000bbc:	00f58733          	add	a4,a1,a5
f9000bc0:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
f9000bc4:	40f707b3          	sub	a5,a4,a5
f9000bc8:	fe07dce3          	bgez	a5,f9000bc0 <clint_uDelay+0x24>
f9000bcc:	00008067          	ret

f9000bd0 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
f9000bd0:	ff010113          	addi	sp,sp,-16
f9000bd4:	00112623          	sw	ra,12(sp)
f9000bd8:	00050593          	mv	a1,a0
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
f9000bdc:	f8010537          	lui	a0,0xf8010
f9000be0:	f1dff0ef          	jal	f9000afc <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f9000be4:	00c12083          	lw	ra,12(sp)
f9000be8:	01010113          	addi	sp,sp,16
f9000bec:	00008067          	ret

f9000bf0 <_putchar_s>:

    static void _putchar_s(char *p)
    {
f9000bf0:	ff010113          	addi	sp,sp,-16
f9000bf4:	00112623          	sw	ra,12(sp)
f9000bf8:	00812423          	sw	s0,8(sp)
f9000bfc:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
f9000c00:	00c0006f          	j	f9000c0c <_putchar_s+0x1c>
            _putchar(*(p++));
f9000c04:	00140413          	addi	s0,s0,1
f9000c08:	fc9ff0ef          	jal	f9000bd0 <_putchar>
        while (*p)
f9000c0c:	00044503          	lbu	a0,0(s0)
f9000c10:	fe051ae3          	bnez	a0,f9000c04 <_putchar_s+0x14>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f9000c14:	00c12083          	lw	ra,12(sp)
f9000c18:	00812403          	lw	s0,8(sp)
f9000c1c:	01010113          	addi	sp,sp,16
f9000c20:	00008067          	ret

f9000c24 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
f9000c24:	ff010113          	addi	sp,sp,-16
f9000c28:	00112623          	sw	ra,12(sp)
f9000c2c:	00812423          	sw	s0,8(sp)
f9000c30:	00912223          	sw	s1,4(sp)
f9000c34:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000c38:	01c00413          	li	s0,28
f9000c3c:	0240006f          	j	f9000c60 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
f9000c40:	0084d733          	srl	a4,s1,s0
f9000c44:	00f77713          	andi	a4,a4,15
f9000c48:	f90047b7          	lui	a5,0xf9004
f9000c4c:	29078793          	addi	a5,a5,656 # f9004290 <_data>
f9000c50:	00e787b3          	add	a5,a5,a4
f9000c54:	0007c503          	lbu	a0,0(a5)
f9000c58:	f79ff0ef          	jal	f9000bd0 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000c5c:	ffc40413          	addi	s0,s0,-4
f9000c60:	fe0450e3          	bgez	s0,f9000c40 <bsp_printHex+0x1c>
        }
    }
f9000c64:	00c12083          	lw	ra,12(sp)
f9000c68:	00812403          	lw	s0,8(sp)
f9000c6c:	00412483          	lw	s1,4(sp)
f9000c70:	01010113          	addi	sp,sp,16
f9000c74:	00008067          	ret

f9000c78 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
f9000c78:	ff010113          	addi	sp,sp,-16
f9000c7c:	00112623          	sw	ra,12(sp)
f9000c80:	00812423          	sw	s0,8(sp)
f9000c84:	00912223          	sw	s1,4(sp)
f9000c88:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000c8c:	01c00413          	li	s0,28
f9000c90:	0240006f          	j	f9000cb4 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
f9000c94:	0084d733          	srl	a4,s1,s0
f9000c98:	00f77713          	andi	a4,a4,15
f9000c9c:	f90047b7          	lui	a5,0xf9004
f9000ca0:	2a478793          	addi	a5,a5,676 # f90042a4 <_data+0x14>
f9000ca4:	00e787b3          	add	a5,a5,a4
f9000ca8:	0007c503          	lbu	a0,0(a5)
f9000cac:	f25ff0ef          	jal	f9000bd0 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000cb0:	ffc40413          	addi	s0,s0,-4
f9000cb4:	fe0450e3          	bgez	s0,f9000c94 <bsp_printHex_lower+0x1c>

        }
    }
f9000cb8:	00c12083          	lw	ra,12(sp)
f9000cbc:	00812403          	lw	s0,8(sp)
f9000cc0:	00412483          	lw	s1,4(sp)
f9000cc4:	01010113          	addi	sp,sp,16
f9000cc8:	00008067          	ret

f9000ccc <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
f9000ccc:	ff010113          	addi	sp,sp,-16
f9000cd0:	00112623          	sw	ra,12(sp)
        _putchar(c);
f9000cd4:	0ff57513          	zext.b	a0,a0
f9000cd8:	ef9ff0ef          	jal	f9000bd0 <_putchar>
    }
f9000cdc:	00c12083          	lw	ra,12(sp)
f9000ce0:	01010113          	addi	sp,sp,16
f9000ce4:	00008067          	ret

f9000ce8 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
f9000ce8:	ff010113          	addi	sp,sp,-16
f9000cec:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
f9000cf0:	f01ff0ef          	jal	f9000bf0 <_putchar_s>
    }
f9000cf4:	00c12083          	lw	ra,12(sp)
f9000cf8:	01010113          	addi	sp,sp,16
f9000cfc:	00008067          	ret

f9000d00 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
f9000d00:	fd010113          	addi	sp,sp,-48
f9000d04:	02112623          	sw	ra,44(sp)
f9000d08:	02812423          	sw	s0,40(sp)
f9000d0c:	02912223          	sw	s1,36(sp)
f9000d10:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
f9000d14:	00054663          	bltz	a0,f9000d20 <bsp_printf_d+0x20>
    {
f9000d18:	00010413          	mv	s0,sp
f9000d1c:	02c0006f          	j	f9000d48 <bsp_printf_d+0x48>
            bsp_printf_c('-');
f9000d20:	02d00513          	li	a0,45
f9000d24:	fa9ff0ef          	jal	f9000ccc <bsp_printf_c>
            val = -val;
f9000d28:	409004b3          	neg	s1,s1
f9000d2c:	fedff06f          	j	f9000d18 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
f9000d30:	00a00713          	li	a4,10
f9000d34:	02e4e7b3          	rem	a5,s1,a4
f9000d38:	03078793          	addi	a5,a5,48
f9000d3c:	00f40023          	sb	a5,0(s0)
            val = val / 10;
f9000d40:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
f9000d44:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
f9000d48:	fe0494e3          	bnez	s1,f9000d30 <bsp_printf_d+0x30>
f9000d4c:	00010793          	mv	a5,sp
f9000d50:	fef400e3          	beq	s0,a5,f9000d30 <bsp_printf_d+0x30>
        }
        while (p != buffer)
f9000d54:	00010793          	mv	a5,sp
f9000d58:	00f40a63          	beq	s0,a5,f9000d6c <bsp_printf_d+0x6c>
            bsp_printf_c(*(--p));
f9000d5c:	fff40413          	addi	s0,s0,-1
f9000d60:	00044503          	lbu	a0,0(s0)
f9000d64:	f69ff0ef          	jal	f9000ccc <bsp_printf_c>
f9000d68:	fedff06f          	j	f9000d54 <bsp_printf_d+0x54>
    }
f9000d6c:	02c12083          	lw	ra,44(sp)
f9000d70:	02812403          	lw	s0,40(sp)
f9000d74:	02412483          	lw	s1,36(sp)
f9000d78:	03010113          	addi	sp,sp,48
f9000d7c:	00008067          	ret

f9000d80 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
f9000d80:	ff010113          	addi	sp,sp,-16
f9000d84:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
f9000d88:	00000713          	li	a4,0
f9000d8c:	00700793          	li	a5,7
f9000d90:	02e7c063          	blt	a5,a4,f9000db0 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f9000d94:	00271693          	slli	a3,a4,0x2
f9000d98:	ff000793          	li	a5,-16
f9000d9c:	00d797b3          	sll	a5,a5,a3
f9000da0:	00f577b3          	and	a5,a0,a5
f9000da4:	00078663          	beqz	a5,f9000db0 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
f9000da8:	00170713          	addi	a4,a4,1 # f8100001 <__stack_size+0xf80ff001>
f9000dac:	fe1ff06f          	j	f9000d8c <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
f9000db0:	ec9ff0ef          	jal	f9000c78 <bsp_printHex_lower>
    }
f9000db4:	00c12083          	lw	ra,12(sp)
f9000db8:	01010113          	addi	sp,sp,16
f9000dbc:	00008067          	ret

f9000dc0 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
f9000dc0:	ff010113          	addi	sp,sp,-16
f9000dc4:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
f9000dc8:	00000713          	li	a4,0
f9000dcc:	00700793          	li	a5,7
f9000dd0:	02e7c063          	blt	a5,a4,f9000df0 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f9000dd4:	00271693          	slli	a3,a4,0x2
f9000dd8:	ff000793          	li	a5,-16
f9000ddc:	00d797b3          	sll	a5,a5,a3
f9000de0:	00f577b3          	and	a5,a0,a5
f9000de4:	00078663          	beqz	a5,f9000df0 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
f9000de8:	00170713          	addi	a4,a4,1
f9000dec:	fe1ff06f          	j	f9000dcc <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
f9000df0:	e35ff0ef          	jal	f9000c24 <bsp_printHex>
        }
f9000df4:	00c12083          	lw	ra,12(sp)
f9000df8:	01010113          	addi	sp,sp,16
f9000dfc:	00008067          	ret

f9000e00 <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
f9000e00:	fe010113          	addi	sp,sp,-32
f9000e04:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
f9000e08:	00800793          	li	a5,8
f9000e0c:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
f9000e10:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
f9000e14:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
f9000e18:	06b00793          	li	a5,107
f9000e1c:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
f9000e20:	00010593          	mv	a1,sp
f9000e24:	f8010537          	lui	a0,0xf8010
f9000e28:	d45ff0ef          	jal	f9000b6c <uart_applyConfig>
    }
f9000e2c:	01c12083          	lw	ra,28(sp)
f9000e30:	02010113          	addi	sp,sp,32
f9000e34:	00008067          	ret

f9000e38 <plic_set_priority>:
*          specified priority value to the calculated address, effectively
*          setting the priority for the specified interrupt gateway in the PLIC.
*
******************************************************************************/
    static void plic_set_priority(u32 plic, u32 gateway, u32 priority){
        write_u32(priority, plic + PLIC_PRIORITY_BASE + gateway*4);
f9000e38:	00259593          	slli	a1,a1,0x2
f9000e3c:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
f9000e40:	00c5a023          	sw	a2,0(a1)
    }
f9000e44:	00008067          	ret

f9000e48 <plic_set_enable>:
*          to the enable register.
*
******************************************************************************/

    static void plic_set_enable(u32 plic, u32 target,u32 gateway, u32 enable){
        u32 word = plic + PLIC_ENABLE_BASE + target * PLIC_ENABLE_PER_HART + (gateway / 32 * 4);
f9000e48:	00759593          	slli	a1,a1,0x7
f9000e4c:	00a585b3          	add	a1,a1,a0
f9000e50:	00565793          	srli	a5,a2,0x5
f9000e54:	00279793          	slli	a5,a5,0x2
f9000e58:	00f587b3          	add	a5,a1,a5
f9000e5c:	00002737          	lui	a4,0x2
f9000e60:	00e787b3          	add	a5,a5,a4
        u32 mask = 1 << (gateway % 32);
f9000e64:	00100713          	li	a4,1
f9000e68:	00c71633          	sll	a2,a4,a2
        if (enable)
f9000e6c:	00068a63          	beqz	a3,f9000e80 <plic_set_enable+0x38>
        return *((volatile u32*) address);
f9000e70:	0007a703          	lw	a4,0(a5)
            write_u32(read_u32(word) | mask, word);
f9000e74:	00e66633          	or	a2,a2,a4
        *((volatile u32*) address) = data;
f9000e78:	00c7a023          	sw	a2,0(a5)
    }
f9000e7c:	00008067          	ret
        return *((volatile u32*) address);
f9000e80:	0007a703          	lw	a4,0(a5)
        else
            write_u32(read_u32(word) & ~mask, word);
f9000e84:	fff64613          	not	a2,a2
f9000e88:	00e67633          	and	a2,a2,a4
        *((volatile u32*) address) = data;
f9000e8c:	00c7a023          	sw	a2,0(a5)
    }
f9000e90:	00008067          	ret

f9000e94 <plic_set_threshold>:
*          to the calculated address, effectively setting the threshold for the
*          specified target in the PLIC.
*
******************************************************************************/   
    static void plic_set_threshold(u32 plic, u32 target, u32 threshold){
        write_u32(threshold, plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
f9000e94:	00c59593          	slli	a1,a1,0xc
f9000e98:	00a585b3          	add	a1,a1,a0
f9000e9c:	002007b7          	lui	a5,0x200
f9000ea0:	00f585b3          	add	a1,a1,a5
f9000ea4:	00c5a023          	sw	a2,0(a1)
    }
f9000ea8:	00008067          	ret

f9000eac <plic_claim>:
*          value from the calculated address, effectively claiming an interrupt
*          for the specified target in the PLIC.
*
******************************************************************************/
    static u32 plic_claim(u32 plic, u32 target){
        return read_u32(plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
f9000eac:	00c59593          	slli	a1,a1,0xc
f9000eb0:	00a585b3          	add	a1,a1,a0
f9000eb4:	002007b7          	lui	a5,0x200
f9000eb8:	00478793          	addi	a5,a5,4 # 200004 <__stack_size+0x1ff004>
f9000ebc:	00f585b3          	add	a1,a1,a5
        return *((volatile u32*) address);
f9000ec0:	0005a503          	lw	a0,0(a1)
    }
f9000ec4:	00008067          	ret

f9000ec8 <plic_release>:
*          to the calculated address, effectively releasing the claimed interrupt
*          for the specified target in the PLIC.
*
******************************************************************************/
    static void plic_release(u32 plic, u32 target, u32 gateway){
        write_u32(gateway,plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
f9000ec8:	00c59593          	slli	a1,a1,0xc
f9000ecc:	00a585b3          	add	a1,a1,a0
f9000ed0:	002007b7          	lui	a5,0x200
f9000ed4:	00478793          	addi	a5,a5,4 # 200004 <__stack_size+0x1ff004>
f9000ed8:	00f585b3          	add	a1,a1,a5
        *((volatile u32*) address) = data;
f9000edc:	00c5a023          	sw	a2,0(a1)
    }
f9000ee0:	00008067          	ret

f9000ee4 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
f9000ee4:	fc010113          	addi	sp,sp,-64
f9000ee8:	00112e23          	sw	ra,28(sp)
f9000eec:	00812c23          	sw	s0,24(sp)
f9000ef0:	00912a23          	sw	s1,20(sp)
f9000ef4:	00050493          	mv	s1,a0
f9000ef8:	02b12223          	sw	a1,36(sp)
f9000efc:	02c12423          	sw	a2,40(sp)
f9000f00:	02d12623          	sw	a3,44(sp)
f9000f04:	02e12823          	sw	a4,48(sp)
f9000f08:	02f12a23          	sw	a5,52(sp)
f9000f0c:	03012c23          	sw	a6,56(sp)
f9000f10:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
f9000f14:	02410793          	addi	a5,sp,36
f9000f18:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
f9000f1c:	00000413          	li	s0,0
f9000f20:	01c0006f          	j	f9000f3c <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
f9000f24:	00c12783          	lw	a5,12(sp)
f9000f28:	00478713          	addi	a4,a5,4
f9000f2c:	00e12623          	sw	a4,12(sp)
f9000f30:	0007a503          	lw	a0,0(a5)
f9000f34:	d99ff0ef          	jal	f9000ccc <bsp_printf_c>
        for (i = 0; format[i]; i++)
f9000f38:	00140413          	addi	s0,s0,1
f9000f3c:	008487b3          	add	a5,s1,s0
f9000f40:	0007c503          	lbu	a0,0(a5)
f9000f44:	0a050e63          	beqz	a0,f9001000 <bsp_printf+0x11c>
            if (format[i] == '%') {
f9000f48:	02500793          	li	a5,37
f9000f4c:	06f50e63          	beq	a0,a5,f9000fc8 <bsp_printf+0xe4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
f9000f50:	d7dff0ef          	jal	f9000ccc <bsp_printf_c>
f9000f54:	fe5ff06f          	j	f9000f38 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
f9000f58:	00c12783          	lw	a5,12(sp)
f9000f5c:	00478713          	addi	a4,a5,4
f9000f60:	00e12623          	sw	a4,12(sp)
f9000f64:	0007a503          	lw	a0,0(a5)
f9000f68:	d81ff0ef          	jal	f9000ce8 <bsp_printf_s>
                        break;
f9000f6c:	fcdff06f          	j	f9000f38 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
f9000f70:	00c12783          	lw	a5,12(sp)
f9000f74:	00478713          	addi	a4,a5,4
f9000f78:	00e12623          	sw	a4,12(sp)
f9000f7c:	0007a503          	lw	a0,0(a5)
f9000f80:	d81ff0ef          	jal	f9000d00 <bsp_printf_d>
                        break;
f9000f84:	fb5ff06f          	j	f9000f38 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
f9000f88:	00c12783          	lw	a5,12(sp)
f9000f8c:	00478713          	addi	a4,a5,4
f9000f90:	00e12623          	sw	a4,12(sp)
f9000f94:	0007a503          	lw	a0,0(a5)
f9000f98:	e29ff0ef          	jal	f9000dc0 <bsp_printf_X>
                        break;
f9000f9c:	f9dff06f          	j	f9000f38 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
f9000fa0:	00c12783          	lw	a5,12(sp)
f9000fa4:	00478713          	addi	a4,a5,4
f9000fa8:	00e12623          	sw	a4,12(sp)
f9000fac:	0007a503          	lw	a0,0(a5)
f9000fb0:	dd1ff0ef          	jal	f9000d80 <bsp_printf_x>
                        break;
f9000fb4:	f85ff06f          	j	f9000f38 <bsp_printf+0x54>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
f9000fb8:	f9004537          	lui	a0,0xf9004
f9000fbc:	2b850513          	addi	a0,a0,696 # f90042b8 <_data+0x28>
f9000fc0:	d29ff0ef          	jal	f9000ce8 <bsp_printf_s>
                        break;
f9000fc4:	f75ff06f          	j	f9000f38 <bsp_printf+0x54>
                while (format[++i]) {
f9000fc8:	00140413          	addi	s0,s0,1
f9000fcc:	008487b3          	add	a5,s1,s0
f9000fd0:	0007c783          	lbu	a5,0(a5)
f9000fd4:	f60782e3          	beqz	a5,f9000f38 <bsp_printf+0x54>
                    if (format[i] == 'c') {
f9000fd8:	fa878793          	addi	a5,a5,-88
f9000fdc:	0ff7f693          	zext.b	a3,a5
f9000fe0:	02000713          	li	a4,32
f9000fe4:	fed762e3          	bltu	a4,a3,f9000fc8 <bsp_printf+0xe4>
f9000fe8:	00269793          	slli	a5,a3,0x2
f9000fec:	f9004737          	lui	a4,0xf9004
f9000ff0:	7c470713          	addi	a4,a4,1988 # f90047c4 <timing_1080p30+0x28>
f9000ff4:	00e787b3          	add	a5,a5,a4
f9000ff8:	0007a783          	lw	a5,0(a5)
f9000ffc:	00078067          	jr	a5

        va_end(ap);
    }
f9001000:	01c12083          	lw	ra,28(sp)
f9001004:	01812403          	lw	s0,24(sp)
f9001008:	01412483          	lw	s1,20(sp)
f900100c:	04010113          	addi	sp,sp,64
f9001010:	00008067          	ret

f9001014 <crash>:
void crash(char* causeType, u32 cause){
f9001014:	ff010113          	addi	sp,sp,-16
f9001018:	00112623          	sw	ra,12(sp)
f900101c:	00058613          	mv	a2,a1
    bsp_printf("\r\n*** CRASH due to %s: %d***\r\n", causeType, cause);
f9001020:	00050593          	mv	a1,a0
f9001024:	f9004537          	lui	a0,0xf9004
f9001028:	3d850513          	addi	a0,a0,984 # f90043d8 <_data+0x148>
f900102c:	eb9ff0ef          	jal	f9000ee4 <bsp_printf>
    while(1);
f9001030:	0000006f          	j	f9001030 <crash+0x1c>

f9001034 <poll_host_settings>:
void poll_host_settings() {
f9001034:	ff010113          	addi	sp,sp,-16
f9001038:	00112623          	sw	ra,12(sp)
f900103c:	00812423          	sw	s0,8(sp)
f9001040:	00912223          	sw	s1,4(sp)
f9001044:	01212023          	sw	s2,0(sp)
    u32 e_tmp = read_apb_reg(REG_OVERRIDE_EXPOSURE);
f9001048:	06400513          	li	a0,100
f900104c:	d00ff0ef          	jal	f900054c <read_apb_reg>
f9001050:	00050913          	mv	s2,a0
    u32 r_tmp = read_apb_reg(REG_OVERRIDE_GAIN_R);
f9001054:	06800513          	li	a0,104
f9001058:	cf4ff0ef          	jal	f900054c <read_apb_reg>
f900105c:	00050413          	mv	s0,a0
    u32 g_tmp = read_apb_reg(REG_OVERRIDE_GAIN_G);
f9001060:	06c00513          	li	a0,108
f9001064:	ce8ff0ef          	jal	f900054c <read_apb_reg>
f9001068:	00050493          	mv	s1,a0
    u32 b_tmp = read_apb_reg(REG_OVERRIDE_GAIN_B);
f900106c:	07000513          	li	a0,112
f9001070:	cdcff0ef          	jal	f900054c <read_apb_reg>
    if (e_tmp != e_raw || r_tmp != r_raw || g_tmp != g_raw || b_tmp != b_raw) {
f9001074:	8641a783          	lw	a5,-1948(gp) # f9004e2c <e_raw.8>
f9001078:	01279663          	bne	a5,s2,f9001084 <poll_host_settings+0x50>
f900107c:	8601a783          	lw	a5,-1952(gp) # f9004e28 <r_raw.7>
f9001080:	08878c63          	beq	a5,s0,f9001118 <poll_host_settings+0xe4>
        e_raw = e_tmp;
f9001084:	8721a223          	sw	s2,-1948(gp) # f9004e2c <e_raw.8>
        r_raw = r_tmp;
f9001088:	8681a023          	sw	s0,-1952(gp) # f9004e28 <r_raw.7>
        g_raw = g_tmp;
f900108c:	8491ae23          	sw	s1,-1956(gp) # f9004e24 <g_raw.6>
        b_raw = b_tmp;
f9001090:	84a1ac23          	sw	a0,-1960(gp) # f9004e20 <b_raw.5>
        s32 r = 420 + ((s32)r_raw - 128);
f9001094:	12440413          	addi	s0,s0,292
        s32 g = 256 + ((s32)g_raw - 128);
f9001098:	08048493          	addi	s1,s1,128
        s32 b = 600 + ((s32)b_raw - 128)*1.5;
f900109c:	f8050513          	addi	a0,a0,-128
f90010a0:	7c9010ef          	jal	f9003068 <__floatsidf>
f90010a4:	8181a603          	lw	a2,-2024(gp) # f9004de0 <fun_num.0+0x8>
f90010a8:	81c1a683          	lw	a3,-2020(gp) # f9004de4 <fun_num.0+0xc>
f90010ac:	061010ef          	jal	f900290c <__muldf3>
f90010b0:	8201a603          	lw	a2,-2016(gp) # f9004de8 <fun_num.0+0x10>
f90010b4:	8241a683          	lw	a3,-2012(gp) # f9004dec <fun_num.0+0x14>
f90010b8:	78d000ef          	jal	f9002044 <__adddf3>
f90010bc:	729010ef          	jal	f9002fe4 <__fixdfsi>
f90010c0:	00050613          	mv	a2,a0
        r = r > 0 ? r : 0;
f90010c4:	00040513          	mv	a0,s0
f90010c8:	06044263          	bltz	s0,f900112c <poll_host_settings+0xf8>
        g = g > 0 ? g : 0;
f90010cc:	00048593          	mv	a1,s1
f90010d0:	0604c263          	bltz	s1,f9001134 <poll_host_settings+0x100>
        b = b > 0 ? b : 0;
f90010d4:	06064463          	bltz	a2,f900113c <poll_host_settings+0x108>
        isp_set_color_balance(r, g, b);
f90010d8:	929ff0ef          	jal	f9000a00 <isp_set_color_balance>
        isp_set_setpoint(e);
f90010dc:	00090513          	mv	a0,s2
f90010e0:	979ff0ef          	jal	f9000a58 <isp_set_setpoint>
        bsp_printf("target exposure value: %d, red gain: %d, green gain: %d, blue gain: %d\r\n", e_raw, r_raw, g_raw, b_raw);
f90010e4:	8581a703          	lw	a4,-1960(gp) # f9004e20 <b_raw.5>
f90010e8:	85c1a683          	lw	a3,-1956(gp) # f9004e24 <g_raw.6>
f90010ec:	8601a603          	lw	a2,-1952(gp) # f9004e28 <r_raw.7>
f90010f0:	8641a583          	lw	a1,-1948(gp) # f9004e2c <e_raw.8>
f90010f4:	f9004537          	lui	a0,0xf9004
f90010f8:	3f850513          	addi	a0,a0,1016 # f90043f8 <_data+0x168>
f90010fc:	de9ff0ef          	jal	f9000ee4 <bsp_printf>
}
f9001100:	00c12083          	lw	ra,12(sp)
f9001104:	00812403          	lw	s0,8(sp)
f9001108:	00412483          	lw	s1,4(sp)
f900110c:	00012903          	lw	s2,0(sp)
f9001110:	01010113          	addi	sp,sp,16
f9001114:	00008067          	ret
    if (e_tmp != e_raw || r_tmp != r_raw || g_tmp != g_raw || b_tmp != b_raw) {
f9001118:	85c1a783          	lw	a5,-1956(gp) # f9004e24 <g_raw.6>
f900111c:	f69794e3          	bne	a5,s1,f9001084 <poll_host_settings+0x50>
f9001120:	8581a783          	lw	a5,-1960(gp) # f9004e20 <b_raw.5>
f9001124:	f6a790e3          	bne	a5,a0,f9001084 <poll_host_settings+0x50>
f9001128:	fd9ff06f          	j	f9001100 <poll_host_settings+0xcc>
        r = r > 0 ? r : 0;
f900112c:	00000513          	li	a0,0
f9001130:	f9dff06f          	j	f90010cc <poll_host_settings+0x98>
        g = g > 0 ? g : 0;
f9001134:	00000593          	li	a1,0
f9001138:	f9dff06f          	j	f90010d4 <poll_host_settings+0xa0>
        b = b > 0 ? b : 0;
f900113c:	00000613          	li	a2,0
f9001140:	f99ff06f          	j	f90010d8 <poll_host_settings+0xa4>

f9001144 <timer_handler>:
void timer_handler() {
f9001144:	ff010113          	addi	sp,sp,-16
f9001148:	00112623          	sw	ra,12(sp)
f900114c:	00812423          	sw	s0,8(sp)
    u32 new_gain = isp_update_gain(prev_dig_gain);
f9001150:	8541d503          	lhu	a0,-1964(gp) # f9004e1c <prev_dig_gain.4>
f9001154:	8e1ff0ef          	jal	f9000a34 <isp_update_gain>
f9001158:	00050413          	mv	s0,a0
    u32 exp_avg = isp_get_expose_avg();
f900115c:	8c1ff0ef          	jal	f9000a1c <isp_get_expose_avg>
f9001160:	00050593          	mv	a1,a0
    ++count;
f9001164:	8501a783          	lw	a5,-1968(gp) # f9004e18 <count.3>
f9001168:	00178793          	addi	a5,a5,1
f900116c:	84f1a823          	sw	a5,-1968(gp) # f9004e18 <count.3>
    if (count >= 10 || abs(prev_dig_gain - new_gain) > 10) {
f9001170:	00900713          	li	a4,9
f9001174:	02f76063          	bltu	a4,a5,f9001194 <timer_handler+0x50>
f9001178:	8541d783          	lhu	a5,-1964(gp) # f9004e1c <prev_dig_gain.4>
f900117c:	408787b3          	sub	a5,a5,s0
f9001180:	41f7d713          	srai	a4,a5,0x1f
f9001184:	00f747b3          	xor	a5,a4,a5
f9001188:	40e787b3          	sub	a5,a5,a4
f900118c:	00a00713          	li	a4,10
f9001190:	00f75e63          	bge	a4,a5,f90011ac <timer_handler+0x68>
        bsp_printf("global average: %d, gain: %d, new gain: %d\r\n", exp_avg, prev_dig_gain, new_gain);
f9001194:	00040693          	mv	a3,s0
f9001198:	8541d603          	lhu	a2,-1964(gp) # f9004e1c <prev_dig_gain.4>
f900119c:	f9004537          	lui	a0,0xf9004
f90011a0:	44450513          	addi	a0,a0,1092 # f9004444 <_data+0x1b4>
f90011a4:	d41ff0ef          	jal	f9000ee4 <bsp_printf>
        count = 0;
f90011a8:	8401a823          	sw	zero,-1968(gp) # f9004e18 <count.3>
    PiCam_Gainfilter(ana_gain, new_gain);
f90011ac:	01041413          	slli	s0,s0,0x10
f90011b0:	01045413          	srli	s0,s0,0x10
f90011b4:	00040593          	mv	a1,s0
f90011b8:	21c00513          	li	a0,540
f90011bc:	6c4000ef          	jal	f9001880 <PiCam_Gainfilter>
    prev_dig_gain = new_gain;
f90011c0:	84819a23          	sh	s0,-1964(gp) # f9004e1c <prev_dig_gain.4>
    poll_host_settings();
f90011c4:	e71ff0ef          	jal	f9001034 <poll_host_settings>
}
f90011c8:	00c12083          	lw	ra,12(sp)
f90011cc:	00812403          	lw	s0,8(sp)
f90011d0:	01010113          	addi	sp,sp,16
f90011d4:	00008067          	ret

f90011d8 <externalInterrupt>:
void externalInterrupt() {
f90011d8:	ff010113          	addi	sp,sp,-16
f90011dc:	00112623          	sw	ra,12(sp)
f90011e0:	00812423          	sw	s0,8(sp)
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
f90011e4:	00000593          	li	a1,0
f90011e8:	f8c00537          	lui	a0,0xf8c00
f90011ec:	cc1ff0ef          	jal	f9000eac <plic_claim>
f90011f0:	00050413          	mv	s0,a0
f90011f4:	02050a63          	beqz	a0,f9001228 <externalInterrupt+0x50>
        switch(claim){
f90011f8:	01300793          	li	a5,19
f90011fc:	00f41e63          	bne	s0,a5,f9001218 <externalInterrupt+0x40>
        case USER_TIMER_0: timer_handler(); break;
f9001200:	f45ff0ef          	jal	f9001144 <timer_handler>
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); 
f9001204:	00040613          	mv	a2,s0
f9001208:	00000593          	li	a1,0
f900120c:	f8c00537          	lui	a0,0xf8c00
f9001210:	cb9ff0ef          	jal	f9000ec8 <plic_release>
f9001214:	fd1ff06f          	j	f90011e4 <externalInterrupt+0xc>
        default: crash("claim", claim); break;
f9001218:	00040593          	mv	a1,s0
f900121c:	f9004537          	lui	a0,0xf9004
f9001220:	47450513          	addi	a0,a0,1140 # f9004474 <_data+0x1e4>
f9001224:	df1ff0ef          	jal	f9001014 <crash>
}
f9001228:	00c12083          	lw	ra,12(sp)
f900122c:	00812403          	lw	s0,8(sp)
f9001230:	01010113          	addi	sp,sp,16
f9001234:	00008067          	ret

f9001238 <trap>:
void trap(){
f9001238:	ff010113          	addi	sp,sp,-16
f900123c:	00112623          	sw	ra,12(sp)
    int32_t mcause = csr_read(mcause);
f9001240:	342027f3          	csrr	a5,mcause
    int32_t cause     = mcause & 0xF;
f9001244:	00f7f593          	andi	a1,a5,15
    if(interrupt){
f9001248:	0207d463          	bgez	a5,f9001270 <trap+0x38>
        switch(cause){
f900124c:	00b00793          	li	a5,11
f9001250:	00f59a63          	bne	a1,a5,f9001264 <trap+0x2c>
        case CAUSE_MACHINE_EXTERNAL: externalInterrupt(); break;
f9001254:	f85ff0ef          	jal	f90011d8 <externalInterrupt>
}
f9001258:	00c12083          	lw	ra,12(sp)
f900125c:	01010113          	addi	sp,sp,16
f9001260:	00008067          	ret
        default: crash("cause", cause); break;
f9001264:	f9004537          	lui	a0,0xf9004
f9001268:	47c50513          	addi	a0,a0,1148 # f900447c <_data+0x1ec>
f900126c:	da9ff0ef          	jal	f9001014 <crash>
        crash("cause", cause);
f9001270:	f9004537          	lui	a0,0xf9004
f9001274:	47c50513          	addi	a0,a0,1148 # f900447c <_data+0x1ec>
f9001278:	d9dff0ef          	jal	f9001014 <crash>

f900127c <interrupt_set>:
void interrupt_set(u32 gateway, u32 enable) {
f900127c:	ff010113          	addi	sp,sp,-16
f9001280:	00112623          	sw	ra,12(sp)
f9001284:	00050613          	mv	a2,a0
f9001288:	00058693          	mv	a3,a1
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, gateway, enable);
f900128c:	00000593          	li	a1,0
f9001290:	f8c00537          	lui	a0,0xf8c00
f9001294:	bb5ff0ef          	jal	f9000e48 <plic_set_enable>
}
f9001298:	00c12083          	lw	ra,12(sp)
f900129c:	01010113          	addi	sp,sp,16
f90012a0:	00008067          	ret

f90012a4 <interrupt_init>:
void interrupt_init() {
f90012a4:	ff010113          	addi	sp,sp,-16
f90012a8:	00112623          	sw	ra,12(sp)
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); //cpu 0 accept all interrupts with priority above 0
f90012ac:	00000613          	li	a2,0
f90012b0:	00000593          	li	a1,0
f90012b4:	f8c00537          	lui	a0,0xf8c00
f90012b8:	bddff0ef          	jal	f9000e94 <plic_set_threshold>
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, USER_TIMER_0, 1);
f90012bc:	00100693          	li	a3,1
f90012c0:	01300613          	li	a2,19
f90012c4:	00000593          	li	a1,0
f90012c8:	f8c00537          	lui	a0,0xf8c00
f90012cc:	b7dff0ef          	jal	f9000e48 <plic_set_enable>
    plic_set_priority(BSP_PLIC, USER_TIMER_0, 2);
f90012d0:	00200613          	li	a2,2
f90012d4:	01300593          	li	a1,19
f90012d8:	f8c00537          	lui	a0,0xf8c00
f90012dc:	b5dff0ef          	jal	f9000e38 <plic_set_priority>
    bsp_printf("plic initialized\r\n");
f90012e0:	f9004537          	lui	a0,0xf9004
f90012e4:	48450513          	addi	a0,a0,1156 # f9004484 <_data+0x1f4>
f90012e8:	bfdff0ef          	jal	f9000ee4 <bsp_printf>
    csr_write(mtvec, trap_entry); 
f90012ec:	f90027b7          	lui	a5,0xf9002
f90012f0:	fb478793          	addi	a5,a5,-76 # f9001fb4 <trap_entry>
f90012f4:	30579073          	csrw	mtvec,a5
    csr_set(mie, MIE_MEIE); //Enable external interrupts and core timer
f90012f8:	000017b7          	lui	a5,0x1
f90012fc:	80078793          	addi	a5,a5,-2048 # 800 <CUSTOM2+0x7a5>
f9001300:	3047a073          	csrs	mie,a5
    csr_write(mstatus, MSTATUS_FS | MSTATUS_MPP | MSTATUS_MIE);
f9001304:	000087b7          	lui	a5,0x8
f9001308:	80878793          	addi	a5,a5,-2040 # 7808 <__stack_size+0x6808>
f900130c:	30079073          	csrw	mstatus,a5
    bsp_printf("Interrupt initialized\r\n");
f9001310:	f9004537          	lui	a0,0xf9004
f9001314:	49850513          	addi	a0,a0,1176 # f9004498 <_data+0x208>
f9001318:	bcdff0ef          	jal	f9000ee4 <bsp_printf>
}
f900131c:	00c12083          	lw	ra,12(sp)
f9001320:	01010113          	addi	sp,sp,16
f9001324:	00008067          	ret

f9001328 <init>:
void init() {
f9001328:	ff010113          	addi	sp,sp,-16
f900132c:	00112623          	sw	ra,12(sp)
	bsp_printf("reg_init start\r\n");
f9001330:	f9004537          	lui	a0,0xf9004
f9001334:	4b050513          	addi	a0,a0,1200 # f90044b0 <_data+0x220>
f9001338:	badff0ef          	jal	f9000ee4 <bsp_printf>
    reg_init();
f900133c:	aacff0ef          	jal	f90005e8 <reg_init>
    bsp_printf("reg_init done\r\n");
f9001340:	f9004537          	lui	a0,0xf9004
f9001344:	4c450513          	addi	a0,a0,1220 # f90044c4 <_data+0x234>
f9001348:	b9dff0ef          	jal	f9000ee4 <bsp_printf>
    bsp_printf("cam_i2c_init start\r\n");
f900134c:	f9004537          	lui	a0,0xf9004
f9001350:	4d450513          	addi	a0,a0,1236 # f90044d4 <_data+0x244>
f9001354:	b91ff0ef          	jal	f9000ee4 <bsp_printf>
    cam_i2c_init();
f9001358:	340000ef          	jal	f9001698 <cam_i2c_init>
    bsp_printf("cam_i2c_init done\r\n");
f900135c:	f9004537          	lui	a0,0xf9004
f9001360:	4ec50513          	addi	a0,a0,1260 # f90044ec <_data+0x25c>
f9001364:	b81ff0ef          	jal	f9000ee4 <bsp_printf>
    PiCam_init(CameraRes_1080P);
f9001368:	00100513          	li	a0,1
f900136c:	52c000ef          	jal	f9001898 <PiCam_init>
    bsp_printf("Camera initialized\r\n");
f9001370:	f9004537          	lui	a0,0xf9004
f9001374:	50050513          	addi	a0,a0,1280 # f9004500 <_data+0x270>
f9001378:	b6dff0ef          	jal	f9000ee4 <bsp_printf>
    isp_init(0.0);
f900137c:	00000513          	li	a0,0
f9001380:	f00ff0ef          	jal	f9000a80 <isp_init>
    initTimer(SYSTEM_CLINT_HZ/10);
f9001384:	00989537          	lui	a0,0x989
f9001388:	68050513          	addi	a0,a0,1664 # 989680 <__stack_size+0x988680>
f900138c:	00000593          	li	a1,0
f9001390:	365000ef          	jal	f9001ef4 <initTimer>
    interrupt_init();
f9001394:	f11ff0ef          	jal	f90012a4 <interrupt_init>
}
f9001398:	00c12083          	lw	ra,12(sp)
f900139c:	01010113          	addi	sp,sp,16
f90013a0:	00008067          	ret

f90013a4 <print_menu>:
{
f90013a4:	ff010113          	addi	sp,sp,-16
f90013a8:	00112623          	sw	ra,12(sp)
f90013ac:	00812423          	sw	s0,8(sp)
    bsp_printf("---------------------------\r\n");
f90013b0:	f9004537          	lui	a0,0xf9004
f90013b4:	51850513          	addi	a0,a0,1304 # f9004518 <_data+0x288>
f90013b8:	b2dff0ef          	jal	f9000ee4 <bsp_printf>
    bsp_printf("Choose resolution and frame rate:\r\n");
f90013bc:	f9004537          	lui	a0,0xf9004
f90013c0:	53850513          	addi	a0,a0,1336 # f9004538 <_data+0x2a8>
f90013c4:	b21ff0ef          	jal	f9000ee4 <bsp_printf>
    for (int tmp_i = 0; tmp_i < sizeof(videoParams)/sizeof(videoParams[0]); tmp_i++){
f90013c8:	00000413          	li	s0,0
f90013cc:	0400006f          	j	f900140c <print_menu+0x68>
    	bsp_printf("%d: ", tmp_i);
f90013d0:	00040593          	mv	a1,s0
f90013d4:	f9004537          	lui	a0,0xf9004
f90013d8:	55c50513          	addi	a0,a0,1372 # f900455c <_data+0x2cc>
f90013dc:	b09ff0ef          	jal	f9000ee4 <bsp_printf>
    	bsp_printf(videoParams[tmp_i].description);
f90013e0:	f90047b7          	lui	a5,0xf9004
f90013e4:	02c00713          	li	a4,44
f90013e8:	02e40733          	mul	a4,s0,a4
f90013ec:	69478793          	addi	a5,a5,1684 # f9004694 <videoParams>
f90013f0:	00e787b3          	add	a5,a5,a4
f90013f4:	0287a503          	lw	a0,40(a5)
f90013f8:	aedff0ef          	jal	f9000ee4 <bsp_printf>
    	bsp_printf("\r\n");
f90013fc:	f9004537          	lui	a0,0xf9004
f9001400:	33c50513          	addi	a0,a0,828 # f900433c <_data+0xac>
f9001404:	ae1ff0ef          	jal	f9000ee4 <bsp_printf>
    for (int tmp_i = 0; tmp_i < sizeof(videoParams)/sizeof(videoParams[0]); tmp_i++){
f9001408:	00140413          	addi	s0,s0,1
f900140c:	00500793          	li	a5,5
f9001410:	fc87f0e3          	bgeu	a5,s0,f90013d0 <print_menu+0x2c>
    bsp_printf("\r\n");
f9001414:	f9004537          	lui	a0,0xf9004
f9001418:	33c50513          	addi	a0,a0,828 # f900433c <_data+0xac>
f900141c:	ac9ff0ef          	jal	f9000ee4 <bsp_printf>
    bsp_printf("Choose pixel format:\r\n");
f9001420:	f9004537          	lui	a0,0xf9004
f9001424:	56450513          	addi	a0,a0,1380 # f9004564 <_data+0x2d4>
f9001428:	abdff0ef          	jal	f9000ee4 <bsp_printf>
    for (int tmp_i = 0; tmp_i < sizeof(pixelFormat)/sizeof(pixelFormat[0]); tmp_i++){
f900142c:	00000413          	li	s0,0
f9001430:	00200793          	li	a5,2
f9001434:	0487e263          	bltu	a5,s0,f9001478 <print_menu+0xd4>
    	bsp_printf("%c: ", 'a' + tmp_i);
f9001438:	06140593          	addi	a1,s0,97
f900143c:	f9004537          	lui	a0,0xf9004
f9001440:	57c50513          	addi	a0,a0,1404 # f900457c <_data+0x2ec>
f9001444:	aa1ff0ef          	jal	f9000ee4 <bsp_printf>
    	bsp_printf_s(pixelFormat[tmp_i]);
f9001448:	00241793          	slli	a5,s0,0x2
f900144c:	008787b3          	add	a5,a5,s0
f9001450:	00279513          	slli	a0,a5,0x2
f9001454:	f90057b7          	lui	a5,0xf9005
f9001458:	d9c78793          	addi	a5,a5,-612 # f9004d9c <pixelFormat>
f900145c:	00a78533          	add	a0,a5,a0
f9001460:	889ff0ef          	jal	f9000ce8 <bsp_printf_s>
    	bsp_printf("\r\n");
f9001464:	f9004537          	lui	a0,0xf9004
f9001468:	33c50513          	addi	a0,a0,828 # f900433c <_data+0xac>
f900146c:	a79ff0ef          	jal	f9000ee4 <bsp_printf>
    for (int tmp_i = 0; tmp_i < sizeof(pixelFormat)/sizeof(pixelFormat[0]); tmp_i++){
f9001470:	00140413          	addi	s0,s0,1
f9001474:	fbdff06f          	j	f9001430 <print_menu+0x8c>
}
f9001478:	00c12083          	lw	ra,12(sp)
f900147c:	00812403          	lw	s0,8(sp)
f9001480:	01010113          	addi	sp,sp,16
f9001484:	00008067          	ret

f9001488 <console_main>:
{
f9001488:	fc010113          	addi	sp,sp,-64
f900148c:	02112e23          	sw	ra,60(sp)
    input = uart_read(BSP_UART_TERMINAL);
f9001490:	f8010537          	lui	a0,0xf8010
f9001494:	ea4ff0ef          	jal	f9000b38 <uart_read>
f9001498:	84a18623          	sb	a0,-1972(gp) # f9004e14 <input.1>
    fun_num = input - '0';
f900149c:	fd050513          	addi	a0,a0,-48 # f800ffd0 <__stack_size+0xf800efd0>
f90014a0:	80a1a823          	sw	a0,-2032(gp) # f9004dd8 <fun_num.0>
    if ((fun_num >= 0 && fun_num <= 9) && (fun_num < sizeof(videoParams)/sizeof(videoParams[0]))) {
f90014a4:	00500793          	li	a5,5
f90014a8:	02a7f263          	bgeu	a5,a0,f90014cc <console_main+0x44>
    fun_num = input - 'a';
f90014ac:	84c1c783          	lbu	a5,-1972(gp) # f9004e14 <input.1>
f90014b0:	f9f78793          	addi	a5,a5,-97
f90014b4:	80f1a823          	sw	a5,-2032(gp) # f9004dd8 <fun_num.0>
    if ((fun_num >= 0 && fun_num <= 9) && (fun_num < sizeof(pixelFormat)/sizeof(pixelFormat[0]))) {
f90014b8:	00200713          	li	a4,2
f90014bc:	12f77e63          	bgeu	a4,a5,f90015f8 <console_main+0x170>
}
f90014c0:	03c12083          	lw	ra,60(sp)
f90014c4:	04010113          	addi	sp,sp,64
f90014c8:	00008067          	ret
f90014cc:	02812c23          	sw	s0,56(sp)
f90014d0:	02912a23          	sw	s1,52(sp)
f90014d4:	03212823          	sw	s2,48(sp)
        bsp_printf("    using ");
f90014d8:	f9004537          	lui	a0,0xf9004
f90014dc:	58450513          	addi	a0,a0,1412 # f9004584 <_data+0x2f4>
f90014e0:	a05ff0ef          	jal	f9000ee4 <bsp_printf>
        bsp_printf(videoParams[fun_num].description);
f90014e4:	8101a703          	lw	a4,-2032(gp) # f9004dd8 <fun_num.0>
f90014e8:	f90047b7          	lui	a5,0xf9004
f90014ec:	69478413          	addi	s0,a5,1684 # f9004694 <videoParams>
f90014f0:	02c00913          	li	s2,44
f90014f4:	032707b3          	mul	a5,a4,s2
f90014f8:	00f407b3          	add	a5,s0,a5
f90014fc:	0287a503          	lw	a0,40(a5)
f9001500:	9e5ff0ef          	jal	f9000ee4 <bsp_printf>
        bsp_printf("\r\n\r\n");
f9001504:	f9004537          	lui	a0,0xf9004
f9001508:	59050513          	addi	a0,a0,1424 # f9004590 <_data+0x300>
f900150c:	9d9ff0ef          	jal	f9000ee4 <bsp_printf>
        interrupt_set(USER_TIMER_0, 0);
f9001510:	00000593          	li	a1,0
f9001514:	01300513          	li	a0,19
f9001518:	d65ff0ef          	jal	f900127c <interrupt_set>
        update_video_timing(videoParams[fun_num].timing);
f900151c:	8101a783          	lw	a5,-2032(gp) # f9004dd8 <fun_num.0>
f9001520:	032787b3          	mul	a5,a5,s2
f9001524:	00f407b3          	add	a5,s0,a5
f9001528:	0007ae03          	lw	t3,0(a5)
f900152c:	0047a303          	lw	t1,4(a5)
f9001530:	0087a883          	lw	a7,8(a5)
f9001534:	00c7a803          	lw	a6,12(a5)
f9001538:	0107a503          	lw	a0,16(a5)
f900153c:	0147a583          	lw	a1,20(a5)
f9001540:	0187a603          	lw	a2,24(a5)
f9001544:	01c7a683          	lw	a3,28(a5)
f9001548:	0207a703          	lw	a4,32(a5)
f900154c:	0247a783          	lw	a5,36(a5)
f9001550:	01c12023          	sw	t3,0(sp)
f9001554:	00612223          	sw	t1,4(sp)
f9001558:	01112423          	sw	a7,8(sp)
f900155c:	01012623          	sw	a6,12(sp)
f9001560:	00a12823          	sw	a0,16(sp)
f9001564:	00b12a23          	sw	a1,20(sp)
f9001568:	00c12c23          	sw	a2,24(sp)
f900156c:	00d12e23          	sw	a3,28(sp)
f9001570:	02e12023          	sw	a4,32(sp)
f9001574:	02f12223          	sw	a5,36(sp)
f9001578:	00010513          	mv	a0,sp
f900157c:	ff1fe0ef          	jal	f900056c <update_video_timing>
        switch(fun_num) {
f9001580:	8101a783          	lw	a5,-2032(gp) # f9004dd8 <fun_num.0>
f9001584:	00300713          	li	a4,3
f9001588:	02f74e63          	blt	a4,a5,f90015c4 <console_main+0x13c>
f900158c:	00200713          	li	a4,2
f9001590:	04e7d663          	bge	a5,a4,f90015dc <console_main+0x154>
f9001594:	00100713          	li	a4,1
f9001598:	04f76863          	bltu	a4,a5,f90015e8 <console_main+0x160>
                PiCam_init(CameraRes_1080P);
f900159c:	00100513          	li	a0,1
f90015a0:	2f8000ef          	jal	f9001898 <PiCam_init>
        interrupt_set(USER_TIMER_0, 1);
f90015a4:	00100593          	li	a1,1
f90015a8:	01300513          	li	a0,19
f90015ac:	cd1ff0ef          	jal	f900127c <interrupt_set>
        print_menu();
f90015b0:	df5ff0ef          	jal	f90013a4 <print_menu>
f90015b4:	03812403          	lw	s0,56(sp)
f90015b8:	03412483          	lw	s1,52(sp)
f90015bc:	03012903          	lw	s2,48(sp)
f90015c0:	eedff06f          	j	f90014ac <console_main+0x24>
        switch(fun_num) {
f90015c4:	ffc78793          	addi	a5,a5,-4
f90015c8:	00100713          	li	a4,1
f90015cc:	00f76e63          	bltu	a4,a5,f90015e8 <console_main+0x160>
                PiCam_init(CameraRes_4K);
f90015d0:	00000513          	li	a0,0
f90015d4:	2c4000ef          	jal	f9001898 <PiCam_init>
                break;
f90015d8:	fcdff06f          	j	f90015a4 <console_main+0x11c>
                PiCam_init(CameraRes_1440P);
f90015dc:	00200513          	li	a0,2
f90015e0:	2b8000ef          	jal	f9001898 <PiCam_init>
                break;
f90015e4:	fc1ff06f          	j	f90015a4 <console_main+0x11c>
                bsp_printf("unexpected resolution & frame rate\r\n");
f90015e8:	f9004537          	lui	a0,0xf9004
f90015ec:	59850513          	addi	a0,a0,1432 # f9004598 <_data+0x308>
f90015f0:	8f5ff0ef          	jal	f9000ee4 <bsp_printf>
                break;
f90015f4:	fb1ff06f          	j	f90015a4 <console_main+0x11c>
f90015f8:	02812c23          	sw	s0,56(sp)
        bsp_printf("    using ");
f90015fc:	f9004537          	lui	a0,0xf9004
f9001600:	58450513          	addi	a0,a0,1412 # f9004584 <_data+0x2f4>
f9001604:	8e1ff0ef          	jal	f9000ee4 <bsp_printf>
        bsp_printf(pixelFormat[fun_num]);
f9001608:	8101a703          	lw	a4,-2032(gp) # f9004dd8 <fun_num.0>
f900160c:	00271793          	slli	a5,a4,0x2
f9001610:	00e787b3          	add	a5,a5,a4
f9001614:	00279793          	slli	a5,a5,0x2
f9001618:	f9005537          	lui	a0,0xf9005
f900161c:	d9c50513          	addi	a0,a0,-612 # f9004d9c <pixelFormat>
f9001620:	00f50533          	add	a0,a0,a5
f9001624:	8c1ff0ef          	jal	f9000ee4 <bsp_printf>
        bsp_printf("\r\n\r\n");
f9001628:	f9004537          	lui	a0,0xf9004
f900162c:	59050513          	addi	a0,a0,1424 # f9004590 <_data+0x300>
f9001630:	8b5ff0ef          	jal	f9000ee4 <bsp_printf>
        switch(fun_num) {
f9001634:	8101a503          	lw	a0,-2032(gp) # f9004dd8 <fun_num.0>
f9001638:	00200793          	li	a5,2
f900163c:	00a7ec63          	bltu	a5,a0,f9001654 <console_main+0x1cc>
                write_apb_reg(fun_num, REG_PIXEL_MODE);
f9001640:	07c00593          	li	a1,124
f9001644:	f19fe0ef          	jal	f900055c <write_apb_reg>
        print_menu();
f9001648:	d5dff0ef          	jal	f90013a4 <print_menu>
f900164c:	03812403          	lw	s0,56(sp)
}
f9001650:	e71ff06f          	j	f90014c0 <console_main+0x38>
                bsp_printf("unsupported pixel format\r\n");
f9001654:	f9004537          	lui	a0,0xf9004
f9001658:	5c050513          	addi	a0,a0,1472 # f90045c0 <_data+0x330>
f900165c:	889ff0ef          	jal	f9000ee4 <bsp_printf>
                break;
f9001660:	fe9ff06f          	j	f9001648 <console_main+0x1c0>

f9001664 <i2c_applyConfig>:
*
* @return       None.
*
******************************************************************************/
    static void i2c_applyConfig(u32 reg, I2c_Config *config){
        write_u32(config->samplingClockDivider, reg + I2C_SAMPLING_CLOCK_DIVIDER);
f9001664:	0005a783          	lw	a5,0(a1)
        *((volatile u32*) address) = data;
f9001668:	02f52423          	sw	a5,40(a0)
        write_u32(config->timeout, reg + I2C_TIMEOUT);
f900166c:	0045a783          	lw	a5,4(a1)
f9001670:	02f52623          	sw	a5,44(a0)
        write_u32(config->tsuDat, reg + I2C_TSUDAT);
f9001674:	0085a783          	lw	a5,8(a1)
f9001678:	02f52823          	sw	a5,48(a0)
        write_u32(config->tLow, reg + I2C_TLOW);
f900167c:	00c5a783          	lw	a5,12(a1)
f9001680:	04f52823          	sw	a5,80(a0)
        write_u32(config->tHigh, reg + I2C_THIGH);
f9001684:	0105a783          	lw	a5,16(a1)
f9001688:	04f52a23          	sw	a5,84(a0)
        write_u32(config->tBuf, reg + I2C_TBUF);
f900168c:	0145a783          	lw	a5,20(a1)
f9001690:	04f52c23          	sw	a5,88(a0)
    }
f9001694:	00008067          	ret

f9001698 <cam_i2c_init>:

#include "i2c.h"
#include "peri.h"

void cam_i2c_init() {
f9001698:	fd010113          	addi	sp,sp,-48
f900169c:	02112623          	sw	ra,44(sp)
    const int i2c_freq = 100000;
    I2c_Config i2c_mipi;
    i2c_mipi.samplingClockDivider = 3;
f90016a0:	00300793          	li	a5,3
f90016a4:	00f12423          	sw	a5,8(sp)
    i2c_mipi.timeout = I2C_CTRL_HZ/1000;
f90016a8:	000187b7          	lui	a5,0x18
f90016ac:	6a078793          	addi	a5,a5,1696 # 186a0 <__stack_size+0x176a0>
f90016b0:	00f12623          	sw	a5,12(sp)
    i2c_mipi.tsuDat  = I2C_CTRL_HZ/(i2c_freq*5);
f90016b4:	0c800793          	li	a5,200
f90016b8:	00f12823          	sw	a5,16(sp)

    /* T_low & T_high = i2c period / 2  */
    i2c_mipi.tLow  = I2C_CTRL_HZ/(i2c_freq*2);
f90016bc:	1f400793          	li	a5,500
f90016c0:	00f12a23          	sw	a5,20(sp)
    i2c_mipi.tHigh = I2C_CTRL_HZ/(i2c_freq*2);
f90016c4:	00f12c23          	sw	a5,24(sp)
    i2c_mipi.tBuf  = I2C_CTRL_HZ/(i2c_freq);
f90016c8:	3e800793          	li	a5,1000
f90016cc:	00f12e23          	sw	a5,28(sp)

    i2c_applyConfig(I2C_CTRL_CAM, &i2c_mipi);
f90016d0:	00810593          	addi	a1,sp,8
f90016d4:	f8016537          	lui	a0,0xf8016
f90016d8:	f8dff0ef          	jal	f9001664 <i2c_applyConfig>
}
f90016dc:	02c12083          	lw	ra,44(sp)
f90016e0:	03010113          	addi	sp,sp,48
f90016e4:	00008067          	ret

f90016e8 <i2c_masterBusy>:
        return *((volatile u32*) address);
f90016e8:	04052503          	lw	a0,64(a0) # f8016040 <__stack_size+0xf8015040>
* @return      Returns 1 if the I2C master is busy, and 0 otherwise.
*
******************************************************************************/
    static int i2c_masterBusy(u32 reg){
        return (read_u32(reg + I2C_MASTER_STATUS) & I2C_MASTER_BUSY) != 0;
    }
f90016ec:	00157513          	andi	a0,a0,1
f90016f0:	00008067          	ret

f90016f4 <i2c_masterStartBlocking>:
        write_u32(I2C_MASTER_START | I2C_MASTER_START_DROPPED, reg + I2C_MASTER_STATUS);
f90016f4:	04050713          	addi	a4,a0,64
        *((volatile u32*) address) = data;
f90016f8:	21000793          	li	a5,528
f90016fc:	04f52023          	sw	a5,64(a0)
        return *((volatile u32*) address);
f9001700:	00072783          	lw	a5,0(a4)
* @return      None.
*
******************************************************************************/
    static void i2c_masterStartBlocking(u32 reg){
        i2c_masterStart(reg);
        while(i2c_getMasterStatus(reg) & I2C_MASTER_START);
f9001704:	0107f793          	andi	a5,a5,16
f9001708:	fe079ce3          	bnez	a5,f9001700 <i2c_masterStartBlocking+0xc>
    }
f900170c:	00008067          	ret

f9001710 <i2c_masterStopWait>:
* @param reg   The base address of the I2C registers.
*
* @return      None.
*
******************************************************************************/
    static void i2c_masterStopWait(u32 reg){
f9001710:	ff010113          	addi	sp,sp,-16
f9001714:	00112623          	sw	ra,12(sp)
f9001718:	00812423          	sw	s0,8(sp)
f900171c:	00050413          	mv	s0,a0
        while(i2c_masterBusy(reg));
f9001720:	00040513          	mv	a0,s0
f9001724:	fc5ff0ef          	jal	f90016e8 <i2c_masterBusy>
f9001728:	fe051ce3          	bnez	a0,f9001720 <i2c_masterStopWait+0x10>
    }
f900172c:	00c12083          	lw	ra,12(sp)
f9001730:	00812403          	lw	s0,8(sp)
f9001734:	01010113          	addi	sp,sp,16
f9001738:	00008067          	ret

f900173c <i2c_masterStopBlocking>:
* @param reg   The base address of the I2C registers.
*
* @return      None.
*
******************************************************************************/
    static void i2c_masterStopBlocking(u32 reg){
f900173c:	ff010113          	addi	sp,sp,-16
f9001740:	00112623          	sw	ra,12(sp)
        *((volatile u32*) address) = data;
f9001744:	42000713          	li	a4,1056
f9001748:	04e52023          	sw	a4,64(a0)
        i2c_masterStop(reg);
        i2c_masterStopWait(reg);
f900174c:	fc5ff0ef          	jal	f9001710 <i2c_masterStopWait>
    }
f9001750:	00c12083          	lw	ra,12(sp)
f9001754:	01010113          	addi	sp,sp,16
f9001758:	00008067          	ret

f900175c <i2c_txAckWait>:
        return *((volatile u32*) address);
f900175c:	00452783          	lw	a5,4(a0)
*
* @return      None.
*
******************************************************************************/
    static void i2c_txAckWait(u32 reg){
        while(read_u32(reg + I2C_TX_ACK) & I2C_TX_VALID);
f9001760:	1007f793          	andi	a5,a5,256
f9001764:	fe079ce3          	bnez	a5,f900175c <i2c_txAckWait>
    }
f9001768:	00008067          	ret

f900176c <i2c_txNackBlocking>:
* @param reg   The base address of the I2C registers.
*
* @return      None.
*
******************************************************************************/
    static void i2c_txNackBlocking(u32 reg){
f900176c:	ff010113          	addi	sp,sp,-16
f9001770:	00112623          	sw	ra,12(sp)
        *((volatile u32*) address) = data;
f9001774:	30100713          	li	a4,769
f9001778:	00e52223          	sw	a4,4(a0)
        i2c_txNack(reg);
        i2c_txAckWait(reg);
f900177c:	fe1ff0ef          	jal	f900175c <i2c_txAckWait>
    }
f9001780:	00c12083          	lw	ra,12(sp)
f9001784:	01010113          	addi	sp,sp,16
f9001788:	00008067          	ret

f900178c <i2c_rxAck>:
        return *((volatile u32*) address);
f900178c:	00c52503          	lw	a0,12(a0)
*
* @return      1 if ACK signal is detected, otherwise 0.
*
******************************************************************************/
    static int i2c_rxAck(u32 reg){
        return (read_u32(reg + I2C_RX_ACK) & I2C_RX_VALUE) == 0;
f9001790:	0ff57513          	zext.b	a0,a0
    }
f9001794:	00153513          	seqz	a0,a0
f9001798:	00008067          	ret

f900179c <PiCam_WriteRegData>:
#include "common.h"
#include "PiCamV3.h"
#include "peri.h"

void PiCam_WriteRegData(u8 addr, u16 reg, u8 data)
{
f900179c:	fe010113          	addi	sp,sp,-32
f90017a0:	00112e23          	sw	ra,28(sp)
f90017a4:	00812c23          	sw	s0,24(sp)
f90017a8:	00912a23          	sw	s1,20(sp)
f90017ac:	01212823          	sw	s2,16(sp)
f90017b0:	01312623          	sw	s3,12(sp)
f90017b4:	01412423          	sw	s4,8(sp)
f90017b8:	00050413          	mv	s0,a0
f90017bc:	00058493          	mv	s1,a1
f90017c0:	00060993          	mv	s3,a2
	u8 outdata;

    i2c_masterStartBlocking(I2C_CTRL_CAM);
f90017c4:	f8016537          	lui	a0,0xf8016
f90017c8:	f2dff0ef          	jal	f90016f4 <i2c_masterStartBlocking>

    i2c_txByte(I2C_CTRL_CAM, addr<<1);
f90017cc:	00141413          	slli	s0,s0,0x1
f90017d0:	0ff47413          	zext.b	s0,s0
        write_u32(byte | I2C_TX_VALID | I2C_TX_ENABLE | I2C_TX_DISABLE_ON_DATA_CONFLICT, reg + I2C_TX_DATA);
f90017d4:	00001937          	lui	s2,0x1
f90017d8:	b0090913          	addi	s2,s2,-1280 # b00 <CUSTOM2+0xaa5>
f90017dc:	01246433          	or	s0,s0,s2
        *((volatile u32*) address) = data;
f90017e0:	f8016a37          	lui	s4,0xf8016
f90017e4:	008a2023          	sw	s0,0(s4) # f8016000 <__stack_size+0xf8015000>
	i2c_txNackBlocking(I2C_CTRL_CAM);
f90017e8:	f8016537          	lui	a0,0xf8016
f90017ec:	f81ff0ef          	jal	f900176c <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check
f90017f0:	f8016537          	lui	a0,0xf8016
f90017f4:	f99ff0ef          	jal	f900178c <i2c_rxAck>
f90017f8:	870ff0ef          	jal	f9000868 <assert>

	i2c_txByte(I2C_CTRL_CAM, (reg>>8) & 0xFF);
f90017fc:	0084d793          	srli	a5,s1,0x8
f9001800:	0127e7b3          	or	a5,a5,s2
f9001804:	00fa2023          	sw	a5,0(s4)
	i2c_txNackBlocking(I2C_CTRL_CAM);
f9001808:	f8016537          	lui	a0,0xf8016
f900180c:	f61ff0ef          	jal	f900176c <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check
f9001810:	f8016537          	lui	a0,0xf8016
f9001814:	f79ff0ef          	jal	f900178c <i2c_rxAck>
f9001818:	850ff0ef          	jal	f9000868 <assert>

	i2c_txByte(I2C_CTRL_CAM, (reg) & 0xFF);
f900181c:	0ff4f493          	zext.b	s1,s1
f9001820:	0124e4b3          	or	s1,s1,s2
f9001824:	009a2023          	sw	s1,0(s4)
	i2c_txNackBlocking(I2C_CTRL_CAM);
f9001828:	f8016537          	lui	a0,0xf8016
f900182c:	f41ff0ef          	jal	f900176c <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check
f9001830:	f8016537          	lui	a0,0xf8016
f9001834:	f59ff0ef          	jal	f900178c <i2c_rxAck>
f9001838:	830ff0ef          	jal	f9000868 <assert>
f900183c:	0129e9b3          	or	s3,s3,s2
f9001840:	013a2023          	sw	s3,0(s4)

	i2c_txByte(I2C_CTRL_CAM, data & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
f9001844:	f8016537          	lui	a0,0xf8016
f9001848:	f25ff0ef          	jal	f900176c <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check
f900184c:	f8016537          	lui	a0,0xf8016
f9001850:	f3dff0ef          	jal	f900178c <i2c_rxAck>
f9001854:	814ff0ef          	jal	f9000868 <assert>

	i2c_masterStopBlocking(I2C_CTRL_CAM);
f9001858:	f8016537          	lui	a0,0xf8016
f900185c:	ee1ff0ef          	jal	f900173c <i2c_masterStopBlocking>
}
f9001860:	01c12083          	lw	ra,28(sp)
f9001864:	01812403          	lw	s0,24(sp)
f9001868:	01412483          	lw	s1,20(sp)
f900186c:	01012903          	lw	s2,16(sp)
f9001870:	00c12983          	lw	s3,12(sp)
f9001874:	00812a03          	lw	s4,8(sp)
f9001878:	02010113          	addi	sp,sp,32
f900187c:	00008067          	ret

f9001880 <PiCam_Gainfilter>:
{
	PiCamV3_TestPattern(Enable, mode);
}

void PiCam_Gainfilter(u16 AGain, u16 DGain)
{
f9001880:	ff010113          	addi	sp,sp,-16
f9001884:	00112623          	sw	ra,12(sp)
	PiCamV3_Gainfilter(AGain, DGain);
f9001888:	254000ef          	jal	f9001adc <PiCamV3_Gainfilter>
}
f900188c:	00c12083          	lw	ra,12(sp)
f9001890:	01010113          	addi	sp,sp,16
f9001894:	00008067          	ret

f9001898 <PiCam_init>:


void PiCam_init(CameraRes_t res)
{
f9001898:	ff010113          	addi	sp,sp,-16
f900189c:	00112623          	sw	ra,12(sp)
	PiCamV3_init(res);
f90018a0:	044000ef          	jal	f90018e4 <PiCamV3_init>
	// PiCam_TestPattern(1, 0);
}
f90018a4:	00c12083          	lw	ra,12(sp)
f90018a8:	01010113          	addi	sp,sp,16
f90018ac:	00008067          	ret

f90018b0 <clint_uDelay>:
        u32 mTimePerUsec = hz/1000000;
f90018b0:	000f47b7          	lui	a5,0xf4
f90018b4:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf3240>
f90018b8:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
f90018bc:	0000c7b7          	lui	a5,0xc
f90018c0:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0xaff8>
f90018c4:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
f90018c8:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
f90018cc:	02a585b3          	mul	a1,a1,a0
f90018d0:	00f58733          	add	a4,a1,a5
f90018d4:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
f90018d8:	40f707b3          	sub	a5,a4,a5
f90018dc:	fe07dce3          	bgez	a5,f90018d4 <clint_uDelay+0x24>
f90018e0:	00008067          	ret

f90018e4 <PiCamV3_init>:
{
    return PiCam_ReadRegData(PI_CAM_V3_ADDR, reg);
}

void PiCamV3_init(CameraRes_t res)
{
f90018e4:	ff010113          	addi	sp,sp,-16
f90018e8:	00112623          	sw	ra,12(sp)
f90018ec:	00812423          	sw	s0,8(sp)
f90018f0:	00912223          	sw	s1,4(sp)
f90018f4:	00050493          	mv	s1,a0
//	WRITE_REGS_1A(im900_common_regs_x34_0);
//	bsp_uDelay(10*1000);
	WRITE_REGS_10(im900_common_regs_x20_1);
f90018f8:	00000413          	li	s0,0
f90018fc:	0280006f          	j	f9001924 <PiCamV3_init+0x40>
f9001900:	f90057b7          	lui	a5,0xf9005
f9001904:	00241713          	slli	a4,s0,0x2
f9001908:	c0078793          	addi	a5,a5,-1024 # f9004c00 <im900_common_regs_x20_1>
f900190c:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(0x10, reg, data);
f9001910:	0027c603          	lbu	a2,2(a5)
f9001914:	0007d583          	lhu	a1,0(a5)
f9001918:	01000513          	li	a0,16
f900191c:	e81ff0ef          	jal	f900179c <PiCam_WriteRegData>
	WRITE_REGS_10(im900_common_regs_x20_1);
f9001920:	00140413          	addi	s0,s0,1
f9001924:	00500793          	li	a5,5
f9001928:	fc87fce3          	bgeu	a5,s0,f9001900 <PiCamV3_init+0x1c>
	bsp_uDelay(1000*1000);
f900192c:	f8b00637          	lui	a2,0xf8b00
f9001930:	05f5e5b7          	lui	a1,0x5f5e
f9001934:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f9001938:	000f4537          	lui	a0,0xf4
f900193c:	24050513          	addi	a0,a0,576 # f4240 <__stack_size+0xf3240>
f9001940:	f71ff0ef          	jal	f90018b0 <clint_uDelay>
	WRITE_REGS_1A(im900_common_regs_x34_2);
f9001944:	00000413          	li	s0,0
f9001948:	0280006f          	j	f9001970 <PiCamV3_init+0x8c>
f900194c:	f90057b7          	lui	a5,0xf9005
f9001950:	00241713          	slli	a4,s0,0x2
f9001954:	bc078793          	addi	a5,a5,-1088 # f9004bc0 <im900_common_regs_x34_2>
f9001958:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f900195c:	0027c603          	lbu	a2,2(a5)
f9001960:	0007d583          	lhu	a1,0(a5)
f9001964:	01a00513          	li	a0,26
f9001968:	e35ff0ef          	jal	f900179c <PiCam_WriteRegData>
	WRITE_REGS_1A(im900_common_regs_x34_2);
f900196c:	00140413          	addi	s0,s0,1
f9001970:	00f00793          	li	a5,15
f9001974:	fc87fce3          	bgeu	a5,s0,f900194c <PiCamV3_init+0x68>
	WRITE_REGS_1A(im900_common_regs_x34_4);
f9001978:	00000413          	li	s0,0
f900197c:	0280006f          	j	f90019a4 <PiCamV3_init+0xc0>
f9001980:	f90057b7          	lui	a5,0xf9005
f9001984:	00241713          	slli	a4,s0,0x2
f9001988:	b9878793          	addi	a5,a5,-1128 # f9004b98 <im900_common_regs_x34_4>
f900198c:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f9001990:	0027c603          	lbu	a2,2(a5)
f9001994:	0007d583          	lhu	a1,0(a5)
f9001998:	01a00513          	li	a0,26
f900199c:	e01ff0ef          	jal	f900179c <PiCam_WriteRegData>
	WRITE_REGS_1A(im900_common_regs_x34_4);
f90019a0:	00140413          	addi	s0,s0,1
f90019a4:	00900793          	li	a5,9
f90019a8:	fc87fce3          	bgeu	a5,s0,f9001980 <PiCamV3_init+0x9c>
	bsp_uDelay(10*1000);
f90019ac:	f8b00637          	lui	a2,0xf8b00
f90019b0:	05f5e5b7          	lui	a1,0x5f5e
f90019b4:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f90019b8:	00002537          	lui	a0,0x2
f90019bc:	71050513          	addi	a0,a0,1808 # 2710 <__stack_size+0x1710>
f90019c0:	ef1ff0ef          	jal	f90018b0 <clint_uDelay>
//	bsp_uDelay(10*1000);
//	WRITE_REGS_10(im900_common_regs_x20_5);
//	bsp_uDelay(10*1000);
//	WRITE_REGS_1A(im900_common_regs_x34_6);
//	bsp_uDelay(10*1000);
	switch (res) {
f90019c4:	00100793          	li	a5,1
f90019c8:	0cf48a63          	beq	s1,a5,f9001a9c <PiCamV3_init+0x1b8>
f90019cc:	00200793          	li	a5,2
f90019d0:	10f48263          	beq	s1,a5,f9001ad4 <PiCamV3_init+0x1f0>
f90019d4:	04048663          	beqz	s1,f9001a20 <PiCamV3_init+0x13c>
    // set exposure
//    PiCamV3_WriteRegData(IMX708_REG_EXPOSURE, 0x03);    //MSB
//    PiCamV3_WriteRegData(IMX708_REG_EXPOSURE + 1, 0x08);  //LSB
    // start streaming
//    PiCamV3_WriteRegData(IMX708_REG_MODE_SELECT, IMX708_MODE_STREAMING);
}
f90019d8:	00c12083          	lw	ra,12(sp)
f90019dc:	00812403          	lw	s0,8(sp)
f90019e0:	00412483          	lw	s1,4(sp)
f90019e4:	01010113          	addi	sp,sp,16
f90019e8:	00008067          	ret
			WRITE_REGS(mode_4608x2592_regs);
f90019ec:	f90057b7          	lui	a5,0xf9005
f90019f0:	00241713          	slli	a4,s0,0x2
f90019f4:	9b478793          	addi	a5,a5,-1612 # f90049b4 <mode_4608x2592_regs>
f90019f8:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f90019fc:	0027c603          	lbu	a2,2(a5)
f9001a00:	0007d583          	lhu	a1,0(a5)
f9001a04:	01a00513          	li	a0,26
f9001a08:	d95ff0ef          	jal	f900179c <PiCam_WriteRegData>
			WRITE_REGS(mode_4608x2592_regs);
f9001a0c:	00140413          	addi	s0,s0,1
f9001a10:	05a00793          	li	a5,90
f9001a14:	fc87fce3          	bgeu	a5,s0,f90019ec <PiCamV3_init+0x108>
			WRITE_REGS(link_453Mhz_regs);
f9001a18:	00000413          	li	s0,0
f9001a1c:	02c0006f          	j	f9001a48 <PiCamV3_init+0x164>
	switch (res) {
f9001a20:	00000413          	li	s0,0
f9001a24:	fedff06f          	j	f9001a10 <PiCamV3_init+0x12c>
			WRITE_REGS(link_453Mhz_regs);
f9001a28:	00241713          	slli	a4,s0,0x2
f9001a2c:	83818793          	addi	a5,gp,-1992 # f9004e00 <link_453Mhz_regs>
f9001a30:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f9001a34:	0027c603          	lbu	a2,2(a5)
f9001a38:	0007d583          	lhu	a1,0(a5)
f9001a3c:	01a00513          	li	a0,26
f9001a40:	d5dff0ef          	jal	f900179c <PiCam_WriteRegData>
			WRITE_REGS(link_453Mhz_regs);
f9001a44:	00140413          	addi	s0,s0,1
f9001a48:	00100793          	li	a5,1
f9001a4c:	fc87fee3          	bgeu	a5,s0,f9001a28 <PiCamV3_init+0x144>
f9001a50:	f89ff06f          	j	f90019d8 <PiCamV3_init+0xf4>
			WRITE_REGS_1A(imx900_regs_0);
f9001a54:	f90057b7          	lui	a5,0xf9005
f9001a58:	00241713          	slli	a4,s0,0x2
f9001a5c:	b2078793          	addi	a5,a5,-1248 # f9004b20 <imx900_regs_0>
f9001a60:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f9001a64:	0027c603          	lbu	a2,2(a5)
f9001a68:	0007d583          	lhu	a1,0(a5)
f9001a6c:	01a00513          	li	a0,26
f9001a70:	d2dff0ef          	jal	f900179c <PiCam_WriteRegData>
			WRITE_REGS_1A(imx900_regs_0);
f9001a74:	00140413          	addi	s0,s0,1
f9001a78:	01d00793          	li	a5,29
f9001a7c:	fc87fce3          	bgeu	a5,s0,f9001a54 <PiCamV3_init+0x170>
			bsp_uDelay(1000*1000);
f9001a80:	f8b00637          	lui	a2,0xf8b00
f9001a84:	05f5e5b7          	lui	a1,0x5f5e
f9001a88:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d100>
f9001a8c:	000f4537          	lui	a0,0xf4
f9001a90:	24050513          	addi	a0,a0,576 # f4240 <__stack_size+0xf3240>
f9001a94:	e1dff0ef          	jal	f90018b0 <clint_uDelay>
		break;
f9001a98:	f41ff06f          	j	f90019d8 <PiCamV3_init+0xf4>
	switch (res) {
f9001a9c:	00000413          	li	s0,0
f9001aa0:	fd9ff06f          	j	f9001a78 <PiCamV3_init+0x194>
			WRITE_REGS(mode_2560x1440_regs);
f9001aa4:	f90057b7          	lui	a5,0xf9005
f9001aa8:	00241713          	slli	a4,s0,0x2
f9001aac:	84878793          	addi	a5,a5,-1976 # f9004848 <mode_2560x1440_regs>
f9001ab0:	00e787b3          	add	a5,a5,a4
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f9001ab4:	0027c603          	lbu	a2,2(a5)
f9001ab8:	0007d583          	lhu	a1,0(a5)
f9001abc:	01a00513          	li	a0,26
f9001ac0:	cddff0ef          	jal	f900179c <PiCam_WriteRegData>
			WRITE_REGS(mode_2560x1440_regs);
f9001ac4:	00140413          	addi	s0,s0,1
f9001ac8:	05a00793          	li	a5,90
f9001acc:	fc87fce3          	bgeu	a5,s0,f9001aa4 <PiCamV3_init+0x1c0>
f9001ad0:	f09ff06f          	j	f90019d8 <PiCamV3_init+0xf4>
	switch (res) {
f9001ad4:	00000413          	li	s0,0
f9001ad8:	ff1ff06f          	j	f9001ac8 <PiCamV3_init+0x1e4>

f9001adc <PiCamV3_Gainfilter>:


void PiCamV3_Gainfilter(u16 AGain, u16 DGain)
{
f9001adc:	ff010113          	addi	sp,sp,-16
f9001ae0:	00112623          	sw	ra,12(sp)
f9001ae4:	00812423          	sw	s0,8(sp)
f9001ae8:	00912223          	sw	s1,4(sp)
f9001aec:	00050413          	mv	s0,a0
f9001af0:	00058493          	mv	s1,a1
    PiCam_WriteRegData(PI_CAM_V3_ADDR, reg, data);
f9001af4:	0085d613          	srli	a2,a1,0x8
f9001af8:	20e00593          	li	a1,526
f9001afc:	01a00513          	li	a0,26
f9001b00:	c9dff0ef          	jal	f900179c <PiCam_WriteRegData>
f9001b04:	0ff4f613          	zext.b	a2,s1
f9001b08:	20f00593          	li	a1,527
f9001b0c:	01a00513          	li	a0,26
f9001b10:	c8dff0ef          	jal	f900179c <PiCam_WriteRegData>
f9001b14:	00845613          	srli	a2,s0,0x8
f9001b18:	20400593          	li	a1,516
f9001b1c:	01a00513          	li	a0,26
f9001b20:	c7dff0ef          	jal	f900179c <PiCam_WriteRegData>
f9001b24:	0ff47613          	zext.b	a2,s0
f9001b28:	20500593          	li	a1,517
f9001b2c:	01a00513          	li	a0,26
f9001b30:	c6dff0ef          	jal	f900179c <PiCam_WriteRegData>
    PiCamV3_WriteRegData(IMX708_REG_DIGITAL_GAIN, (u8)(DGain >> 8));    //MSB
    PiCamV3_WriteRegData(IMX708_REG_DIGITAL_GAIN + 1, (u8)(DGain & 0xff));  //LSB
    // set analog gain
    PiCamV3_WriteRegData(IMX708_REG_ANALOG_GAIN, (u8)(AGain >> 8));    //MSB
    PiCamV3_WriteRegData(IMX708_REG_ANALOG_GAIN + 1, (u8)(AGain & 0xff));  //LSB
}
f9001b34:	00c12083          	lw	ra,12(sp)
f9001b38:	00812403          	lw	s0,8(sp)
f9001b3c:	00412483          	lw	s1,4(sp)
f9001b40:	01010113          	addi	sp,sp,16
f9001b44:	00008067          	ret

f9001b48 <uart_writeAvailability>:
        return *((volatile u32*) address);
f9001b48:	00452503          	lw	a0,4(a0)
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f9001b4c:	01055513          	srli	a0,a0,0x10
    }
f9001b50:	0ff57513          	zext.b	a0,a0
f9001b54:	00008067          	ret

f9001b58 <uart_write>:
    static void uart_write(u32 reg, char data){
f9001b58:	ff010113          	addi	sp,sp,-16
f9001b5c:	00112623          	sw	ra,12(sp)
f9001b60:	00812423          	sw	s0,8(sp)
f9001b64:	00912223          	sw	s1,4(sp)
f9001b68:	00050413          	mv	s0,a0
f9001b6c:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9001b70:	00040513          	mv	a0,s0
f9001b74:	fd5ff0ef          	jal	f9001b48 <uart_writeAvailability>
f9001b78:	fe050ce3          	beqz	a0,f9001b70 <uart_write+0x18>
        *((volatile u32*) address) = data;
f9001b7c:	00942023          	sw	s1,0(s0)
    }
f9001b80:	00c12083          	lw	ra,12(sp)
f9001b84:	00812403          	lw	s0,8(sp)
f9001b88:	00412483          	lw	s1,4(sp)
f9001b8c:	01010113          	addi	sp,sp,16
f9001b90:	00008067          	ret

f9001b94 <_putchar>:
    static void _putchar(char character){
f9001b94:	ff010113          	addi	sp,sp,-16
f9001b98:	00112623          	sw	ra,12(sp)
f9001b9c:	00050593          	mv	a1,a0
            bsp_putChar(character);
f9001ba0:	f8010537          	lui	a0,0xf8010
f9001ba4:	fb5ff0ef          	jal	f9001b58 <uart_write>
    }
f9001ba8:	00c12083          	lw	ra,12(sp)
f9001bac:	01010113          	addi	sp,sp,16
f9001bb0:	00008067          	ret

f9001bb4 <_putchar_s>:
    {
f9001bb4:	ff010113          	addi	sp,sp,-16
f9001bb8:	00112623          	sw	ra,12(sp)
f9001bbc:	00812423          	sw	s0,8(sp)
f9001bc0:	00050413          	mv	s0,a0
        while (*p)
f9001bc4:	00c0006f          	j	f9001bd0 <_putchar_s+0x1c>
            _putchar(*(p++));
f9001bc8:	00140413          	addi	s0,s0,1
f9001bcc:	fc9ff0ef          	jal	f9001b94 <_putchar>
        while (*p)
f9001bd0:	00044503          	lbu	a0,0(s0)
f9001bd4:	fe051ae3          	bnez	a0,f9001bc8 <_putchar_s+0x14>
    }
f9001bd8:	00c12083          	lw	ra,12(sp)
f9001bdc:	00812403          	lw	s0,8(sp)
f9001be0:	01010113          	addi	sp,sp,16
f9001be4:	00008067          	ret

f9001be8 <bsp_printHex>:
    {
f9001be8:	ff010113          	addi	sp,sp,-16
f9001bec:	00112623          	sw	ra,12(sp)
f9001bf0:	00812423          	sw	s0,8(sp)
f9001bf4:	00912223          	sw	s1,4(sp)
f9001bf8:	00050493          	mv	s1,a0
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9001bfc:	01c00413          	li	s0,28
f9001c00:	0240006f          	j	f9001c24 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
f9001c04:	0084d733          	srl	a4,s1,s0
f9001c08:	00f77713          	andi	a4,a4,15
f9001c0c:	f90047b7          	lui	a5,0xf9004
f9001c10:	29078793          	addi	a5,a5,656 # f9004290 <_data>
f9001c14:	00e787b3          	add	a5,a5,a4
f9001c18:	0007c503          	lbu	a0,0(a5)
f9001c1c:	f79ff0ef          	jal	f9001b94 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9001c20:	ffc40413          	addi	s0,s0,-4
f9001c24:	fe0450e3          	bgez	s0,f9001c04 <bsp_printHex+0x1c>
    }
f9001c28:	00c12083          	lw	ra,12(sp)
f9001c2c:	00812403          	lw	s0,8(sp)
f9001c30:	00412483          	lw	s1,4(sp)
f9001c34:	01010113          	addi	sp,sp,16
f9001c38:	00008067          	ret

f9001c3c <bsp_printHex_lower>:
    {
f9001c3c:	ff010113          	addi	sp,sp,-16
f9001c40:	00112623          	sw	ra,12(sp)
f9001c44:	00812423          	sw	s0,8(sp)
f9001c48:	00912223          	sw	s1,4(sp)
f9001c4c:	00050493          	mv	s1,a0
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9001c50:	01c00413          	li	s0,28
f9001c54:	0240006f          	j	f9001c78 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
f9001c58:	0084d733          	srl	a4,s1,s0
f9001c5c:	00f77713          	andi	a4,a4,15
f9001c60:	f90047b7          	lui	a5,0xf9004
f9001c64:	2a478793          	addi	a5,a5,676 # f90042a4 <_data+0x14>
f9001c68:	00e787b3          	add	a5,a5,a4
f9001c6c:	0007c503          	lbu	a0,0(a5)
f9001c70:	f25ff0ef          	jal	f9001b94 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9001c74:	ffc40413          	addi	s0,s0,-4
f9001c78:	fe0450e3          	bgez	s0,f9001c58 <bsp_printHex_lower+0x1c>
    }
f9001c7c:	00c12083          	lw	ra,12(sp)
f9001c80:	00812403          	lw	s0,8(sp)
f9001c84:	00412483          	lw	s1,4(sp)
f9001c88:	01010113          	addi	sp,sp,16
f9001c8c:	00008067          	ret

f9001c90 <bsp_printf_c>:
    {
f9001c90:	ff010113          	addi	sp,sp,-16
f9001c94:	00112623          	sw	ra,12(sp)
        _putchar(c);
f9001c98:	0ff57513          	zext.b	a0,a0
f9001c9c:	ef9ff0ef          	jal	f9001b94 <_putchar>
    }
f9001ca0:	00c12083          	lw	ra,12(sp)
f9001ca4:	01010113          	addi	sp,sp,16
f9001ca8:	00008067          	ret

f9001cac <bsp_printf_s>:
    {
f9001cac:	ff010113          	addi	sp,sp,-16
f9001cb0:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
f9001cb4:	f01ff0ef          	jal	f9001bb4 <_putchar_s>
    }
f9001cb8:	00c12083          	lw	ra,12(sp)
f9001cbc:	01010113          	addi	sp,sp,16
f9001cc0:	00008067          	ret

f9001cc4 <bsp_printf_d>:
    {
f9001cc4:	fd010113          	addi	sp,sp,-48
f9001cc8:	02112623          	sw	ra,44(sp)
f9001ccc:	02812423          	sw	s0,40(sp)
f9001cd0:	02912223          	sw	s1,36(sp)
f9001cd4:	00050493          	mv	s1,a0
        if (val < 0) {
f9001cd8:	00054663          	bltz	a0,f9001ce4 <bsp_printf_d+0x20>
    {
f9001cdc:	00010413          	mv	s0,sp
f9001ce0:	02c0006f          	j	f9001d0c <bsp_printf_d+0x48>
            bsp_printf_c('-');
f9001ce4:	02d00513          	li	a0,45
f9001ce8:	fa9ff0ef          	jal	f9001c90 <bsp_printf_c>
            val = -val;
f9001cec:	409004b3          	neg	s1,s1
f9001cf0:	fedff06f          	j	f9001cdc <bsp_printf_d+0x18>
            *(p++) = '0' + val % 10;
f9001cf4:	00a00713          	li	a4,10
f9001cf8:	02e4e7b3          	rem	a5,s1,a4
f9001cfc:	03078793          	addi	a5,a5,48
f9001d00:	00f40023          	sb	a5,0(s0)
            val = val / 10;
f9001d04:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
f9001d08:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
f9001d0c:	fe0494e3          	bnez	s1,f9001cf4 <bsp_printf_d+0x30>
f9001d10:	00010793          	mv	a5,sp
f9001d14:	fef400e3          	beq	s0,a5,f9001cf4 <bsp_printf_d+0x30>
        while (p != buffer)
f9001d18:	00010793          	mv	a5,sp
f9001d1c:	00f40a63          	beq	s0,a5,f9001d30 <bsp_printf_d+0x6c>
            bsp_printf_c(*(--p));
f9001d20:	fff40413          	addi	s0,s0,-1
f9001d24:	00044503          	lbu	a0,0(s0)
f9001d28:	f69ff0ef          	jal	f9001c90 <bsp_printf_c>
f9001d2c:	fedff06f          	j	f9001d18 <bsp_printf_d+0x54>
    }
f9001d30:	02c12083          	lw	ra,44(sp)
f9001d34:	02812403          	lw	s0,40(sp)
f9001d38:	02412483          	lw	s1,36(sp)
f9001d3c:	03010113          	addi	sp,sp,48
f9001d40:	00008067          	ret

f9001d44 <bsp_printf_x>:
    {
f9001d44:	ff010113          	addi	sp,sp,-16
f9001d48:	00112623          	sw	ra,12(sp)
        for(i=0;i<8;i++)
f9001d4c:	00000713          	li	a4,0
f9001d50:	00700793          	li	a5,7
f9001d54:	02e7c063          	blt	a5,a4,f9001d74 <bsp_printf_x+0x30>
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f9001d58:	00271693          	slli	a3,a4,0x2
f9001d5c:	ff000793          	li	a5,-16
f9001d60:	00d797b3          	sll	a5,a5,a3
f9001d64:	00f577b3          	and	a5,a0,a5
f9001d68:	00078663          	beqz	a5,f9001d74 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
f9001d6c:	00170713          	addi	a4,a4,1
f9001d70:	fe1ff06f          	j	f9001d50 <bsp_printf_x+0xc>
        bsp_printHex_lower(val);
f9001d74:	ec9ff0ef          	jal	f9001c3c <bsp_printHex_lower>
    }
f9001d78:	00c12083          	lw	ra,12(sp)
f9001d7c:	01010113          	addi	sp,sp,16
f9001d80:	00008067          	ret

f9001d84 <bsp_printf_X>:
        {
f9001d84:	ff010113          	addi	sp,sp,-16
f9001d88:	00112623          	sw	ra,12(sp)
            for(i=0;i<8;i++)
f9001d8c:	00000713          	li	a4,0
f9001d90:	00700793          	li	a5,7
f9001d94:	02e7c063          	blt	a5,a4,f9001db4 <bsp_printf_X+0x30>
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f9001d98:	00271693          	slli	a3,a4,0x2
f9001d9c:	ff000793          	li	a5,-16
f9001da0:	00d797b3          	sll	a5,a5,a3
f9001da4:	00f577b3          	and	a5,a0,a5
f9001da8:	00078663          	beqz	a5,f9001db4 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
f9001dac:	00170713          	addi	a4,a4,1
f9001db0:	fe1ff06f          	j	f9001d90 <bsp_printf_X+0xc>
            bsp_printHex(val);
f9001db4:	e35ff0ef          	jal	f9001be8 <bsp_printHex>
        }
f9001db8:	00c12083          	lw	ra,12(sp)
f9001dbc:	01010113          	addi	sp,sp,16
f9001dc0:	00008067          	ret

f9001dc4 <bsp_printf>:
    {
f9001dc4:	fc010113          	addi	sp,sp,-64
f9001dc8:	00112e23          	sw	ra,28(sp)
f9001dcc:	00812c23          	sw	s0,24(sp)
f9001dd0:	00912a23          	sw	s1,20(sp)
f9001dd4:	00050493          	mv	s1,a0
f9001dd8:	02b12223          	sw	a1,36(sp)
f9001ddc:	02c12423          	sw	a2,40(sp)
f9001de0:	02d12623          	sw	a3,44(sp)
f9001de4:	02e12823          	sw	a4,48(sp)
f9001de8:	02f12a23          	sw	a5,52(sp)
f9001dec:	03012c23          	sw	a6,56(sp)
f9001df0:	03112e23          	sw	a7,60(sp)
        va_start(ap, format);
f9001df4:	02410793          	addi	a5,sp,36
f9001df8:	00f12623          	sw	a5,12(sp)
        for (i = 0; format[i]; i++)
f9001dfc:	00000413          	li	s0,0
f9001e00:	01c0006f          	j	f9001e1c <bsp_printf+0x58>
                        bsp_printf_c(va_arg(ap,int));
f9001e04:	00c12783          	lw	a5,12(sp)
f9001e08:	00478713          	addi	a4,a5,4
f9001e0c:	00e12623          	sw	a4,12(sp)
f9001e10:	0007a503          	lw	a0,0(a5)
f9001e14:	e7dff0ef          	jal	f9001c90 <bsp_printf_c>
        for (i = 0; format[i]; i++)
f9001e18:	00140413          	addi	s0,s0,1
f9001e1c:	008487b3          	add	a5,s1,s0
f9001e20:	0007c503          	lbu	a0,0(a5)
f9001e24:	0a050e63          	beqz	a0,f9001ee0 <bsp_printf+0x11c>
            if (format[i] == '%') {
f9001e28:	02500793          	li	a5,37
f9001e2c:	06f50e63          	beq	a0,a5,f9001ea8 <bsp_printf+0xe4>
                bsp_printf_c(format[i]);
f9001e30:	e61ff0ef          	jal	f9001c90 <bsp_printf_c>
f9001e34:	fe5ff06f          	j	f9001e18 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
f9001e38:	00c12783          	lw	a5,12(sp)
f9001e3c:	00478713          	addi	a4,a5,4
f9001e40:	00e12623          	sw	a4,12(sp)
f9001e44:	0007a503          	lw	a0,0(a5)
f9001e48:	e65ff0ef          	jal	f9001cac <bsp_printf_s>
                        break;
f9001e4c:	fcdff06f          	j	f9001e18 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
f9001e50:	00c12783          	lw	a5,12(sp)
f9001e54:	00478713          	addi	a4,a5,4
f9001e58:	00e12623          	sw	a4,12(sp)
f9001e5c:	0007a503          	lw	a0,0(a5)
f9001e60:	e65ff0ef          	jal	f9001cc4 <bsp_printf_d>
                        break;
f9001e64:	fb5ff06f          	j	f9001e18 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
f9001e68:	00c12783          	lw	a5,12(sp)
f9001e6c:	00478713          	addi	a4,a5,4
f9001e70:	00e12623          	sw	a4,12(sp)
f9001e74:	0007a503          	lw	a0,0(a5)
f9001e78:	f0dff0ef          	jal	f9001d84 <bsp_printf_X>
                        break;
f9001e7c:	f9dff06f          	j	f9001e18 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
f9001e80:	00c12783          	lw	a5,12(sp)
f9001e84:	00478713          	addi	a4,a5,4
f9001e88:	00e12623          	sw	a4,12(sp)
f9001e8c:	0007a503          	lw	a0,0(a5)
f9001e90:	eb5ff0ef          	jal	f9001d44 <bsp_printf_x>
                        break;
f9001e94:	f85ff06f          	j	f9001e18 <bsp_printf+0x54>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
f9001e98:	f9004537          	lui	a0,0xf9004
f9001e9c:	2b850513          	addi	a0,a0,696 # f90042b8 <_data+0x28>
f9001ea0:	e0dff0ef          	jal	f9001cac <bsp_printf_s>
                        break;
f9001ea4:	f75ff06f          	j	f9001e18 <bsp_printf+0x54>
                while (format[++i]) {
f9001ea8:	00140413          	addi	s0,s0,1
f9001eac:	008487b3          	add	a5,s1,s0
f9001eb0:	0007c783          	lbu	a5,0(a5)
f9001eb4:	f60782e3          	beqz	a5,f9001e18 <bsp_printf+0x54>
                    if (format[i] == 'c') {
f9001eb8:	fa878793          	addi	a5,a5,-88
f9001ebc:	0ff7f693          	zext.b	a3,a5
f9001ec0:	02000713          	li	a4,32
f9001ec4:	fed762e3          	bltu	a4,a3,f9001ea8 <bsp_printf+0xe4>
f9001ec8:	00269793          	slli	a5,a3,0x2
f9001ecc:	f9005737          	lui	a4,0xf9005
f9001ed0:	c1870713          	addi	a4,a4,-1000 # f9004c18 <im900_common_regs_x20_1+0x18>
f9001ed4:	00e787b3          	add	a5,a5,a4
f9001ed8:	0007a783          	lw	a5,0(a5)
f9001edc:	00078067          	jr	a5
    }
f9001ee0:	01c12083          	lw	ra,28(sp)
f9001ee4:	01812403          	lw	s0,24(sp)
f9001ee8:	01412483          	lw	s1,20(sp)
f9001eec:	04010113          	addi	sp,sp,64
f9001ef0:	00008067          	ret

f9001ef4 <initTimer>:
#define TIMER_CONFIG_WITH_PRESCALER     0x2
#define TIMER_CONFIG_WITHOUT_PRESCALER  0x1
#define TIMER_CONFIG_SELF_RESTART       0x10000


void initTimer(u64 interval){
f9001ef4:	ff010113          	addi	sp,sp,-16
f9001ef8:	00112623          	sw	ra,12(sp)
f9001efc:	f80177b7          	lui	a5,0xf8017
f9001f00:	06300713          	li	a4,99
f9001f04:	00e7a023          	sw	a4,0(a5) # f8017000 <__stack_size+0xf8016000>
f9001f08:	00010737          	lui	a4,0x10
f9001f0c:	00270713          	addi	a4,a4,2 # 10002 <__stack_size+0xf002>
f9001f10:	04e7a023          	sw	a4,64(a5)
    //Divide clock rate by 99+1
    write_u32(99, TIMER_PRESCALER_CTRL); 
    write_u32(TIMER_CONFIG_WITH_PRESCALER | TIMER_CONFIG_SELF_RESTART, TIMER_CTRL + 0x0);
    //Will tick each interval cycles (as it use the prescaler)
    write_u32(interval/100 - 1, TIMER_CTRL + 0x4);
f9001f14:	001007b7          	lui	a5,0x100
f9001f18:	fff78793          	addi	a5,a5,-1 # fffff <__stack_size+0xfefff>
f9001f1c:	00f57733          	and	a4,a0,a5
f9001f20:	00c59613          	slli	a2,a1,0xc
f9001f24:	01455693          	srli	a3,a0,0x14
f9001f28:	00d666b3          	or	a3,a2,a3
f9001f2c:	00f6f6b3          	and	a3,a3,a5
f9001f30:	00d70733          	add	a4,a4,a3
f9001f34:	0085d693          	srli	a3,a1,0x8
f9001f38:	00f6f7b3          	and	a5,a3,a5
f9001f3c:	00f70733          	add	a4,a4,a5
f9001f40:	01c5d793          	srli	a5,a1,0x1c
f9001f44:	00f70733          	add	a4,a4,a5
f9001f48:	01900793          	li	a5,25
f9001f4c:	02f77733          	remu	a4,a4,a5
f9001f50:	40e50733          	sub	a4,a0,a4
f9001f54:	00e53533          	sltu	a0,a0,a4
f9001f58:	40a587b3          	sub	a5,a1,a0
f9001f5c:	c28f6637          	lui	a2,0xc28f6
f9001f60:	c2960613          	addi	a2,a2,-983 # c28f5c29 <__stack_size+0xc28f4c29>
f9001f64:	02c787b3          	mul	a5,a5,a2
f9001f68:	8f5c36b7          	lui	a3,0x8f5c3
f9001f6c:	8f568693          	addi	a3,a3,-1803 # 8f5c28f5 <__stack_size+0x8f5c18f5>
f9001f70:	02d706b3          	mul	a3,a4,a3
f9001f74:	00d787b3          	add	a5,a5,a3
f9001f78:	02c706b3          	mul	a3,a4,a2
f9001f7c:	02c73733          	mulhu	a4,a4,a2
f9001f80:	00e787b3          	add	a5,a5,a4
f9001f84:	01e79793          	slli	a5,a5,0x1e
f9001f88:	0026d713          	srli	a4,a3,0x2
f9001f8c:	00e7e733          	or	a4,a5,a4
f9001f90:	fff70713          	addi	a4,a4,-1
f9001f94:	f80177b7          	lui	a5,0xf8017
f9001f98:	04e7a223          	sw	a4,68(a5) # f8017044 <__stack_size+0xf8016044>
    bsp_printf("user timer initialized!\r\n");
f9001f9c:	f9004537          	lui	a0,0xf9004
f9001fa0:	5f450513          	addi	a0,a0,1524 # f90045f4 <_data+0x364>
f9001fa4:	e21ff0ef          	jal	f9001dc4 <bsp_printf>
}
f9001fa8:	00c12083          	lw	ra,12(sp)
f9001fac:	01010113          	addi	sp,sp,16
f9001fb0:	00008067          	ret

f9001fb4 <trap_entry>:

trap_entry:
#ifdef __riscv_flen
  addi sp, sp, -STACK_SIZE
#else
  addi sp, sp, -64
f9001fb4:	fc010113          	addi	sp,sp,-64
#endif
  sw x1,   0*4(sp)
f9001fb8:	00112023          	sw	ra,0(sp)
  sw x5,   1*4(sp)
f9001fbc:	00512223          	sw	t0,4(sp)
  sw x6,   2*4(sp)
f9001fc0:	00612423          	sw	t1,8(sp)
  sw x7,   3*4(sp)
f9001fc4:	00712623          	sw	t2,12(sp)
  sw x10,  4*4(sp)
f9001fc8:	00a12823          	sw	a0,16(sp)
  sw x11,  5*4(sp)
f9001fcc:	00b12a23          	sw	a1,20(sp)
  sw x12,  6*4(sp)
f9001fd0:	00c12c23          	sw	a2,24(sp)
  sw x13,  7*4(sp)
f9001fd4:	00d12e23          	sw	a3,28(sp)
  sw x14,  8*4(sp)
f9001fd8:	02e12023          	sw	a4,32(sp)
  sw x15,  9*4(sp)
f9001fdc:	02f12223          	sw	a5,36(sp)
  sw x16, 10*4(sp)
f9001fe0:	03012423          	sw	a6,40(sp)
  sw x17, 11*4(sp)
f9001fe4:	03112623          	sw	a7,44(sp)
  sw x28, 12*4(sp)
f9001fe8:	03c12823          	sw	t3,48(sp)
  sw x29, 13*4(sp)
f9001fec:	03d12a23          	sw	t4,52(sp)
  sw x30, 14*4(sp)
f9001ff0:	03e12c23          	sw	t5,56(sp)
  sw x31, 15*4(sp)
f9001ff4:	03f12e23          	sw	t6,60(sp)
  FSTORE f30, 64 + 18*FPR_SIZE(sp)
  FSTORE f31, 64 + 19*FPR_SIZE(sp)
  csrr t0, fcsr
  sw t0, 64 + 20*FPR_SIZE(sp)
#endif
  call trap
f9001ff8:	a40ff0ef          	jal	f9001238 <trap>
  FLOAD f28, 64 + 16*FPR_SIZE(sp)
  FLOAD f29, 64 + 17*FPR_SIZE(sp)
  FLOAD f30, 64 + 18*FPR_SIZE(sp)
  FLOAD f31, 64 + 19*FPR_SIZE(sp)
#endif
  lw x1 ,  0*4(sp)
f9001ffc:	00012083          	lw	ra,0(sp)
  lw x5,   1*4(sp)
f9002000:	00412283          	lw	t0,4(sp)
  lw x6,   2*4(sp)
f9002004:	00812303          	lw	t1,8(sp)
  lw x7,   3*4(sp)
f9002008:	00c12383          	lw	t2,12(sp)
  lw x10,  4*4(sp)
f900200c:	01012503          	lw	a0,16(sp)
  lw x11,  5*4(sp)
f9002010:	01412583          	lw	a1,20(sp)
  lw x12,  6*4(sp)
f9002014:	01812603          	lw	a2,24(sp)
  lw x13,  7*4(sp)
f9002018:	01c12683          	lw	a3,28(sp)
  lw x14,  8*4(sp)
f900201c:	02012703          	lw	a4,32(sp)
  lw x15,  9*4(sp)
f9002020:	02412783          	lw	a5,36(sp)
  lw x16, 10*4(sp)
f9002024:	02812803          	lw	a6,40(sp)
  lw x17, 11*4(sp)
f9002028:	02c12883          	lw	a7,44(sp)
  lw x28, 12*4(sp)
f900202c:	03012e03          	lw	t3,48(sp)
  lw x29, 13*4(sp)
f9002030:	03412e83          	lw	t4,52(sp)
  lw x30, 14*4(sp)
f9002034:	03812f03          	lw	t5,56(sp)
  lw x31, 15*4(sp)
f9002038:	03c12f83          	lw	t6,60(sp)
#ifdef __riscv_flen
  addi sp, sp, STACK_SIZE
#else
  addi sp, sp, 64
f900203c:	04010113          	addi	sp,sp,64
#endif
f9002040:	30200073          	mret

f9002044 <__adddf3>:
f9002044:	001007b7          	lui	a5,0x100
f9002048:	fe010113          	addi	sp,sp,-32
f900204c:	fff78e93          	addi	t4,a5,-1 # fffff <__stack_size+0xfefff>
f9002050:	00bef833          	and	a6,t4,a1
f9002054:	00def7b3          	and	a5,t4,a3
f9002058:	0146d313          	srli	t1,a3,0x14
f900205c:	01212823          	sw	s2,16(sp)
f9002060:	0145d913          	srli	s2,a1,0x14
f9002064:	00379793          	slli	a5,a5,0x3
f9002068:	00812c23          	sw	s0,24(sp)
f900206c:	00381813          	slli	a6,a6,0x3
f9002070:	01f5d413          	srli	s0,a1,0x1f
f9002074:	01d55713          	srli	a4,a0,0x1d
f9002078:	01d65893          	srli	a7,a2,0x1d
f900207c:	7ff97913          	andi	s2,s2,2047
f9002080:	7ff37313          	andi	t1,t1,2047
f9002084:	00112e23          	sw	ra,28(sp)
f9002088:	00912a23          	sw	s1,20(sp)
f900208c:	01312623          	sw	s3,12(sp)
f9002090:	01f6d693          	srli	a3,a3,0x1f
f9002094:	00f8e8b3          	or	a7,a7,a5
f9002098:	01076733          	or	a4,a4,a6
f900209c:	00351593          	slli	a1,a0,0x3
f90020a0:	00361f13          	slli	t5,a2,0x3
f90020a4:	406907b3          	sub	a5,s2,t1
f90020a8:	1ed40463          	beq	s0,a3,f9002290 <__adddf3+0x24c>
f90020ac:	16f05263          	blez	a5,f9002210 <__adddf3+0x1cc>
f90020b0:	28030663          	beqz	t1,f900233c <__adddf3+0x2f8>
f90020b4:	7ff00693          	li	a3,2047
f90020b8:	42d90663          	beq	s2,a3,f90024e4 <__adddf3+0x4a0>
f90020bc:	03800693          	li	a3,56
f90020c0:	00100613          	li	a2,1
f90020c4:	02f6ce63          	blt	a3,a5,f9002100 <__adddf3+0xbc>
f90020c8:	008006b7          	lui	a3,0x800
f90020cc:	00d8e8b3          	or	a7,a7,a3
f90020d0:	01f00693          	li	a3,31
f90020d4:	52f6ce63          	blt	a3,a5,f9002610 <__adddf3+0x5cc>
f90020d8:	02000693          	li	a3,32
f90020dc:	40f686b3          	sub	a3,a3,a5
f90020e0:	00d89633          	sll	a2,a7,a3
f90020e4:	00ff5533          	srl	a0,t5,a5
f90020e8:	00df16b3          	sll	a3,t5,a3
f90020ec:	00a66633          	or	a2,a2,a0
f90020f0:	00d036b3          	snez	a3,a3
f90020f4:	00f8d8b3          	srl	a7,a7,a5
f90020f8:	00d66633          	or	a2,a2,a3
f90020fc:	41170733          	sub	a4,a4,a7
f9002100:	40c58633          	sub	a2,a1,a2
f9002104:	00c5b5b3          	sltu	a1,a1,a2
f9002108:	00060493          	mv	s1,a2
f900210c:	40b709b3          	sub	s3,a4,a1
f9002110:	00899793          	slli	a5,s3,0x8
f9002114:	3207da63          	bgez	a5,f9002448 <__adddf3+0x404>
f9002118:	008007b7          	lui	a5,0x800
f900211c:	fff78793          	addi	a5,a5,-1 # 7fffff <__stack_size+0x7fefff>
f9002120:	00f9f9b3          	and	s3,s3,a5
f9002124:	2c098863          	beqz	s3,f90023f4 <__adddf3+0x3b0>
f9002128:	00098513          	mv	a0,s3
f900212c:	0dc020ef          	jal	f9004208 <__clzsi2>
f9002130:	ff850793          	addi	a5,a0,-8
f9002134:	02000693          	li	a3,32
f9002138:	40f68733          	sub	a4,a3,a5
f900213c:	00e4d733          	srl	a4,s1,a4
f9002140:	00f999b3          	sll	s3,s3,a5
f9002144:	01376733          	or	a4,a4,s3
f9002148:	00f494b3          	sll	s1,s1,a5
f900214c:	4b27c863          	blt	a5,s2,f90025fc <__adddf3+0x5b8>
f9002150:	412787b3          	sub	a5,a5,s2
f9002154:	00178793          	addi	a5,a5,1
f9002158:	40f686b3          	sub	a3,a3,a5
f900215c:	00d49633          	sll	a2,s1,a3
f9002160:	00f4d9b3          	srl	s3,s1,a5
f9002164:	00c03633          	snez	a2,a2
f9002168:	01366633          	or	a2,a2,s3
f900216c:	00d716b3          	sll	a3,a4,a3
f9002170:	00c6e4b3          	or	s1,a3,a2
f9002174:	00f759b3          	srl	s3,a4,a5
f9002178:	00000913          	li	s2,0
f900217c:	0074f793          	andi	a5,s1,7
f9002180:	02078063          	beqz	a5,f90021a0 <__adddf3+0x15c>
f9002184:	00f4f793          	andi	a5,s1,15
f9002188:	00400713          	li	a4,4
f900218c:	00e78a63          	beq	a5,a4,f90021a0 <__adddf3+0x15c>
f9002190:	00448793          	addi	a5,s1,4
f9002194:	0097b633          	sltu	a2,a5,s1
f9002198:	00c989b3          	add	s3,s3,a2
f900219c:	00078493          	mv	s1,a5
f90021a0:	00899793          	slli	a5,s3,0x8
f90021a4:	6e07da63          	bgez	a5,f9002898 <__adddf3+0x854>
f90021a8:	00190793          	addi	a5,s2,1
f90021ac:	7ff00713          	li	a4,2047
f90021b0:	00040e13          	mv	t3,s0
f90021b4:	2ae78663          	beq	a5,a4,f9002460 <__adddf3+0x41c>
f90021b8:	ff800737          	lui	a4,0xff800
f90021bc:	fff70713          	addi	a4,a4,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa19f>
f90021c0:	00e9f733          	and	a4,s3,a4
f90021c4:	7ff7f793          	andi	a5,a5,2047
f90021c8:	01d71813          	slli	a6,a4,0x1d
f90021cc:	0034d613          	srli	a2,s1,0x3
f90021d0:	00971713          	slli	a4,a4,0x9
f90021d4:	00c86833          	or	a6,a6,a2
f90021d8:	00c75713          	srli	a4,a4,0xc
f90021dc:	01c12083          	lw	ra,28(sp)
f90021e0:	01812403          	lw	s0,24(sp)
f90021e4:	01479793          	slli	a5,a5,0x14
f90021e8:	00e7e7b3          	or	a5,a5,a4
f90021ec:	01fe1713          	slli	a4,t3,0x1f
f90021f0:	00e7e7b3          	or	a5,a5,a4
f90021f4:	01412483          	lw	s1,20(sp)
f90021f8:	01012903          	lw	s2,16(sp)
f90021fc:	00c12983          	lw	s3,12(sp)
f9002200:	00080513          	mv	a0,a6
f9002204:	00078593          	mv	a1,a5
f9002208:	02010113          	addi	sp,sp,32
f900220c:	00008067          	ret
f9002210:	14078c63          	beqz	a5,f9002368 <__adddf3+0x324>
f9002214:	412307b3          	sub	a5,t1,s2
f9002218:	3c091263          	bnez	s2,f90025dc <__adddf3+0x598>
f900221c:	00b76533          	or	a0,a4,a1
f9002220:	4c050463          	beqz	a0,f90026e8 <__adddf3+0x6a4>
f9002224:	fff78513          	addi	a0,a5,-1
f9002228:	60050263          	beqz	a0,f900282c <__adddf3+0x7e8>
f900222c:	7ff00813          	li	a6,2047
f9002230:	57078663          	beq	a5,a6,f900279c <__adddf3+0x758>
f9002234:	03800793          	li	a5,56
f9002238:	00100613          	li	a2,1
f900223c:	02a7cc63          	blt	a5,a0,f9002274 <__adddf3+0x230>
f9002240:	00050793          	mv	a5,a0
f9002244:	01f00613          	li	a2,31
f9002248:	56f64c63          	blt	a2,a5,f90027c0 <__adddf3+0x77c>
f900224c:	02000513          	li	a0,32
f9002250:	40f50533          	sub	a0,a0,a5
f9002254:	00a71633          	sll	a2,a4,a0
f9002258:	00f5d833          	srl	a6,a1,a5
f900225c:	00a59533          	sll	a0,a1,a0
f9002260:	01066633          	or	a2,a2,a6
f9002264:	00a03533          	snez	a0,a0
f9002268:	00f75733          	srl	a4,a4,a5
f900226c:	00a66633          	or	a2,a2,a0
f9002270:	40e888b3          	sub	a7,a7,a4
f9002274:	40cf0633          	sub	a2,t5,a2
f9002278:	00cf3733          	sltu	a4,t5,a2
f900227c:	00060493          	mv	s1,a2
f9002280:	40e889b3          	sub	s3,a7,a4
f9002284:	00030913          	mv	s2,t1
f9002288:	00068413          	mv	s0,a3
f900228c:	e85ff06f          	j	f9002110 <__adddf3+0xcc>
f9002290:	1ef05063          	blez	a5,f9002470 <__adddf3+0x42c>
f9002294:	14031063          	bnez	t1,f90023d4 <__adddf3+0x390>
f9002298:	01e8e6b3          	or	a3,a7,t5
f900229c:	26068c63          	beqz	a3,f9002514 <__adddf3+0x4d0>
f90022a0:	fff78693          	addi	a3,a5,-1
f90022a4:	48068063          	beqz	a3,f9002724 <__adddf3+0x6e0>
f90022a8:	7ff00613          	li	a2,2047
f90022ac:	22c78c63          	beq	a5,a2,f90024e4 <__adddf3+0x4a0>
f90022b0:	03800793          	li	a5,56
f90022b4:	00100993          	li	s3,1
f90022b8:	02d7cc63          	blt	a5,a3,f90022f0 <__adddf3+0x2ac>
f90022bc:	00068793          	mv	a5,a3
f90022c0:	01f00693          	li	a3,31
f90022c4:	4af6c063          	blt	a3,a5,f9002764 <__adddf3+0x720>
f90022c8:	02000693          	li	a3,32
f90022cc:	40f686b3          	sub	a3,a3,a5
f90022d0:	00d899b3          	sll	s3,a7,a3
f90022d4:	00ff5633          	srl	a2,t5,a5
f90022d8:	00df16b3          	sll	a3,t5,a3
f90022dc:	00c9e9b3          	or	s3,s3,a2
f90022e0:	00d036b3          	snez	a3,a3
f90022e4:	00f8d8b3          	srl	a7,a7,a5
f90022e8:	00d9e9b3          	or	s3,s3,a3
f90022ec:	01170733          	add	a4,a4,a7
f90022f0:	00b985b3          	add	a1,s3,a1
f90022f4:	0135b9b3          	sltu	s3,a1,s3
f90022f8:	00058493          	mv	s1,a1
f90022fc:	00e989b3          	add	s3,s3,a4
f9002300:	00899793          	slli	a5,s3,0x8
f9002304:	1407d263          	bgez	a5,f9002448 <__adddf3+0x404>
f9002308:	00190913          	addi	s2,s2,1
f900230c:	7ff00793          	li	a5,2047
f9002310:	36f90c63          	beq	s2,a5,f9002688 <__adddf3+0x644>
f9002314:	ff8007b7          	lui	a5,0xff800
f9002318:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa19f>
f900231c:	0014f613          	andi	a2,s1,1
f9002320:	00f9f7b3          	and	a5,s3,a5
f9002324:	0014d713          	srli	a4,s1,0x1
f9002328:	00c76733          	or	a4,a4,a2
f900232c:	01f79613          	slli	a2,a5,0x1f
f9002330:	00e664b3          	or	s1,a2,a4
f9002334:	0017d993          	srli	s3,a5,0x1
f9002338:	e45ff06f          	j	f900217c <__adddf3+0x138>
f900233c:	01e8e6b3          	or	a3,a7,t5
f9002340:	1c068a63          	beqz	a3,f9002514 <__adddf3+0x4d0>
f9002344:	fff78693          	addi	a3,a5,-1
f9002348:	40068063          	beqz	a3,f9002748 <__adddf3+0x704>
f900234c:	7ff00613          	li	a2,2047
f9002350:	18c78a63          	beq	a5,a2,f90024e4 <__adddf3+0x4a0>
f9002354:	03800793          	li	a5,56
f9002358:	00100613          	li	a2,1
f900235c:	dad7c2e3          	blt	a5,a3,f9002100 <__adddf3+0xbc>
f9002360:	00068793          	mv	a5,a3
f9002364:	d6dff06f          	j	f90020d0 <__adddf3+0x8c>
f9002368:	00190813          	addi	a6,s2,1
f900236c:	7fe87813          	andi	a6,a6,2046
f9002370:	22081c63          	bnez	a6,f90025a8 <__adddf3+0x564>
f9002374:	00b76333          	or	t1,a4,a1
f9002378:	01e8e833          	or	a6,a7,t5
f900237c:	38091063          	bnez	s2,f90026fc <__adddf3+0x6b8>
f9002380:	46030e63          	beqz	t1,f90027fc <__adddf3+0x7b8>
f9002384:	40080663          	beqz	a6,f9002790 <__adddf3+0x74c>
f9002388:	41e589b3          	sub	s3,a1,t5
f900238c:	0135b533          	sltu	a0,a1,s3
f9002390:	41170633          	sub	a2,a4,a7
f9002394:	40a60633          	sub	a2,a2,a0
f9002398:	00861513          	slli	a0,a2,0x8
f900239c:	50055e63          	bgez	a0,f90028b8 <__adddf3+0x874>
f90023a0:	40bf05b3          	sub	a1,t5,a1
f90023a4:	40e88733          	sub	a4,a7,a4
f90023a8:	00bf3f33          	sltu	t5,t5,a1
f90023ac:	41e70733          	sub	a4,a4,t5
f90023b0:	00871613          	slli	a2,a4,0x8
f90023b4:	00058493          	mv	s1,a1
f90023b8:	52065e63          	bgez	a2,f90028f4 <__adddf3+0x8b0>
f90023bc:	ff8007b7          	lui	a5,0xff800
f90023c0:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa19f>
f90023c4:	00f77733          	and	a4,a4,a5
f90023c8:	00068e13          	mv	t3,a3
f90023cc:	00100793          	li	a5,1
f90023d0:	df9ff06f          	j	f90021c8 <__adddf3+0x184>
f90023d4:	7ff00693          	li	a3,2047
f90023d8:	10d90663          	beq	s2,a3,f90024e4 <__adddf3+0x4a0>
f90023dc:	03800693          	li	a3,56
f90023e0:	00100993          	li	s3,1
f90023e4:	f0f6c6e3          	blt	a3,a5,f90022f0 <__adddf3+0x2ac>
f90023e8:	008006b7          	lui	a3,0x800
f90023ec:	00d8e8b3          	or	a7,a7,a3
f90023f0:	ed1ff06f          	j	f90022c0 <__adddf3+0x27c>
f90023f4:	00048513          	mv	a0,s1
f90023f8:	611010ef          	jal	f9004208 <__clzsi2>
f90023fc:	01850793          	addi	a5,a0,24
f9002400:	01f00693          	li	a3,31
f9002404:	d2f6d8e3          	bge	a3,a5,f9002134 <__adddf3+0xf0>
f9002408:	ff850713          	addi	a4,a0,-8
f900240c:	00e49733          	sll	a4,s1,a4
f9002410:	2327c663          	blt	a5,s2,f900263c <__adddf3+0x5f8>
f9002414:	41278933          	sub	s2,a5,s2
f9002418:	00190793          	addi	a5,s2,1
f900241c:	48f6d663          	bge	a3,a5,f90028a8 <__adddf3+0x864>
f9002420:	fe190913          	addi	s2,s2,-31
f9002424:	02000693          	li	a3,32
f9002428:	012754b3          	srl	s1,a4,s2
f900242c:	00d78c63          	beq	a5,a3,f9002444 <__adddf3+0x400>
f9002430:	04000693          	li	a3,64
f9002434:	40f687b3          	sub	a5,a3,a5
f9002438:	00f71733          	sll	a4,a4,a5
f900243c:	00e03733          	snez	a4,a4
f9002440:	00e4e4b3          	or	s1,s1,a4
f9002444:	00000913          	li	s2,0
f9002448:	0074f793          	andi	a5,s1,7
f900244c:	d2079ce3          	bnez	a5,f9002184 <__adddf3+0x140>
f9002450:	00090793          	mv	a5,s2
f9002454:	0034d613          	srli	a2,s1,0x3
f9002458:	00098713          	mv	a4,s3
f900245c:	0c00006f          	j	f900251c <__adddf3+0x4d8>
f9002460:	7ff00793          	li	a5,2047
f9002464:	00000713          	li	a4,0
f9002468:	00000813          	li	a6,0
f900246c:	d71ff06f          	j	f90021dc <__adddf3+0x198>
f9002470:	0c078a63          	beqz	a5,f9002544 <__adddf3+0x500>
f9002474:	412307b3          	sub	a5,t1,s2
f9002478:	1e090263          	beqz	s2,f900265c <__adddf3+0x618>
f900247c:	7ff00693          	li	a3,2047
f9002480:	32d30863          	beq	t1,a3,f90027b0 <__adddf3+0x76c>
f9002484:	03800693          	li	a3,56
f9002488:	00100993          	li	s3,1
f900248c:	02f6ce63          	blt	a3,a5,f90024c8 <__adddf3+0x484>
f9002490:	008006b7          	lui	a3,0x800
f9002494:	00d76733          	or	a4,a4,a3
f9002498:	01f00693          	li	a3,31
f900249c:	3cf6c863          	blt	a3,a5,f900286c <__adddf3+0x828>
f90024a0:	02000693          	li	a3,32
f90024a4:	40f686b3          	sub	a3,a3,a5
f90024a8:	00d719b3          	sll	s3,a4,a3
f90024ac:	00f5d633          	srl	a2,a1,a5
f90024b0:	00d596b3          	sll	a3,a1,a3
f90024b4:	00c9e9b3          	or	s3,s3,a2
f90024b8:	00d036b3          	snez	a3,a3
f90024bc:	00f75733          	srl	a4,a4,a5
f90024c0:	00d9e9b3          	or	s3,s3,a3
f90024c4:	00e888b3          	add	a7,a7,a4
f90024c8:	01e98733          	add	a4,s3,t5
f90024cc:	013739b3          	sltu	s3,a4,s3
f90024d0:	00070493          	mv	s1,a4
f90024d4:	011989b3          	add	s3,s3,a7
f90024d8:	00030913          	mv	s2,t1
f90024dc:	e25ff06f          	j	f9002300 <__adddf3+0x2bc>
f90024e0:	02081063          	bnez	a6,f9002500 <__adddf3+0x4bc>
f90024e4:	00351613          	slli	a2,a0,0x3
f90024e8:	00365613          	srli	a2,a2,0x3
f90024ec:	01d71813          	slli	a6,a4,0x1d
f90024f0:	00c86833          	or	a6,a6,a2
f90024f4:	00375713          	srli	a4,a4,0x3
f90024f8:	01076733          	or	a4,a4,a6
f90024fc:	18070663          	beqz	a4,f9002688 <__adddf3+0x644>
f9002500:	00000e13          	li	t3,0
f9002504:	7ff00793          	li	a5,2047
f9002508:	00080737          	lui	a4,0x80
f900250c:	00000813          	li	a6,0
f9002510:	ccdff06f          	j	f90021dc <__adddf3+0x198>
f9002514:	00351613          	slli	a2,a0,0x3
f9002518:	00365613          	srli	a2,a2,0x3
f900251c:	01d71813          	slli	a6,a4,0x1d
f9002520:	7ff00693          	li	a3,2047
f9002524:	00c86833          	or	a6,a6,a2
f9002528:	00375713          	srli	a4,a4,0x3
f900252c:	fcd786e3          	beq	a5,a3,f90024f8 <__adddf3+0x4b4>
f9002530:	00c71713          	slli	a4,a4,0xc
f9002534:	00c75713          	srli	a4,a4,0xc
f9002538:	7ff7f793          	andi	a5,a5,2047
f900253c:	00040e13          	mv	t3,s0
f9002540:	c9dff06f          	j	f90021dc <__adddf3+0x198>
f9002544:	00190693          	addi	a3,s2,1
f9002548:	7fe6f813          	andi	a6,a3,2046
f900254c:	14081863          	bnez	a6,f900269c <__adddf3+0x658>
f9002550:	00b766b3          	or	a3,a4,a1
f9002554:	28091c63          	bnez	s2,f90027ec <__adddf3+0x7a8>
f9002558:	30068263          	beqz	a3,f900285c <__adddf3+0x818>
f900255c:	01e8e6b3          	or	a3,a7,t5
f9002560:	22068863          	beqz	a3,f9002790 <__adddf3+0x74c>
f9002564:	01e587b3          	add	a5,a1,t5
f9002568:	00b7b5b3          	sltu	a1,a5,a1
f900256c:	01170733          	add	a4,a4,a7
f9002570:	00b70733          	add	a4,a4,a1
f9002574:	0037d813          	srli	a6,a5,0x3
f9002578:	00871793          	slli	a5,a4,0x8
f900257c:	00040e13          	mv	t3,s0
f9002580:	3407de63          	bgez	a5,f90028dc <__adddf3+0x898>
f9002584:	ff8007b7          	lui	a5,0xff800
f9002588:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa19f>
f900258c:	00f77733          	and	a4,a4,a5
f9002590:	01d71793          	slli	a5,a4,0x1d
f9002594:	00375713          	srli	a4,a4,0x3
f9002598:	0107e833          	or	a6,a5,a6
f900259c:	01d77733          	and	a4,a4,t4
f90025a0:	00100793          	li	a5,1
f90025a4:	c39ff06f          	j	f90021dc <__adddf3+0x198>
f90025a8:	41e58833          	sub	a6,a1,t5
f90025ac:	0105b7b3          	sltu	a5,a1,a6
f90025b0:	411709b3          	sub	s3,a4,a7
f90025b4:	40f989b3          	sub	s3,s3,a5
f90025b8:	00899793          	slli	a5,s3,0x8
f90025bc:	00080493          	mv	s1,a6
f90025c0:	1007c663          	bltz	a5,f90026cc <__adddf3+0x688>
f90025c4:	01386833          	or	a6,a6,s3
f90025c8:	b4081ee3          	bnez	a6,f9002124 <__adddf3+0xe0>
f90025cc:	00000e13          	li	t3,0
f90025d0:	00000793          	li	a5,0
f90025d4:	00000713          	li	a4,0
f90025d8:	c05ff06f          	j	f90021dc <__adddf3+0x198>
f90025dc:	7ff00513          	li	a0,2047
f90025e0:	1aa30e63          	beq	t1,a0,f900279c <__adddf3+0x758>
f90025e4:	03800513          	li	a0,56
f90025e8:	00100613          	li	a2,1
f90025ec:	c8f544e3          	blt	a0,a5,f9002274 <__adddf3+0x230>
f90025f0:	00800637          	lui	a2,0x800
f90025f4:	00c76733          	or	a4,a4,a2
f90025f8:	c4dff06f          	j	f9002244 <__adddf3+0x200>
f90025fc:	ff8009b7          	lui	s3,0xff800
f9002600:	fff98993          	addi	s3,s3,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa19f>
f9002604:	40f90933          	sub	s2,s2,a5
f9002608:	013779b3          	and	s3,a4,s3
f900260c:	b71ff06f          	j	f900217c <__adddf3+0x138>
f9002610:	fe078693          	addi	a3,a5,-32
f9002614:	02000613          	li	a2,32
f9002618:	00d8d6b3          	srl	a3,a7,a3
f900261c:	00c78a63          	beq	a5,a2,f9002630 <__adddf3+0x5ec>
f9002620:	04000613          	li	a2,64
f9002624:	40f607b3          	sub	a5,a2,a5
f9002628:	00f897b3          	sll	a5,a7,a5
f900262c:	00ff6f33          	or	t5,t5,a5
f9002630:	01e03633          	snez	a2,t5
f9002634:	00d66633          	or	a2,a2,a3
f9002638:	ac9ff06f          	j	f9002100 <__adddf3+0xbc>
f900263c:	ff8006b7          	lui	a3,0xff800
f9002640:	fff68693          	addi	a3,a3,-1 # ff7fffff <__freertos_irq_stack_top+0x67fa19f>
f9002644:	40f907b3          	sub	a5,s2,a5
f9002648:	00d77733          	and	a4,a4,a3
f900264c:	01d71813          	slli	a6,a4,0x1d
f9002650:	01386833          	or	a6,a6,s3
f9002654:	00375713          	srli	a4,a4,0x3
f9002658:	ed9ff06f          	j	f9002530 <__adddf3+0x4ec>
f900265c:	00b766b3          	or	a3,a4,a1
f9002660:	1e068663          	beqz	a3,f900284c <__adddf3+0x808>
f9002664:	fff78693          	addi	a3,a5,-1
f9002668:	0a068e63          	beqz	a3,f9002724 <__adddf3+0x6e0>
f900266c:	7ff00513          	li	a0,2047
f9002670:	14a78063          	beq	a5,a0,f90027b0 <__adddf3+0x76c>
f9002674:	03800793          	li	a5,56
f9002678:	00100993          	li	s3,1
f900267c:	e4d7c6e3          	blt	a5,a3,f90024c8 <__adddf3+0x484>
f9002680:	00068793          	mv	a5,a3
f9002684:	e15ff06f          	j	f9002498 <__adddf3+0x454>
f9002688:	00040e13          	mv	t3,s0
f900268c:	7ff00793          	li	a5,2047
f9002690:	00000713          	li	a4,0
f9002694:	00000813          	li	a6,0
f9002698:	b45ff06f          	j	f90021dc <__adddf3+0x198>
f900269c:	7ff00793          	li	a5,2047
f90026a0:	fef684e3          	beq	a3,a5,f9002688 <__adddf3+0x644>
f90026a4:	01e58f33          	add	t5,a1,t5
f90026a8:	00bf35b3          	sltu	a1,t5,a1
f90026ac:	011707b3          	add	a5,a4,a7
f90026b0:	00b787b3          	add	a5,a5,a1
f90026b4:	01f79613          	slli	a2,a5,0x1f
f90026b8:	001f5f13          	srli	t5,t5,0x1
f90026bc:	01e664b3          	or	s1,a2,t5
f90026c0:	0017d993          	srli	s3,a5,0x1
f90026c4:	00068913          	mv	s2,a3
f90026c8:	ab5ff06f          	j	f900217c <__adddf3+0x138>
f90026cc:	40bf0633          	sub	a2,t5,a1
f90026d0:	40e887b3          	sub	a5,a7,a4
f90026d4:	00cf3733          	sltu	a4,t5,a2
f90026d8:	00060493          	mv	s1,a2
f90026dc:	40e789b3          	sub	s3,a5,a4
f90026e0:	00068413          	mv	s0,a3
f90026e4:	a41ff06f          	j	f9002124 <__adddf3+0xe0>
f90026e8:	00361613          	slli	a2,a2,0x3
f90026ec:	00365613          	srli	a2,a2,0x3
f90026f0:	00068413          	mv	s0,a3
f90026f4:	00088713          	mv	a4,a7
f90026f8:	e25ff06f          	j	f900251c <__adddf3+0x4d8>
f90026fc:	de0312e3          	bnez	t1,f90024e0 <__adddf3+0x49c>
f9002700:	1c080663          	beqz	a6,f90028cc <__adddf3+0x888>
f9002704:	0038d713          	srli	a4,a7,0x3
f9002708:	00361613          	slli	a2,a2,0x3
f900270c:	01d89893          	slli	a7,a7,0x1d
f9002710:	01176733          	or	a4,a4,a7
f9002714:	00365613          	srli	a2,a2,0x3
f9002718:	00c76733          	or	a4,a4,a2
f900271c:	00068413          	mv	s0,a3
f9002720:	dddff06f          	j	f90024fc <__adddf3+0x4b8>
f9002724:	01e58f33          	add	t5,a1,t5
f9002728:	011708b3          	add	a7,a4,a7
f900272c:	00bf35b3          	sltu	a1,t5,a1
f9002730:	00b889b3          	add	s3,a7,a1
f9002734:	00899793          	slli	a5,s3,0x8
f9002738:	000f0493          	mv	s1,t5
f900273c:	0e07d463          	bgez	a5,f9002824 <__adddf3+0x7e0>
f9002740:	00200913          	li	s2,2
f9002744:	bd1ff06f          	j	f9002314 <__adddf3+0x2d0>
f9002748:	41e58f33          	sub	t5,a1,t5
f900274c:	411708b3          	sub	a7,a4,a7
f9002750:	01e5b5b3          	sltu	a1,a1,t5
f9002754:	000f0493          	mv	s1,t5
f9002758:	40b889b3          	sub	s3,a7,a1
f900275c:	00100913          	li	s2,1
f9002760:	9b1ff06f          	j	f9002110 <__adddf3+0xcc>
f9002764:	fe078693          	addi	a3,a5,-32
f9002768:	02000613          	li	a2,32
f900276c:	00d8d6b3          	srl	a3,a7,a3
f9002770:	00c78a63          	beq	a5,a2,f9002784 <__adddf3+0x740>
f9002774:	04000613          	li	a2,64
f9002778:	40f607b3          	sub	a5,a2,a5
f900277c:	00f897b3          	sll	a5,a7,a5
f9002780:	00ff6f33          	or	t5,t5,a5
f9002784:	01e039b3          	snez	s3,t5
f9002788:	00d9e9b3          	or	s3,s3,a3
f900278c:	b65ff06f          	j	f90022f0 <__adddf3+0x2ac>
f9002790:	00351613          	slli	a2,a0,0x3
f9002794:	00365993          	srli	s3,a2,0x3
f9002798:	eb5ff06f          	j	f900264c <__adddf3+0x608>
f900279c:	00361613          	slli	a2,a2,0x3
f90027a0:	00365613          	srli	a2,a2,0x3
f90027a4:	00068413          	mv	s0,a3
f90027a8:	00088713          	mv	a4,a7
f90027ac:	d41ff06f          	j	f90024ec <__adddf3+0x4a8>
f90027b0:	00361613          	slli	a2,a2,0x3
f90027b4:	00365613          	srli	a2,a2,0x3
f90027b8:	00088713          	mv	a4,a7
f90027bc:	d31ff06f          	j	f90024ec <__adddf3+0x4a8>
f90027c0:	fe078513          	addi	a0,a5,-32
f90027c4:	02000613          	li	a2,32
f90027c8:	00a75533          	srl	a0,a4,a0
f90027cc:	00c78a63          	beq	a5,a2,f90027e0 <__adddf3+0x79c>
f90027d0:	04000613          	li	a2,64
f90027d4:	40f607b3          	sub	a5,a2,a5
f90027d8:	00f717b3          	sll	a5,a4,a5
f90027dc:	00f5e5b3          	or	a1,a1,a5
f90027e0:	00b03633          	snez	a2,a1
f90027e4:	00a66633          	or	a2,a2,a0
f90027e8:	a8dff06f          	j	f9002274 <__adddf3+0x230>
f90027ec:	fc0682e3          	beqz	a3,f90027b0 <__adddf3+0x76c>
f90027f0:	01e8ef33          	or	t5,a7,t5
f90027f4:	d00f16e3          	bnez	t5,f9002500 <__adddf3+0x4bc>
f90027f8:	cedff06f          	j	f90024e4 <__adddf3+0x4a0>
f90027fc:	dc0808e3          	beqz	a6,f90025cc <__adddf3+0x588>
f9002800:	00361813          	slli	a6,a2,0x3
f9002804:	01d89793          	slli	a5,a7,0x1d
f9002808:	00385813          	srli	a6,a6,0x3
f900280c:	0038d713          	srli	a4,a7,0x3
f9002810:	00f86833          	or	a6,a6,a5
f9002814:	01d77733          	and	a4,a4,t4
f9002818:	00068e13          	mv	t3,a3
f900281c:	00000793          	li	a5,0
f9002820:	9bdff06f          	j	f90021dc <__adddf3+0x198>
f9002824:	00100793          	li	a5,1
f9002828:	c2dff06f          	j	f9002454 <__adddf3+0x410>
f900282c:	40bf05b3          	sub	a1,t5,a1
f9002830:	40e888b3          	sub	a7,a7,a4
f9002834:	00bf3733          	sltu	a4,t5,a1
f9002838:	00058493          	mv	s1,a1
f900283c:	40e889b3          	sub	s3,a7,a4
f9002840:	00068413          	mv	s0,a3
f9002844:	00100913          	li	s2,1
f9002848:	8c9ff06f          	j	f9002110 <__adddf3+0xcc>
f900284c:	00361613          	slli	a2,a2,0x3
f9002850:	00365613          	srli	a2,a2,0x3
f9002854:	00088713          	mv	a4,a7
f9002858:	cc5ff06f          	j	f900251c <__adddf3+0x4d8>
f900285c:	00361613          	slli	a2,a2,0x3
f9002860:	00365993          	srli	s3,a2,0x3
f9002864:	00088713          	mv	a4,a7
f9002868:	de5ff06f          	j	f900264c <__adddf3+0x608>
f900286c:	fe078693          	addi	a3,a5,-32
f9002870:	02000613          	li	a2,32
f9002874:	00d756b3          	srl	a3,a4,a3
f9002878:	00c78a63          	beq	a5,a2,f900288c <__adddf3+0x848>
f900287c:	04000613          	li	a2,64
f9002880:	40f607b3          	sub	a5,a2,a5
f9002884:	00f717b3          	sll	a5,a4,a5
f9002888:	00f5e5b3          	or	a1,a1,a5
f900288c:	00b039b3          	snez	s3,a1
f9002890:	00d9e9b3          	or	s3,s3,a3
f9002894:	c35ff06f          	j	f90024c8 <__adddf3+0x484>
f9002898:	0034d613          	srli	a2,s1,0x3
f900289c:	00090793          	mv	a5,s2
f90028a0:	00098713          	mv	a4,s3
f90028a4:	c79ff06f          	j	f900251c <__adddf3+0x4d8>
f90028a8:	02000693          	li	a3,32
f90028ac:	40f686b3          	sub	a3,a3,a5
f90028b0:	00000613          	li	a2,0
f90028b4:	8b5ff06f          	j	f9002168 <__adddf3+0x124>
f90028b8:	00c9e833          	or	a6,s3,a2
f90028bc:	d00808e3          	beqz	a6,f90025cc <__adddf3+0x588>
f90028c0:	0039d993          	srli	s3,s3,0x3
f90028c4:	00060713          	mv	a4,a2
f90028c8:	d85ff06f          	j	f900264c <__adddf3+0x608>
f90028cc:	00000e13          	li	t3,0
f90028d0:	7ff00793          	li	a5,2047
f90028d4:	00080737          	lui	a4,0x80
f90028d8:	905ff06f          	j	f90021dc <__adddf3+0x198>
f90028dc:	01d71793          	slli	a5,a4,0x1d
f90028e0:	00375713          	srli	a4,a4,0x3
f90028e4:	0107e833          	or	a6,a5,a6
f90028e8:	01d77733          	and	a4,a4,t4
f90028ec:	00000793          	li	a5,0
f90028f0:	8edff06f          	j	f90021dc <__adddf3+0x198>
f90028f4:	01d71813          	slli	a6,a4,0x1d
f90028f8:	0035d593          	srli	a1,a1,0x3
f90028fc:	00b86833          	or	a6,a6,a1
f9002900:	00375713          	srli	a4,a4,0x3
f9002904:	00068413          	mv	s0,a3
f9002908:	c29ff06f          	j	f9002530 <__adddf3+0x4ec>

f900290c <__muldf3>:
f900290c:	fd010113          	addi	sp,sp,-48
f9002910:	0145d793          	srli	a5,a1,0x14
f9002914:	02812423          	sw	s0,40(sp)
f9002918:	02912223          	sw	s1,36(sp)
f900291c:	03212023          	sw	s2,32(sp)
f9002920:	01312e23          	sw	s3,28(sp)
f9002924:	01512a23          	sw	s5,20(sp)
f9002928:	00c59493          	slli	s1,a1,0xc
f900292c:	02112623          	sw	ra,44(sp)
f9002930:	01412c23          	sw	s4,24(sp)
f9002934:	01612823          	sw	s6,16(sp)
f9002938:	01712623          	sw	s7,12(sp)
f900293c:	01812423          	sw	s8,8(sp)
f9002940:	7ff7f793          	andi	a5,a5,2047
f9002944:	00050413          	mv	s0,a0
f9002948:	00060a93          	mv	s5,a2
f900294c:	00068993          	mv	s3,a3
f9002950:	00c4d493          	srli	s1,s1,0xc
f9002954:	01f5d913          	srli	s2,a1,0x1f
f9002958:	42078463          	beqz	a5,f9002d80 <__muldf3+0x474>
f900295c:	7ff00713          	li	a4,2047
f9002960:	0ae78663          	beq	a5,a4,f9002a0c <__muldf3+0x100>
f9002964:	00349693          	slli	a3,s1,0x3
f9002968:	01d55713          	srli	a4,a0,0x1d
f900296c:	00d76733          	or	a4,a4,a3
f9002970:	008006b7          	lui	a3,0x800
f9002974:	00d764b3          	or	s1,a4,a3
f9002978:	00351a13          	slli	s4,a0,0x3
f900297c:	c0178c13          	addi	s8,a5,-1023
f9002980:	00000b13          	li	s6,0
f9002984:	00000b93          	li	s7,0
f9002988:	0149d793          	srli	a5,s3,0x14
f900298c:	00c99713          	slli	a4,s3,0xc
f9002990:	7ff7f793          	andi	a5,a5,2047
f9002994:	000a8f13          	mv	t5,s5
f9002998:	00c75413          	srli	s0,a4,0xc
f900299c:	01f9d993          	srli	s3,s3,0x1f
f90029a0:	0a078063          	beqz	a5,f9002a40 <__muldf3+0x134>
f90029a4:	7ff00713          	li	a4,2047
f90029a8:	14e78e63          	beq	a5,a4,f9002b04 <__muldf3+0x1f8>
f90029ac:	00341713          	slli	a4,s0,0x3
f90029b0:	01dad593          	srli	a1,s5,0x1d
f90029b4:	00e5e5b3          	or	a1,a1,a4
f90029b8:	c0178793          	addi	a5,a5,-1023
f90029bc:	00800737          	lui	a4,0x800
f90029c0:	00e5e433          	or	s0,a1,a4
f90029c4:	003a9f13          	slli	t5,s5,0x3
f90029c8:	018788b3          	add	a7,a5,s8
f90029cc:	00000313          	li	t1,0
f90029d0:	00a00713          	li	a4,10
f90029d4:	00188513          	addi	a0,a7,1
f90029d8:	0b674c63          	blt	a4,s6,f9002a90 <__muldf3+0x184>
f90029dc:	013945b3          	xor	a1,s2,s3
f90029e0:	00200793          	li	a5,2
f90029e4:	00058813          	mv	a6,a1
f90029e8:	1567c663          	blt	a5,s6,f9002b34 <__muldf3+0x228>
f90029ec:	fffb0b13          	addi	s6,s6,-1
f90029f0:	00100713          	li	a4,1
f90029f4:	17676063          	bltu	a4,s6,f9002b54 <__muldf3+0x248>
f90029f8:	3cf30a63          	beq	t1,a5,f9002dcc <__muldf3+0x4c0>
f90029fc:	00040493          	mv	s1,s0
f9002a00:	000f0a13          	mv	s4,t5
f9002a04:	00030b93          	mv	s7,t1
f9002a08:	09c0006f          	j	f9002aa4 <__muldf3+0x198>
f9002a0c:	00a4ea33          	or	s4,s1,a0
f9002a10:	3c0a1863          	bnez	s4,f9002de0 <__muldf3+0x4d4>
f9002a14:	0149d793          	srli	a5,s3,0x14
f9002a18:	00c99713          	slli	a4,s3,0xc
f9002a1c:	7ff7f793          	andi	a5,a5,2047
f9002a20:	00000493          	li	s1,0
f9002a24:	00800b13          	li	s6,8
f9002a28:	7ff00c13          	li	s8,2047
f9002a2c:	00200b93          	li	s7,2
f9002a30:	000a8f13          	mv	t5,s5
f9002a34:	00c75413          	srli	s0,a4,0xc
f9002a38:	01f9d993          	srli	s3,s3,0x1f
f9002a3c:	f60794e3          	bnez	a5,f90029a4 <__muldf3+0x98>
f9002a40:	015467b3          	or	a5,s0,s5
f9002a44:	3c078263          	beqz	a5,f9002e08 <__muldf3+0x4fc>
f9002a48:	4a040063          	beqz	s0,f9002ee8 <__muldf3+0x5dc>
f9002a4c:	00040513          	mv	a0,s0
f9002a50:	7b8010ef          	jal	f9004208 <__clzsi2>
f9002a54:	00050893          	mv	a7,a0
f9002a58:	ff550713          	addi	a4,a0,-11
f9002a5c:	01d00793          	li	a5,29
f9002a60:	ff888f13          	addi	t5,a7,-8
f9002a64:	40e787b3          	sub	a5,a5,a4
f9002a68:	00fad7b3          	srl	a5,s5,a5
f9002a6c:	01e41733          	sll	a4,s0,t5
f9002a70:	00e7e433          	or	s0,a5,a4
f9002a74:	01ea9f33          	sll	t5,s5,t5
f9002a78:	411c08b3          	sub	a7,s8,a7
f9002a7c:	c0d88893          	addi	a7,a7,-1011
f9002a80:	00a00713          	li	a4,10
f9002a84:	00000313          	li	t1,0
f9002a88:	00188513          	addi	a0,a7,1
f9002a8c:	f56758e3          	bge	a4,s6,f90029dc <__muldf3+0xd0>
f9002a90:	00090593          	mv	a1,s2
f9002a94:	00200793          	li	a5,2
f9002a98:	32fb8a63          	beq	s7,a5,f9002dcc <__muldf3+0x4c0>
f9002a9c:	00300793          	li	a5,3
f9002aa0:	48fb8c63          	beq	s7,a5,f9002f38 <__muldf3+0x62c>
f9002aa4:	00100793          	li	a5,1
f9002aa8:	00058813          	mv	a6,a1
f9002aac:	46fb9a63          	bne	s7,a5,f9002f20 <__muldf3+0x614>
f9002ab0:	00000793          	li	a5,0
f9002ab4:	00000693          	li	a3,0
f9002ab8:	00000713          	li	a4,0
f9002abc:	02c12083          	lw	ra,44(sp)
f9002ac0:	02812403          	lw	s0,40(sp)
f9002ac4:	01479793          	slli	a5,a5,0x14
f9002ac8:	00d7e7b3          	or	a5,a5,a3
f9002acc:	01f81693          	slli	a3,a6,0x1f
f9002ad0:	00d7e7b3          	or	a5,a5,a3
f9002ad4:	02412483          	lw	s1,36(sp)
f9002ad8:	02012903          	lw	s2,32(sp)
f9002adc:	01c12983          	lw	s3,28(sp)
f9002ae0:	01812a03          	lw	s4,24(sp)
f9002ae4:	01412a83          	lw	s5,20(sp)
f9002ae8:	01012b03          	lw	s6,16(sp)
f9002aec:	00c12b83          	lw	s7,12(sp)
f9002af0:	00812c03          	lw	s8,8(sp)
f9002af4:	00070513          	mv	a0,a4
f9002af8:	00078593          	mv	a1,a5
f9002afc:	03010113          	addi	sp,sp,48
f9002b00:	00008067          	ret
f9002b04:	01546733          	or	a4,s0,s5
f9002b08:	7ffc0893          	addi	a7,s8,2047
f9002b0c:	30070a63          	beqz	a4,f9002e20 <__muldf3+0x514>
f9002b10:	00001737          	lui	a4,0x1
f9002b14:	01394833          	xor	a6,s2,s3
f9002b18:	80070713          	addi	a4,a4,-2048 # 800 <CUSTOM2+0x7a5>
f9002b1c:	003b6b13          	ori	s6,s6,3
f9002b20:	00a00693          	li	a3,10
f9002b24:	00080593          	mv	a1,a6
f9002b28:	00ec0533          	add	a0,s8,a4
f9002b2c:	3966c063          	blt	a3,s6,f9002eac <__muldf3+0x5a0>
f9002b30:	00300313          	li	t1,3
f9002b34:	00100613          	li	a2,1
f9002b38:	01661633          	sll	a2,a2,s6
f9002b3c:	53067713          	andi	a4,a2,1328
f9002b40:	f4071ae3          	bnez	a4,f9002a94 <__muldf3+0x188>
f9002b44:	24067793          	andi	a5,a2,576
f9002b48:	3c079463          	bnez	a5,f9002f10 <__muldf3+0x604>
f9002b4c:	08867613          	andi	a2,a2,136
f9002b50:	2e061263          	bnez	a2,f9002e34 <__muldf3+0x528>
f9002b54:	00010fb7          	lui	t6,0x10
f9002b58:	ffff8e93          	addi	t4,t6,-1 # ffff <__stack_size+0xefff>
f9002b5c:	01da77b3          	and	a5,s4,t4
f9002b60:	010a5693          	srli	a3,s4,0x10
f9002b64:	01df7eb3          	and	t4,t5,t4
f9002b68:	010f5e13          	srli	t3,t5,0x10
f9002b6c:	03d78733          	mul	a4,a5,t4
f9002b70:	03d68333          	mul	t1,a3,t4
f9002b74:	01075593          	srli	a1,a4,0x10
f9002b78:	02fe0633          	mul	a2,t3,a5
f9002b7c:	00660633          	add	a2,a2,t1
f9002b80:	00c585b3          	add	a1,a1,a2
f9002b84:	03c68f33          	mul	t5,a3,t3
f9002b88:	0065f463          	bgeu	a1,t1,f9002b90 <__muldf3+0x284>
f9002b8c:	01ff0f33          	add	t5,t5,t6
f9002b90:	000103b7          	lui	t2,0x10
f9002b94:	fff38613          	addi	a2,t2,-1 # ffff <__stack_size+0xefff>
f9002b98:	00c5f333          	and	t1,a1,a2
f9002b9c:	01045f93          	srli	t6,s0,0x10
f9002ba0:	00c77733          	and	a4,a4,a2
f9002ba4:	00c47433          	and	s0,s0,a2
f9002ba8:	01031313          	slli	t1,t1,0x10
f9002bac:	028782b3          	mul	t0,a5,s0
f9002bb0:	00e30333          	add	t1,t1,a4
f9002bb4:	0105d593          	srli	a1,a1,0x10
f9002bb8:	02868733          	mul	a4,a3,s0
f9002bbc:	0102d613          	srli	a2,t0,0x10
f9002bc0:	02ff87b3          	mul	a5,t6,a5
f9002bc4:	00e787b3          	add	a5,a5,a4
f9002bc8:	00f60633          	add	a2,a2,a5
f9002bcc:	03f687b3          	mul	a5,a3,t6
f9002bd0:	00e67463          	bgeu	a2,a4,f9002bd8 <__muldf3+0x2cc>
f9002bd4:	007787b3          	add	a5,a5,t2
f9002bd8:	00010937          	lui	s2,0x10
f9002bdc:	fff90993          	addi	s3,s2,-1 # ffff <__stack_size+0xefff>
f9002be0:	01367733          	and	a4,a2,s3
f9002be4:	0104d393          	srli	t2,s1,0x10
f9002be8:	0134f6b3          	and	a3,s1,s3
f9002bec:	0132f2b3          	and	t0,t0,s3
f9002bf0:	01071713          	slli	a4,a4,0x10
f9002bf4:	02de84b3          	mul	s1,t4,a3
f9002bf8:	00570733          	add	a4,a4,t0
f9002bfc:	01065613          	srli	a2,a2,0x10
f9002c00:	00f60633          	add	a2,a2,a5
f9002c04:	00e585b3          	add	a1,a1,a4
f9002c08:	02de02b3          	mul	t0,t3,a3
f9002c0c:	0104d793          	srli	a5,s1,0x10
f9002c10:	03d38eb3          	mul	t4,t2,t4
f9002c14:	01d282b3          	add	t0,t0,t4
f9002c18:	005787b3          	add	a5,a5,t0
f9002c1c:	027e0e33          	mul	t3,t3,t2
f9002c20:	01d7f463          	bgeu	a5,t4,f9002c28 <__muldf3+0x31c>
f9002c24:	012e0e33          	add	t3,t3,s2
f9002c28:	000109b7          	lui	s3,0x10
f9002c2c:	fff98e93          	addi	t4,s3,-1 # ffff <__stack_size+0xefff>
f9002c30:	01d7f2b3          	and	t0,a5,t4
f9002c34:	0107d793          	srli	a5,a5,0x10
f9002c38:	01c787b3          	add	a5,a5,t3
f9002c3c:	01d4feb3          	and	t4,s1,t4
f9002c40:	01029293          	slli	t0,t0,0x10
f9002c44:	02d40933          	mul	s2,s0,a3
f9002c48:	01d282b3          	add	t0,t0,t4
f9002c4c:	02838433          	mul	s0,t2,s0
f9002c50:	01095e13          	srli	t3,s2,0x10
f9002c54:	02df86b3          	mul	a3,t6,a3
f9002c58:	008686b3          	add	a3,a3,s0
f9002c5c:	00de0e33          	add	t3,t3,a3
f9002c60:	027f8eb3          	mul	t4,t6,t2
f9002c64:	008e7463          	bgeu	t3,s0,f9002c6c <__muldf3+0x360>
f9002c68:	013e8eb3          	add	t4,t4,s3
f9002c6c:	00010fb7          	lui	t6,0x10
f9002c70:	ffff8f93          	addi	t6,t6,-1 # ffff <__stack_size+0xefff>
f9002c74:	01fe76b3          	and	a3,t3,t6
f9002c78:	01069693          	slli	a3,a3,0x10
f9002c7c:	01f97933          	and	s2,s2,t6
f9002c80:	01e585b3          	add	a1,a1,t5
f9002c84:	012686b3          	add	a3,a3,s2
f9002c88:	00c68633          	add	a2,a3,a2
f9002c8c:	00e5b733          	sltu	a4,a1,a4
f9002c90:	00e60733          	add	a4,a2,a4
f9002c94:	00558f33          	add	t5,a1,t0
f9002c98:	00f707b3          	add	a5,a4,a5
f9002c9c:	00bf35b3          	sltu	a1,t5,a1
f9002ca0:	00b785b3          	add	a1,a5,a1
f9002ca4:	00d636b3          	sltu	a3,a2,a3
f9002ca8:	00c73633          	sltu	a2,a4,a2
f9002cac:	00c6e6b3          	or	a3,a3,a2
f9002cb0:	00e7b733          	sltu	a4,a5,a4
f9002cb4:	010e5e13          	srli	t3,t3,0x10
f9002cb8:	00f5b7b3          	sltu	a5,a1,a5
f9002cbc:	01c686b3          	add	a3,a3,t3
f9002cc0:	00f76733          	or	a4,a4,a5
f9002cc4:	009f1793          	slli	a5,t5,0x9
f9002cc8:	00d70733          	add	a4,a4,a3
f9002ccc:	0067e7b3          	or	a5,a5,t1
f9002cd0:	01d70733          	add	a4,a4,t4
f9002cd4:	00f037b3          	snez	a5,a5
f9002cd8:	017f5613          	srli	a2,t5,0x17
f9002cdc:	00971713          	slli	a4,a4,0x9
f9002ce0:	0175d693          	srli	a3,a1,0x17
f9002ce4:	00c7e7b3          	or	a5,a5,a2
f9002ce8:	00959593          	slli	a1,a1,0x9
f9002cec:	00b7ea33          	or	s4,a5,a1
f9002cf0:	00771793          	slli	a5,a4,0x7
f9002cf4:	00d764b3          	or	s1,a4,a3
f9002cf8:	0207d063          	bgez	a5,f9002d18 <__muldf3+0x40c>
f9002cfc:	001a5713          	srli	a4,s4,0x1
f9002d00:	001a7793          	andi	a5,s4,1
f9002d04:	01f49693          	slli	a3,s1,0x1f
f9002d08:	00f767b3          	or	a5,a4,a5
f9002d0c:	00d7ea33          	or	s4,a5,a3
f9002d10:	0014d493          	srli	s1,s1,0x1
f9002d14:	00050893          	mv	a7,a0
f9002d18:	3ff88613          	addi	a2,a7,1023
f9002d1c:	12c05663          	blez	a2,f9002e48 <__muldf3+0x53c>
f9002d20:	007a7793          	andi	a5,s4,7
f9002d24:	02078063          	beqz	a5,f9002d44 <__muldf3+0x438>
f9002d28:	00fa7793          	andi	a5,s4,15
f9002d2c:	00400713          	li	a4,4
f9002d30:	00e78a63          	beq	a5,a4,f9002d44 <__muldf3+0x438>
f9002d34:	004a0713          	addi	a4,s4,4
f9002d38:	014737b3          	sltu	a5,a4,s4
f9002d3c:	00f484b3          	add	s1,s1,a5
f9002d40:	00070a13          	mv	s4,a4
f9002d44:	00749793          	slli	a5,s1,0x7
f9002d48:	0007da63          	bgez	a5,f9002d5c <__muldf3+0x450>
f9002d4c:	ff0007b7          	lui	a5,0xff000
f9002d50:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0x5ffa19f>
f9002d54:	00f4f4b3          	and	s1,s1,a5
f9002d58:	40088613          	addi	a2,a7,1024
f9002d5c:	7fe00793          	li	a5,2046
f9002d60:	1cc7c463          	blt	a5,a2,f9002f28 <__muldf3+0x61c>
f9002d64:	003a5793          	srli	a5,s4,0x3
f9002d68:	01d49713          	slli	a4,s1,0x1d
f9002d6c:	00949693          	slli	a3,s1,0x9
f9002d70:	00f76733          	or	a4,a4,a5
f9002d74:	00c6d693          	srli	a3,a3,0xc
f9002d78:	7ff67793          	andi	a5,a2,2047
f9002d7c:	d41ff06f          	j	f9002abc <__muldf3+0x1b0>
f9002d80:	00a4ea33          	or	s4,s1,a0
f9002d84:	060a0863          	beqz	s4,f9002df4 <__muldf3+0x4e8>
f9002d88:	12048e63          	beqz	s1,f9002ec4 <__muldf3+0x5b8>
f9002d8c:	00048513          	mv	a0,s1
f9002d90:	478010ef          	jal	f9004208 <__clzsi2>
f9002d94:	00050613          	mv	a2,a0
f9002d98:	ff550693          	addi	a3,a0,-11
f9002d9c:	01d00713          	li	a4,29
f9002da0:	ff860793          	addi	a5,a2,-8 # 7ffff8 <__stack_size+0x7feff8>
f9002da4:	40d70733          	sub	a4,a4,a3
f9002da8:	00e45733          	srl	a4,s0,a4
f9002dac:	00f496b3          	sll	a3,s1,a5
f9002db0:	00d764b3          	or	s1,a4,a3
f9002db4:	00f41a33          	sll	s4,s0,a5
f9002db8:	c0d00793          	li	a5,-1011
f9002dbc:	40c78c33          	sub	s8,a5,a2
f9002dc0:	00000b13          	li	s6,0
f9002dc4:	00000b93          	li	s7,0
f9002dc8:	bc1ff06f          	j	f9002988 <__muldf3+0x7c>
f9002dcc:	00058813          	mv	a6,a1
f9002dd0:	7ff00793          	li	a5,2047
f9002dd4:	00000693          	li	a3,0
f9002dd8:	00000713          	li	a4,0
f9002ddc:	ce1ff06f          	j	f9002abc <__muldf3+0x1b0>
f9002de0:	00050a13          	mv	s4,a0
f9002de4:	00c00b13          	li	s6,12
f9002de8:	7ff00c13          	li	s8,2047
f9002dec:	00300b93          	li	s7,3
f9002df0:	b99ff06f          	j	f9002988 <__muldf3+0x7c>
f9002df4:	00000493          	li	s1,0
f9002df8:	00400b13          	li	s6,4
f9002dfc:	00000c13          	li	s8,0
f9002e00:	00100b93          	li	s7,1
f9002e04:	b85ff06f          	j	f9002988 <__muldf3+0x7c>
f9002e08:	001b6b13          	ori	s6,s6,1
f9002e0c:	000c0893          	mv	a7,s8
f9002e10:	00000413          	li	s0,0
f9002e14:	00000f13          	li	t5,0
f9002e18:	00100313          	li	t1,1
f9002e1c:	bb5ff06f          	j	f90029d0 <__muldf3+0xc4>
f9002e20:	002b6b13          	ori	s6,s6,2
f9002e24:	00000413          	li	s0,0
f9002e28:	00000f13          	li	t5,0
f9002e2c:	00200313          	li	t1,2
f9002e30:	ba1ff06f          	j	f90029d0 <__muldf3+0xc4>
f9002e34:	00040493          	mv	s1,s0
f9002e38:	000f0a13          	mv	s4,t5
f9002e3c:	00030b93          	mv	s7,t1
f9002e40:	00098593          	mv	a1,s3
f9002e44:	c51ff06f          	j	f9002a94 <__muldf3+0x188>
f9002e48:	00100713          	li	a4,1
f9002e4c:	10061063          	bnez	a2,f9002f4c <__muldf3+0x640>
f9002e50:	41e88893          	addi	a7,a7,1054
f9002e54:	011a1633          	sll	a2,s4,a7
f9002e58:	00c03633          	snez	a2,a2
f9002e5c:	011498b3          	sll	a7,s1,a7
f9002e60:	00ea57b3          	srl	a5,s4,a4
f9002e64:	01166633          	or	a2,a2,a7
f9002e68:	00f66633          	or	a2,a2,a5
f9002e6c:	00767793          	andi	a5,a2,7
f9002e70:	00e4d5b3          	srl	a1,s1,a4
f9002e74:	02078063          	beqz	a5,f9002e94 <__muldf3+0x588>
f9002e78:	00f67793          	andi	a5,a2,15
f9002e7c:	00400713          	li	a4,4
f9002e80:	00e78a63          	beq	a5,a4,f9002e94 <__muldf3+0x588>
f9002e84:	00460793          	addi	a5,a2,4
f9002e88:	00c7b633          	sltu	a2,a5,a2
f9002e8c:	00c585b3          	add	a1,a1,a2
f9002e90:	00078613          	mv	a2,a5
f9002e94:	00859513          	slli	a0,a1,0x8
f9002e98:	00100793          	li	a5,1
f9002e9c:	00000693          	li	a3,0
f9002ea0:	00000713          	li	a4,0
f9002ea4:	c0054ce3          	bltz	a0,f9002abc <__muldf3+0x1b0>
f9002ea8:	10c0006f          	j	f9002fb4 <__muldf3+0x6a8>
f9002eac:	00f00713          	li	a4,15
f9002eb0:	12eb1063          	bne	s6,a4,f9002fd0 <__muldf3+0x6c4>
f9002eb4:	00000813          	li	a6,0
f9002eb8:	000806b7          	lui	a3,0x80
f9002ebc:	00000713          	li	a4,0
f9002ec0:	bfdff06f          	j	f9002abc <__muldf3+0x1b0>
f9002ec4:	344010ef          	jal	f9004208 <__clzsi2>
f9002ec8:	01550693          	addi	a3,a0,21
f9002ecc:	01c00793          	li	a5,28
f9002ed0:	02050613          	addi	a2,a0,32
f9002ed4:	ecd7d4e3          	bge	a5,a3,f9002d9c <__muldf3+0x490>
f9002ed8:	ff850513          	addi	a0,a0,-8
f9002edc:	00000a13          	li	s4,0
f9002ee0:	00a414b3          	sll	s1,s0,a0
f9002ee4:	ed5ff06f          	j	f9002db8 <__muldf3+0x4ac>
f9002ee8:	000a8513          	mv	a0,s5
f9002eec:	31c010ef          	jal	f9004208 <__clzsi2>
f9002ef0:	01550713          	addi	a4,a0,21
f9002ef4:	01c00793          	li	a5,28
f9002ef8:	02050893          	addi	a7,a0,32
f9002efc:	b6e7d0e3          	bge	a5,a4,f9002a5c <__muldf3+0x150>
f9002f00:	ff850513          	addi	a0,a0,-8
f9002f04:	00000f13          	li	t5,0
f9002f08:	00aa9433          	sll	s0,s5,a0
f9002f0c:	b6dff06f          	j	f9002a78 <__muldf3+0x16c>
f9002f10:	00000813          	li	a6,0
f9002f14:	7ff00793          	li	a5,2047
f9002f18:	000806b7          	lui	a3,0x80
f9002f1c:	ba1ff06f          	j	f9002abc <__muldf3+0x1b0>
f9002f20:	00050893          	mv	a7,a0
f9002f24:	df5ff06f          	j	f9002d18 <__muldf3+0x40c>
f9002f28:	7ff00793          	li	a5,2047
f9002f2c:	00000693          	li	a3,0
f9002f30:	00000713          	li	a4,0
f9002f34:	b89ff06f          	j	f9002abc <__muldf3+0x1b0>
f9002f38:	00000813          	li	a6,0
f9002f3c:	7ff00793          	li	a5,2047
f9002f40:	000806b7          	lui	a3,0x80
f9002f44:	00000713          	li	a4,0
f9002f48:	b75ff06f          	j	f9002abc <__muldf3+0x1b0>
f9002f4c:	40c70733          	sub	a4,a4,a2
f9002f50:	03800793          	li	a5,56
f9002f54:	b4e7cee3          	blt	a5,a4,f9002ab0 <__muldf3+0x1a4>
f9002f58:	01f00793          	li	a5,31
f9002f5c:	eee7dae3          	bge	a5,a4,f9002e50 <__muldf3+0x544>
f9002f60:	fe100793          	li	a5,-31
f9002f64:	40c787b3          	sub	a5,a5,a2
f9002f68:	02000693          	li	a3,32
f9002f6c:	00f4d7b3          	srl	a5,s1,a5
f9002f70:	00d70863          	beq	a4,a3,f9002f80 <__muldf3+0x674>
f9002f74:	43e88893          	addi	a7,a7,1086
f9002f78:	011498b3          	sll	a7,s1,a7
f9002f7c:	011a6a33          	or	s4,s4,a7
f9002f80:	01403633          	snez	a2,s4
f9002f84:	00f66633          	or	a2,a2,a5
f9002f88:	00767713          	andi	a4,a2,7
f9002f8c:	00000693          	li	a3,0
f9002f90:	02070863          	beqz	a4,f9002fc0 <__muldf3+0x6b4>
f9002f94:	00f67793          	andi	a5,a2,15
f9002f98:	00400713          	li	a4,4
f9002f9c:	00000593          	li	a1,0
f9002fa0:	00e78a63          	beq	a5,a4,f9002fb4 <__muldf3+0x6a8>
f9002fa4:	00460793          	addi	a5,a2,4
f9002fa8:	00c7b633          	sltu	a2,a5,a2
f9002fac:	00c035b3          	snez	a1,a2
f9002fb0:	00078613          	mv	a2,a5
f9002fb4:	00959693          	slli	a3,a1,0x9
f9002fb8:	01d59713          	slli	a4,a1,0x1d
f9002fbc:	00c6d693          	srli	a3,a3,0xc
f9002fc0:	00365613          	srli	a2,a2,0x3
f9002fc4:	00e66733          	or	a4,a2,a4
f9002fc8:	00000793          	li	a5,0
f9002fcc:	af1ff06f          	j	f9002abc <__muldf3+0x1b0>
f9002fd0:	00040493          	mv	s1,s0
f9002fd4:	000a8a13          	mv	s4,s5
f9002fd8:	00300b93          	li	s7,3
f9002fdc:	00098593          	mv	a1,s3
f9002fe0:	ab5ff06f          	j	f9002a94 <__muldf3+0x188>

f9002fe4 <__fixdfsi>:
f9002fe4:	0145d793          	srli	a5,a1,0x14
f9002fe8:	001006b7          	lui	a3,0x100
f9002fec:	fff68713          	addi	a4,a3,-1 # fffff <__stack_size+0xfefff>
f9002ff0:	7ff7f793          	andi	a5,a5,2047
f9002ff4:	3fe00613          	li	a2,1022
f9002ff8:	00b77733          	and	a4,a4,a1
f9002ffc:	01f5d593          	srli	a1,a1,0x1f
f9003000:	00f65e63          	bge	a2,a5,f900301c <__fixdfsi+0x38>
f9003004:	41d00613          	li	a2,1053
f9003008:	00f65e63          	bge	a2,a5,f9003024 <__fixdfsi+0x40>
f900300c:	80000537          	lui	a0,0x80000
f9003010:	fff50513          	addi	a0,a0,-1 # 7fffffff <__stack_size+0x7fffefff>
f9003014:	00a58533          	add	a0,a1,a0
f9003018:	00008067          	ret
f900301c:	00000513          	li	a0,0
f9003020:	00008067          	ret
f9003024:	43300613          	li	a2,1075
f9003028:	40f60633          	sub	a2,a2,a5
f900302c:	01f00813          	li	a6,31
f9003030:	00d76733          	or	a4,a4,a3
f9003034:	02c85063          	bge	a6,a2,f9003054 <__fixdfsi+0x70>
f9003038:	41300693          	li	a3,1043
f900303c:	40f687b3          	sub	a5,a3,a5
f9003040:	00f75733          	srl	a4,a4,a5
f9003044:	40e00533          	neg	a0,a4
f9003048:	fc059ce3          	bnez	a1,f9003020 <__fixdfsi+0x3c>
f900304c:	00070513          	mv	a0,a4
f9003050:	00008067          	ret
f9003054:	bed78793          	addi	a5,a5,-1043
f9003058:	00f71733          	sll	a4,a4,a5
f900305c:	00c55533          	srl	a0,a0,a2
f9003060:	00a76733          	or	a4,a4,a0
f9003064:	fe1ff06f          	j	f9003044 <__fixdfsi+0x60>

f9003068 <__floatsidf>:
f9003068:	ff010113          	addi	sp,sp,-16
f900306c:	00112623          	sw	ra,12(sp)
f9003070:	00812423          	sw	s0,8(sp)
f9003074:	00912223          	sw	s1,4(sp)
f9003078:	04050a63          	beqz	a0,f90030cc <__floatsidf+0x64>
f900307c:	41f55713          	srai	a4,a0,0x1f
f9003080:	00a744b3          	xor	s1,a4,a0
f9003084:	40e484b3          	sub	s1,s1,a4
f9003088:	00050793          	mv	a5,a0
f900308c:	00048513          	mv	a0,s1
f9003090:	01f7d413          	srli	s0,a5,0x1f
f9003094:	174010ef          	jal	f9004208 <__clzsi2>
f9003098:	41e00793          	li	a5,1054
f900309c:	40a787b3          	sub	a5,a5,a0
f90030a0:	00a00713          	li	a4,10
f90030a4:	7ff7f793          	andi	a5,a5,2047
f90030a8:	06a74063          	blt	a4,a0,f9003108 <__floatsidf+0xa0>
f90030ac:	00b00713          	li	a4,11
f90030b0:	40a70733          	sub	a4,a4,a0
f90030b4:	00e4d733          	srl	a4,s1,a4
f90030b8:	01550513          	addi	a0,a0,21
f90030bc:	00c71713          	slli	a4,a4,0xc
f90030c0:	00a494b3          	sll	s1,s1,a0
f90030c4:	00c75713          	srli	a4,a4,0xc
f90030c8:	0140006f          	j	f90030dc <__floatsidf+0x74>
f90030cc:	00000413          	li	s0,0
f90030d0:	00000793          	li	a5,0
f90030d4:	00000713          	li	a4,0
f90030d8:	00000493          	li	s1,0
f90030dc:	01479793          	slli	a5,a5,0x14
f90030e0:	01f41413          	slli	s0,s0,0x1f
f90030e4:	00e7e7b3          	or	a5,a5,a4
f90030e8:	00c12083          	lw	ra,12(sp)
f90030ec:	0087e7b3          	or	a5,a5,s0
f90030f0:	00812403          	lw	s0,8(sp)
f90030f4:	00048513          	mv	a0,s1
f90030f8:	00078593          	mv	a1,a5
f90030fc:	00412483          	lw	s1,4(sp)
f9003100:	01010113          	addi	sp,sp,16
f9003104:	00008067          	ret
f9003108:	ff550513          	addi	a0,a0,-11
f900310c:	00a49733          	sll	a4,s1,a0
f9003110:	00c71713          	slli	a4,a4,0xc
f9003114:	00c75713          	srli	a4,a4,0xc
f9003118:	00000493          	li	s1,0
f900311c:	fc1ff06f          	j	f90030dc <__floatsidf+0x74>

f9003120 <__addsf3>:
f9003120:	008007b7          	lui	a5,0x800
f9003124:	ff010113          	addi	sp,sp,-16
f9003128:	01755693          	srli	a3,a0,0x17
f900312c:	0175d713          	srli	a4,a1,0x17
f9003130:	fff78793          	addi	a5,a5,-1 # 7fffff <__stack_size+0x7fefff>
f9003134:	00a7f633          	and	a2,a5,a0
f9003138:	0ff77813          	zext.b	a6,a4
f900313c:	00812423          	sw	s0,8(sp)
f9003140:	01212023          	sw	s2,0(sp)
f9003144:	01f55413          	srli	s0,a0,0x1f
f9003148:	0ff6f913          	zext.b	s2,a3
f900314c:	00b7f533          	and	a0,a5,a1
f9003150:	00112623          	sw	ra,12(sp)
f9003154:	01f5d593          	srli	a1,a1,0x1f
f9003158:	00060693          	mv	a3,a2
f900315c:	00040893          	mv	a7,s0
f9003160:	00361713          	slli	a4,a2,0x3
f9003164:	00351e13          	slli	t3,a0,0x3
f9003168:	41090333          	sub	t1,s2,a6
f900316c:	04b40863          	beq	s0,a1,f90031bc <__addsf3+0x9c>
f9003170:	02605263          	blez	t1,f9003194 <__addsf3+0x74>
f9003174:	06081863          	bnez	a6,f90031e4 <__addsf3+0xc4>
f9003178:	1e0e0463          	beqz	t3,f9003360 <__addsf3+0x240>
f900317c:	fff30793          	addi	a5,t1,-1
f9003180:	3c078e63          	beqz	a5,f900355c <__addsf3+0x43c>
f9003184:	0ff00693          	li	a3,255
f9003188:	1ed30463          	beq	t1,a3,f9003370 <__addsf3+0x250>
f900318c:	00078313          	mv	t1,a5
f9003190:	0640006f          	j	f90031f4 <__addsf3+0xd4>
f9003194:	14030463          	beqz	t1,f90032dc <__addsf3+0x1bc>
f9003198:	41280333          	sub	t1,a6,s2
f900319c:	28091263          	bnez	s2,f9003420 <__addsf3+0x300>
f90031a0:	1a070c63          	beqz	a4,f9003358 <__addsf3+0x238>
f90031a4:	fff30793          	addi	a5,t1,-1
f90031a8:	3e078263          	beqz	a5,f900358c <__addsf3+0x46c>
f90031ac:	0ff00693          	li	a3,255
f90031b0:	3ad30063          	beq	t1,a3,f9003550 <__addsf3+0x430>
f90031b4:	00078313          	mv	t1,a5
f90031b8:	2780006f          	j	f9003430 <__addsf3+0x310>
f90031bc:	1e605063          	blez	t1,f900339c <__addsf3+0x27c>
f90031c0:	16080463          	beqz	a6,f9003328 <__addsf3+0x208>
f90031c4:	0ff00793          	li	a5,255
f90031c8:	1af90463          	beq	s2,a5,f9003370 <__addsf3+0x250>
f90031cc:	040007b7          	lui	a5,0x4000
f90031d0:	00fe6e33          	or	t3,t3,a5
f90031d4:	01b00793          	li	a5,27
f90031d8:	2a67da63          	bge	a5,t1,f900348c <__addsf3+0x36c>
f90031dc:	00170713          	addi	a4,a4,1
f90031e0:	0900006f          	j	f9003270 <__addsf3+0x150>
f90031e4:	0ff00793          	li	a5,255
f90031e8:	18f90463          	beq	s2,a5,f9003370 <__addsf3+0x250>
f90031ec:	040007b7          	lui	a5,0x4000
f90031f0:	00fe6e33          	or	t3,t3,a5
f90031f4:	01b00693          	li	a3,27
f90031f8:	00100793          	li	a5,1
f90031fc:	0066ce63          	blt	a3,t1,f9003218 <__addsf3+0xf8>
f9003200:	02000793          	li	a5,32
f9003204:	406787b3          	sub	a5,a5,t1
f9003208:	00fe17b3          	sll	a5,t3,a5
f900320c:	006e56b3          	srl	a3,t3,t1
f9003210:	00f037b3          	snez	a5,a5
f9003214:	00f6e7b3          	or	a5,a3,a5
f9003218:	40f70733          	sub	a4,a4,a5
f900321c:	00571793          	slli	a5,a4,0x5
f9003220:	1607d863          	bgez	a5,f9003390 <__addsf3+0x270>
f9003224:	00912223          	sw	s1,4(sp)
f9003228:	040004b7          	lui	s1,0x4000
f900322c:	fff48493          	addi	s1,s1,-1 # 3ffffff <__stack_size+0x3ffefff>
f9003230:	009774b3          	and	s1,a4,s1
f9003234:	00048513          	mv	a0,s1
f9003238:	7d1000ef          	jal	f9004208 <__clzsi2>
f900323c:	ffb50513          	addi	a0,a0,-5
f9003240:	00a494b3          	sll	s1,s1,a0
f9003244:	19254063          	blt	a0,s2,f90033c4 <__addsf3+0x2a4>
f9003248:	41250533          	sub	a0,a0,s2
f900324c:	00150513          	addi	a0,a0,1
f9003250:	02000713          	li	a4,32
f9003254:	40a70733          	sub	a4,a4,a0
f9003258:	00e49733          	sll	a4,s1,a4
f900325c:	00e03733          	snez	a4,a4
f9003260:	00a4d4b3          	srl	s1,s1,a0
f9003264:	00e4e733          	or	a4,s1,a4
f9003268:	00412483          	lw	s1,4(sp)
f900326c:	00000913          	li	s2,0
f9003270:	00777793          	andi	a5,a4,7
f9003274:	00078a63          	beqz	a5,f9003288 <__addsf3+0x168>
f9003278:	00f77793          	andi	a5,a4,15
f900327c:	00400613          	li	a2,4
f9003280:	00c78463          	beq	a5,a2,f9003288 <__addsf3+0x168>
f9003284:	00470713          	addi	a4,a4,4
f9003288:	00571793          	slli	a5,a4,0x5
f900328c:	0c07dc63          	bgez	a5,f9003364 <__addsf3+0x244>
f9003290:	00190793          	addi	a5,s2,1
f9003294:	0ff00693          	li	a3,255
f9003298:	00040893          	mv	a7,s0
f900329c:	0ed78463          	beq	a5,a3,f9003384 <__addsf3+0x264>
f90032a0:	fc0006b7          	lui	a3,0xfc000
f90032a4:	fff68693          	addi	a3,a3,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f90032a8:	00d776b3          	and	a3,a4,a3
f90032ac:	0ff7f513          	zext.b	a0,a5
f90032b0:	00669693          	slli	a3,a3,0x6
f90032b4:	0096d693          	srli	a3,a3,0x9
f90032b8:	00c12083          	lw	ra,12(sp)
f90032bc:	00812403          	lw	s0,8(sp)
f90032c0:	01751513          	slli	a0,a0,0x17
f90032c4:	00d56533          	or	a0,a0,a3
f90032c8:	01f89793          	slli	a5,a7,0x1f
f90032cc:	00012903          	lw	s2,0(sp)
f90032d0:	00f56533          	or	a0,a0,a5
f90032d4:	01010113          	addi	sp,sp,16
f90032d8:	00008067          	ret
f90032dc:	00190613          	addi	a2,s2,1
f90032e0:	0fe67613          	andi	a2,a2,254
f90032e4:	18061063          	bnez	a2,f9003464 <__addsf3+0x344>
f90032e8:	06091063          	bnez	s2,f9003348 <__addsf3+0x228>
f90032ec:	2a070863          	beqz	a4,f900359c <__addsf3+0x47c>
f90032f0:	00000513          	li	a0,0
f90032f4:	fc0e02e3          	beqz	t3,f90032b8 <__addsf3+0x198>
f90032f8:	41c706b3          	sub	a3,a4,t3
f90032fc:	00569613          	slli	a2,a3,0x5
f9003300:	2a065e63          	bgez	a2,f90035bc <__addsf3+0x49c>
f9003304:	40ee06b3          	sub	a3,t3,a4
f9003308:	00569713          	slli	a4,a3,0x5
f900330c:	2c075863          	bgez	a4,f90035dc <__addsf3+0x4bc>
f9003310:	fc0007b7          	lui	a5,0xfc000
f9003314:	fff78793          	addi	a5,a5,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f9003318:	00f6f6b3          	and	a3,a3,a5
f900331c:	00058893          	mv	a7,a1
f9003320:	00100513          	li	a0,1
f9003324:	f8dff06f          	j	f90032b0 <__addsf3+0x190>
f9003328:	020e0c63          	beqz	t3,f9003360 <__addsf3+0x240>
f900332c:	fff30793          	addi	a5,t1,-1
f9003330:	1e078a63          	beqz	a5,f9003524 <__addsf3+0x404>
f9003334:	0ff00693          	li	a3,255
f9003338:	02d30c63          	beq	t1,a3,f9003370 <__addsf3+0x250>
f900333c:	00078313          	mv	t1,a5
f9003340:	e95ff06f          	j	f90031d4 <__addsf3+0xb4>
f9003344:	20070863          	beqz	a4,f9003554 <__addsf3+0x434>
f9003348:	00000893          	li	a7,0
f900334c:	0ff00513          	li	a0,255
f9003350:	004006b7          	lui	a3,0x400
f9003354:	f65ff06f          	j	f90032b8 <__addsf3+0x198>
f9003358:	00058413          	mv	s0,a1
f900335c:	000e0713          	mv	a4,t3
f9003360:	00030913          	mv	s2,t1
f9003364:	0ff00793          	li	a5,255
f9003368:	00375613          	srli	a2,a4,0x3
f900336c:	1cf91863          	bne	s2,a5,f900353c <__addsf3+0x41c>
f9003370:	fc061ce3          	bnez	a2,f9003348 <__addsf3+0x228>
f9003374:	00040893          	mv	a7,s0
f9003378:	0ff00513          	li	a0,255
f900337c:	00000693          	li	a3,0
f9003380:	f39ff06f          	j	f90032b8 <__addsf3+0x198>
f9003384:	0ff00513          	li	a0,255
f9003388:	00000693          	li	a3,0
f900338c:	f2dff06f          	j	f90032b8 <__addsf3+0x198>
f9003390:	00777793          	andi	a5,a4,7
f9003394:	ee0792e3          	bnez	a5,f9003278 <__addsf3+0x158>
f9003398:	fcdff06f          	j	f9003364 <__addsf3+0x244>
f900339c:	04030063          	beqz	t1,f90033dc <__addsf3+0x2bc>
f90033a0:	41280333          	sub	t1,a6,s2
f90033a4:	12091c63          	bnez	s2,f90034dc <__addsf3+0x3bc>
f90033a8:	fa070ae3          	beqz	a4,f900335c <__addsf3+0x23c>
f90033ac:	fff30793          	addi	a5,t1,-1
f90033b0:	16078a63          	beqz	a5,f9003524 <__addsf3+0x404>
f90033b4:	0ff00693          	li	a3,255
f90033b8:	18d30e63          	beq	t1,a3,f9003554 <__addsf3+0x434>
f90033bc:	00078313          	mv	t1,a5
f90033c0:	12c0006f          	j	f90034ec <__addsf3+0x3cc>
f90033c4:	fc000737          	lui	a4,0xfc000
f90033c8:	fff70713          	addi	a4,a4,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f90033cc:	00e4f733          	and	a4,s1,a4
f90033d0:	40a90933          	sub	s2,s2,a0
f90033d4:	00412483          	lw	s1,4(sp)
f90033d8:	e99ff06f          	j	f9003270 <__addsf3+0x150>
f90033dc:	00190613          	addi	a2,s2,1
f90033e0:	0fe67593          	andi	a1,a2,254
f90033e4:	10059e63          	bnez	a1,f9003500 <__addsf3+0x3e0>
f90033e8:	f4091ee3          	bnez	s2,f9003344 <__addsf3+0x224>
f90033ec:	1c070263          	beqz	a4,f90035b0 <__addsf3+0x490>
f90033f0:	00000513          	li	a0,0
f90033f4:	ec0e02e3          	beqz	t3,f90032b8 <__addsf3+0x198>
f90033f8:	01c70e33          	add	t3,a4,t3
f90033fc:	005e1713          	slli	a4,t3,0x5
f9003400:	003e5693          	srli	a3,t3,0x3
f9003404:	1c075063          	bgez	a4,f90035c4 <__addsf3+0x4a4>
f9003408:	1f800737          	lui	a4,0x1f800
f900340c:	fff70713          	addi	a4,a4,-1 # 1f7fffff <__stack_size+0x1f7fefff>
f9003410:	00e6f6b3          	and	a3,a3,a4
f9003414:	00f6f6b3          	and	a3,a3,a5
f9003418:	00100513          	li	a0,1
f900341c:	e9dff06f          	j	f90032b8 <__addsf3+0x198>
f9003420:	0ff00793          	li	a5,255
f9003424:	12f80663          	beq	a6,a5,f9003550 <__addsf3+0x430>
f9003428:	040007b7          	lui	a5,0x4000
f900342c:	00f76733          	or	a4,a4,a5
f9003430:	01b00693          	li	a3,27
f9003434:	00100793          	li	a5,1
f9003438:	0066ce63          	blt	a3,t1,f9003454 <__addsf3+0x334>
f900343c:	02000793          	li	a5,32
f9003440:	406787b3          	sub	a5,a5,t1
f9003444:	00f717b3          	sll	a5,a4,a5
f9003448:	00f037b3          	snez	a5,a5
f900344c:	00675733          	srl	a4,a4,t1
f9003450:	00f767b3          	or	a5,a4,a5
f9003454:	40fe0733          	sub	a4,t3,a5
f9003458:	00080913          	mv	s2,a6
f900345c:	00058413          	mv	s0,a1
f9003460:	dbdff06f          	j	f900321c <__addsf3+0xfc>
f9003464:	00912223          	sw	s1,4(sp)
f9003468:	41c704b3          	sub	s1,a4,t3
f900346c:	00549793          	slli	a5,s1,0x5
f9003470:	0a07c463          	bltz	a5,f9003518 <__addsf3+0x3f8>
f9003474:	dc0490e3          	bnez	s1,f9003234 <__addsf3+0x114>
f9003478:	00412483          	lw	s1,4(sp)
f900347c:	00000893          	li	a7,0
f9003480:	00000513          	li	a0,0
f9003484:	00000693          	li	a3,0
f9003488:	e31ff06f          	j	f90032b8 <__addsf3+0x198>
f900348c:	02000793          	li	a5,32
f9003490:	406787b3          	sub	a5,a5,t1
f9003494:	00fe17b3          	sll	a5,t3,a5
f9003498:	006e5333          	srl	t1,t3,t1
f900349c:	00f037b3          	snez	a5,a5
f90034a0:	00f36333          	or	t1,t1,a5
f90034a4:	00670733          	add	a4,a4,t1
f90034a8:	00571793          	slli	a5,a4,0x5
f90034ac:	ee07d2e3          	bgez	a5,f9003390 <__addsf3+0x270>
f90034b0:	00190913          	addi	s2,s2,1
f90034b4:	0ff00513          	li	a0,255
f90034b8:	00000693          	li	a3,0
f90034bc:	dea90ee3          	beq	s2,a0,f90032b8 <__addsf3+0x198>
f90034c0:	7e0006b7          	lui	a3,0x7e000
f90034c4:	00175793          	srli	a5,a4,0x1
f90034c8:	fff68693          	addi	a3,a3,-1 # 7dffffff <__stack_size+0x7dffefff>
f90034cc:	00177713          	andi	a4,a4,1
f90034d0:	00d7f7b3          	and	a5,a5,a3
f90034d4:	00e7e733          	or	a4,a5,a4
f90034d8:	d99ff06f          	j	f9003270 <__addsf3+0x150>
f90034dc:	0ff00793          	li	a5,255
f90034e0:	06f80a63          	beq	a6,a5,f9003554 <__addsf3+0x434>
f90034e4:	040007b7          	lui	a5,0x4000
f90034e8:	00f76733          	or	a4,a4,a5
f90034ec:	01b00793          	li	a5,27
f90034f0:	0667dc63          	bge	a5,t1,f9003568 <__addsf3+0x448>
f90034f4:	001e0713          	addi	a4,t3,1
f90034f8:	00080913          	mv	s2,a6
f90034fc:	d75ff06f          	j	f9003270 <__addsf3+0x150>
f9003500:	0ff00793          	li	a5,255
f9003504:	e8f600e3          	beq	a2,a5,f9003384 <__addsf3+0x264>
f9003508:	01c70e33          	add	t3,a4,t3
f900350c:	001e5713          	srli	a4,t3,0x1
f9003510:	00060913          	mv	s2,a2
f9003514:	d5dff06f          	j	f9003270 <__addsf3+0x150>
f9003518:	40ee04b3          	sub	s1,t3,a4
f900351c:	00058413          	mv	s0,a1
f9003520:	d15ff06f          	j	f9003234 <__addsf3+0x114>
f9003524:	01c70733          	add	a4,a4,t3
f9003528:	00571793          	slli	a5,a4,0x5
f900352c:	00200913          	li	s2,2
f9003530:	f807c8e3          	bltz	a5,f90034c0 <__addsf3+0x3a0>
f9003534:	00375613          	srli	a2,a4,0x3
f9003538:	00100913          	li	s2,1
f900353c:	00961613          	slli	a2,a2,0x9
f9003540:	00965693          	srli	a3,a2,0x9
f9003544:	0ff97513          	zext.b	a0,s2
f9003548:	00040893          	mv	a7,s0
f900354c:	d6dff06f          	j	f90032b8 <__addsf3+0x198>
f9003550:	00058413          	mv	s0,a1
f9003554:	00050613          	mv	a2,a0
f9003558:	e19ff06f          	j	f9003370 <__addsf3+0x250>
f900355c:	41c70733          	sub	a4,a4,t3
f9003560:	00100913          	li	s2,1
f9003564:	cb9ff06f          	j	f900321c <__addsf3+0xfc>
f9003568:	02000793          	li	a5,32
f900356c:	406787b3          	sub	a5,a5,t1
f9003570:	00f717b3          	sll	a5,a4,a5
f9003574:	00675333          	srl	t1,a4,t1
f9003578:	00f037b3          	snez	a5,a5
f900357c:	00f36333          	or	t1,t1,a5
f9003580:	01c30733          	add	a4,t1,t3
f9003584:	00080913          	mv	s2,a6
f9003588:	f21ff06f          	j	f90034a8 <__addsf3+0x388>
f900358c:	40ee0733          	sub	a4,t3,a4
f9003590:	00058413          	mv	s0,a1
f9003594:	00100913          	li	s2,1
f9003598:	c85ff06f          	j	f900321c <__addsf3+0xfc>
f900359c:	020e0863          	beqz	t3,f90035cc <__addsf3+0x4ac>
f90035a0:	00050693          	mv	a3,a0
f90035a4:	00058893          	mv	a7,a1
f90035a8:	00000513          	li	a0,0
f90035ac:	d0dff06f          	j	f90032b8 <__addsf3+0x198>
f90035b0:	00050693          	mv	a3,a0
f90035b4:	00000513          	li	a0,0
f90035b8:	d01ff06f          	j	f90032b8 <__addsf3+0x198>
f90035bc:	02068863          	beqz	a3,f90035ec <__addsf3+0x4cc>
f90035c0:	0036d693          	srli	a3,a3,0x3
f90035c4:	00f6f6b3          	and	a3,a3,a5
f90035c8:	cf1ff06f          	j	f90032b8 <__addsf3+0x198>
f90035cc:	00000893          	li	a7,0
f90035d0:	00000513          	li	a0,0
f90035d4:	00000693          	li	a3,0
f90035d8:	ce1ff06f          	j	f90032b8 <__addsf3+0x198>
f90035dc:	0036d693          	srli	a3,a3,0x3
f90035e0:	00f6f6b3          	and	a3,a3,a5
f90035e4:	00058893          	mv	a7,a1
f90035e8:	cd1ff06f          	j	f90032b8 <__addsf3+0x198>
f90035ec:	00000893          	li	a7,0
f90035f0:	00000693          	li	a3,0
f90035f4:	cc5ff06f          	j	f90032b8 <__addsf3+0x198>

f90035f8 <__gesf2>:
f90035f8:	01755613          	srli	a2,a0,0x17
f90035fc:	00800737          	lui	a4,0x800
f9003600:	fff70713          	addi	a4,a4,-1 # 7fffff <__stack_size+0x7fefff>
f9003604:	0175d693          	srli	a3,a1,0x17
f9003608:	0ff67613          	zext.b	a2,a2
f900360c:	0ff00813          	li	a6,255
f9003610:	00a778b3          	and	a7,a4,a0
f9003614:	01f55793          	srli	a5,a0,0x1f
f9003618:	00b77733          	and	a4,a4,a1
f900361c:	0ff6f513          	zext.b	a0,a3
f9003620:	01f5d593          	srli	a1,a1,0x1f
f9003624:	05060063          	beq	a2,a6,f9003664 <__gesf2+0x6c>
f9003628:	03050063          	beq	a0,a6,f9003648 <__gesf2+0x50>
f900362c:	04061863          	bnez	a2,f900367c <__gesf2+0x84>
f9003630:	02051063          	bnez	a0,f9003650 <__gesf2+0x58>
f9003634:	06070a63          	beqz	a4,f90036a8 <__gesf2+0xb0>
f9003638:	08089063          	bnez	a7,f90036b8 <__gesf2+0xc0>
f900363c:	00100513          	li	a0,1
f9003640:	06058063          	beqz	a1,f90036a0 <__gesf2+0xa8>
f9003644:	00008067          	ret
f9003648:	06071463          	bnez	a4,f90036b0 <__gesf2+0xb8>
f900364c:	00061463          	bnez	a2,f9003654 <__gesf2+0x5c>
f9003650:	fe0886e3          	beqz	a7,f900363c <__gesf2+0x44>
f9003654:	04b78263          	beq	a5,a1,f9003698 <__gesf2+0xa0>
f9003658:	04079463          	bnez	a5,f90036a0 <__gesf2+0xa8>
f900365c:	00100513          	li	a0,1
f9003660:	00008067          	ret
f9003664:	04089663          	bnez	a7,f90036b0 <__gesf2+0xb8>
f9003668:	fec518e3          	bne	a0,a2,f9003658 <__gesf2+0x60>
f900366c:	04071263          	bnez	a4,f90036b0 <__gesf2+0xb8>
f9003670:	feb794e3          	bne	a5,a1,f9003658 <__gesf2+0x60>
f9003674:	00000513          	li	a0,0
f9003678:	00008067          	ret
f900367c:	fc050ee3          	beqz	a0,f9003658 <__gesf2+0x60>
f9003680:	fcb79ce3          	bne	a5,a1,f9003658 <__gesf2+0x60>
f9003684:	fcc54ae3          	blt	a0,a2,f9003658 <__gesf2+0x60>
f9003688:	00a64863          	blt	a2,a0,f9003698 <__gesf2+0xa0>
f900368c:	fd1766e3          	bltu	a4,a7,f9003658 <__gesf2+0x60>
f9003690:	00000513          	li	a0,0
f9003694:	fae8f8e3          	bgeu	a7,a4,f9003644 <__gesf2+0x4c>
f9003698:	00100513          	li	a0,1
f900369c:	fa0794e3          	bnez	a5,f9003644 <__gesf2+0x4c>
f90036a0:	fff00513          	li	a0,-1
f90036a4:	00008067          	ret
f90036a8:	fa0898e3          	bnez	a7,f9003658 <__gesf2+0x60>
f90036ac:	00008067          	ret
f90036b0:	ffe00513          	li	a0,-2
f90036b4:	00008067          	ret
f90036b8:	fcb78ae3          	beq	a5,a1,f900368c <__gesf2+0x94>
f90036bc:	f9dff06f          	j	f9003658 <__gesf2+0x60>

f90036c0 <__lesf2>:
f90036c0:	01755613          	srli	a2,a0,0x17
f90036c4:	00800737          	lui	a4,0x800
f90036c8:	fff70713          	addi	a4,a4,-1 # 7fffff <__stack_size+0x7fefff>
f90036cc:	0175d693          	srli	a3,a1,0x17
f90036d0:	0ff67613          	zext.b	a2,a2
f90036d4:	0ff00813          	li	a6,255
f90036d8:	00a778b3          	and	a7,a4,a0
f90036dc:	01f55793          	srli	a5,a0,0x1f
f90036e0:	00b77733          	and	a4,a4,a1
f90036e4:	0ff6f513          	zext.b	a0,a3
f90036e8:	01f5d593          	srli	a1,a1,0x1f
f90036ec:	05060263          	beq	a2,a6,f9003730 <__lesf2+0x70>
f90036f0:	03050063          	beq	a0,a6,f9003710 <__lesf2+0x50>
f90036f4:	04061c63          	bnez	a2,f900374c <__lesf2+0x8c>
f90036f8:	02051263          	bnez	a0,f900371c <__lesf2+0x5c>
f90036fc:	06070e63          	beqz	a4,f9003778 <__lesf2+0xb8>
f9003700:	08089463          	bnez	a7,f9003788 <__lesf2+0xc8>
f9003704:	00100513          	li	a0,1
f9003708:	06058463          	beqz	a1,f9003770 <__lesf2+0xb0>
f900370c:	00008067          	ret
f9003710:	00200513          	li	a0,2
f9003714:	fe071ce3          	bnez	a4,f900370c <__lesf2+0x4c>
f9003718:	00061463          	bnez	a2,f9003720 <__lesf2+0x60>
f900371c:	fe0884e3          	beqz	a7,f9003704 <__lesf2+0x44>
f9003720:	04b78463          	beq	a5,a1,f9003768 <__lesf2+0xa8>
f9003724:	04079663          	bnez	a5,f9003770 <__lesf2+0xb0>
f9003728:	00100513          	li	a0,1
f900372c:	00008067          	ret
f9003730:	04089863          	bnez	a7,f9003780 <__lesf2+0xc0>
f9003734:	fec518e3          	bne	a0,a2,f9003724 <__lesf2+0x64>
f9003738:	00200513          	li	a0,2
f900373c:	fc0718e3          	bnez	a4,f900370c <__lesf2+0x4c>
f9003740:	feb792e3          	bne	a5,a1,f9003724 <__lesf2+0x64>
f9003744:	00000513          	li	a0,0
f9003748:	00008067          	ret
f900374c:	fc050ce3          	beqz	a0,f9003724 <__lesf2+0x64>
f9003750:	fcb79ae3          	bne	a5,a1,f9003724 <__lesf2+0x64>
f9003754:	fcc548e3          	blt	a0,a2,f9003724 <__lesf2+0x64>
f9003758:	00a64863          	blt	a2,a0,f9003768 <__lesf2+0xa8>
f900375c:	fd1764e3          	bltu	a4,a7,f9003724 <__lesf2+0x64>
f9003760:	00000513          	li	a0,0
f9003764:	fae8f4e3          	bgeu	a7,a4,f900370c <__lesf2+0x4c>
f9003768:	00100513          	li	a0,1
f900376c:	fa0790e3          	bnez	a5,f900370c <__lesf2+0x4c>
f9003770:	fff00513          	li	a0,-1
f9003774:	00008067          	ret
f9003778:	fa0896e3          	bnez	a7,f9003724 <__lesf2+0x64>
f900377c:	00008067          	ret
f9003780:	00200513          	li	a0,2
f9003784:	00008067          	ret
f9003788:	fcb78ae3          	beq	a5,a1,f900375c <__lesf2+0x9c>
f900378c:	f99ff06f          	j	f9003724 <__lesf2+0x64>

f9003790 <__mulsf3>:
f9003790:	fd010113          	addi	sp,sp,-48
f9003794:	01755793          	srli	a5,a0,0x17
f9003798:	03212023          	sw	s2,32(sp)
f900379c:	01412c23          	sw	s4,24(sp)
f90037a0:	02112623          	sw	ra,44(sp)
f90037a4:	00951a13          	slli	s4,a0,0x9
f90037a8:	02812423          	sw	s0,40(sp)
f90037ac:	02912223          	sw	s1,36(sp)
f90037b0:	01312e23          	sw	s3,28(sp)
f90037b4:	01512a23          	sw	s5,20(sp)
f90037b8:	01612823          	sw	s6,16(sp)
f90037bc:	0ff7f793          	zext.b	a5,a5
f90037c0:	009a5a13          	srli	s4,s4,0x9
f90037c4:	01f55913          	srli	s2,a0,0x1f
f90037c8:	24078063          	beqz	a5,f9003a08 <__mulsf3+0x278>
f90037cc:	0ff00713          	li	a4,255
f90037d0:	16e78663          	beq	a5,a4,f900393c <__mulsf3+0x1ac>
f90037d4:	003a1a13          	slli	s4,s4,0x3
f90037d8:	04000737          	lui	a4,0x4000
f90037dc:	00ea6a33          	or	s4,s4,a4
f90037e0:	f8178993          	addi	s3,a5,-127 # 3ffff81 <__stack_size+0x3ffef81>
f90037e4:	00000493          	li	s1,0
f90037e8:	00000b13          	li	s6,0
f90037ec:	0175d793          	srli	a5,a1,0x17
f90037f0:	00959a93          	slli	s5,a1,0x9
f90037f4:	0ff7f793          	zext.b	a5,a5
f90037f8:	009ada93          	srli	s5,s5,0x9
f90037fc:	01f5d413          	srli	s0,a1,0x1f
f9003800:	16078263          	beqz	a5,f9003964 <__mulsf3+0x1d4>
f9003804:	0ff00713          	li	a4,255
f9003808:	1ce78a63          	beq	a5,a4,f90039dc <__mulsf3+0x24c>
f900380c:	003a9a93          	slli	s5,s5,0x3
f9003810:	f8178793          	addi	a5,a5,-127
f9003814:	04000737          	lui	a4,0x4000
f9003818:	00eaeab3          	or	s5,s5,a4
f900381c:	00f989b3          	add	s3,s3,a5
f9003820:	00000593          	li	a1,0
f9003824:	00a00793          	li	a5,10
f9003828:	00198613          	addi	a2,s3,1
f900382c:	1497c863          	blt	a5,s1,f900397c <__mulsf3+0x1ec>
f9003830:	00894533          	xor	a0,s2,s0
f9003834:	00200793          	li	a5,2
f9003838:	00050693          	mv	a3,a0
f900383c:	1e97d863          	bge	a5,s1,f9003a2c <__mulsf3+0x29c>
f9003840:	00100713          	li	a4,1
f9003844:	00971733          	sll	a4,a4,s1
f9003848:	53077793          	andi	a5,a4,1328
f900384c:	12079a63          	bnez	a5,f9003980 <__mulsf3+0x1f0>
f9003850:	24077793          	andi	a5,a4,576
f9003854:	26079863          	bnez	a5,f9003ac4 <__mulsf3+0x334>
f9003858:	08877713          	andi	a4,a4,136
f900385c:	24071c63          	bnez	a4,f9003ab4 <__mulsf3+0x324>
f9003860:	000108b7          	lui	a7,0x10
f9003864:	fff88793          	addi	a5,a7,-1 # ffff <__stack_size+0xefff>
f9003868:	010a5593          	srli	a1,s4,0x10
f900386c:	010ad813          	srli	a6,s5,0x10
f9003870:	00fa7a33          	and	s4,s4,a5
f9003874:	00faf7b3          	and	a5,s5,a5
f9003878:	03478533          	mul	a0,a5,s4
f900387c:	02f587b3          	mul	a5,a1,a5
f9003880:	01055713          	srli	a4,a0,0x10
f9003884:	03480a33          	mul	s4,a6,s4
f9003888:	00fa0a33          	add	s4,s4,a5
f900388c:	01470733          	add	a4,a4,s4
f9003890:	030585b3          	mul	a1,a1,a6
f9003894:	00f77463          	bgeu	a4,a5,f900389c <__mulsf3+0x10c>
f9003898:	011585b3          	add	a1,a1,a7
f900389c:	00010837          	lui	a6,0x10
f90038a0:	fff80813          	addi	a6,a6,-1 # ffff <__stack_size+0xefff>
f90038a4:	010777b3          	and	a5,a4,a6
f90038a8:	01079793          	slli	a5,a5,0x10
f90038ac:	01057533          	and	a0,a0,a6
f90038b0:	00a787b3          	add	a5,a5,a0
f90038b4:	01075713          	srli	a4,a4,0x10
f90038b8:	00679a13          	slli	s4,a5,0x6
f90038bc:	00b70733          	add	a4,a4,a1
f90038c0:	01a7d793          	srli	a5,a5,0x1a
f90038c4:	00671713          	slli	a4,a4,0x6
f90038c8:	01403a33          	snez	s4,s4
f90038cc:	00fa6a33          	or	s4,s4,a5
f90038d0:	00471793          	slli	a5,a4,0x4
f90038d4:	01476a33          	or	s4,a4,s4
f90038d8:	0007da63          	bgez	a5,f90038ec <__mulsf3+0x15c>
f90038dc:	001a5793          	srli	a5,s4,0x1
f90038e0:	001a7a13          	andi	s4,s4,1
f90038e4:	0147ea33          	or	s4,a5,s4
f90038e8:	00060993          	mv	s3,a2
f90038ec:	07f98793          	addi	a5,s3,127
f90038f0:	1ef05263          	blez	a5,f9003ad4 <__mulsf3+0x344>
f90038f4:	007a7713          	andi	a4,s4,7
f90038f8:	00070a63          	beqz	a4,f900390c <__mulsf3+0x17c>
f90038fc:	00fa7713          	andi	a4,s4,15
f9003900:	00400613          	li	a2,4
f9003904:	00c70463          	beq	a4,a2,f900390c <__mulsf3+0x17c>
f9003908:	004a0a13          	addi	s4,s4,4
f900390c:	004a1713          	slli	a4,s4,0x4
f9003910:	00075a63          	bgez	a4,f9003924 <__mulsf3+0x194>
f9003914:	f80007b7          	lui	a5,0xf8000
f9003918:	fff78793          	addi	a5,a5,-1 # f7ffffff <__stack_size+0xf7ffefff>
f900391c:	00fa7a33          	and	s4,s4,a5
f9003920:	08098793          	addi	a5,s3,128
f9003924:	0fe00713          	li	a4,254
f9003928:	22f74663          	blt	a4,a5,f9003b54 <__mulsf3+0x3c4>
f900392c:	006a1713          	slli	a4,s4,0x6
f9003930:	00975713          	srli	a4,a4,0x9
f9003934:	0ff7f793          	zext.b	a5,a5
f9003938:	06c0006f          	j	f90039a4 <__mulsf3+0x214>
f900393c:	160a1463          	bnez	s4,f9003aa4 <__mulsf3+0x314>
f9003940:	0175d793          	srli	a5,a1,0x17
f9003944:	00959a93          	slli	s5,a1,0x9
f9003948:	0ff7f793          	zext.b	a5,a5
f900394c:	00800493          	li	s1,8
f9003950:	0ff00993          	li	s3,255
f9003954:	00200b13          	li	s6,2
f9003958:	009ada93          	srli	s5,s5,0x9
f900395c:	01f5d413          	srli	s0,a1,0x1f
f9003960:	ea0792e3          	bnez	a5,f9003804 <__mulsf3+0x74>
f9003964:	100a9863          	bnez	s5,f9003a74 <__mulsf3+0x2e4>
f9003968:	0014e493          	ori	s1,s1,1
f900396c:	00a00793          	li	a5,10
f9003970:	00100593          	li	a1,1
f9003974:	00198613          	addi	a2,s3,1
f9003978:	ea97dce3          	bge	a5,s1,f9003830 <__mulsf3+0xa0>
f900397c:	00090513          	mv	a0,s2
f9003980:	00200793          	li	a5,2
f9003984:	08fb0c63          	beq	s6,a5,f9003a1c <__mulsf3+0x28c>
f9003988:	00300793          	li	a5,3
f900398c:	12fb0c63          	beq	s6,a5,f9003ac4 <__mulsf3+0x334>
f9003990:	00100793          	li	a5,1
f9003994:	00050693          	mv	a3,a0
f9003998:	1afb1a63          	bne	s6,a5,f9003b4c <__mulsf3+0x3bc>
f900399c:	00000793          	li	a5,0
f90039a0:	00000713          	li	a4,0
f90039a4:	02c12083          	lw	ra,44(sp)
f90039a8:	02812403          	lw	s0,40(sp)
f90039ac:	01779513          	slli	a0,a5,0x17
f90039b0:	00e56533          	or	a0,a0,a4
f90039b4:	01f69793          	slli	a5,a3,0x1f
f90039b8:	02412483          	lw	s1,36(sp)
f90039bc:	02012903          	lw	s2,32(sp)
f90039c0:	01c12983          	lw	s3,28(sp)
f90039c4:	01812a03          	lw	s4,24(sp)
f90039c8:	01412a83          	lw	s5,20(sp)
f90039cc:	01012b03          	lw	s6,16(sp)
f90039d0:	00f56533          	or	a0,a0,a5
f90039d4:	03010113          	addi	sp,sp,48
f90039d8:	00008067          	ret
f90039dc:	0ff98713          	addi	a4,s3,255
f90039e0:	0a0a8a63          	beqz	s5,f9003a94 <__mulsf3+0x304>
f90039e4:	0034e493          	ori	s1,s1,3
f90039e8:	00a00693          	li	a3,10
f90039ec:	10098613          	addi	a2,s3,256
f90039f0:	1496c063          	blt	a3,s1,f9003b30 <__mulsf3+0x3a0>
f90039f4:	008946b3          	xor	a3,s2,s0
f90039f8:	00068513          	mv	a0,a3
f90039fc:	00070993          	mv	s3,a4
f9003a00:	00300593          	li	a1,3
f9003a04:	e3dff06f          	j	f9003840 <__mulsf3+0xb0>
f9003a08:	040a1063          	bnez	s4,f9003a48 <__mulsf3+0x2b8>
f9003a0c:	00400493          	li	s1,4
f9003a10:	00000993          	li	s3,0
f9003a14:	00100b13          	li	s6,1
f9003a18:	dd5ff06f          	j	f90037ec <__mulsf3+0x5c>
f9003a1c:	00050693          	mv	a3,a0
f9003a20:	0ff00793          	li	a5,255
f9003a24:	00000713          	li	a4,0
f9003a28:	f7dff06f          	j	f90039a4 <__mulsf3+0x214>
f9003a2c:	fff48493          	addi	s1,s1,-1
f9003a30:	00100713          	li	a4,1
f9003a34:	e29766e3          	bltu	a4,s1,f9003860 <__mulsf3+0xd0>
f9003a38:	fef582e3          	beq	a1,a5,f9003a1c <__mulsf3+0x28c>
f9003a3c:	000a8a13          	mv	s4,s5
f9003a40:	00058b13          	mv	s6,a1
f9003a44:	f4dff06f          	j	f9003990 <__mulsf3+0x200>
f9003a48:	000a0513          	mv	a0,s4
f9003a4c:	00b12623          	sw	a1,12(sp)
f9003a50:	7b8000ef          	jal	f9004208 <__clzsi2>
f9003a54:	ffb50793          	addi	a5,a0,-5
f9003a58:	00fa1a33          	sll	s4,s4,a5
f9003a5c:	f8a00793          	li	a5,-118
f9003a60:	00c12583          	lw	a1,12(sp)
f9003a64:	40a789b3          	sub	s3,a5,a0
f9003a68:	00000493          	li	s1,0
f9003a6c:	00000b13          	li	s6,0
f9003a70:	d7dff06f          	j	f90037ec <__mulsf3+0x5c>
f9003a74:	000a8513          	mv	a0,s5
f9003a78:	790000ef          	jal	f9004208 <__clzsi2>
f9003a7c:	ffb50793          	addi	a5,a0,-5
f9003a80:	40a98533          	sub	a0,s3,a0
f9003a84:	00fa9ab3          	sll	s5,s5,a5
f9003a88:	f8a50993          	addi	s3,a0,-118
f9003a8c:	00000593          	li	a1,0
f9003a90:	d95ff06f          	j	f9003824 <__mulsf3+0x94>
f9003a94:	0024e493          	ori	s1,s1,2
f9003a98:	00070993          	mv	s3,a4
f9003a9c:	00200593          	li	a1,2
f9003aa0:	d85ff06f          	j	f9003824 <__mulsf3+0x94>
f9003aa4:	00c00493          	li	s1,12
f9003aa8:	0ff00993          	li	s3,255
f9003aac:	00300b13          	li	s6,3
f9003ab0:	d3dff06f          	j	f90037ec <__mulsf3+0x5c>
f9003ab4:	000a8a13          	mv	s4,s5
f9003ab8:	00058b13          	mv	s6,a1
f9003abc:	00040513          	mv	a0,s0
f9003ac0:	ec1ff06f          	j	f9003980 <__mulsf3+0x1f0>
f9003ac4:	00000693          	li	a3,0
f9003ac8:	0ff00793          	li	a5,255
f9003acc:	00400737          	lui	a4,0x400
f9003ad0:	ed5ff06f          	j	f90039a4 <__mulsf3+0x214>
f9003ad4:	00100613          	li	a2,1
f9003ad8:	00078c63          	beqz	a5,f9003af0 <__mulsf3+0x360>
f9003adc:	40f60633          	sub	a2,a2,a5
f9003ae0:	01b00593          	li	a1,27
f9003ae4:	00000793          	li	a5,0
f9003ae8:	00000713          	li	a4,0
f9003aec:	eac5cce3          	blt	a1,a2,f90039a4 <__mulsf3+0x214>
f9003af0:	09e98713          	addi	a4,s3,158
f9003af4:	00ea1733          	sll	a4,s4,a4
f9003af8:	00e03733          	snez	a4,a4
f9003afc:	00ca57b3          	srl	a5,s4,a2
f9003b00:	00e7e7b3          	or	a5,a5,a4
f9003b04:	0077f713          	andi	a4,a5,7
f9003b08:	00070a63          	beqz	a4,f9003b1c <__mulsf3+0x38c>
f9003b0c:	00f7f713          	andi	a4,a5,15
f9003b10:	00400613          	li	a2,4
f9003b14:	00c70463          	beq	a4,a2,f9003b1c <__mulsf3+0x38c>
f9003b18:	00478793          	addi	a5,a5,4
f9003b1c:	00579713          	slli	a4,a5,0x5
f9003b20:	04075063          	bgez	a4,f9003b60 <__mulsf3+0x3d0>
f9003b24:	00100793          	li	a5,1
f9003b28:	00000713          	li	a4,0
f9003b2c:	e79ff06f          	j	f90039a4 <__mulsf3+0x214>
f9003b30:	00f00593          	li	a1,15
f9003b34:	00000693          	li	a3,0
f9003b38:	00400737          	lui	a4,0x400
f9003b3c:	000a8a13          	mv	s4,s5
f9003b40:	00300b13          	li	s6,3
f9003b44:	e6b480e3          	beq	s1,a1,f90039a4 <__mulsf3+0x214>
f9003b48:	f75ff06f          	j	f9003abc <__mulsf3+0x32c>
f9003b4c:	00060993          	mv	s3,a2
f9003b50:	d9dff06f          	j	f90038ec <__mulsf3+0x15c>
f9003b54:	0ff00793          	li	a5,255
f9003b58:	00000713          	li	a4,0
f9003b5c:	e49ff06f          	j	f90039a4 <__mulsf3+0x214>
f9003b60:	00679793          	slli	a5,a5,0x6
f9003b64:	0097d713          	srli	a4,a5,0x9
f9003b68:	00000793          	li	a5,0
f9003b6c:	e39ff06f          	j	f90039a4 <__mulsf3+0x214>

f9003b70 <__subsf3>:
f9003b70:	008007b7          	lui	a5,0x800
f9003b74:	ff010113          	addi	sp,sp,-16
f9003b78:	fff78793          	addi	a5,a5,-1 # 7fffff <__stack_size+0x7fefff>
f9003b7c:	0175d693          	srli	a3,a1,0x17
f9003b80:	00a7f833          	and	a6,a5,a0
f9003b84:	00b7f733          	and	a4,a5,a1
f9003b88:	00812423          	sw	s0,8(sp)
f9003b8c:	00912223          	sw	s1,4(sp)
f9003b90:	01755413          	srli	s0,a0,0x17
f9003b94:	01f55493          	srli	s1,a0,0x1f
f9003b98:	00112623          	sw	ra,12(sp)
f9003b9c:	0ff6f693          	zext.b	a3,a3
f9003ba0:	0ff00513          	li	a0,255
f9003ba4:	00080613          	mv	a2,a6
f9003ba8:	0ff47413          	zext.b	s0,s0
f9003bac:	00048313          	mv	t1,s1
f9003bb0:	00381793          	slli	a5,a6,0x3
f9003bb4:	01f5d593          	srli	a1,a1,0x1f
f9003bb8:	00371e13          	slli	t3,a4,0x3
f9003bbc:	04a68a63          	beq	a3,a0,f9003c10 <__subsf3+0xa0>
f9003bc0:	0015c893          	xori	a7,a1,1
f9003bc4:	40d405b3          	sub	a1,s0,a3
f9003bc8:	03148263          	beq	s1,a7,f9003bec <__subsf3+0x7c>
f9003bcc:	48b05263          	blez	a1,f9004050 <__subsf3+0x4e0>
f9003bd0:	06069663          	bnez	a3,f9003c3c <__subsf3+0xcc>
f9003bd4:	1c0e0c63          	beqz	t3,f9003dac <__subsf3+0x23c>
f9003bd8:	fff58713          	addi	a4,a1,-1
f9003bdc:	3c070c63          	beqz	a4,f9003fb4 <__subsf3+0x444>
f9003be0:	1ca58e63          	beq	a1,a0,f9003dbc <__subsf3+0x24c>
f9003be4:	00070593          	mv	a1,a4
f9003be8:	0600006f          	j	f9003c48 <__subsf3+0xd8>
f9003bec:	48b05263          	blez	a1,f9004070 <__subsf3+0x500>
f9003bf0:	18068e63          	beqz	a3,f9003d8c <__subsf3+0x21c>
f9003bf4:	1ca40463          	beq	s0,a0,f9003dbc <__subsf3+0x24c>
f9003bf8:	04000737          	lui	a4,0x4000
f9003bfc:	00ee6e33          	or	t3,t3,a4
f9003c00:	01b00713          	li	a4,27
f9003c04:	2cb75c63          	bge	a4,a1,f9003edc <__subsf3+0x36c>
f9003c08:	00178793          	addi	a5,a5,1
f9003c0c:	0b80006f          	j	f9003cc4 <__subsf3+0x154>
f9003c10:	f0140513          	addi	a0,s0,-255
f9003c14:	100e1e63          	bnez	t3,f9003d30 <__subsf3+0x1c0>
f9003c18:	0015c893          	xori	a7,a1,1
f9003c1c:	29148063          	beq	s1,a7,f9003e9c <__subsf3+0x32c>
f9003c20:	1a050e63          	beqz	a0,f9003ddc <__subsf3+0x26c>
f9003c24:	00088493          	mv	s1,a7
f9003c28:	10040c63          	beqz	s0,f9003d40 <__subsf3+0x1d0>
f9003c2c:	0014f313          	andi	t1,s1,1
f9003c30:	0ff00513          	li	a0,255
f9003c34:	00000613          	li	a2,0
f9003c38:	0d40006f          	j	f9003d0c <__subsf3+0x19c>
f9003c3c:	18a40063          	beq	s0,a0,f9003dbc <__subsf3+0x24c>
f9003c40:	04000737          	lui	a4,0x4000
f9003c44:	00ee6e33          	or	t3,t3,a4
f9003c48:	01b00693          	li	a3,27
f9003c4c:	00100713          	li	a4,1
f9003c50:	00b6ce63          	blt	a3,a1,f9003c6c <__subsf3+0xfc>
f9003c54:	02000713          	li	a4,32
f9003c58:	40b70733          	sub	a4,a4,a1
f9003c5c:	00ee1733          	sll	a4,t3,a4
f9003c60:	00be56b3          	srl	a3,t3,a1
f9003c64:	00e03733          	snez	a4,a4
f9003c68:	00e6e733          	or	a4,a3,a4
f9003c6c:	40e787b3          	sub	a5,a5,a4
f9003c70:	00579713          	slli	a4,a5,0x5
f9003c74:	14075e63          	bgez	a4,f9003dd0 <__subsf3+0x260>
f9003c78:	01212023          	sw	s2,0(sp)
f9003c7c:	04000937          	lui	s2,0x4000
f9003c80:	fff90913          	addi	s2,s2,-1 # 3ffffff <__stack_size+0x3ffefff>
f9003c84:	0127f933          	and	s2,a5,s2
f9003c88:	00090513          	mv	a0,s2
f9003c8c:	57c000ef          	jal	f9004208 <__clzsi2>
f9003c90:	ffb50513          	addi	a0,a0,-5
f9003c94:	00a91933          	sll	s2,s2,a0
f9003c98:	18854863          	blt	a0,s0,f9003e28 <__subsf3+0x2b8>
f9003c9c:	40850533          	sub	a0,a0,s0
f9003ca0:	00150513          	addi	a0,a0,1
f9003ca4:	02000793          	li	a5,32
f9003ca8:	40a787b3          	sub	a5,a5,a0
f9003cac:	00f917b3          	sll	a5,s2,a5
f9003cb0:	00f037b3          	snez	a5,a5
f9003cb4:	00a95933          	srl	s2,s2,a0
f9003cb8:	00f967b3          	or	a5,s2,a5
f9003cbc:	00012903          	lw	s2,0(sp)
f9003cc0:	00000413          	li	s0,0
f9003cc4:	0077f713          	andi	a4,a5,7
f9003cc8:	00070a63          	beqz	a4,f9003cdc <__subsf3+0x16c>
f9003ccc:	00f7f713          	andi	a4,a5,15
f9003cd0:	00400693          	li	a3,4
f9003cd4:	00d70463          	beq	a4,a3,f9003cdc <__subsf3+0x16c>
f9003cd8:	00478793          	addi	a5,a5,4
f9003cdc:	00579713          	slli	a4,a5,0x5
f9003ce0:	0c075863          	bgez	a4,f9003db0 <__subsf3+0x240>
f9003ce4:	00140413          	addi	s0,s0,1
f9003ce8:	0ff00713          	li	a4,255
f9003cec:	f4e400e3          	beq	s0,a4,f9003c2c <__subsf3+0xbc>
f9003cf0:	fc000637          	lui	a2,0xfc000
f9003cf4:	fff60613          	addi	a2,a2,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f9003cf8:	00c7f633          	and	a2,a5,a2
f9003cfc:	0ff47513          	zext.b	a0,s0
f9003d00:	00661613          	slli	a2,a2,0x6
f9003d04:	00965613          	srli	a2,a2,0x9
f9003d08:	0014f313          	andi	t1,s1,1
f9003d0c:	00c12083          	lw	ra,12(sp)
f9003d10:	00812403          	lw	s0,8(sp)
f9003d14:	01751513          	slli	a0,a0,0x17
f9003d18:	00c56533          	or	a0,a0,a2
f9003d1c:	01f31793          	slli	a5,t1,0x1f
f9003d20:	00412483          	lw	s1,4(sp)
f9003d24:	00f56533          	or	a0,a0,a5
f9003d28:	01010113          	addi	sp,sp,16
f9003d2c:	00008067          	ret
f9003d30:	00058893          	mv	a7,a1
f9003d34:	12b48a63          	beq	s1,a1,f9003e68 <__subsf3+0x2f8>
f9003d38:	0a050263          	beqz	a0,f9003ddc <__subsf3+0x26c>
f9003d3c:	20041263          	bnez	s0,f9003f40 <__subsf3+0x3d0>
f9003d40:	0ff00593          	li	a1,255
f9003d44:	06078063          	beqz	a5,f9003da4 <__subsf3+0x234>
f9003d48:	fff58613          	addi	a2,a1,-1
f9003d4c:	28060c63          	beqz	a2,f9003fe4 <__subsf3+0x474>
f9003d50:	0ff00513          	li	a0,255
f9003d54:	00088493          	mv	s1,a7
f9003d58:	24a58a63          	beq	a1,a0,f9003fac <__subsf3+0x43c>
f9003d5c:	01b00593          	li	a1,27
f9003d60:	00100713          	li	a4,1
f9003d64:	00c5ce63          	blt	a1,a2,f9003d80 <__subsf3+0x210>
f9003d68:	02000713          	li	a4,32
f9003d6c:	40c70733          	sub	a4,a4,a2
f9003d70:	00e79733          	sll	a4,a5,a4
f9003d74:	00c7d633          	srl	a2,a5,a2
f9003d78:	00e03733          	snez	a4,a4
f9003d7c:	00e66733          	or	a4,a2,a4
f9003d80:	40ee07b3          	sub	a5,t3,a4
f9003d84:	00068413          	mv	s0,a3
f9003d88:	ee9ff06f          	j	f9003c70 <__subsf3+0x100>
f9003d8c:	020e0063          	beqz	t3,f9003dac <__subsf3+0x23c>
f9003d90:	fff58713          	addi	a4,a1,-1
f9003d94:	1e070463          	beqz	a4,f9003f7c <__subsf3+0x40c>
f9003d98:	02a58263          	beq	a1,a0,f9003dbc <__subsf3+0x24c>
f9003d9c:	00070593          	mv	a1,a4
f9003da0:	e61ff06f          	j	f9003c00 <__subsf3+0x90>
f9003da4:	00088493          	mv	s1,a7
f9003da8:	000e0793          	mv	a5,t3
f9003dac:	00058413          	mv	s0,a1
f9003db0:	0ff00713          	li	a4,255
f9003db4:	0037d813          	srli	a6,a5,0x3
f9003db8:	1ce41e63          	bne	s0,a4,f9003f94 <__subsf3+0x424>
f9003dbc:	e60808e3          	beqz	a6,f9003c2c <__subsf3+0xbc>
f9003dc0:	00000313          	li	t1,0
f9003dc4:	0ff00513          	li	a0,255
f9003dc8:	00400637          	lui	a2,0x400
f9003dcc:	f41ff06f          	j	f9003d0c <__subsf3+0x19c>
f9003dd0:	0077f713          	andi	a4,a5,7
f9003dd4:	ee071ce3          	bnez	a4,f9003ccc <__subsf3+0x15c>
f9003dd8:	fd9ff06f          	j	f9003db0 <__subsf3+0x240>
f9003ddc:	00140693          	addi	a3,s0,1
f9003de0:	0fe6f693          	andi	a3,a3,254
f9003de4:	04069e63          	bnez	a3,f9003e40 <__subsf3+0x2d0>
f9003de8:	fc041ce3          	bnez	s0,f9003dc0 <__subsf3+0x250>
f9003dec:	20078463          	beqz	a5,f9003ff4 <__subsf3+0x484>
f9003df0:	00000513          	li	a0,0
f9003df4:	f00e0ce3          	beqz	t3,f9003d0c <__subsf3+0x19c>
f9003df8:	41c78733          	sub	a4,a5,t3
f9003dfc:	00571693          	slli	a3,a4,0x5
f9003e00:	2206d263          	bgez	a3,f9004024 <__subsf3+0x4b4>
f9003e04:	40fe0633          	sub	a2,t3,a5
f9003e08:	00561793          	slli	a5,a2,0x5
f9003e0c:	2207d463          	bgez	a5,f9004034 <__subsf3+0x4c4>
f9003e10:	fc0007b7          	lui	a5,0xfc000
f9003e14:	fff78793          	addi	a5,a5,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f9003e18:	00f67633          	and	a2,a2,a5
f9003e1c:	00088493          	mv	s1,a7
f9003e20:	00100513          	li	a0,1
f9003e24:	eddff06f          	j	f9003d00 <__subsf3+0x190>
f9003e28:	fc0007b7          	lui	a5,0xfc000
f9003e2c:	fff78793          	addi	a5,a5,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f9003e30:	00f977b3          	and	a5,s2,a5
f9003e34:	40a40433          	sub	s0,s0,a0
f9003e38:	00012903          	lw	s2,0(sp)
f9003e3c:	e89ff06f          	j	f9003cc4 <__subsf3+0x154>
f9003e40:	01212023          	sw	s2,0(sp)
f9003e44:	41c78933          	sub	s2,a5,t3
f9003e48:	00591713          	slli	a4,s2,0x5
f9003e4c:	12074263          	bltz	a4,f9003f70 <__subsf3+0x400>
f9003e50:	e2091ce3          	bnez	s2,f9003c88 <__subsf3+0x118>
f9003e54:	00012903          	lw	s2,0(sp)
f9003e58:	00000313          	li	t1,0
f9003e5c:	00000513          	li	a0,0
f9003e60:	00000613          	li	a2,0
f9003e64:	ea9ff06f          	j	f9003d0c <__subsf3+0x19c>
f9003e68:	02050c63          	beqz	a0,f9003ea0 <__subsf3+0x330>
f9003e6c:	14041063          	bnez	s0,f9003fac <__subsf3+0x43c>
f9003e70:	0ff00593          	li	a1,255
f9003e74:	f2078ae3          	beqz	a5,f9003da8 <__subsf3+0x238>
f9003e78:	fff58613          	addi	a2,a1,-1
f9003e7c:	10060063          	beqz	a2,f9003f7c <__subsf3+0x40c>
f9003e80:	0ff00513          	li	a0,255
f9003e84:	12a58463          	beq	a1,a0,f9003fac <__subsf3+0x43c>
f9003e88:	01b00713          	li	a4,27
f9003e8c:	12c75a63          	bge	a4,a2,f9003fc0 <__subsf3+0x450>
f9003e90:	001e0793          	addi	a5,t3,1
f9003e94:	00068413          	mv	s0,a3
f9003e98:	e2dff06f          	j	f9003cc4 <__subsf3+0x154>
f9003e9c:	08051c63          	bnez	a0,f9003f34 <__subsf3+0x3c4>
f9003ea0:	00140693          	addi	a3,s0,1
f9003ea4:	0fe6f593          	andi	a1,a3,254
f9003ea8:	0a059863          	bnez	a1,f9003f58 <__subsf3+0x3e8>
f9003eac:	0e041e63          	bnez	s0,f9003fa8 <__subsf3+0x438>
f9003eb0:	14078c63          	beqz	a5,f9004008 <__subsf3+0x498>
f9003eb4:	00000513          	li	a0,0
f9003eb8:	e40e0ae3          	beqz	t3,f9003d0c <__subsf3+0x19c>
f9003ebc:	01c78e33          	add	t3,a5,t3
f9003ec0:	003e5793          	srli	a5,t3,0x3
f9003ec4:	00979793          	slli	a5,a5,0x9
f9003ec8:	005e1713          	slli	a4,t3,0x5
f9003ecc:	0097d613          	srli	a2,a5,0x9
f9003ed0:	e2075ee3          	bgez	a4,f9003d0c <__subsf3+0x19c>
f9003ed4:	00100513          	li	a0,1
f9003ed8:	e35ff06f          	j	f9003d0c <__subsf3+0x19c>
f9003edc:	02000713          	li	a4,32
f9003ee0:	40b70733          	sub	a4,a4,a1
f9003ee4:	00ee1733          	sll	a4,t3,a4
f9003ee8:	00be55b3          	srl	a1,t3,a1
f9003eec:	00e03733          	snez	a4,a4
f9003ef0:	00e5e5b3          	or	a1,a1,a4
f9003ef4:	00b787b3          	add	a5,a5,a1
f9003ef8:	00579713          	slli	a4,a5,0x5
f9003efc:	ec075ae3          	bgez	a4,f9003dd0 <__subsf3+0x260>
f9003f00:	00140413          	addi	s0,s0,1
f9003f04:	0ff00713          	li	a4,255
f9003f08:	00e41863          	bne	s0,a4,f9003f18 <__subsf3+0x3a8>
f9003f0c:	0ff00513          	li	a0,255
f9003f10:	00000613          	li	a2,0
f9003f14:	df9ff06f          	j	f9003d0c <__subsf3+0x19c>
f9003f18:	7e0006b7          	lui	a3,0x7e000
f9003f1c:	0017d713          	srli	a4,a5,0x1
f9003f20:	fff68693          	addi	a3,a3,-1 # 7dffffff <__stack_size+0x7dffefff>
f9003f24:	0017f793          	andi	a5,a5,1
f9003f28:	00d77733          	and	a4,a4,a3
f9003f2c:	00f767b3          	or	a5,a4,a5
f9003f30:	d95ff06f          	j	f9003cc4 <__subsf3+0x154>
f9003f34:	ce041ce3          	bnez	s0,f9003c2c <__subsf3+0xbc>
f9003f38:	0ff00593          	li	a1,255
f9003f3c:	f39ff06f          	j	f9003e74 <__subsf3+0x304>
f9003f40:	00058493          	mv	s1,a1
f9003f44:	00070813          	mv	a6,a4
f9003f48:	e75ff06f          	j	f9003dbc <__subsf3+0x24c>
f9003f4c:	00140693          	addi	a3,s0,1
f9003f50:	0fe6f593          	andi	a1,a3,254
f9003f54:	f4058ee3          	beqz	a1,f9003eb0 <__subsf3+0x340>
f9003f58:	0ff00713          	li	a4,255
f9003f5c:	fae688e3          	beq	a3,a4,f9003f0c <__subsf3+0x39c>
f9003f60:	01c78e33          	add	t3,a5,t3
f9003f64:	001e5793          	srli	a5,t3,0x1
f9003f68:	00068413          	mv	s0,a3
f9003f6c:	d59ff06f          	j	f9003cc4 <__subsf3+0x154>
f9003f70:	40fe0933          	sub	s2,t3,a5
f9003f74:	00088493          	mv	s1,a7
f9003f78:	d11ff06f          	j	f9003c88 <__subsf3+0x118>
f9003f7c:	01c787b3          	add	a5,a5,t3
f9003f80:	00579713          	slli	a4,a5,0x5
f9003f84:	00200413          	li	s0,2
f9003f88:	f80748e3          	bltz	a4,f9003f18 <__subsf3+0x3a8>
f9003f8c:	0037d813          	srli	a6,a5,0x3
f9003f90:	00100413          	li	s0,1
f9003f94:	00981813          	slli	a6,a6,0x9
f9003f98:	00985613          	srli	a2,a6,0x9
f9003f9c:	0ff47513          	zext.b	a0,s0
f9003fa0:	0014f313          	andi	t1,s1,1
f9003fa4:	d69ff06f          	j	f9003d0c <__subsf3+0x19c>
f9003fa8:	e0079ce3          	bnez	a5,f9003dc0 <__subsf3+0x250>
f9003fac:	00070813          	mv	a6,a4
f9003fb0:	e0dff06f          	j	f9003dbc <__subsf3+0x24c>
f9003fb4:	41c787b3          	sub	a5,a5,t3
f9003fb8:	00100413          	li	s0,1
f9003fbc:	cb5ff06f          	j	f9003c70 <__subsf3+0x100>
f9003fc0:	02000713          	li	a4,32
f9003fc4:	40c70733          	sub	a4,a4,a2
f9003fc8:	00e79733          	sll	a4,a5,a4
f9003fcc:	00c7d633          	srl	a2,a5,a2
f9003fd0:	00e037b3          	snez	a5,a4
f9003fd4:	00f66633          	or	a2,a2,a5
f9003fd8:	01c607b3          	add	a5,a2,t3
f9003fdc:	00068413          	mv	s0,a3
f9003fe0:	f19ff06f          	j	f9003ef8 <__subsf3+0x388>
f9003fe4:	40fe07b3          	sub	a5,t3,a5
f9003fe8:	00088493          	mv	s1,a7
f9003fec:	00100413          	li	s0,1
f9003ff0:	c81ff06f          	j	f9003c70 <__subsf3+0x100>
f9003ff4:	020e0063          	beqz	t3,f9004014 <__subsf3+0x4a4>
f9003ff8:	00088313          	mv	t1,a7
f9003ffc:	00070613          	mv	a2,a4
f9004000:	00000513          	li	a0,0
f9004004:	d09ff06f          	j	f9003d0c <__subsf3+0x19c>
f9004008:	00070613          	mv	a2,a4
f900400c:	00000513          	li	a0,0
f9004010:	cfdff06f          	j	f9003d0c <__subsf3+0x19c>
f9004014:	00000313          	li	t1,0
f9004018:	00000513          	li	a0,0
f900401c:	00000613          	li	a2,0
f9004020:	cedff06f          	j	f9003d0c <__subsf3+0x19c>
f9004024:	02070063          	beqz	a4,f9004044 <__subsf3+0x4d4>
f9004028:	00671713          	slli	a4,a4,0x6
f900402c:	00975613          	srli	a2,a4,0x9
f9004030:	cddff06f          	j	f9003d0c <__subsf3+0x19c>
f9004034:	00661613          	slli	a2,a2,0x6
f9004038:	00088313          	mv	t1,a7
f900403c:	00965613          	srli	a2,a2,0x9
f9004040:	ccdff06f          	j	f9003d0c <__subsf3+0x19c>
f9004044:	00000313          	li	t1,0
f9004048:	00000613          	li	a2,0
f900404c:	cc1ff06f          	j	f9003d0c <__subsf3+0x19c>
f9004050:	d80586e3          	beqz	a1,f9003ddc <__subsf3+0x26c>
f9004054:	40868633          	sub	a2,a3,s0
f9004058:	00060593          	mv	a1,a2
f900405c:	ce0404e3          	beqz	s0,f9003d44 <__subsf3+0x1d4>
f9004060:	04000737          	lui	a4,0x4000
f9004064:	00e7e7b3          	or	a5,a5,a4
f9004068:	00088493          	mv	s1,a7
f900406c:	cf1ff06f          	j	f9003d5c <__subsf3+0x1ec>
f9004070:	ec058ee3          	beqz	a1,f9003f4c <__subsf3+0x3dc>
f9004074:	40868633          	sub	a2,a3,s0
f9004078:	00041663          	bnez	s0,f9004084 <__subsf3+0x514>
f900407c:	00060593          	mv	a1,a2
f9004080:	df5ff06f          	j	f9003e74 <__subsf3+0x304>
f9004084:	04000737          	lui	a4,0x4000
f9004088:	00e7e7b3          	or	a5,a5,a4
f900408c:	dfdff06f          	j	f9003e88 <__subsf3+0x318>

f9004090 <__fixunssfsi>:
f9004090:	01755713          	srli	a4,a0,0x17
f9004094:	00800637          	lui	a2,0x800
f9004098:	fff60793          	addi	a5,a2,-1 # 7fffff <__stack_size+0x7fefff>
f900409c:	0ff77713          	zext.b	a4,a4
f90040a0:	07e00593          	li	a1,126
f90040a4:	00a7f6b3          	and	a3,a5,a0
f90040a8:	01f55793          	srli	a5,a0,0x1f
f90040ac:	00000513          	li	a0,0
f90040b0:	00e5d463          	bge	a1,a4,f90040b8 <__fixunssfsi+0x28>
f90040b4:	00078463          	beqz	a5,f90040bc <__fixunssfsi+0x2c>
f90040b8:	00008067          	ret
f90040bc:	09e00793          	li	a5,158
f90040c0:	fff00513          	li	a0,-1
f90040c4:	fee7cae3          	blt	a5,a4,f90040b8 <__fixunssfsi+0x28>
f90040c8:	09500593          	li	a1,149
f90040cc:	00c6e7b3          	or	a5,a3,a2
f90040d0:	00e5d863          	bge	a1,a4,f90040e0 <__fixunssfsi+0x50>
f90040d4:	f6a70713          	addi	a4,a4,-150 # 3ffff6a <__stack_size+0x3ffef6a>
f90040d8:	00e79533          	sll	a0,a5,a4
f90040dc:	00008067          	ret
f90040e0:	09600513          	li	a0,150
f90040e4:	40e50533          	sub	a0,a0,a4
f90040e8:	00a7d533          	srl	a0,a5,a0
f90040ec:	00008067          	ret

f90040f0 <__floatunsisf>:
f90040f0:	ff010113          	addi	sp,sp,-16
f90040f4:	00112623          	sw	ra,12(sp)
f90040f8:	00812423          	sw	s0,8(sp)
f90040fc:	04050863          	beqz	a0,f900414c <__floatunsisf+0x5c>
f9004100:	00050413          	mv	s0,a0
f9004104:	104000ef          	jal	f9004208 <__clzsi2>
f9004108:	09e00793          	li	a5,158
f900410c:	40a787b3          	sub	a5,a5,a0
f9004110:	09600713          	li	a4,150
f9004114:	04f74c63          	blt	a4,a5,f900416c <__floatunsisf+0x7c>
f9004118:	00800713          	li	a4,8
f900411c:	0ce50e63          	beq	a0,a4,f90041f8 <__floatunsisf+0x108>
f9004120:	ff850513          	addi	a0,a0,-8
f9004124:	00a41433          	sll	s0,s0,a0
f9004128:	00941413          	slli	s0,s0,0x9
f900412c:	0ff7f513          	zext.b	a0,a5
f9004130:	00945413          	srli	s0,s0,0x9
f9004134:	01751513          	slli	a0,a0,0x17
f9004138:	00c12083          	lw	ra,12(sp)
f900413c:	00856533          	or	a0,a0,s0
f9004140:	00812403          	lw	s0,8(sp)
f9004144:	01010113          	addi	sp,sp,16
f9004148:	00008067          	ret
f900414c:	00000513          	li	a0,0
f9004150:	00000413          	li	s0,0
f9004154:	01751513          	slli	a0,a0,0x17
f9004158:	00c12083          	lw	ra,12(sp)
f900415c:	00856533          	or	a0,a0,s0
f9004160:	00812403          	lw	s0,8(sp)
f9004164:	01010113          	addi	sp,sp,16
f9004168:	00008067          	ret
f900416c:	09900713          	li	a4,153
f9004170:	06f74463          	blt	a4,a5,f90041d8 <__floatunsisf+0xe8>
f9004174:	ffb50713          	addi	a4,a0,-5
f9004178:	00e41733          	sll	a4,s0,a4
f900417c:	fc0006b7          	lui	a3,0xfc000
f9004180:	fff68693          	addi	a3,a3,-1 # fbffffff <__freertos_irq_stack_top+0x2ffa19f>
f9004184:	00777613          	andi	a2,a4,7
f9004188:	00d77433          	and	s0,a4,a3
f900418c:	02060463          	beqz	a2,f90041b4 <__floatunsisf+0xc4>
f9004190:	00f77713          	andi	a4,a4,15
f9004194:	00400613          	li	a2,4
f9004198:	00c70e63          	beq	a4,a2,f90041b4 <__floatunsisf+0xc4>
f900419c:	00440413          	addi	s0,s0,4
f90041a0:	00541713          	slli	a4,s0,0x5
f90041a4:	00075863          	bgez	a4,f90041b4 <__floatunsisf+0xc4>
f90041a8:	09f00793          	li	a5,159
f90041ac:	00d47433          	and	s0,s0,a3
f90041b0:	40a787b3          	sub	a5,a5,a0
f90041b4:	00641413          	slli	s0,s0,0x6
f90041b8:	0ff7f513          	zext.b	a0,a5
f90041bc:	00945413          	srli	s0,s0,0x9
f90041c0:	01751513          	slli	a0,a0,0x17
f90041c4:	00c12083          	lw	ra,12(sp)
f90041c8:	00856533          	or	a0,a0,s0
f90041cc:	00812403          	lw	s0,8(sp)
f90041d0:	01010113          	addi	sp,sp,16
f90041d4:	00008067          	ret
f90041d8:	01b50713          	addi	a4,a0,27
f90041dc:	00500693          	li	a3,5
f90041e0:	00e41733          	sll	a4,s0,a4
f90041e4:	40a686b3          	sub	a3,a3,a0
f90041e8:	00e03733          	snez	a4,a4
f90041ec:	00d45433          	srl	s0,s0,a3
f90041f0:	00876733          	or	a4,a4,s0
f90041f4:	f89ff06f          	j	f900417c <__floatunsisf+0x8c>
f90041f8:	00941413          	slli	s0,s0,0x9
f90041fc:	00945413          	srli	s0,s0,0x9
f9004200:	09600513          	li	a0,150
f9004204:	f51ff06f          	j	f9004154 <__floatunsisf+0x64>

f9004208 <__clzsi2>:
f9004208:	000107b7          	lui	a5,0x10
f900420c:	02f57a63          	bgeu	a0,a5,f9004240 <__clzsi2+0x38>
f9004210:	10053793          	sltiu	a5,a0,256
f9004214:	0017b793          	seqz	a5,a5
f9004218:	00379793          	slli	a5,a5,0x3
f900421c:	02000713          	li	a4,32
f9004220:	40f70733          	sub	a4,a4,a5
f9004224:	00f55533          	srl	a0,a0,a5
f9004228:	00001797          	auipc	a5,0x1
f900422c:	a7478793          	addi	a5,a5,-1420 # f9004c9c <__clz_tab>
f9004230:	00a787b3          	add	a5,a5,a0
f9004234:	0007c503          	lbu	a0,0(a5)
f9004238:	40a70533          	sub	a0,a4,a0
f900423c:	00008067          	ret
f9004240:	010007b7          	lui	a5,0x1000
f9004244:	02f57463          	bgeu	a0,a5,f900426c <__clzsi2+0x64>
f9004248:	01000793          	li	a5,16
f900424c:	00f55533          	srl	a0,a0,a5
f9004250:	00001797          	auipc	a5,0x1
f9004254:	a4c78793          	addi	a5,a5,-1460 # f9004c9c <__clz_tab>
f9004258:	00a787b3          	add	a5,a5,a0
f900425c:	0007c503          	lbu	a0,0(a5)
f9004260:	01000713          	li	a4,16
f9004264:	40a70533          	sub	a0,a4,a0
f9004268:	00008067          	ret
f900426c:	01800793          	li	a5,24
f9004270:	00f55533          	srl	a0,a0,a5
f9004274:	00001797          	auipc	a5,0x1
f9004278:	a2878793          	addi	a5,a5,-1496 # f9004c9c <__clz_tab>
f900427c:	00a787b3          	add	a5,a5,a0
f9004280:	0007c503          	lbu	a0,0(a5)
f9004284:	00800713          	li	a4,8
f9004288:	40a70533          	sub	a0,a4,a0
f900428c:	00008067          	ret
