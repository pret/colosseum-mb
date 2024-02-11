#include "global.h"
#include "gflib.h"
#include "all.h"
#include "libpmagb/agb_rom.h"
#include "unk_200E344.h"
#include "unk_200C5DC.h"
#include "libpmagb/save.h"
#include "gflib/keys.h"
#include "gflib/bg.h"
#include "gflib/text.h"
#include "gflib/characters.h"
#include "constants/pokemon.h"
#include "constants/items.h"
#include "pokemon.h"
#include "strings.h"

EWRAM_DATA volatile struct UnkStruct_02024960 gUnknown_02024960 = {0};

u32 sub_02006490(void);
void sub_02002A9C(u8, u32, u8);
void sub_02002C44(void);
void sub_02006344(void);
void sub_02005BB8(void);
void FadeOut(void);
u32 sub_020047D4(void);
u32 sub_020064B0(void);
bool32 sub_02005704(u32);

bool8 sub_0200023C(void)
{
    u32 r0;

    sub_02006490();
    if (gUnknown_02024960.unk_03_0 == 0)
    {
        gUnknown_02024960.unk_858 = 1;
    }
    else
    {
        gUnknown_02024960.unk_858 = 2;
    }
    sub_02002A9C(0, sub_02006490(), 1);
    r0 = gUnknown_02024960.unk_87E | (gUnknown_02024960.unk_87B << 16);
    gUnknown_02024960.unk_880 = r0;
    gUnknown_02024960.unk_87F = 1;
    return FALSE;
}

extern IntrFunc *gUnknown_0201F4AC;
extern u8 gUnknown_020217B4;
extern u8 gUnknown_020217B8;
extern u8 gStringBuffers[][32];
extern const u8 gFont1JapanGfx[];
extern const u8 gFont0JapanGfx[];
extern const u8 gFont0LatinGfx[];
extern const u8 gFont1LatinGfx[];
extern const u8 gFont1JapanWidths[];
extern const u8 gFont0JapanWidths[];
extern const u8 gFont0LatinWidths[];
extern const u8 gFont1LatinWidths[];

extern void sub_0200D924(const u8*);
extern void sub_0200D9EC(void);

struct RomHeader
{
    u8 a0[0xA8];
    u8 unkA8[8];
};

extern const struct RomHeader gRomHeader;

#ifdef NONMATCHING

static inline u32 Setunk20217B8(void)
{
    u8 buffer[64];
    u32 var18 = 0;
    u32 r4 = 0;

    if (gAgbPmRomParams->gameLanguage != LANGUAGE_ENGLISH)
        return 0;

    while (1)
    {
        main_callback(&var18, buffer, 0);
        if (var18 == 5)
            r4 = 1;
        if (var18 == 11)
            r4 = 2;
        if (var18 == 6 || var18 == 7 || var18 == 11)
            break;
    }
    return r4;
}

void GF_Main(void)
{
    s32 i;
    u16 monStatus;

    DetectROM();
    sub_020098D8(2, gUnknown_0201F4AC);
    SaveBlocksInit();
    SetSaveSectorPtrs();
    gUnknown_020217B4 = ReadSaveBlockChunks();

    gUnknown_020217B8 = Setunk20217B8();

    InitSound();
    sub_02002C44();
    SetKeyRepeatTiming(0x28, 5);
    REG_IE = 1;
    REG_DISPSTAT = 8;
    REG_DISPCNT &= (0xFF7F);
    REG_IME = 1;
    sub_0200C9C0(gSaveBlock2Ptr, gSaveBlock1Ptr, gUnknown_020217B4);

    sub_0200D924(gRomHeader.unkA8);

    SetVBlankCallback(sub_0200D9EC);
    PauseSoundVSync();
    GenerateFontHalfrowLookupTable((u32 *) 0x03004000);
    FadeOut();
    for (;;)
    {
        if (sub_020047D4() == 0)
        {
            sub_02006344();
            sub_02005BB8();
            if (sub_020064B0() == 0)
            {
                sub_02005704((gUnknown_02024960.unk_03_0 != 0) ? gUnknown_02024960.unk_03_0 - 1 : 0);
            }
            else
            {
                sub_0200023C();
            }
        }
        else
        {
            CpuCopy16(gSaveBlock1BakPtr, gSaveBlock1Ptr, gAgbPmRomParams->saveBlock1Size);
            monStatus = 0;
            for (i = 0; i < PARTY_SIZE; i++)
            {
                SetMonData(&gPlayerPartyPtr[i], MON_DATA_STATUS, &monStatus);
            }
            sub_02002A9C(1, 0, 0);
        }
    }
}

static u32 sub_0200043C(void)
{

}

#else

