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

struct Subsprites
{
    u32 oam;
    s16 x;
    s16 y;
    u16 baseBlock;
    u16 unk_a;
};

struct Sprite
{
    u8 prev;
    u8 next;
    u8 flag;
    u16 paletteNum;
    u16 tileOffset;
    s16 x;
    s16 y;
    const struct Subsprites * spriteTemplates;
    void (*callback)(struct Sprite *);
    void * unk14[4];
};

extern u8 ewram_start[];
extern struct Sprite gSprites[18];
extern void (*gIntrFuncs[])(void);
extern u32 gVBlankCounter;
extern void (*gVBlankCallback)(void);
extern u16 gBgHofsBuffer[4];
extern u16 gBgVofsBuffer[4];
extern u8 gBgTilemapBufferTransferScheduled[4];
extern u16 gUnknown_02022EB8;
extern struct RomInfo *gUnknown_020251E8;
extern u8 ewram_end[];

void InitIntr(void);
void VBlankIntr(void);
void IntrDummy(void);
void DoGpuUpdateAndTilemapTransfers(void);
void ResetGpuBuffers(void);
void UpdateSprites(void);
void InitOam(void);
void DoOamBufferTransfer(void);
void sub_02009228(void);
bool32 EnableSoundVSync(u32);

extern void GF_Main(void);

#define SR_KEYS (A_BUTTON | B_BUTTON | SELECT_BUTTON | START_BUTTON)

#define TEST_BUTTON(arr, flags) ({(arr) & (flags);})

void AgbMain(void)
{
    REG_IME = 0;
    RegisterRamReset(RESET_ALL & ~(RESET_EWRAM | RESET_IWRAM));
    CpuFill16(0, ewram_start, ewram_end - ewram_start);
    REG_WAITCNT = WAITCNT_SRAM_4 | WAITCNT_WS0_N_3 | WAITCNT_WS0_S_1 | WAITCNT_WS1_N_3 | WAITCNT_WS1_S_1 | WAITCNT_WS2_N_3 | WAITCNT_WS2_S_1 | WAITCNT_PREFETCH_ENABLE;
    InitIntr();
    ResetGpuBuffers();
    InitOam();
    GF_Main();
    SoftReset(RESET_ALL);
}

u32 sub_020085F4(void)
{
    return gVBlankCounter;
}

void sub_02008600(u32 a0)
{
    for (; a0 != 0; a0--)
    {
        UpdateSprites();
        VBlankIntrWait();
        sub_02009228();
        if (TEST_BUTTON(gUnknown_02022EB8, SR_KEYS) == SR_KEYS)
            SoftReset(0);
    }
}

void InitIntr(void)
{
    int i;
    gVBlankCallback = NULL;
    for (i = 0; i < 14u; i++)
        gIntrFuncs[i] = IntrDummy;
    if (VBlankIntr != NULL)
        gIntrFuncs[1] = VBlankIntr;
    else
        gIntrFuncs[1] = IntrDummy;
}

void SetIntrFunc(int i, void (*func)(void))
{
    if (func != NULL)
        gIntrFuncs[i] = func;
    else
        gIntrFuncs[i] = IntrDummy;
}

void SetVBlankCallback(void (*cb)(void))
{
    u16 imeBak = REG_IME;
    REG_IME = 0;
    gVBlankCallback = cb;
    REG_IME = imeBak;
}

void VBlankIntr(void)
{
    if (EnableSoundVSync(0))
        m4aSoundVSync();
    DoOamBufferTransfer();
    DoGpuUpdateAndTilemapTransfers();
    gVBlankCounter++;
    INTR_CHECK = INTR_FLAG_VBLANK;
    if (gVBlankCallback != NULL)
        gVBlankCallback();
    if (EnableSoundVSync(1))
        m4aSoundMain();
}

void IntrDummy(void)
{
    
}

void DoGpuUpdateAndTilemapTransfers(void)
{
    s32 i;
    u16 bgCnt;
    void * screenBase;
    size_t size;
    s32 r2;
    REG_BG0HOFS = gBgHofsBuffer[0];
    REG_BG1HOFS = gBgHofsBuffer[1];
    REG_BG2HOFS = gBgHofsBuffer[2];
    REG_BG3HOFS = gBgHofsBuffer[3];
    REG_BG0VOFS = gBgVofsBuffer[0];
    REG_BG1VOFS = gBgVofsBuffer[1];
    REG_BG2VOFS = gBgVofsBuffer[2];
    REG_BG3VOFS = gBgVofsBuffer[3];
    for (i = 0; i < 4; i++)
    {
        if (gBgTilemapBufferTransferScheduled[i])
        {
            gBgTilemapBufferTransferScheduled[i] = 0;
            bgCnt = *(vu16 *)(REG_ADDR_BG0CNT + 2 * i);
            screenBase = (void *)(BG_VRAM + ((bgCnt & 0x1F00) << 3));
            r2 = bgCnt & 0xC000 ? 2 : 1;
            CpuCopy32((void *)(0x03000000 + 0x1000 * i), screenBase, r2 * BG_SCREEN_SIZE);
        }
    }
}

