
#include "apb3reg.h"
#include "common.h"
#include "gpio.h"
#include "peri.h"

static const VideoTiming_t timing_4k24 = {
    .max_hres = 3840,
    .hact = 3840/2,
    .hsp = 44,
    .hbp = 490,
    .hfp = 500,
    .max_vres = 2160,
    .vsp = 5,
    .vbp = 36,
    .vfp = 4,
    .pcnt = 1
};

static const VideoTiming_t timing_4k30 = {
    .max_hres = 3840,
    .hact = 3840/2,
    .hsp = 44,
    .hbp = 200,
    .hfp = 200,
    .max_vres = 2160,
    .vsp = 5,
    .vbp = 36,
    .vfp = 4,
    .pcnt = 1
};

static const VideoTiming_t timing_1080p60 = {
    .max_hres = 1920,
    .hact = 1920/2,
    .hsp = 44,
    .hbp = (148 + 1920/4),
    .hfp = (200 + 1920/4),
    .max_vres = 1080,
    .vsp = 5,
    .vbp = 36,
    .vfp = 4,
    .pcnt = 1
};

static const VideoTiming_t timing_1080p30 = {
    .max_hres = 1920,
    .hact = 1920/2,
    .hsp = 44,
    .hbp = (1335 + 1920/4),
    .hfp = (1335 + 1920/4),
    .max_vres = 1080,
    .vsp = 5,
    .vbp = 36,
    .vfp = 4,
    .pcnt = 1
};

static const VideoTiming_t timing_1440p30 = {
    .max_hres = 2560,
    .hact = 2560/2,
    .hsp = 44,
    .hbp = (450 + 2560/4),
    .hfp = (450 + 2560/4),
    .max_vres = 1440,
    .vsp = 5,
    .vbp = 36,
    .vfp = 4,
    .pcnt = 1
};

static const VideoTiming_t timing_1440p60 = {
    .max_hres = 2560,
    .hact = 2560/2,
    .hsp = 44,
    .hbp = (148),
    .hfp = (282),
    .max_vres = 1440,
    .vsp = 5,
    .vbp = 36,
    .vfp = 4,
    .pcnt = 1
};

const VideoParam_t videoParams[6] = {
    {.timing=timing_1080p30, .description="1920x1080 @ 30FPS"},
    {.timing=timing_1080p60, .description="1920x1080 @ 60FPS"},
    {.timing=timing_1440p30, .description="2560x1440 @ 30FPS"},
    {.timing=timing_1440p60, .description="2560x1440 @ 60FPS"},
    {.timing=timing_4k24, .description="3840x2160 @ 24FPS"},
    {.timing=timing_4k30, .description="3840x2160 @ 30FPS"}
};

char pixelFormat[3][20] = {
    {"32-bit ARGB8888"},
    {"24-bit RGB888"},
    {"16-bit RGB565"}
};

typedef struct {
    u32 reg;
    u32 value;
    u32 delay;
} RegConfig; 

typedef union {
    u8 data[4];
    u32 ip;
} IPv4;

static void write_config(u32 base_addr, const RegConfig *config, u32 size) {
    for (int i=0 ; i<size ; ++i) {
        write_u32(config[i].value, base_addr + config[i].reg);
        bsp_uDelay(config[i].delay);
        bsp_printf("written: %x\r\n", base_addr + config[i].reg);
    }
}

u32 read_apb_reg(u32 reg) {
    return read_u32(APB_SLAVE + reg);
}

void write_apb_reg(u32 data, u32 reg) {
    write_u32(data, APB_SLAVE + reg);
}

void update_video_timing(VideoTiming_t config) {
    write_u32(config.max_hres, APB_SLAVE + REG_MAX_HRES);
    write_u32(config.hsp, APB_SLAVE + REG_HSP);
    write_u32(config.hbp, APB_SLAVE + REG_HBP);
    write_u32(config.hact, APB_SLAVE + REG_HACT);
    write_u32(config.hfp, APB_SLAVE + REG_HFP);
    write_u32(config.vsp, APB_SLAVE + REG_VSP);
    write_u32(config.vbp, APB_SLAVE + REG_VBP);
    write_u32(config.max_vres, APB_SLAVE + REG_MAX_VRES);
    write_u32(config.vfp, APB_SLAVE + REG_VFP);
    write_u32(config.pcnt, APB_SLAVE + REG_PCNT);
}

void reg_init() {
    IPv4 local_ip = {.data = {20, 100, 16, 172}};
    IPv4 dest_ip = {.data = {10, 100, 16, 172}};
    IPv4 gateway = {.data = {10,100,16,172}};

    write_u32(0, SERDES_APB_SLAVE + 8); // assert soft reset
    write_u32(0, APB_SLAVE + REG_VIDEO_RSTN);
    write_u32(0, APB_SLAVE + REG_HDMI_RESET);
    write_u32(1, SERDES_APB_SLAVE + 8); // deassert soft reset
    bsp_uDelay(1000*1000);  // WARNING: a long delay is need here

    bsp_printf("network initialization started\r\n");
    write_u32(local_ip.ip, APB_SLAVE + REG_LOCAL_IP);
    write_u32(gateway.ip, APB_SLAVE + REG_GATEWAY_IP);
    write_u32(dest_ip.ip, APB_SLAVE + REG_DEST_IP);
    write_u32(1234, APB_SLAVE + REG_SOURCE_PORT);
    write_u32(1235, APB_SLAVE + REG_DEST_PORT);
    write_u32(floor((9000 - 20 - 8 - 8 - 4)/8), APB_SLAVE + REG_MSS);
    update_video_timing(timing_1080p30);
    write_u32(1, APB_SLAVE + REG_HDMI_RESET);
    write_u32(1, APB_SLAVE + REG_VIDEO_RSTN);

    for (int i=0 ; i<25 ; ++i) {
        u32 val = read_u32(APB_SLAVE + i*4);
        bsp_printf("reg %d readback: ", i);
        bsp_printf_x(val);
        bsp_printf("\r\n");
    }

    bsp_printf("initialized!\r\n");
    bsp_uDelay(50*1000);
}