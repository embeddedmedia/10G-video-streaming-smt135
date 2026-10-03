
#pragma once

#define I2C_CTRL_HZ         SYSTEM_CLINT_HZ
#define I2C_CTRL_CAM        SYSTEM_I2C_0_IO_CTRL
#define APB_SLAVE           IO_APB_SLAVE_0_INPUT
#define SERDES_APB_SLAVE    IO_APB_SLAVE_1_INPUT

void cam_i2c_init();
