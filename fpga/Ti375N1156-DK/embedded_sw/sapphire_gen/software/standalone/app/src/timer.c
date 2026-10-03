
#include "common.h"
#include "timer.h"

#define TIMER_TICK_DELAY                (SYSTEM_CLINT_HZ)
#define TIMER_PRESCALER_CTRL            (SYSTEM_USER_TIMER_0_CTRL)
#define TIMER_CTRL                      (SYSTEM_USER_TIMER_0_CTRL + 0x40)
#define TIMER_CONFIG_WITH_PRESCALER     0x2
#define TIMER_CONFIG_WITHOUT_PRESCALER  0x1
#define TIMER_CONFIG_SELF_RESTART       0x10000


void initTimer(u64 interval){
    //Divide clock rate by 99+1
    write_u32(99, TIMER_PRESCALER_CTRL); 
    write_u32(TIMER_CONFIG_WITH_PRESCALER | TIMER_CONFIG_SELF_RESTART, TIMER_CTRL + 0x0);
    //Will tick each interval cycles (as it use the prescaler)
    write_u32(interval/100 - 1, TIMER_CTRL + 0x4);
    bsp_printf("user timer initialized!\r\n");
}
