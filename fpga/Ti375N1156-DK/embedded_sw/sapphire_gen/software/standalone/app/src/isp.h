
#include "common.h"

void isp_set_color_balance(u32 gain_r, u32 gain_g, u32 gain_b);

u32 isp_get_expose_avg();

u32 isp_update_gain(u32 current_gain);

void isp_set_setpoint(u32 exp_setpoint);

void isp_init(u32 exp_setpoint);