void ResetGpuBuffers(void)
{
    CpuFill16(0, (void *)0x03000000, 0x4000);
    CpuFill16(0, gBgHofsBuffer, 8);
    CpuFill16(0, gBgVofsBuffer, 8);
    gBgTilemapBufferTransferScheduled[3] = 0;
    gBgTilemapBufferTransferScheduled[2] = 0;
    gBgTilemapBufferTransferScheduled[1] = 0;
    gBgTilemapBufferTransferScheduled[0] = 0;
}

void CopyToBgTilemapBufferRect(int bgNum, int left, int top, int width, int height, const u16 * src)
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

void CopyFromBgTilemapBufferRect(int bgNum, int left, int top, int width, int height, u16 * dest)
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

void SetBgTilemapBufferPaletteRect(int bgNum, int left, int top, int width, int height, int paletteNum)
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

void SetBgTilemapBufferTileAt(int bgNum, int x, int y, u16 tileNum)
{
    u16 * ptr = (void *)(0x03000000 + (bgNum << 12) + (y << 6) + (x << 1));
    *ptr = tileNum;
}

void FillBgTilemapBufferRect(int bgNum, int left, int top, int width, int height, u16 tileNum)
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

void CopyRectWithinBgTilemapBuffer(int bgNum, int srcLeft, int srcTop, int width, int height, int destLeft, int destTop)
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

void SetBgPos(int bgNum, u16 x, u16 y)
{
    gBgHofsBuffer[bgNum] = x;
    gBgVofsBuffer[bgNum] = y;
}

struct OamBuffer
{
    struct OamData oamBuffer[0x80];
    u8 numSprites;
};

BSS_DATA struct OamBuffer sOamBuffer;

void InsertSprite(struct Sprite * a0, struct Sprite * a1)
{
    a1->next = a0->next;
    a1->prev = a0 - gSprites;
    a0->next = gSprites[a0->next].prev = a1 - gSprites;
}

struct Sprite * AddSprite(s32 x, s32 y, const struct Subsprites * subsprites)
{
    s32 i;
    struct Sprite * r7 = &gSprites[gSprites[0].next];
    gSprites[r7->prev].next = r7->next;
    gSprites[r7->next].prev = r7->prev;
    InsertSprite(&gSprites[1], r7);
    r7->x = x;
    r7->y = y;
    r7->spriteTemplates = subsprites;
    r7->flag = 0;
    r7->paletteNum = 0;
    r7->tileOffset = 0;
    r7->callback = NULL;
    for (i = 0; i < 4; i++)
        r7->unk14[i] = NULL;
    return r7;
}

void BufferSpriteOAM(struct Sprite * ptr)
{
    u32 num_sprites;
    struct OamData * oam_p;
    const struct Subsprites * templates;
    s32 width;
    s32 left;
    s32 top;
    s32 height;
    u32 size;
    u32 flags;

    num_sprites = sOamBuffer.numSprites;
    oam_p = &sOamBuffer.oamBuffer[num_sprites];

    templates = ptr->spriteTemplates;
    while (templates->oam != 0xFFFF)
    {
        if (num_sprites == 0x80)
            return;

        if ((left = templates->x + ptr->x) < 0xF0 && (top = templates->y + ptr->y) < 0xA0)
        {
            size = ((templates->oam & 0xC000) >> 12) + (templates->oam >> 30);
            flags = templates->oam;
            switch (size)
            {
            case SPRITE_SIZE_8x8:
            case SPRITE_SIZE_8x16:
            case SPRITE_SIZE_8x32:
                width = 8;
                break;
            case SPRITE_SIZE_16x16:
            case SPRITE_SIZE_16x8:
            case SPRITE_SIZE_16x32:
                width = 16;
                break;
            case SPRITE_SIZE_32x32:
            case SPRITE_SIZE_32x8:
            case SPRITE_SIZE_32x16:
            case SPRITE_SIZE_32x64:
                width = 32;
                break;;
            case SPRITE_SIZE_64x64:
            case SPRITE_SIZE_64x32:
                width = 64;
                break;
            default:
                width = 0;
                break;
            }
            if (left + width >= 0)
            {
                switch (size)
                {
                case SPRITE_SIZE_8x8:
                case SPRITE_SIZE_16x8:
                case SPRITE_SIZE_32x8:
                    height = 8;
                    break;
                case SPRITE_SIZE_16x16:
                case SPRITE_SIZE_32x16:
                case SPRITE_SIZE_8x16:
                    height = 16;
                    break;
                case SPRITE_SIZE_32x32:
                case SPRITE_SIZE_64x32:
                case SPRITE_SIZE_8x32:
                case SPRITE_SIZE_16x32:
                    height = 32;
                    break;
                case SPRITE_SIZE_64x64:
                case SPRITE_SIZE_32x64:
                    height = 64;
                    break;
                }
                if (top + height >= 0)
                {
                    left &= 0x1FF;
                    top &= 0xFF;
                    *(u32 *)oam_p = top | ((left << 16) | flags);
                    *((u16 *)oam_p + 2) = ((templates->baseBlock & 0xFFF) | ptr->paletteNum) + ptr->tileOffset;
                    oam_p++;
                    num_sprites++;
                }
            }
        }
        templates++;
    }
    sOamBuffer.numSprites = num_sprites;
}

