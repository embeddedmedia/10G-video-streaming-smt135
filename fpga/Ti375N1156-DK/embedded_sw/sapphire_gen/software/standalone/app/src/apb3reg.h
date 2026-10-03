
#pragma once
#include "type.h"

typedef struct {
    int max_hres;
    int hact;
    int hsp;
    int hbp;
    int hfp;
    int max_vres;
    int vsp;
    int vbp;
    int vfp;
    int pcnt;
} VideoTiming_t;

typedef struct {
    VideoTiming_t timing;
    char * description;
} VideoParam_t;

extern const VideoParam_t videoParams[6];
extern char pixelFormat[3][20];

#define REG_VIDEO_RSTN          0x20
#define REG_MAX_HRES            (0x20 + 0x04)
#define REG_HSP                 (0x20 + 0x08)
#define REG_HBP                 (0x20 + 0x0C)
#define REG_HACT                (0x20 + 0x10)
#define REG_HFP                 (0x20 + 0x14)
#define REG_VSP                 (0x20 + 0x18)
#define REG_VBP                 (0x20 + 0x1C)
#define REG_MAX_VRES            (0x20 + 0x20)
#define REG_VFP                 (0x20 + 0x24)
#define REG_PCNT                (0x20 + 0x28)
#define REG_HDMI_RESET          0x4C
#define REG_LOCAL_IP            0x50
#define REG_GATEWAY_IP          0x54
#define REG_DEST_IP             0x58
#define REG_SOURCE_PORT         0x5C
#define REG_DEST_PORT           0x60
#define REG_DEST_PORT           0x60
#define REG_DEST_PORT           0x60
#define REG_OVERRIDE_EXPOSURE   0x64
#define REG_OVERRIDE_GAIN_R     0x68
#define REG_OVERRIDE_GAIN_G     0x6C
#define REG_OVERRIDE_GAIN_B     0x70
#define REG_MSS                 0x74
#define REG_PIXEL_MODE          0x7C

u32 read_apb_reg(u32 reg);

void write_apb_reg(u32 data, u32 reg);

void update_video_timing(VideoTiming_t config);

void reg_init();
