
#include "common.h"
#include "isp.h"
// #include "dma.h"

#define ISP_APB IO_APB_SLAVE_0_INPUT
#define THRESHOLD 100

typedef struct
{
    float incr_limit;
    float output_limit;
    float actual_val;
    float set_point;
    float err;
    float err_next;
    float err_last;
    float kp, ki, kd;
} PidIncremental;


typedef struct
{
    float set_point;
    float err_last;
    float acc_err;
    float limit;
    float kp, ki, kd;
} PidPositional;


static PidIncremental exp_pid;

void isp_set_color_balance(u32 gain_r, u32 gain_g, u32 gain_b) {
    write_u32(gain_r, ISP_APB + 8);
    write_u32(gain_g, ISP_APB + 12);
    write_u32(gain_b, ISP_APB + 16);
}

u32 isp_get_expose_avg() {
    u32 sum = read_u32(ISP_APB + 0);
    u32 cnt = read_u32(ISP_APB + 4);
    // *4 because 1 cycle = 4 pixels
    return sum/cnt;
}

static float clamp(float val, float min, float max) {
    return val < min ? min : val > max ? max : val;
}

static u32 update_incremental(PidIncremental *pid, u32 point) {
    pid->err = pid->set_point - point;

    float increment_val = 
        pid->kp*(pid->err - pid->err_next) + 
        pid->ki*pid->err + 
        pid->kd*(pid->err - 2 * pid->err_next + pid->err_last);

    increment_val = clamp(increment_val, -1*pid->incr_limit, pid->incr_limit);
    pid->actual_val += increment_val;
    pid->actual_val = clamp(pid->actual_val, -1*pid->output_limit, pid->output_limit);
    
    pid->err_last = pid->err_next;
    pid->err_next = pid->err;
    return pid->actual_val;
}

static u32 update_positional(PidPositional *pid, u32 point) {
    float err = pid->set_point - point;

    pid->acc_err += err;
    pid->acc_err = clamp(pid->acc_err, -1*pid->limit, pid->limit);
    
    float output = 
        pid->kp*(err) + 
        pid->ki*pid->acc_err + 
        pid->kd*(err - pid->err_last);
    pid->err_last = err;
    return output;
}

static float lowPassFrequency(float* input, float* output, int points) 
{ 
    #define SAMPLE_RATE 10 // sampling rate in Hz 
    #define CUTOFF_FREQ 5 // cutoff frequency in Hz 
    #define ALPHA (2 * M_PI * CUTOFF_FREQ / SAMPLE_RATE) 

    float RC = 1.0/(CUTOFF_FREQ*2*3.14);  
    float dt = 1.0/SAMPLE_RATE;  
    float alpha = dt/(RC+dt); 
    output[0] = input[0];
    for(int i = 1; i < points; ++i) 
    {  
        output[i] = output[i-1] + (alpha*(input[i] - output[i-1])); 
    }
    return output[points-1];
}     

u32 isp_update_gain(u32 current_gain) {
    // incremental pid
    static float input[10];
    static float output[10];
    u32 avg = isp_get_expose_avg();
    // memcpy(input, input+1, sizeof(float)*9);
    // input[9] = avg;
    // s32 avg_filter = lowPassFrequency(input, output, 10);

    return update_incremental(&exp_pid, avg);
}

// u8* isp_get_metadata(u32 addr) {
//     const u32 line_size = 5760;
//     static u32 trigger_cnt;
//     ++trigger_cnt;
//     if (trigger_cnt < THRESHOLD) {
//         // bsp_printf("trigger count: %d\r\n", trigger_cnt);
//         return 0;
//     }
//     trigger_cnt = 0;

//     for (int i=0 ; i<4; ++i) {
//         const u32 transfer_size = dma_get_transfer_size(i);
//         bsp_printf("line %d size transferred: %d\r\n", i, transfer_size);
//         for (int j=0 ; j<100/4 ; ++j) {
//             u32 dat = read_u32(addr + line_size * i + j*4);
//             bsp_printf("%x", dat);
//         }
//         bsp_printf("\r\n");
//     }
// }

void isp_set_setpoint(u32 exp_setpoint) {
    exp_pid.set_point = exp_setpoint;
}

void isp_init(u32 exp_setpoint) {
    exp_pid.actual_val=0.0;
    exp_pid.set_point=exp_setpoint;
    exp_pid.incr_limit = 1000.0;
    exp_pid.output_limit = 4000.0;
    exp_pid.err_last = 0.0;
    // exp_pid.acc_err = 0.0;
    exp_pid.kp = 1.50;
    exp_pid.ki = 1.00;
    exp_pid.kd = 0.00;
}