void UpdateSprites(void)
{
    s32 r2;
    s32 i;
    struct OamData * r4;
    struct Sprite * ptr;

    i = gSprites[1].next;

    while (i != 1)
    {
        ptr = &gSprites[i];

        if (ptr->callback != NULL)
            ptr->callback(ptr);

        if (!(ptr->flag & 1))
            BufferSpriteOAM(ptr);
        i = ptr->next;
    }

    r4 = &sOamBuffer.oamBuffer[sOamBuffer.numSprites];
    for (r2 = sOamBuffer.numSprites; r2 < 0x80 && *(u16 *)r4 != 0x200; r2++, r4++)
    {
        *(u16 *)r4 = 0x200;
    }
    sOamBuffer.numSprites = 0;
}

void InitOam(void)
{
    s32 i;
    struct OamData * r2;
    struct Sprite * r4;

    CpuFill16(0, gSprites, sizeof(gSprites));
    gSprites[0].next = 0;
    gSprites[0].prev = 0;
    gSprites[1].next = 1;
    gSprites[1].prev = 1;

    for (i = 2; i < 18; i++)
    {
        InsertSprite(&gSprites[0], &gSprites[i]);
    }
    sOamBuffer.numSprites = 0;
    r2 = &sOamBuffer.oamBuffer[0];
    for (i = 0; i < 0x80; i++, r2++)
        *(u16 *)r2 = 0x200;
}

void MoveSpriteToHead(struct Sprite * a0)
{
    gSprites[a0->prev].next = a0->next;
    gSprites[a0->next].prev = a0->prev;
    InsertSprite(&gSprites[0], a0);
}

void DoOamBufferTransfer(void)
{
    DmaCopy32(3, sOamBuffer.oamBuffer, (void *)OAM, OAM_SIZE);
}

void SetSpritePos(struct Sprite * r0, s32 r1, s32 r2)
{
    r0->x = r1;
    r0->y = r2;
}

void AddSpritePos(struct Sprite * r0, s32 r1, s32 r2)
{
    r0->x += r1;
    r0->y += r2;
}

void sub_02008D54(struct Sprite * r0, s32 r1)
{
    r0->paletteNum = r1 << 12;
}

void sub_02008D5C(struct Sprite * r0, s32 r1)
{
    r0->tileOffset = r1;
}

void sub_02008D60(struct Sprite * r0, s32 r1)
{
    r0->flag = ((r0->flag & ~1) | r1);
}

BSS_DATA u32 ** gUnknown_0202135C;

asm(".section .text.020092C0");

BSS_DATA u16 gUnknown_02021360;
BSS_DATA u16 gUnknown_02021362;
BSS_DATA u16 gUnknown_02021364;
BSS_DATA u8 gUnknown_02021368;
BSS_DATA bool8 isSoundVsync;

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

void InitSound(void)
{
    gUnknown_02021368 = 0;
    isSoundVsync = 0;
    m4aSoundInit();
}

void PauseSoundVSync(void)
{
    gUnknown_02021368 = 1;
    isSoundVsync = 0;
}

bool32 EnableSoundVSync(u32 a0)
{
    if (a0 && gUnknown_02021368)
        isSoundVsync = 1;
    return isSoundVsync;
}

void PlaySE(u16 song)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    MPlayStart(mPlayInfo, gSongTable[song].header);
    m4aMPlayImmInit(mPlayInfo);
}

void StopSE(u16 song)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayStop(mPlayInfo);
}

void StopAllSound(void)
{
    m4aMPlayAllStop();
}

bool8 sub_020093AC(void)
{
    return TRUE;
}

void FadeOutSE(u16 song, u16 _speed)
{
    struct MusicPlayerInfo * mPlayInfo;

    u16 speed = _speed >> 4;
    if (speed == 0)
        speed = 1;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayFadeOut(mPlayInfo, speed);
}

void SetSEVolume(u16 song, u16 volume)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayVolumeControl(mPlayInfo, 0xFF, volume);
}

void SetSETempo(u16 song, u16 tempo)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayTempoControl(mPlayInfo, tempo);
}

void SetSEPitch(u16 song, s16 pitch)
{
    struct MusicPlayerInfo * mPlayInfo;

    mPlayInfo = gMPlayTable[gSongTable[song].ms].info;
    m4aMPlayPitchControl(mPlayInfo, 0xFF, pitch);
}

void SoundVSyncOff(void)
{
    isSoundVsync = 0;
    m4aSoundVSyncOff();
}

void SoundVSyncOn(void)
{
    m4aSoundVSyncOn();
    isSoundVsync = 1;
}
