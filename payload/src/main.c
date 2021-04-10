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

struct UnkStruct_02020CD0_sub
{
    u32 unk_0;
    struct Coords16 pos;
    u16 unk_8;
    u16 unk_a;
};

struct UnkStruct_02020CD0
{
    u8 unk0;
    u8 unk1;
    u8 unk2;
    u16 unk4;
    u16 unk6;
    struct Coords16 unk8;
    const struct UnkStruct_02020CD0_sub * unkC;
    void (*unk10)(struct UnkStruct_02020CD0 *);
    void * unk14[4];
};

extern u8 ewram_start[];
extern struct UnkStruct_02020CD0 gUnknown_02020CD0[18];
extern void (*gUnknown_02022BD0[])(void);
extern u32 gUnknown_02022C08;
extern void (*gUnknown_02022C0C)(void);
extern u16 gUnknown_02022C10[4];
extern u16 gUnknown_02022C18[4];
extern u8 gUnknown_02022C20[4];
extern u16 gUnknown_02022EB8;
extern struct RomInfo *gUnknown_020251E8;
extern u8 ewram_end[];

BSS_DATA u16 gUnknown_02021360;
BSS_DATA u16 gUnknown_02021362;
BSS_DATA u16 gUnknown_02021364;
BSS_DATA u8 gUnknown_02021368;
BSS_DATA u8 gUnknown_02021369;

void sub_02008638(void);
void sub_020086B8(void);
void sub_02008708(void);
void sub_0200870C(void);
void sub_020087B4(void);
void sub_02008C00(void);
void sub_02008C80(void);
void sub_02008D1C(void);
void sub_02009228(void);
bool32 sub_02009324(u32);

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

void sub_0200870C(void)
{
    s32 i;
    u16 bgCnt;
    void * screenBase;
    size_t size;
    s32 r2;
    REG_BG0HOFS = gUnknown_02022C10[0];
    REG_BG1HOFS = gUnknown_02022C10[1];
    REG_BG2HOFS = gUnknown_02022C10[2];
    REG_BG3HOFS = gUnknown_02022C10[3];
    REG_BG0VOFS = gUnknown_02022C18[0];
    REG_BG1VOFS = gUnknown_02022C18[1];
    REG_BG2VOFS = gUnknown_02022C18[2];
    REG_BG3VOFS = gUnknown_02022C18[3];
    for (i = 0; i < 4; i++)
    {
        if (gUnknown_02022C20[i])
        {
            gUnknown_02022C20[i] = 0;
            bgCnt = *(vu16 *)(REG_ADDR_BG0CNT + 2 * i);
            screenBase = (void *)(BG_VRAM + ((bgCnt & 0x1F00) << 3));
            r2 = bgCnt & 0xC000 ? 2 : 1;
            CpuCopy32((void *)(0x03000000 + 0x1000 * i), screenBase, r2 * 0x800);
        }
    }
}

void sub_020087B4(void)
{
    CpuFill16(0, (void *)0x03000000, 0x4000);
    CpuFill16(0, gUnknown_02022C10, 8);
    CpuFill16(0, gUnknown_02022C18, 8);
    gUnknown_02022C20[3] = 0;
    gUnknown_02022C20[2] = 0;
    gUnknown_02022C20[1] = 0;
    gUnknown_02022C20[0] = 0;
}

void sub_0200880C(int bgNum, int left, int top, int width, int height, const u16 * src)
{
    int x;
    u16 * ptr = (void *)(0x03000000 + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++, src++)
        {
            ptr[x] = *src;
        }
        ptr += 32;
        height--;
    }
}

void sub_02008850(int bgNum, int left, int top, int width, int height, u16 * dest)
{
    int x;
    u16 * ptr = (void *)(0x03000000 + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++, dest++)
        {
            *dest = ptr[x];
        }
        ptr += 32;
        height--;
    }
}

void sub_02008894(int bgNum, int left, int top, int width, int height, int paletteNum)
{
    int x;
    u16 * ptr = (void *)(0x03000000 + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++)
        {
            ptr[x] &= 0xFFF;
            ptr[x] |= paletteNum << 12;
        }
        ptr += 32;
        height--;
    }
}

