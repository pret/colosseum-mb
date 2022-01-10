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
PREPROC := tools/preproc/preproc
SCANINC := tools/scaninc/scaninc
RAMSCRGEN := tools/ramscrgen/ramscrgen
GBAFIX := tools/gbafix/gbafix
GBAGFX := tools/gbagfx/gbagfx
PYTHON := python3

NAME := colosseum-mb
TARGET ?= EM
ifeq ($(TARGET),EM)
GAPFILL := 0
NAME := $(NAME)-em
else
ifeq ($(TARGET),FRLG)
GAPFILL := 255
NAME := $(NAME)-frlg
else
$(error TARGET must be one of "EM" or "FRLG")
endif
endif
ROM := $(NAME).gba
ELF := $(NAME).elf

PAYLOAD   := payload/payload.gba
PAYLOADLZ := $(PAYLOAD).lz

OBJ_DIR := build/$(NAME)

ASM_SRCS := $(wildcard asm/*.s)
ASM_OBJS := $(ASM_SRCS:%.s=$(OBJ_DIR)/%.o)
C_SRCS := $(wildcard src/*.c)
C_OBJS := $(C_SRCS:%.c=$(OBJ_DIR)/%.o)
DATA_ASM_SRCS := $(wildcard data/*.s)
DATA_ASM_OBJS := $(DATA_ASM_SRCS:%.s=$(OBJ_DIR)/%.o)

CC1 := tools/agbcc/bin/old_agbcc
CPPFLAGS := -I tools/agbcc/include -iquote include -nostdinc -undef
CFLAGS := -O2 -mthumb-interwork -fhex-asm -Wimplicit -Werror
ASFLAGS := -mcpu=arm7tdmi
LIBS := -L../../tools/agbcc/lib -lgcc -lc

SUBDIRS := asm src data

ALL_OBJS := $(ASM_OBJS) $(C_OBJS) $(DATA_ASM_OBJS)

TOOLDIRS := $(filter-out tools/agbcc tools/binutils,$(wildcard tools/*))

infoshell = $(foreach line, $(shell $1 | sed "s/ /__SPACE__/g"), $(info $(subst __SPACE__, ,$(line))))

# Special rules for particular files
$(OBJ_DIR)/src/unk_200E344.o: CFLAGS := -mthumb-interwork -fhex-asm -Wimplicit -Werror
$(OBJ_DIR)/src/siirtc.o:      CC1    := tools/agbcc/bin/agbcc
$(OBJ_DIR)/src/siirtc.o:      CFLAGS := -mthumb-interwork -fhex-asm -Wimplicit -Werror

MAKEFLAGS += --no-print-directory
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

.PHONY: all rom clean compare tools cleantools mostlyclean payload frlg em

ALL_ROMS := colosseum-mb-em.gba colosseum-mb-frlg.gba

all: rom
	@:

rom: $(ROM)
ifeq ($(COMPARE),1)
	@$(SHA1) $(NAME).sha1
endif

mostlyclean:
	$(MAKE) -C payload mostlyclean
	$(RM) -r $(ALL_ROMS) $(ALL_ROMS:%.gba=%.elf) $(ALL_ROMS:%.gba=%.map) build/

clean: mostlyclean
	$(MAKE) -C payload clean
	@$(foreach tool,$(TOOLDIRS),$(MAKE) clean -C $(tool);)

tools:
	@$(foreach tool,$(TOOLDIRS),$(MAKE) -C $(tool);)

ifeq ($(NODEP),1)
$(OBJ_DIR)/asm/%.o: asm_dep :=
$(OBJ_DIR)/src/%.o: c_dep :=
$(OBJ_DIR)/data/%.o: data_dep :=
else
$(OBJ_DIR)/asm/%.o: asm_dep = $(shell $(SCANINC) -I include $*.s)
$(OBJ_DIR)/src/%.o: c_dep = $(shell $(SCANINC) -I include $*.c)
$(OBJ_DIR)/data/%.o: data_dep = $(shell $(SCANINC) -I include $*.s)
endif

$(ASM_OBJS): $(OBJ_DIR)/%.o: %.s $$(asm_dep)
	$(AS) $(ASFLAGS) -o $@ $<

$(C_OBJS): $(OBJ_DIR)/%.o: %.c $$(c_dep)
	$(CPP) $(CPPFLAGS) -o $(OBJ_DIR)/$*.i $<
	$(PREPROC) $(OBJ_DIR)/$*.i charmap.txt | $(CC1) $(CFLAGS) -o $(OBJ_DIR)/$*.s
	$(AS) $(ASFLAGS) -o $@ $(OBJ_DIR)/$*.s

$(DATA_ASM_OBJS): $(OBJ_DIR)/%.o: %.s $$(data_dep)
	$(PREPROC) $< charmap.txt | $(CPP) $(CPPFLAGS) | $(AS) $(ASFLAGS) -o $@

$(OBJ_DIR)/ld_script.ld: ld_script.txt
	cd $(OBJ_DIR) && sed "s#tools/#../../tools/#g" ../../$< > ld_script.ld

$(ELF): $(OBJ_DIR)/ld_script.ld $(ALL_OBJS)
	cd $(OBJ_DIR) && $(LD) -Map ../../$(NAME).map -T ../../$< -o ../../$@ $(LIBS)
	$(GBAFIX) $@ -cTEST -m01 -r0 --silent

$(ROM): $(ELF)
	$(OBJCOPY) -O binary --gap-fill $(GAPFILL) --pad-to 0x2028000 $< $@
	$(GBAFIX) $@ --silent
	@# Hack to get the ROM header complement to match
	$(PYTHON) fixrom.py $@

%.lz: %
	$(GBAGFX) $< $@

payload:
	@$(MAKE) -C payload COMPARE=$(COMPARE)

$(PAYLOAD): payload
	@:

compare:
	@$(MAKE) COMPARE=1

frlg: ; @$(MAKE) TARGET=FRLG
em:   ; @$(MAKE) TARGET=EM