NAKED void GF_Main(void)
{
    asm_unified("push {r4, r5, r6, r7, lr}\t\n\
	sub sp, #0x48\t\n\
	bl DetectROM\t\n\
	ldr r0, =gUnknown_0201F4AC\t\n\
	ldr r1, [r0]\t\n\
	movs r0, #2\t\n\
	bl sub_020098D8\t\n\
	bl SaveBlocksInit\t\n\
	bl SetSaveSectorPtrs\t\n\
	ldr r4, =gUnknown_020217B4\t\n\
	bl ReadSaveBlockChunks\t\n\
	strb r0, [r4]\t\n\
	ldr r5, =gUnknown_020217B8\t\n\
	movs r0, #0\t\n\
	str r0, [sp, #0x44]\t\n\
	movs r4, #0\t\n\
	ldr r0, =gAgbPmRomParams\t\n\
	ldr r0, [r0]\t\n\
	ldr r0, [r0, #4]\t\n\
	cmp r0, #2\t\n\
	beq _02000304\t\n\
	movs r0, #0\t\n\
	ldr r6, =gRomHeader + 0xA8\t\n\
	add r7, sp, #0x40\t\n\
	b _0200032C\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_02000304:\t\n\
	ldr r6, =gRomHeader + 0xA8\t\n\
	add r7, sp, #0x40\t\n\
_02000308:\t\n\
	add r0, sp, #0x44\t\n\
	mov r1, sp\t\n\
	movs r2, #0\t\n\
	bl main_callback\t\n\
	ldr r1, [sp, #0x44]\t\n\
	cmp r1, #5\t\n\
	bne _0200031A\t\n\
	movs r4, #1\t\n\
_0200031A:\t\n\
	cmp r1, #0xb\t\n\
	bne _02000320\t\n\
	movs r4, #2\t\n\
_02000320:\t\n\
	subs r0, r1, #6\t\n\
	cmp r0, #1\t\n\
	bls _0200032A\t\n\
	cmp r1, #0xb\t\n\
	bne _02000308\t\n\
_0200032A:\t\n\
	adds r0, r4, #0\t\n\
_0200032C:\t\n\
	strb r0, [r5]\t\n\
	bl InitSound\t\n\
	bl sub_02002C44\t\n\
	movs r0, #0x28\t\n\
	movs r1, #5\t\n\
	bl SetKeyRepeatTiming\t\n\
	ldr r0, =0x04000200\t\n\
	movs r3, #1\t\n\
	strh r3, [r0]\t\n\
	ldr r1, =0x04000004\t\n\
	movs r0, #8\t\n\
	strh r0, [r1]\t\n\
	movs r2, #0x80\t\n\
	lsls r2, r2, #0x13\t\n\
	ldrh r1, [r2]\t\n\
	ldr r0, =0x0000FF7F\t\n\
	ands r0, r1\t\n\
	strh r0, [r2]\t\n\
	ldr r0, =0x04000208\t\n\
	strh r3, [r0]\t\n\
	ldr r0, =gSaveBlock2Ptr\t\n\
	ldr r0, [r0]\t\n\
	ldr r1, =gSaveBlock1Ptr\t\n\
	ldr r1, [r1]\t\n\
	ldr r2, =gUnknown_020217B4\t\n\
	ldrb r2, [r2]\t\n\
	bl sub_0200C9C0\t\n\
	adds r0, r6, #0\t\n\
	bl sub_0200D924\t\n\
	ldr r0, =sub_0200D9EC\t\n\
	bl SetVBlankCallback\t\n\
	bl PauseSoundVSync\t\n\
	ldr r0, =0x03004000\t\n\
	bl GenerateFontHalfrowLookupTable\t\n\
	bl FadeOut\t\n\
_02000384:\t\n\
	bl sub_020047D4\t\n\
	cmp r0, #0\t\n\
	bne _020003EA\t\n\
	bl sub_02006344\t\n\
	bl sub_02005BB8\t\n\
	bl sub_020064B0\t\n\
	cmp r0, #0\t\n\
	bne _020003E4\t\n\
	ldr r1, =gUnknown_02024960\t\n\
	ldrb r0, [r1, #3]\t\n\
	lsls r0, r0, #0x19\t\n\
	cmp r0, #0\t\n\
	beq _020003DC\t\n\
	ldrb r0, [r1, #3]\t\n\
	lsls r0, r0, #0x19\t\n\
	lsrs r0, r0, #0x19\t\n\
	subs r0, #1\t\n\
	b _020003DE\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_020003DC:\t\n\
	movs r0, #0\t\n\
_020003DE:\t\n\
	bl sub_02005704\t\n\
	b _02000384\t\n\
_020003E4:\t\n\
	bl sub_0200023C\t\n\
	b _02000384\t\n\
_020003EA:\t\n\
	ldr r0, =gSaveBlock1BakPtr\t\n\
	ldr r0, [r0]\t\n\
	ldr r1, =gSaveBlock1Ptr\t\n\
	ldr r1, [r1]\t\n\
	ldr r2, =gAgbPmRomParams\t\n\
	ldr r2, [r2]\t\n\
	adds r2, #0x8c\t\n\
	ldr r2, [r2]\t\n\
	lsls r2, r2, #0xa\t\n\
	lsrs r2, r2, #0xb\t\n\
	bl CpuSet\t\n\
	movs r0, #0\t\n\
	strh r0, [r7]\t\n\
	movs r5, #0\t\n\
	ldr r6, =gPlayerPartyPtr\t\n\
	movs r4, #0\t\n\
_0200040C:\t\n\
	ldr r0, [r6]\t\n\
	adds r0, r0, r4\t\n\
	movs r1, #0x37\t\n\
	adds r2, r7, #0\t\n\
	bl SetMonData\t\n\
	adds r4, #0x64\t\n\
	adds r5, #1\t\n\
	cmp r5, #5\t\n\
	ble _0200040C\t\n\
	movs r0, #1\t\n\
	movs r1, #0\t\n\
	movs r2, #0\t\n\
	bl sub_02002A9C\t\n\
	b _02000384\t\n\
	.align 2, 0\t\n\
	.pool");
}