void sub_020088E8(int bgNum, int x, int y, u16 tileNum)
{
    u16 * ptr = (void *)(0x03000000 + (bgNum << 12) + (y << 6) + (x << 1));
    *ptr = tileNum;
}

void sub_02008904(int bgNum, int left, int top, int width, int height,u16 tileNum)
{
    int x;
    u16 * ptr = (void *)(0x03000000 + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++)
        {
            ptr[x] = tileNum;
        }
        ptr += 32;
        height--;
    }
}

void sub_02008948(int bgNum, int srcLeft, int srcTop, int width, int height, int destLeft, int destTop)
{
    int x;
    const u16 * srcPtr;
    u16 * destPtr;

    srcPtr = (void *)(0x03000000 + (bgNum << 12) + (srcTop << 6) + (srcLeft << 1));
    destPtr = (void *)(0x03000000 + (bgNum << 12) + (destTop << 6) + (destLeft << 1));

    while (height)
    {
        for (x = 0; x < width; x++)
        {
            destPtr[x] = srcPtr[x];
        }
        srcPtr += 32;
        destPtr += 32;
        height--;
    }
}

void sub_020089A4(int bgNum, u16 x, u16 y)
{
    gUnknown_02022C10[bgNum] = x;
    gUnknown_02022C18[bgNum] = y;
}

void sub_020089BC(struct UnkStruct_02020CD0 * a0, struct UnkStruct_02020CD0 * a1)
{
    a1->unk1 = a0->unk1;
    a1->unk0 = a0 - gUnknown_02020CD0;
    a0->unk1 = gUnknown_02020CD0[a0->unk1].unk0 = a1 - gUnknown_02020CD0;
}

struct UnkStruct_02020CD0 * sub_02008A10(s32 a, s32 b, const struct UnkStruct_02020CD0_sub * c)
{
    s32 i;
    struct UnkStruct_02020CD0 * r7 = &gUnknown_02020CD0[gUnknown_02020CD0[0].unk1];
    gUnknown_02020CD0[r7->unk0].unk1 = r7->unk1;
    gUnknown_02020CD0[r7->unk1].unk0 = r7->unk0;
    sub_020089BC(&gUnknown_02020CD0[1], r7);
    r7->unk8.x = a;
    r7->unk8.y = b;
    r7->unkC = c;
    r7->unk2 = 0;
    r7->unk4 = 0;
    r7->unk6 = 0;
    r7->unk10 = NULL;
    for (i = 0; i < 4; i++)
        r7->unk14[i] = NULL;
    return r7;
}

struct UnkStruct_02020F58
{
    struct OamData unk_0000[0x80];
    u8 unk_4000;
};

extern struct UnkStruct_02020F58 gUnknown_02020F58;

void sub_02008A84(struct UnkStruct_02020CD0 * ptr)
{
    u32 ip;
    struct OamData * r7;
    const struct UnkStruct_02020CD0_sub * r4;
    s32 r0;
    s32 r5;
    s32 r3;
    s32 sb;
    u32 r2;
    u32 r8;

    ip = gUnknown_02020F58.unk_4000;
    r7 = &gUnknown_02020F58.unk_0000[ip];

    r4 = ptr->unkC;
    while (r4->unk_0 != 0xFFFF)
    {
        if (ip == 0x80)
            return;

        if ((r5 = r4->pos.x + ptr->unk8.x) < 0xF0 && (r3 = r4->pos.y + ptr->unk8.y) < 0xA0)
        {
            r2 = ((r4->unk_0 & 0xC000) >> 12) + (r4->unk_0 >> 30);
            r8 = r4->unk_0;
            switch (r2)
            {
            case 0:
            case 8:
            case 9:
                r0 = 8;
                break;
            case 1:
            case 4:
            case 10:
                r0 = 16;
                break;
            case 2:
            case 5:
            case 6:
            case 11:
                r0 = 32;
                break;;
            case 3:
            case 7:
                r0 = 64;
                break;
            default:
                r0 = 0;
                break;
            }
            if (r5 + r0 >= 0)
            {
                switch (r2)
                {
                case 0:
                case 4:
                case 5:
                    sb = 8;
                    break;
                case 1:
                case 6:
                case 8:
                    sb = 16;
                    break;
                case 2:
                case 7:
                case 9:
                case 10:
                    sb = 32;
                    break;
                case 3:
                case 11:
                    sb = 64;
                    break;
                }
                if (r3 + sb >= 0)
                {
                    r5 &= 0x1FF;
                    r3 &= 0xFF;
                    *(u32 *)r7 = r3 | ((r5 << 16) | r8);
                    *((u16 *)r7 + 2) = ((r4->unk_8 & 0xFFF) | ptr->unk4) + ptr->unk6;
                    r7++;
                    ip++;
                }
            }
        }
        r4++;
    }
    gUnknown_02020F58.unk_4000 = ip;
}

