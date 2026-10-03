
#pragma once

#include "common.h"

void PiCamV3_Streraming();

void PiCamV3_Standby();

void PiCamV3_init(CameraRes_t res);

void PiCamV3_Gainfilter(u16 AGain, u16 DGain);

void PiCamV3_AccessCommSeq(void);

void PiCamV3_Output_Size(u16 X,u16 Y);

void PiCamV3_Output_activePixel(u16 XStart,u16 XEnd, u16 YStart, u16 YEnd);

void PiCamV3_Output_activePixelX(u16 XStart,u16 XEnd);

void PiCamV3_Output_activePixelY(u16 YStart,u16 YEnd);

void PiCamV3_SetBinningMode(u8 Xmode, u8 Ymode);

void PiCamV3_Output_ColorBarSize(u16 X,u16 Y);

void PiCamV3_TestPattern(u8 Enable,u8 mode);
