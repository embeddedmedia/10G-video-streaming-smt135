
#include "i2c.h"
#include "peri.h"

void cam_i2c_init() {
    const int i2c_freq = 100000;
    I2c_Config i2c_mipi;
    i2c_mipi.samplingClockDivider = 3;
    i2c_mipi.timeout = I2C_CTRL_HZ/1000;
    i2c_mipi.tsuDat  = I2C_CTRL_HZ/(i2c_freq*5);

    /* T_low & T_high = i2c period / 2  */
    i2c_mipi.tLow  = I2C_CTRL_HZ/(i2c_freq*2);
    i2c_mipi.tHigh = I2C_CTRL_HZ/(i2c_freq*2);
    i2c_mipi.tBuf  = I2C_CTRL_HZ/(i2c_freq);

    i2c_applyConfig(I2C_CTRL_CAM, &i2c_mipi);
}