u32 NAKED sub_0200043C(void)
{
    asm_unified("push {r4, lr}\t\n\
	sub sp, #0x44\t\n\
	movs r0, #0\t\n\
	str r0, [sp, #0x40]\t\n\
	movs r4, #0\t\n\
	ldr r0, =gAgbPmRomParams\t\n\
	ldr r0, [r0]\t\n\
	ldr r0, [r0, #4]\t\n\
	cmp r0, #2\t\n\
	beq _02000458\t\n\
	movs r0, #0\t\n\
	b _0200047C\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_02000458:\t\n\
	add r0, sp, #0x40\t\n\
	mov r1, sp\t\n\
	movs r2, #0\t\n\
	bl main_callback\t\n\
	ldr r1, [sp, #0x40]\t\n\
	cmp r1, #5\t\n\
	bne _0200046A\t\n\
	movs r4, #1\t\n\
_0200046A:\t\n\
	cmp r1, #0xb\t\n\
	bne _02000470\t\n\
	movs r4, #2\t\n\
_02000470:\t\n\
	subs r0, r1, #6\t\n\
	cmp r0, #1\t\n\
	bls _0200047A\t\n\
	cmp r1, #0xb\t\n\
	bne _02000458\t\n\
_0200047A:\t\n\
	adds r0, r4, #0\t\n\
_0200047C:\t\n\
	add sp, #0x44\t\n\
	pop {r4}\t\n\
	pop {r1}\t\n\
	bx r1");
}

#endif // NONMATCHING

void RenderText(struct Window *win, const u8 *str)
{
    const u8 *currStr;
    const u8 *glyphGfx = win->glyphGfx;
    const u8 *glyphWidths = win->glyphWidths;

    while (*str != EOS)
    {
        switch (*str)
        {
        case CHAR_NEWLINE:
            TextWindowNextLine(win);
            break;
        case PLACEHOLDER_BEGIN:
            str++;
            RenderText(win, gStringBuffers[*str]);
            break;
        case CHAR_PROMPT_CLEAR:
            do
            {
                DelayFrames(1);
            } while (!(gNewKeys & (A_BUTTON | B_BUTTON)));
            break;
        case EXT_CTRL_CODE_BEGIN:
            str++;
            currStr = str;
            switch (*str)
            {
            case 0x14:
                win->glyphWidth = str[1];
                currStr = str + 2;
                break;
            case 0x15:
                if (win->glyphSize == 8)
                {
                    win->glyphGfx = gFont1JapanGfx;
                    win->glyphWidths = gFont1JapanWidths;
                }
                else
                {
                    win->glyphGfx = gFont0JapanGfx;
                    win->glyphWidths = gFont0JapanWidths;
                }
                break;
            case 0xF:
                ClearWindowCharBuffer(win, 0);
                break;
            }
            str = currStr;
            break;
        default:
            if (win->shadowColor == 0)
                DrawGlyphOnWindow_NoShadow(win, *str, win->fgColor);
            else
                DrawGlyphOnWindow_WithShadow(win, *str, win->fgColor, win->shadowColor);
            break;
        }
        str++;
    }

    win->glyphWidth = 0;
    win->glyphGfx = glyphGfx;
    win->glyphWidths = glyphWidths;
}

void RenderText_NoPlaceholders(struct Window *win, const u8 *str)
{
    const u8 *currStr;
    const u8 *glyphGfx = win->glyphGfx;
    const u8 *glyphWidths = win->glyphWidths;

    while (*str != EOS)
    {
        switch (*str)
        {
        case CHAR_NEWLINE:
            TextWindowNextLine(win);
            break;
        case CHAR_EXTRA_SYMBOL:
            if (win->glyphWidths != gFont1JapanWidths)
                TextWindowShiftXY(win, 5, 0);
            else
                TextWindowShiftXY(win, 8, 0);
            break;
        case EXT_CTRL_CODE_BEGIN:
            str++;
            currStr = str;
            switch (*str)
            {
            case 0x14:
                win->glyphWidth = str[1];
                currStr = str + 2;
                break;
            case 0x15:
                if (win->glyphSize == 8)
                {
                    win->glyphGfx = gFont1JapanGfx;
                    win->glyphWidths = gFont1JapanWidths;
                }
                else
                {
                    win->glyphGfx = gFont0JapanGfx;
                    win->glyphWidths = gFont0JapanWidths;
                }
                break;
            case 0xF:
                ClearWindowCharBuffer(win, 0);
                break;
            }
            str = currStr;
            break;
        default:
            DrawGlyphOnWindow_WithShadow(win, *str, win->fgColor, win->shadowColor);
            break;
        }
        str++;
    }

    win->glyphGfx = glyphGfx;
    win->glyphWidths = glyphWidths;
}

