
#include "common.h"

#define TIMER_INTRRUPT_ID SYSTEM_PLIC_SYSTEM_USER_TIMER_0_INTERRUPTS_0

void initTimer(u64 interval);

void timerInterruptHandler(void (*callback)(void));
