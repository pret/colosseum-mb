#include "global.h"
#include "m4a.h"

struct RomInfo
{
    /*0x00*/ int gameVersion;
    /*0x04*/ int gameLanguage;
    /*0x08*/ char gameTitle[32];
    /*0x28*/ const struct CompressedSpriteSheet *monFrontPicTable;
    /*0x2C*/ const struct CompressedSpriteSheet * monBackPicTable;
    /*0x30*/ const struct CompressedSpritePalette *monPaletteTable;
    /*0x34*/ const struct CompressedSpritePalette *monShinyPaletteTable;
    /*0x38*/ const u8 *const *monIconTable;
    /*0x3C*/ const u8 *gMonIconPaletteIndices;
    /*0x40*/ const struct SpritePalette *monIconPaletteTable;
    /*0x44*/ const u8 *speciesNames;
    /*0x48*/ const u8 *moveNames;
    /*0x4C*/ const struct Decoration *decorations;
    /*0x50*/ ptrdiff_t unk50;
    /*0x54*/ ptrdiff_t unk54;
    /*0x58*/ ptrdiff_t unk58;
    /*0x5C*/ ptrdiff_t unk5C;
    /*0x60*/ ptrdiff_t unk60;
    /*0x64*/ ptrdiff_t unk64;
    /*0x68*/ ptrdiff_t unk68;
    /*0x6C*/ ptrdiff_t unk6C;
    /*0x70*/ ptrdiff_t unk70;
    /*0x74*/ u8 unk74[16];
    /*0x84*/ ptrdiff_t unk84;
    /*0x88*/ ptrdiff_t unk88;
    /*0x8C*/ ptrdiff_t unk8C;
    /*0x90*/ ptrdiff_t unk90;
    /*0x94*/ ptrdiff_t unk94;
    /*0x98*/ ptrdiff_t unk98;
    /*0x9C*/ ptrdiff_t unk9C;
    /*0xA0*/ ptrdiff_t unkA0;
    /*0xA4*/ ptrdiff_t unkA4;
    /*0xA8*/ ptrdiff_t unkA8;
    /*0xAC*/ ptrdiff_t unkAC;
    /*0xB0*/ ptrdiff_t unkB0;
    /*0xB4*/ ptrdiff_t unkB4;
    /*0xB8*/ ptrdiff_t unkB8;
    /*0xBC*/ const struct BaseStats *baseStats;
    /*0xC0*/ const u8 *abilityNames;
    /*0xC4*/ const u8 *abilityDescriptions;
    /*0xC8*/ const struct Item *items;
    /*0xCC*/ const struct BattleMove *unkCC;
    /*0xD0*/ const struct CompressedSpriteSheet *ballSpriteSheets;
    /*0xD4*/ const struct CompressedSpritePalette *ballSpritePalettes;
    /*0xD8*/ ptrdiff_t unkD8;
    /*0xDC*/ ptrdiff_t unkDC;
    /*0xE0*/ ptrdiff_t unkE0;
    /*0xE4*/ ptrdiff_t unkE4;
    /*0xE8*/ ptrdiff_t unkE8;
    /*0xEC*/ ptrdiff_t unkEC;
    /*0xF0*/ ptrdiff_t unkF0;
    /*0xF4*/ ptrdiff_t unkF4;
    /*0xF8*/ ptrdiff_t unkF8;
    /*0xFC*/ const u8 *moveDescriptions;
};

extern u8 ewram_start[];
extern u32 gUnknown_02022C08;
extern void (*gUnknown_02022BD0[])(void);
extern void (*gUnknown_02022C0C)(void);
extern u16 gUnknown_02022EB8;
extern struct RomInfo *gUnknown_020251E8;
extern u8 ewram_end[];

void sub_02008638(void);
void sub_020086B8(void);
void sub_02008708(void);
void sub_0200870C(void);
void sub_020087B4(void);
void sub_02008C00(void);
void sub_02008C80(void);
void sub_02008D1C(void);
void sub_02009228(void);
bool32 sub_02009324(u8);

extern void sub_020002B4(void);

#define SR_KEYS (A_BUTTON | B_BUTTON | SELECT_BUTTON | START_BUTTON)

#define TEST_BUTTON(arr, flags) ({(arr) & (flags);})

void AgbMain(void)
{
    REG_IME = 0;
    RegisterRamReset(RESET_ALL & ~(RESET_EWRAM | RESET_IWRAM));
    CpuFill16(0, ewram_start, ewram_end - ewram_start);
    REG_WAITCNT = WAITCNT_SRAM_4 | WAITCNT_WS0_N_3 | WAITCNT_WS0_S_1 | WAITCNT_WS1_N_3 | WAITCNT_WS1_S_1 | WAITCNT_WS2_N_3 | WAITCNT_WS2_S_1 | WAITCNT_PREFETCH_ENABLE;
    sub_02008638();
    sub_020087B4();
    sub_02008C80();
    sub_020002B4();
    SoftReset(RESET_ALL);
}

u32 sub_020085F4(void)
{
    return gUnknown_02022C08;
}

void sub_02008600(u32 a0)
{
    for (; a0 != 0; a0--)
    {
        sub_02008C00();
        VBlankIntrWait();
        sub_02009228();
        if (TEST_BUTTON(gUnknown_02022EB8, SR_KEYS) == SR_KEYS)
            SoftReset(0);
    }
}

void sub_02008638(void)
{
    int i;
    gUnknown_02022C0C = NULL;
    for (i = 0; i < 14u; i++)
        gUnknown_02022BD0[i] = sub_02008708;
    if (sub_020086B8 != NULL)
        gUnknown_02022BD0[1] = sub_020086B8;
    else
        gUnknown_02022BD0[1] = sub_02008708;
}

void sub_02008674(int i, void (*func)(void))
{
    if (func != NULL)
        gUnknown_02022BD0[i] = func;
    else
        gUnknown_02022BD0[i] = sub_02008708;
}

void sub_020086A0(void (*a0)(void))
{
    u16 imeBak = REG_IME;
    REG_IME = 0;
    gUnknown_02022C0C = a0;
    REG_IME = imeBak;
}

void sub_020086B8(void)
{
    if (sub_02009324(0))
        m4aSoundVSync();
    sub_02008D1C();
    sub_0200870C();
    gUnknown_02022C08++;
    INTR_CHECK = TRUE;
    if (gUnknown_02022C0C != NULL)
        gUnknown_02022C0C();
    if (sub_02009324(1))
        m4aSoundMain();
}

void sub_02008708(void)
{
    
}