void BufferString(u32 bufferId, const u8 *src)
{
    StringCopy(gStringBuffers[bufferId], src);
}

s32 GetStringWidth(struct Window *win, const u8 *src)
{
    s32 width = 0;
    while (*src != EOS)
    {
        width += win->glyphWidths[*src];
        src++;
    }
    return width;
}

void DrawPartyMonHealthBar(int bgNum, int x, int y, u32 monId)
{
    s32 r5, r4, x2;
    s32 hp, maxHp;
    u16 tile;

    SetBgTilemapBufferTileAt(bgNum, x, y, 0x300A);
    SetBgTilemapBufferTileAt(bgNum, x + 1, y, 0x300B);
    SetBgTilemapBufferTileAt(bgNum, x + 8, y, 0x300C);

    hp = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HP, NULL);
    maxHp = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_MAX_HP, NULL);
    if (hp > maxHp)
        hp = maxHp;

    if (20 * maxHp > hp * 100)
        tile = 0x6001;
    else if (50 * maxHp > hp * 100)
        tile = 0x5001;
    else
        tile = 0x4001;

    r4 = Div(hp * 48, maxHp);
    r5 = 0;
    x += 2;
    while (r4 > 8)
    {
        SetBgTilemapBufferTileAt(bgNum, x + r5, y, tile + 8);
        r5++;
        r4 -= 8;
    }

    if (r4 != 0)
        SetBgTilemapBufferTileAt(bgNum, x + r5++, y, r4 + tile);

    for (; r5 < 6; r5++)
    {
        SetBgTilemapBufferTileAt(bgNum, x + r5, y, tile);
    }
}

static UNUSED u8 gUnknown_02020A38[8];
static u8 gScreenIsFadedOut;
// probably another file
static u8 sPadding[2];
static u16 sSomeWindowBaseBlock;

bool32 IsScreenFadedOut(void)
{
    return gScreenIsFadedOut;
}

void OverrideScreenFadeState(bool32 faded)
{
    gScreenIsFadedOut = faded;
}

void FadeIn(void)
{
    s32 i;

    DelayFrames(1);
    REG_BLDY = 0x1F;
    REG_BLDCNT = 0xFF;
    for (i = 29; i > 0; i -= 2)
    {
        DelayFrames(1);
        REG_BLDY = i;
    }
    REG_BLDCNT = 0;
    gScreenIsFadedOut = FALSE;
}

void FadeOut(void)
{
    s32 i;

    gScreenIsFadedOut = TRUE;
    DelayFrames(1);
    REG_BLDY = 0;
    REG_BLDCNT = 0xFF;
    for (i = 1; i <= 31; i += 2)
    {
        DelayFrames(1);
        REG_BLDY = i;
    }
    REG_BLDY = 0x1F;
    ResetSprites();
}

void DrawTextWindowBorder(u32 a0, u32 a1, s32 a2, s32 a3, u32 a4)
{
    s32 r1, i;
    u16 *ptr;

    ptr = ((u16 *)(0x3002000) + a1 * 32 + a0);
    *ptr = a4;

    for (i = 1; i < a2 - 1; i++)
        ptr[i] = a4 + 1;
    ptr[i] = a4 + 2;

    ptr += 0x20;
    for (r1 = 1; r1 < a3 - 1; r1++, ptr += 0x20)
    {
        *ptr = a4 + 3;
        for (i = 1; i < a2 - 1; i++)
            ;
        ptr[i] = a4 + 5;
    }

    *ptr = a4 + 6;
    for (i = 1; i < a2 - 1; i++)
        ptr[i] = a4 + 7;
    ptr[i] = a4 + 8;
}

u8 *NumToPmString3CustomZeroChar(s32 num, u8 *str, u32 zeroChar)
{
    str[0] = Div(num, 100) + zeroChar;
    num = Mod(num, 100);
    str[1] = Div(num, 10) + zeroChar;
    str[2] = Mod(num, 10) + zeroChar;
    str[3] = EOS;
    return str;
}

void ClearVram(void)
{
    CpuFill32(0, (void *)VRAM, VRAM_SIZE);
    ResetGpuBuffers();
}