asm(".section .text.020092C0");

void sub_020092A4(u16 a0, u16 a1)
{
    gUnknown_02021360 = a0;
    gUnknown_02021362 = a1;
    gUnknown_02021364 = 1;
}

void AutoUnCompVram(const void * src, void * dest)
{
    switch (*(u8 *)src & 0xF0)
    {
    case 0x10:
        LZ77UnCompVram(src, dest);
        break;
    case 0x20:
        HuffUnComp(src, dest);
        break;
    case 0x30:
        RLUnCompVram(src, dest);
        break;
    }
}

void sub_020092F0(void)
{
    gUnknown_02021368 = 0;
    gUnknown_02021369 = 0;
    m4aSoundInit();
}

void sub_0200930C(void)
{
    gUnknown_02021368 = 1;
    gUnknown_02021369 = 0;
}

bool32 sub_02009324(u32 a0)
{
    if (a0 && gUnknown_02021368)
        gUnknown_02021369 = 1;
    return gUnknown_02021369;
}

struct UnkStruct_201DE04
{
    struct SongHeader * songHeader;
    u16 player;
};

struct UnkStruct_201DDF8
{
    struct MusicPlayerInfo * mPlayInfo;
    u8 unknown[8];
};

extern const struct UnkStruct_201DE04 gUnknown_0201DE04[];
extern const struct UnkStruct_201DDF8 gUnknown_0201DDF8[];

void sub_02009344(u16 a0)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gUnknown_0201DDF8[gUnknown_0201DE04[a0].player].mPlayInfo;
    MPlayStart(mPlayInfo, gUnknown_0201DE04[a0].songHeader);
    m4aMPlayFadeOutTemporarily(mPlayInfo);
}

void sub_02009378(u16 a0)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gUnknown_0201DDF8[gUnknown_0201DE04[a0].player].mPlayInfo;
    m4aMPlayStop(mPlayInfo);
}

void sub_020093A0(void)
{
    m4aMPlayAllStop();
}

bool8 sub_020093AC(void)
{
    return TRUE;
}

void sub_020093B0(u16 a0, u16 a1)
{
    struct MusicPlayerInfo * mPlayInfo;

    u16 speed = a1 >> 4;
    if (speed == 0)
        speed = 1;

    mPlayInfo = gUnknown_0201DDF8[gUnknown_0201DE04[a0].player].mPlayInfo;
    m4aMPlayFadeOut(mPlayInfo, speed);
}

void sub_020093E8(u16 a0, u16 a1)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gUnknown_0201DDF8[gUnknown_0201DE04[a0].player].mPlayInfo;
    m4aMPlayVolumeControl(mPlayInfo, 0xFF, a1);
}

void sub_0200941C(u16 a0, u16 a1)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gUnknown_0201DDF8[gUnknown_0201DE04[a0].player].mPlayInfo;
    m4aMPlayTempoControl(mPlayInfo, a1);
}

void sub_0200944C(u16 a0, s16 a1)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gUnknown_0201DDF8[gUnknown_0201DE04[a0].player].mPlayInfo;
    m4aMPlayPitchControl(mPlayInfo, 0xFF, a1);
}

void sub_02009480(void)
{
    gUnknown_02021369 = 0;
    m4aSoundVSyncOff();
}

void sub_02009494(void)
{
    m4aSoundVSyncOn();
    gUnknown_02021369 = 1;
}
