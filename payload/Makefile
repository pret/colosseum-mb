TOOLCHAIN := $(DEVKITARM)
COMPARE ?= 0

ifeq ($(CC),)
HOSTCC := gcc
else
HOSTCC := $(CC)
endif

ifeq ($(CXX),)
HOSTCXX := g++
else
HOSTCXX := $(CXX)
endif

ifneq (,$(wildcard $(TOOLCHAIN)/base_tools))
include $(TOOLCHAIN)/base_tools
else
export PATH := $(TOOLCHAIN)/bin:$(PATH)
PREFIX := arm-none-eabi-
OBJCOPY := $(PREFIX)objcopy
export CC := $(PREFIX)gcc
export AS := $(PREFIX)as
endif
export CPP := $(PREFIX)cpp
export LD := $(PREFIX)ld
export OBJCOPY := $(PREFIX)objcopy

SHA1 := $(shell { command -v sha1sum || command -v shasum; } 2>/dev/null) -c
PREPROC := ../tools/preproc/preproc
SCANINC := ../tools/scaninc/scaninc
RAMSCRGEN := ../tools/ramscrgen/ramscrgen
MID := ../tools/mid2agb/mid2agb
AIF := ../tools/aif2pcm/aif2pcm
GFX := ../tools/gbagfx/gbagfx
RSFONT := ../tools/rsfont/rsfont

NAME := payload
ROM := $(NAME).gba
ELF := $(NAME).elf

OBJ_DIR := build/$(NAME)

SHELL := /bin/bash -o pipefail

C_SUBDIRS := src src/gflib src/libpmagb
ASM_SUBDIRS := asm asm/gflib asm/libpmagb

