OBJDIR ?= build

LDFLAGS += -lc
PROJ_ROOT = $(STANDALONE)/../..
FLASH_PHY_ADDR = 0x800000
BL_RAM_ADDR = 0xf9000000 

SPINAL_SIM ?= no
ifeq ($(SPINAL_SIM),yes)
    PROJ_NAME := $(PROJ_NAME)_spinal_sim
    CFLAGS += -DSPINAL_SIM
endif
CFLAGS += ${CFLAGS_ARGS}
CFLAGS += -I${STANDALONE}/include
CFLAGS += -I${STANDALONE}/driver
LDFLAGS += -L${STANDALONE}/common
LDFLAGS += -specs=nosys.specs -lgcc -nostartfiles -ffreestanding -Wl,-Bstatic,-T,$(LDSCRIPT),-Map,$(OBJDIR)/$(PROJ_NAME).map,--print-memory-usage -lm

DOT:= .
COLON:=:

OBJS := $(SRCS)
OBJS := $(notdir $(OBJS))
OBJS := $(OBJS:.c=.o)
OBJS := $(OBJS:.cpp=.o)
OBJS := $(OBJS:.S=.o)
OBJS := $(OBJS:.s=.o)
OBJS := $(addprefix $(OBJDIR)/obj_files/,$(OBJS))

all: $(OBJDIR)/$(PROJ_NAME).elf $(OBJDIR)/$(PROJ_NAME).hex $(OBJDIR)/$(PROJ_NAME).asm $(OBJDIR)/$(PROJ_NAME).bin

flash: all
	@openocd -f $(BSP_PATH)/openocd/ftdi_ti_soft.cfg -c "set CPU0_YAML $(PROJ_ROOT)/cpu0.yaml" -f $(BSP_PATH)/openocd/flash_softTap.cfg -c halt -c "flash write_image erase unlock $(OBJDIR)/$(PROJ_NAME).bin $(FLASH_PHY_ADDR) " -c "resume $(BL_RAM_ADDR)" -c exit
	
$(OBJDIR)/%.elf: $(OBJS) | $(OBJDIR)
	@echo "LD $(PROJ_NAME)"
	@$(RISCV_CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

%.hex: %.elf
	@$(RISCV_OBJCOPY) -O ihex $^ $@

%.bin: %.elf
	@$(RISCV_OBJCOPY) -O binary $^ $@

%.v: %.elf
	@$(RISCV_OBJCOPY) -O verilog $^ $@

%.asm: %.elf
	@$(RISCV_OBJDUMP) -S -d $^ > $@

define LIST_RULE
$(1)
	@mkdir -p $(dir $(word 1, $(subst $(COLON), ,$(1))))
	@echo "CC $(word 2,$(subst $(COLON), ,$(1)))"
	@$(RISCV_CC) -c $(CFLAGS)  $(INC) -o $(subst $(COLON), ,$(1))
endef

CAT:= $(addsuffix  $(COLON), $(OBJS))
CAT:= $(join  $(CAT), $(SRCS))
$(foreach i,$(CAT),$(eval $(call LIST_RULE,$(i))))

$(OBJDIR):
	@mkdir -p $@

clean:
	@rm -rf $(OBJDIR)

.SECONDARY: $(OBJS)