u8 *NumToPmString3RightAlign(u8 *str, s32 num)
{
    s32 i;

    str[0] = Div(num, 100) + (unsigned) CHAR_0;
    num = Mod(num, 100);
    str[1] = Div(num, 10) + (unsigned) CHAR_0;
    str[2] = Mod(num, 10) + (unsigned) CHAR_0;
    str[3] = EOS;
    for (i = 0; str[i + 1] != EOS && str[i] == CHAR_0; i++)
        str[i] = CHAR_SPACE;
    return str;
}

void RenderTextAt(struct Window *win, u32 x, u32 y, const u8 *str)
{
    TextWindowSetXY(win, x, y);
    RenderText(win, str);
}

struct Window *CreateSomeWindowParameterized(u32 winId, u32 left, u32 top, u32 width, u32 height, u32 glyphSize)
{
    struct Window winTemplate;
    struct Window *winCreated;

    winTemplate.bg = 0;
    winTemplate.left = left;
    winTemplate.top = top;
    winTemplate.width = width;
    winTemplate.height = height;
    winTemplate.baseBlock = sSomeWindowBaseBlock;
    winTemplate.fillValue = 0xF;
    winTemplate.glyphSize = glyphSize;
    winTemplate.vramCharBase = (void *) BG_VRAM + BG_CHAR_SIZE + (winTemplate.baseBlock * 32);
    if (glyphSize == 8)
    {
        winTemplate.glyphGfx = gFont1LatinGfx;
        winTemplate.glyphWidths = gFont1LatinWidths;
    }
    else
    {
        winTemplate.glyphGfx = gFont0LatinGfx;
        winTemplate.glyphWidths = gFont0LatinWidths;
    }

    winCreated = AddWindow(winId, &winTemplate);
    SetTextColor(winCreated, 15, 1);
    ClearWindowCharBuffer(winCreated, 0);
    sSomeWindowBaseBlock += width * height;
    return winCreated;
}

struct Window *CreatePartyMonHPWindow(u32 left, u32 top, u32 monId)
{
    s32 i;
    u8 text[8];
    s32 hp, maxHp;
    struct Window *win = CreateSomeWindowParameterized(1, left, top, 7, 1, 8);

    ClearWindowCharBuffer(win, 0);
    hp = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HP, NULL);
    maxHp = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_MAX_HP, NULL);

    NumToPmString3CustomZeroChar(hp, text, 0x76);
    for (i = 0; text[i] == 0x76; i++)
        text[i] = CHAR_EXTRA_SYMBOL;
    text[3] = 0x73;
    if (hp == 0)
        text[2] = 0x76;

    NumToPmString3CustomZeroChar(maxHp, text + 4, 0x76);
    for (i = 0; text[i + 4] == 0x76; i++)
        text[i + 4] = CHAR_EXTRA_SYMBOL;
    if (maxHp == 0)
        text[6] = 0x76;

    TextWindowSetXY(win, 4, 0);
    RenderText_NoPlaceholders(win, text);
    return win;
}

struct UnkSpriteMonIconStruct
{
    u8 monId;
    u8 unk1;
    u8 unk2;
    u8 statusPrimary;
    u16 species;
    u16 speciesIcon; // Support for Unown.
    u16 unk8;
    struct Sprite *monSprite; // 0xC
    u8 filler10;
    u8 filler11;
    u8 filler12;
    u8 filler13;
    struct Window *unk14;
    struct Window *unk18;
    struct Window *unk1C;
    u8 unk20;
    u8 unk21;
    u8 unk22;
    struct Window *win; // 0x24
    struct Sprite *unk28;
};

struct Unk02021860Struct
{
    struct UnkSpriteMonIconStruct unk0[6];
    u8 fill108;
    u8 fill109;
    u8 fill10A;
    u8 fill10B;
    u8 fill10C;
    u8 fill10D;
    u8 fill10E;
    u8 fill10F;
    u8 fill110;
    u8 fill111;
    u8 fill112;
    u8 fill113;
    u8 fill114;
    u8 fill115;
    u8 fill116;
    u8 fill117;
    u8 unk118;
    u8 fill119;
    u8 fill11A;
    u8 unk11B;
    u8 filler11C;
    u8 filler11D;
    u8 filler11E;
    u8 filler11F;
    u8 unk120;
    u8 unk121;
    u8 filler122;
    u8 filler123;
    u8 unk124;
};

extern struct Unk02021860Struct gUnknown_02021860;

void CreateMonIcon(struct Sprite *sprite)
{
    u32 r1;
    if (sprite->unk14[1] == 7 || sprite->unk14[1] == 20)
    {
        struct UnkSpriteMonIconStruct *ptr = (void *)sprite->unk14[0];
        if (ptr->statusPrimary != STATUS_PRIMARY_FAINTED)
        {
            sprite->unk14[1] = 0;
            sprite->unk14[2]++;
        }
        else if (sprite->unk14[1] == 7)
        {
            sprite->unk14[1]++;
            return;
        }
        else
        {
            sprite->unk14[1] = 0;
        }

        r1 = sprite->unk14[2] & 1;
        CpuCopy16(&gAgbPmRomParams->monIconTable[ptr->speciesIcon][r1 * 512], (void *)VRAM + 0x10000 + (ptr->unk8 * 32), 512);
        SetSpritePos(sprite, ptr->unk1, ptr->unk2);
        if (gUnknown_02021860.unk11B == ptr->monId)
        {
            if (gUnknown_02021860.unk121 == 4)
                AddSpritePos(sprite, 0, -gUnknown_02021860.unk121);
            else
                SetSpritePos(sprite, ptr->unk1, ptr->unk2);
            gUnknown_02021860.unk121 ^= 4;
        }
    }
    else
    {
        sprite->unk14[1]++;
    }
}