ASM_SRCS := $(foreach subdir,$(ASM_SUBDIRS),$(wildcard $(subdir)/*.s))
ASM_OBJS := $(ASM_SRCS:%.s=$(OBJ_DIR)/%.o)
C_SRCS := $(foreach subdir,$(C_SUBDIRS),$(wildcard $(subdir)/*.c))
C_OBJS := $(C_SRCS:%.c=$(OBJ_DIR)/%.o)
DATA_ASM_SRCS := $(wildcard data/*.s sound/*.s sound/*/*.s)
DATA_ASM_OBJS := $(DATA_ASM_SRCS:%.s=$(OBJ_DIR)/%.o)
MID_SUBDIR := sound/songs/midi
MID_ASM_MIDS := $(wildcard $(MID_SUBDIR)/*.mid)
MID_ASM_SRCS := $(MID_ASM_MIDS:%.mid=%.s)
MID_ASM_OBJS := $(MID_ASM_SRCS:%.s=$(OBJ_DIR)/%.o)

SAMPLE_SUBDIR := sound/direct_sound_samples
AIF_SRCS := $(wildcard $(SAMPLE_SUBDIR)/*.aif)
AIF_BINS := $(AIF_SRCS:%.aif=%.bin)

CC1 := ../tools/agbcc/bin/old_agbcc
CPPFLAGS := -I ../tools/agbcc/include -iquote include -nostdinc -undef
CFLAGS := -O2 -g -mthumb-interwork -fhex-asm -Wimplicit -Werror
ASFLAGS := -mcpu=arm7tdmi -I include
LIBS := -L../../../tools/agbcc/lib -lgcc -lc

SUBDIRS := $(ASM_SUBDIRS) $(C_SUBDIRS) data sound sound/songs $(MID_SUBDIR)

ALL_OBJS := $(ASM_OBJS) $(C_OBJS) $(DATA_ASM_OBJS) $(MID_ASM_OBJS)

TOOLDIRS := $(filter-out ../tools/agbcc ../tools/binutils,$(wildcard ../tools/*))

infoshell = $(foreach line, $(shell $1 | sed "s/ /__SPACE__/g"), $(info $(subst __SPACE__, ,$(line))))

# Special rules for particular files
$(OBJ_DIR)/src/unk_200E344.o: CFLAGS := -g -mthumb-interwork -fhex-asm -Wimplicit -Werror
$(OBJ_DIR)/src/siirtc.o:      CC1    := ../tools/agbcc/bin/agbcc
$(OBJ_DIR)/src/siirtc.o:      CFLAGS := -g -mthumb-interwork -fhex-asm -Wimplicit -Werror

$(OBJ_DIR)/src/agb_flash.o:    CFLAGS := -O -mthumb-interwork -g
$(OBJ_DIR)/src/agb_flash.o:    CC1    := ../tools/agbcc/bin/agbcc
$(OBJ_DIR)/src/agb_flash_1m.o: CFLAGS := -O -mthumb-interwork -g
$(OBJ_DIR)/src/agb_flash_1m.o: CC1    := ../tools/agbcc/bin/agbcc
$(OBJ_DIR)/src/agb_flash_mx.o: CFLAGS := -O -mthumb-interwork -g
$(OBJ_DIR)/src/agb_flash_mx.o: CC1    := ../tools/agbcc/bin/agbcc
$(OBJ_DIR)/src/agb_flash_le.o: CFLAGS := -O -mthumb-interwork -g
$(OBJ_DIR)/src/agb_flash_le.o: CC1    := ../tools/agbcc/bin/agbcc

$(OBJ_DIR)/src/libpmagb/%.o:   CFLAGS := -O3 -mthumb-interwork -g -fhex-asm -Wimplicit -Werror
# Temporary
$(OBJ_DIR)/src/libpmagb/save.o:   CFLAGS := -O2 -mthumb-interwork -g -fhex-asm -Wimplicit -Werror

# Build tools when building the rom
# Disable dependency scanning for clean/tidy/tools
ifeq (,$(filter-out all compare,$(MAKECMDGOALS)))
$(call infoshell, $(MAKE) tools)
else
NODEP := 1
endif

$(shell mkdir -p $(SUBDIRS:%=$(OBJ_DIR)/%))

.SUFFIXES:
.SECONDARY:
.DELETE_ON_ERROR:
.SECONDEXPANSION:

.PHONY: all rom clean compare tools cleantools mostlyclean

all: rom
	@:

rom: $(ROM)
ifeq ($(COMPARE),1)
	@$(SHA1) rom.sha1
endif

mostlyclean:
	$(RM) $(ROM) $(ROM:%.gba=%.elf) $(ALL_OBJS) $(MID_ASM_SRCS) $(AIF_BINS)
	find . \( -name "*.rl" -or -name "*.lz" -or -name "*.[1248]bpp" -or -name "*.gbapal" \) -exec $(RM) {} +

clean: mostlyclean
	@$(foreach tool,$(TOOLDIRS),$(MAKE) clean -C $(tool);)

compare:
	@$(MAKE) COMPARE=1

tools:
	@$(foreach tool,$(TOOLDIRS),$(MAKE) -C $(tool);)

ifeq ($(NODEP),1)
$(OBJ_DIR)/asm/%.o: asm_dep :=
$(OBJ_DIR)/src/%.o: c_dep :=
$(OBJ_DIR)/data/%.o: data_dep :=
else
$(OBJ_DIR)/asm/%.o: asm_dep = $(shell $(SCANINC) -I "include" -I "" $*.s)
$(OBJ_DIR)/src/%.o: c_dep = $(shell $(SCANINC) -I "include" -I "" $*.c)
$(OBJ_DIR)/data/%.o: data_dep = $(shell $(SCANINC) -I "include" -I "" $*.s)
endif

$(ASM_OBJS): $(OBJ_DIR)/%.o: %.s $$(asm_dep)
	$(AS) $(ASFLAGS) -o $@ $<

$(C_OBJS): $(OBJ_DIR)/%.o: %.c $$(c_dep)
	@echo "CC <flags> -o $@ $<"
	@$(CPP) $(CPPFLAGS) -o $(OBJ_DIR)/$*.i $<
	@$(PREPROC) $(OBJ_DIR)/$*.i charmap.txt | $(CC1) $(CFLAGS) -o $(OBJ_DIR)/$*.s
	@echo -e ".text\n\t.align\t2, 0 @ Don't pad with nop\n" >> $(OBJ_DIR)/$*.s
	@$(AS) $(ASFLAGS) -o $@ $(OBJ_DIR)/$*.s

$(DATA_ASM_OBJS): $(OBJ_DIR)/%.o: %.s $$(data_dep)
	$(PREPROC) $< charmap.txt | $(CPP) $(CPPFLAGS) | $(AS) $(ASFLAGS) -o $@

$(MID_ASM_OBJS): $(OBJ_DIR)/%.o: %.s include/MPlayDef.s
	$(AS) $(ASFLAGS) -I sound -o $@ $<

$(OBJ_DIR)/sym_bss.ld: sym_bss.txt
	$(RAMSCRGEN) .bss $< ENGLISH | sed "s#tools/#../../../tools/#g" > $@

$(OBJ_DIR)/sym_common.ld: sym_common.txt $(C_OBJS) $(wildcard common_syms/*.txt common_syms/gflib/*.txt)
	$(RAMSCRGEN) COMMON $< ENGLISH -c $(OBJ_DIR)/src,common_syms | sed "s#tools/#../../../tools/#g" > $@

$(OBJ_DIR)/sym_ewram.ld: sym_ewram.txt
	$(RAMSCRGEN) ewram_data $< ENGLISH | sed "s#tools/#../../../tools/#g" > $@

$(OBJ_DIR)/ld_script.ld: ld_script.txt $(OBJ_DIR)/sym_bss.ld $(OBJ_DIR)/sym_common.ld $(OBJ_DIR)/sym_ewram.ld
	sed "s#tools/#../../../tools/#g" $< > $@

$(ELF): $(OBJ_DIR)/ld_script.ld $(ALL_OBJS)
	cd $(OBJ_DIR) && $(LD) -Map ../../$(NAME).map -T ../../$< -o ../../$@ $(LIBS)

$(ROM): $(ELF)
	$(OBJCOPY) -O binary $< $@

include songs.mk
include fonts.mk

sound/%.bin: sound/%.aif
	$(AIF) $< $@ $(AIFFLAGS)

%.lz: %
	$(GFX) $(GFXFLAGS) $< $@

%.4bpp: %.png
	$(GFX) $(GFXFLAGS) $< $@

%.8bpp: %.png
	$(GFX) $(GFXFLAGS) $< $@

%.gbapal: %.png
	$(GFX) $(GFXFLAGS) $< $@

%.gbapal: %.pal
	$(GFX) $(GFXFLAGS) $< $@

%.rl: %
	$(GFX) $(GFXFLAGS) $< $@

### Debug Print ###

print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true
