include $(DEVKITARM)/base_tools
AS := $(PREFIX)as
LD := $(PREFIX)ld
CPP := $(PREFIX)cpp
OBJCOPY := $(PREFIX)objcopy
PREPROC := tools/preproc/preproc
SCANINC := tools/scaninc/scaninc

NAME := payload
ROM := $(NAME).gba
ELF := $(NAME).elf

BUILD_DIR := build/$(NAME)

ASM_SRCS := $(wildcard asm/*.s)
ASM_OBJS := $(ASM_SRCS:%.s=$(BUILD_DIR)/%.o)
C_SRCS := $(wildcard src/*.c)
C_OBJS := $(C_SRCS:%.c=$(BUILD_DIR)/%.o)
DATA_ASM_SRCS := $(wildcard data/*.s)
DATA_ASM_OBJS := $(DATA_ASM_SRCS:%.s=$(BUILD_DIR)/%.o)

CC1 := tools/agbcc/bin/agbcc
CPPFLAGS := -I tools/agbcc/include -iquote include -nostdinc -undef
CFLAGS := -O2 -mthumb-interwork -fhex-asm
ASFLAGS := -mcpu=arm7tdmi
LIBS := -L../../tools/agbcc/lib -lgcc -lc

SUBDIRS := asm src data

ALL_OBJS := $(ASM_OBJS) $(C_OBJS) $(DATA_ASM_OBJS)

TOOLDIRS := $(filter-out tools/agbcc tools/binutils,$(wildcard tools/*))

infoshell = $(foreach line, $(shell $1 | sed "s/ /__SPACE__/g"), $(info $(subst __SPACE__, ,$(line))))

# Build tools when building the rom
# Disable dependency scanning for clean/tidy/tools
ifeq (,$(filter-out all compare,$(MAKECMDGOALS)))
$(call infoshell, $(MAKE) tools)
else
NODEP := 1
endif

$(shell mkdir -p $(SUBDIRS:%=$(BUILD_DIR)/%))

.SUFFIXES:
.SECONDARY:
.DELETE_ON_ERROR:
.SECONDEXPANSION:

.PHONY: all rom clean compare tools cleantools mostlyclean

all: rom

rom: $(ROM)

mostlyclean:
	rm -f $(ROM) $(ROM:%.gba=%.elf) $(ALL_OBJS)

clean: mostlyclean
	@$(foreach tool,$(TOOLDIRS),$(MAKE) clean -C $(tool);)

compare: rom
	sha1sum -c rom.sha1

tools:
	@$(foreach tool,$(TOOLDIRS),$(MAKE) -C $(tool);)

ifeq ($(NODEP),1)
$(BUILD_DIR)/asm/%.o: asm_dep :=
$(BUILD_DIR)/src/%.o: c_dep :=
$(BUILD_DIR)/data/%.o: data_dep :=
else
$(BUILD_DIR)/asm/%.o: asm_dep = $(shell $(SCANINC) -I include $*.s)
$(BUILD_DIR)/src/%.o: c_dep = $(shell $(SCANINC) -I include $*.c)
$(BUILD_DIR)/data/%.o: data_dep = $(shell $(SCANINC) -I include $*.s)
endif

$(ASM_OBJS): $(BUILD_DIR)/%.o: %.s $$(asm_dep)
	$(AS) $(ASFLAGS) -o $@ $<

$(C_OBJS): $(BUILD_DIR)/%.o: %.s $$(c_dep)
	$(CPP) $(CPPFLAGS) -o $*.i $<
	$(PREPROC) $*.i charmap.txt | $(CC1) $(CFLAGS) -o $*.s
	$(AS) $(ASFLAGS) -o $@ $*.i

$(DATA_ASM_OBJS): $(BUILD_DIR)/%.o: %.s $$(data_dep)
	$(PREPROC) $< charmap.txt | $(CPP) $(CPPFLAGS) | $(AS) $(ASFLAGS) -o $@

$(ELF): ld_script.ld $(ALL_OBJS)
	cd $(BUILD_DIR) && $(LD) -Map ../../$*.map -T ../../$< -o ../../$@ $(LIBS)

$(ROM): $(ELF)
	$(OBJCOPY) -O binary $< $@