void sub_02000BFC(void)
{
    u8 text[4];
    struct Window *win;
    s32 i;

    for (i = 0; i < 6; i++)
    {
        struct UnkSpriteMonIconStruct *ptr = &gUnknown_02021860.unk0[i];
        if (ptr->unk22 == gUnknown_02021860.unk124)
        {
            ptr->unk22 = 0;
            win = ptr->win;
            ClearWindowCharBuffer(win, 0);
            if (ptr->unk22 == 0)
            {
                RenderTextAt(win, 0, 2, gText_Space);
            }
            else
            {
                text[0] = ptr->unk22 + CHAR_0;
                text[1] = EOS;
                BufferString(0, text);
                TextWindowSetXY(win, 0, 2);
                RenderText(win, gText_Number);
            }
            gUnknown_02021860.unk124--;
            gUnknown_02021860.unk11B = i;
            break;
        }
    }
}

extern const struct Subsprites gUnknown_0201F9F4[];
extern const struct Subsprites gUnknown_0201F958[];

u32 sub_02000CA4(struct UnkSpriteMonIconStruct *a0, u32 monId, s32 x, s32 y)
{
    u32 personality;
    struct Sprite *sprite;

    a0->species = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_SPECIES2, NULL);
    if (a0->species == SPECIES_NONE)
        return SPECIES_NONE;

    a0->unk8 = (monId * 16) + 0xC0;
    a0->monId = monId;
    a0->unk1 = x;
    a0->unk2 = y;
    personality = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_PERSONALITY, NULL);
    a0->speciesIcon = FixUnownSpecies(a0->species, personality);
    sprite = AddSprite(x, y, gUnknown_0201F9F4);
    sprite->unk14[0] = (uintptr_t)(a0);
    sprite->callback = CreateMonIcon;
    SetSpritePaletteNum(sprite, gAgbPmRomParams->gMonIconPaletteIndices[a0->species]);
    SetSpriteTileOffset(sprite, a0->unk8);
    CpuCopy16(&gAgbPmRomParams->monIconTable[a0->speciesIcon][512], (void *)VRAM + 0x10000 + (a0->unk8 * 32), 512);
    a0->monSprite = sprite;
    return a0->species;
}

struct Unk02000D74Struct
{
    u8 x;
    u8 y;
    u8 f2;
};

struct Unk201F9B0Struct
{
    u8 unk0;
    u8 unk1;
    u8 unk2;
};

extern const struct Unk201F9B0Struct gUnknown_0201F9B0[];
extern const u16 gUnknown_0201F6B0[];
extern const u16 gUnknown_0201F4B0[];

static inline void SomeMonNameStrMagic(u8 *monName, u8 *sp32, u32 nameLen)
{
    u16 a;
    s32 i;
    if (monName[0] != EXT_CTRL_CODE_BEGIN)
    {
        for (i = 0; *monName != EOS; monName++, i++)
        {
            a = gUnknown_0201F6B0[*monName];
            sp32[i] = a >> 8;
            sp32[nameLen + 1 + i] = a;
        }
        sp32[nameLen] = CHAR_NEWLINE;
        sp32[nameLen * 2 + 1] = EOS;
    }
    else
    {
        sp32[0] = monName[0];
        monName++;
        sp32[1] = monName[0];
        monName++;
        nameLen -= 2;
        for (i = 2; *monName != EOS; monName++, i++)
        {
            a = gUnknown_0201F4B0[*monName];
            sp32[i] = a >> 8;
            sp32[nameLen + 1 + i] = a;
        }
        sp32[nameLen + 2] = CHAR_NEWLINE;
        sp32[nameLen * 2 + 3] = EOS;
    }
}

static inline struct Window *PutMonLvlOnWindow(u32 x, u32 y, u32 monId)
{
    s32 i;
    u8 text[8];
    struct Window *win = CreateSomeWindowParameterized(1, x, y, 3, 1, 8);
    u32 lvl = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_LEVEL, NULL);

    text[0] = 0x60;
    text[1] = EOS;
    TextWindowSetXY(win, 0, 0);
    RenderText(win, text);
    NumToPmString3CustomZeroChar(lvl, text, 0x76);
    for (i = 0; text[i] == 0x76; i++)
        ;
    if (text[i] == EOS)
        i--;
    RenderText_NoPlaceholders(win, &text[i]);

    return win;
}

