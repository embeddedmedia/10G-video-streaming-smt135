
#include "bsp.h"
#include "i2c.h"
#include "i2cDemo.h" //From BSP
#include "riscv.h"
#include "PiCamDriver.h"
#include "common.h"
#include "PiCamV3.h"
#include "peri.h"

void PiCam_WriteRegData(u8 addr, u16 reg, u8 data)
{
	u8 outdata;

    i2c_masterStartBlocking(I2C_CTRL_CAM);

    i2c_txByte(I2C_CTRL_CAM, addr<<1);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_txByte(I2C_CTRL_CAM, (reg>>8) & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_txByte(I2C_CTRL_CAM, (reg) & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_txByte(I2C_CTRL_CAM, data & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_masterStopBlocking(I2C_CTRL_CAM);
}

u8 PiCam_ReadRegData(u8 addr, u16 reg)
{
	u8 outdata;

    i2c_masterStartBlocking(I2C_CTRL_CAM);

    i2c_txByte(I2C_CTRL_CAM, addr<<1);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_txByte(I2C_CTRL_CAM, (reg>>8) & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_txByte(I2C_CTRL_CAM, (reg) & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_masterStopBlocking(I2C_CTRL_CAM);
	i2c_masterStartBlocking(I2C_CTRL_CAM);

	i2c_txByte(I2C_CTRL_CAM, (addr<<1) | 0x01);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxAck(I2C_CTRL_CAM)); // Optional check

	i2c_txByte(I2C_CTRL_CAM, 0xFF);
	i2c_txNackBlocking(I2C_CTRL_CAM);
	assert(i2c_rxNack(I2C_CTRL_CAM)); // Optional check
	outdata = i2c_rxData(I2C_CTRL_CAM);

	i2c_masterStopBlocking(I2C_CTRL_CAM);

	return outdata;
}
void AccessCommSeq(void)
{
	PiCamV3_AccessCommSeq();
}

void PiCam_Output_Size(u16 X,u16 Y)
{
	PiCamV3_Output_Size(X, Y);
}

void PiCam_Output_activePixel(u16 XStart,u16 XEnd, u16 YStart, u16 YEnd)
{
	PiCamV3_Output_activePixel(XStart, XEnd, YStart, YEnd);
}

void PiCam_Output_activePixelX(u16 XStart,u16 XEnd)
{
	PiCamV3_Output_activePixelX(XStart, XEnd);
}

void PiCam_Output_activePixelY(u16 YStart,u16 YEnd)
{
	PiCamV3_Output_activePixelY(YStart, YEnd);
}

void PiCam_SetBinningMode(u8 Xmode, u8 Ymode)
{
	PiCamV3_SetBinningMode(Xmode, Ymode);
}

void PiCam_Output_ColorBarSize(u16 X,u16 Y)
{
	PiCamV3_Output_ColorBarSize(X, Y);
}

void PiCam_TestPattern(u8 Enable,u8 mode)
{
	PiCamV3_TestPattern(Enable, mode);
}

void PiCam_Gainfilter(u16 AGain, u16 DGain)
{
	PiCamV3_Gainfilter(AGain, DGain);
}


void PiCam_init(CameraRes_t res)
{
	PiCamV3_init(res);
	// PiCam_TestPattern(1, 0);
}
