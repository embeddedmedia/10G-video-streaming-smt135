/*
 * PiCamDriver.h
 *
 *  Created on: 14 May 2020
 *      Author: root
 */

#ifndef SRC_PICAMDRIVER_H_
#define SRC_PICAMDRIVER_H_
#include "bsp.h"
#include "i2c.h"
//#include "i2cDemo.h" //BSP



//Image Compression Capability Registers – [0x1300-0x1301]	(Read Only)
#define compression_capability					0x1301	//[0]
#if __cplusplus
extern "C" {
#endif

typedef enum {
    CameraRes_4K,  
    CameraRes_1080P,  
    CameraRes_1440P
} CameraRes_t;

void PiCam_WriteRegData(u8 addr, u16 reg,u8 data);
u8 PiCam_ReadRegData(u8 addr, u16 reg);
void PiCam_init(CameraRes_t res);

void PiCam_Output_activePixelX(u16 XStart,u16 XEnd);
void PiCam_Output_activePixelY(u16 YStart,u16 YEnd);
void PiCam_TestPattern(u8 Enable,u8 mode);
void PiCam_Gainfilter(u16 AGain, u16 DGain);

#if __cplusplus
}
#endif


#endif /* SRC_PICAMDRIVER_H_ */