static inline void PutMonGenderOnBgTilemap(int x, int y, u32 monId)
{
    u16 tileNum;
    switch (GetMonGender(&gPlayerPartyPtr[monId]))
    {
    default:
        tileNum = 0;
        break;
    case MON_MALE:
        tileNum = 0xF;
        break;
    case MON_FEMALE:
        tileNum = 0x11;
        break;
    }
    SetBgTilemapBufferTileAt(0, x, y, tileNum);
}

static inline void sub_2002EE0Inline(struct Window *win, struct UnkSpriteMonIconStruct *r9)
{
    u8 sp76[4];

    ClearWindowCharBuffer(win, 0);
    if (r9->unk22 == 0)
    {
        RenderTextAt(win, 0, 2, gText_Space);
    }
    else
    {
        sp76[0] = r9->unk22 + CHAR_0;
        sp76[1] = EOS;
        BufferString(0, sp76);
        TextWindowSetXY(win, 0, 2);
        RenderText(win, gText_Number);
    }
}

void sub_02000D74(struct Unk02021860Struct *a0, const struct Unk02000D74Struct *coords, u32 monId)
{
    s32 i;
    u8 monName[24];
    u8 sp32[44];
    const struct Unk201F9B0Struct *r5 = &gUnknown_0201F9B0[coords->f2];
    struct UnkSpriteMonIconStruct *r9 = &a0->unk0[monId];
    u32 species = sub_02000CA4(r9, monId, coords->x * 8, (coords->y * 8) + 2);

    if (species == SPECIES_NONE)
    {
        r5 = &gUnknown_0201F9B0[2];
        CopyToBgTilemapBufferRect(3, coords->x, coords->y, r5->unk0, r5->unk1, (u16 *) (VRAM + 0x14000) + r5->unk2);
    }
    else
    {
        r9->statusPrimary = GetMonStatus(&gPlayerPartyPtr[monId]);
        CopyToBgTilemapBufferRect(3, coords->x, coords->y, r5->unk0, r5->unk1, (u16 *) (VRAM + 0x14000) + r5->unk2);
        if (r9->statusPrimary != STATUS_PRIMARY_FAINTED)
        {
            if (a0->unk11B == monId)
                SetBgTilemapBufferPaletteRect(3, coords->x, coords->y, r5->unk0, r5->unk1, 7);
        }
        else
        {
            if (a0->unk11B == monId)
                SetBgTilemapBufferPaletteRect(3, coords->x, coords->y, r5->unk0, r5->unk1, 9);
            else
                SetBgTilemapBufferPaletteRect(3, coords->x, coords->y, r5->unk0, r5->unk1, 5);
        }

        r9->unk14 = CreateSomeWindowParameterized(1, coords->x + 4, coords->y + 1, gAgbPmRomParams->pokemonNameLength_2, 2, 8);
        GetMonData(&gPlayerPartyPtr[monId], MON_DATA_NICKNAME, monName);
        SomeMonNameStrMagic(monName, sp32, GetStringSizeHandleExtCtrlCodes(monName));
        if (GetMonData(&gPlayerPartyPtr[monId], MON_DATA_LANGUAGE, monName) != LANGUAGE_JAPANESE)
            r9->unk14->startX = 1;
        else
            r9->unk14->startX = 2;
        TextWindowSetXY(r9->unk14, r9->unk14->startX, 0);
        RenderText_NoPlaceholders(r9->unk14, sp32);

        if (r9->statusPrimary == STATUS_PRIMARY_NONE || r9->statusPrimary == STATUS_PRIMARY_POKERUS)
        {
            r9->unk18 = PutMonLvlOnWindow(coords->x + 6, coords->y + 3, monId);
        }
        else
        {
            for (i = 0; i < 4; i++)
            {
                u32 tileNum = i + 0xB05C + (r9->statusPrimary * 4);
                SetBgTilemapBufferTileAt(0, coords->x + 5 + i, coords->y + 3, tileNum);
            }
            gBgTilemapBufferTransferScheduled[0] = 1;
        }

        if (species != SPECIES_NIDORAN_M && species != SPECIES_NIDORAN_F)
        {
            PutMonGenderOnBgTilemap(coords->x + 9, coords->y + 3, monId);
        }
        else
        {
            GetSpeciesName(sp32, species);
            if (StringCompare(monName, sp32) != 0)
            {
                PutMonGenderOnBgTilemap(coords->x + 9, coords->y + 3, monId);
            }
        }

        if (gUnknown_02021860.unk118 == 0)
        {
            r9->unk1C = CreatePartyMonHPWindow(coords->x + 5, coords->y + 5, monId);
            DrawPartyMonHealthBar(0, coords->x + 2, coords->y + 4, monId);
            gUnknown_02021860.unk0[monId].unk20 = coords->x + 2;
            gUnknown_02021860.unk0[monId].unk21 = coords->y + 4;
        }
        else
        {
            r9->unk20 = coords->x + 3;
            r9->unk21 = coords->y + 4;
            r9->win = CreateSomeWindowParameterized(monId + 5, r9->unk20, r9->unk21, 6, 2, 0x10);
            sub_2002EE0Inline(r9->win, r9);
        }

        if (GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HELD_ITEM, NULL) != ITEM_NONE)
        {
            r9->unk28 = AddSprite((coords->x * 8) + 24, (coords->y * 8) + 21, gUnknown_0201F958);
            SetSpritePaletteNum(r9->unk28, 12);
        }
        gUnknown_02021860.unk120 = monId;
    }
}

void sub_02001258(struct Unk02021860Struct *a0, const struct Unk02000D74Struct *coords, u32 monId)
{
    s32 i;
    u8 monName[24];
    u8 sp32[44];
    const struct Unk201F9B0Struct *r5 = &gUnknown_0201F9B0[coords->f2];
    struct UnkSpriteMonIconStruct *r9 = &a0->unk0[monId];
    u32 species = sub_02000CA4(r9, monId, (coords->x * 8) - 1, ((coords->y - 1) * 8) + 2);

    if (species == SPECIES_NONE)
    {
        r5 = &gUnknown_0201F9B0[2];
        CopyToBgTilemapBufferRect(3, coords->x, coords->y, r5->unk0, r5->unk1, (u16 *) (VRAM + 0x14000) + r5->unk2);
    }
    else
    {
        r9->statusPrimary = GetMonStatus(&gPlayerPartyPtr[monId]);
        CopyToBgTilemapBufferRect(3, coords->x, coords->y, r5->unk0, r5->unk1, (u16 *) (VRAM + 0x14000) + r5->unk2);
        if (r9->statusPrimary != STATUS_PRIMARY_FAINTED)
        {
            if (a0->unk11B == monId)
                SetBgTilemapBufferPaletteRect(3, coords->x, coords->y, r5->unk0, r5->unk1, 7);
        }
        else
        {
            if (a0->unk11B == monId)
                SetBgTilemapBufferPaletteRect(3, coords->x, coords->y, r5->unk0, r5->unk1, 9);
            else
                SetBgTilemapBufferPaletteRect(3, coords->x, coords->y, r5->unk0, r5->unk1, 5);
        }

        r9->unk14 = CreateSomeWindowParameterized(1, coords->x + 3, coords->y, gAgbPmRomParams->pokemonNameLength_2, 2, 8);
        GetMonData(&gPlayerPartyPtr[monId], MON_DATA_NICKNAME, monName);
        SomeMonNameStrMagic(monName, sp32, GetStringSizeHandleExtCtrlCodes(monName));
        if (GetMonData(&gPlayerPartyPtr[monId], MON_DATA_LANGUAGE, monName) != LANGUAGE_JAPANESE)
            r9->unk14->startX = 6;
        else
            r9->unk14->startX = 8;
        TextWindowSetXY(r9->unk14, r9->unk14->startX, 0);
        RenderText_NoPlaceholders(r9->unk14, sp32);

        if (r9->statusPrimary == STATUS_PRIMARY_NONE || r9->statusPrimary == STATUS_PRIMARY_POKERUS)
        {
            r9->unk18 = PutMonLvlOnWindow(coords->x + 6, coords->y + 2, monId);
        }
        else
        {
            for (i = 0; i < 4; i++)
            {
                u32 tileNum = i + 0xB05C + (r9->statusPrimary * 4);
                SetBgTilemapBufferTileAt(0, coords->x + 5 + i, coords->y + 2, tileNum);
            }
        }

        if (species != SPECIES_NIDORAN_M && species != SPECIES_NIDORAN_F)
        {
            PutMonGenderOnBgTilemap(coords->x + 9, coords->y + 2, monId);
        }
        else
        {
            GetSpeciesName(sp32, species);
            if (StringCompare(monName, sp32) != 0)
            {
                PutMonGenderOnBgTilemap(coords->x + 9, coords->y + 2, monId);
            }
        }

        if (gUnknown_02021860.unk118 == 0)
        {
            r9->unk1C = CreatePartyMonHPWindow(coords->x + 13, coords->y + 2, monId);
            DrawPartyMonHealthBar(0, coords->x + 10, coords->y + 1, monId);
            gUnknown_02021860.unk0[monId].unk20 = coords->x + 10;
            gUnknown_02021860.unk0[monId].unk21 = coords->y + 1;
        }
        else
        {
            r9->unk20 = coords->x + 11;
            r9->unk21 = coords->y;
            r9->win = CreateSomeWindowParameterized(monId + 5, r9->unk20, r9->unk21, 6, 2, 0x10);
            sub_2002EE0Inline(r9->win, r9);
        }

        if (GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HELD_ITEM, NULL) != ITEM_NONE)
        {
            r9->unk28 = AddSprite((coords->x * 8) + 24, (coords->y * 8) + 15, gUnknown_0201F958);
            SetSpritePaletteNum(r9->unk28, 12);
        }
        gUnknown_02021860.unk120 = monId;
        gBgTilemapBufferTransferScheduled[0] = TRUE;
    }
}

