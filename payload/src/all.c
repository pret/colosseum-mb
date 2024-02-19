#include "global.h"
#include "gflib.h"
#include "all.h"
#include "libpmagb/agb_rom.h"
#include "unk_200E344.h"
#include "unk_200C5DC.h"
#include "gflib/keys.h"
#include "gflib/bg.h"
#include "gflib/text.h"
#include "gflib/characters.h"
#include "gflib/gfxload.h"
#include "constants/pokemon.h"
#include "constants/items.h"
#include "constants/songs.h"
#include "pokemon.h"
#include "strings.h"
#include "graphics.h"

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
    struct Window *unk108;
    struct Window *unk10C;
    struct Window *unk110;
    struct Sprite *unk114;
    u8 unk118;
    u8 unk119;
    u8 unk11A;
    u8 unk11B;
    u8 filler11C;
    u8 filler11D;
    u8 unk11E;
    u8 filler11F;
    u8 unk120;
    u8 unk121;
    u8 unk122;
    u8 unk123;
    u8 unk124;
    u8 unk125;
};

struct Struct0201F9A8
{
    u8 a0;
    u8 a1;
    u8 a2;
    u8 a3;
};

struct Struct0201F9E
{
    u8 a0;
    u8 a1;
    u8 a2;
    u8 a3;
};

EWRAM_DATA volatile struct UnkStruct_02024960 gUnknown_02024960 = {0};

static UNUSED u8 gUnknown_02020A38[8];
static u8 gScreenIsFadedOut;
// probably another file
static u8 sPadding[2];
static u16 sSomeWindowBaseBlock;

extern u8 gSaveStatus;
extern u8 gStringBuffers[][32];
extern const u8 gFont1JapanGfx[];
extern const u8 gFont0JapanGfx[];
extern const u8 gFont0LatinGfx[];
extern const u8 gFont1LatinGfx[];
extern const u8 gFont1JapanWidths[];
extern const u8 gFont0JapanWidths[];
extern const u8 gFont0LatinWidths[];
extern const u8 gFont1LatinWidths[];
extern const struct Subsprites gUnknown_0201F9F4[];
extern const struct Subsprites gUnknown_0201F958[];
extern const struct Subsprites gUnknown_0201F910[];
extern const struct Unk02000D74Struct gUnknown_0201F9D4[];
extern const struct Unk02000D74Struct gUnknown_0201F9BC[];
extern const struct Unk201F9B0Struct gUnknown_0201F9B0[];
extern const u16 gUnknown_0201F6B0[];
extern const u16 gUnknown_0201F4B0[];
extern const struct Window gUnknown_0201F8B0;
extern const struct Window gUnknown_0201F8F0;
extern const struct Window gUnknown_0201F8D0;
extern const struct Struct0201F9A8 *gUnknown_0201F9A8[2];
extern const struct Struct0201F9E *gUnknown_0201F9EC[];

extern void sub_0200D924(const u8*);
extern void sub_0200D9EC(void);
extern const struct RomHeader gRomHeader;

extern struct Unk02021860Struct gUnknown_02021860;
extern s32 sub_020063FC(void);
extern s32 sub_020064BC(u32 a0, u32 a1);
extern u32 sub_020044F0(u32 a0);

void sub_02002A9C(s32 a0, u32 a1, u32 a2);
void sub_02002C44(void);
void sub_02006344(void);
void sub_02005BB8(void);
void FadeOut(void);
u32 sub_020047D4(void);
u32 sub_020064B0(void);
bool32 sub_02005704(u32);
bool32 IsMonFainted(u32 monId);

// const data
const struct Window gFont0LatinInfo =
{
    .bg = 2,
    .left = 4,
    .top = 15,
    .width = 22,
    .height = 4,
    .baseBlock = 0x20,
    .fillValue = 0xF,
    .glyphSize = 0x10,
    .vramCharBase = (void *) VRAM + 0x08400,
    .glyphGfx = gFont0LatinGfx,
    .glyphWidths = gFont0LatinWidths,
    .fgColor = 0,
    .shadowColor = 0,
    .currentX = 0,
    .currentY = 0,
    .glyphWidth = 0,
    .startX = 0,
    .startY = 0,
};

// This file's functions.
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

inline void SomeMonNameStrMagic(u8 *monName, u8 *sp32, u32 nameLen)
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

inline struct Window *PutMonLvlOnWindow(u32 x, u32 y, u32 monId)
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

inline void PutMonGenderOnBgTilemap(int x, int y, u32 monId)
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

inline void CopyMonIconToVram(struct UnkSpriteMonIconStruct *ptr, u32 a1)
{
    CpuCopy16(&gAgbPmRomParams->monIcons[ptr->speciesIcon][a1 * 512], (void *)VRAM + 0x10000 + (ptr->unk8 * 32), 512);
}

inline void sub_2002E70(s32 a0)
{
    switch (a0)
    {
    case 0:
        CopyRectWithinBgTilemapBuffer(1, 0,   0x14, 6, 2, 0x18, 0x12);
        break;
    case 2:
        CopyRectWithinBgTilemapBuffer(1, 0xC, 0x14, 6, 2, 0x18, 0x10);
        CopyRectWithinBgTilemapBuffer(1, 0,   0x14, 6, 2, 0x18, 0x12);
        break;
    case 1:
        CopyRectWithinBgTilemapBuffer(1, 0xC, 0x14, 6, 2, 0x18, 0x12);
        break;
    }
}

inline void sub_02002EE0(struct Window *win, struct UnkSpriteMonIconStruct *r9)
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

void CreateMonIcon(struct Sprite *sprite)
{
    u32 r1;
    if (sprite->data[1] == 7 || sprite->data[1] == 20)
    {
        struct UnkSpriteMonIconStruct *ptr = (void *)sprite->data[0];
        if (ptr->statusPrimary != STATUS_PRIMARY_FAINTED)
        {
            sprite->data[1] = 0;
            sprite->data[2]++;
        }
        else if (sprite->data[1] == 7)
        {
            sprite->data[1]++;
            return;
        }
        else
        {
            sprite->data[1] = 0;
        }

        r1 = sprite->data[2] & 1;
        CopyMonIconToVram(ptr, r1);
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
        sprite->data[1]++;
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
    sprite->data[0] = (uintptr_t)(a0);
    sprite->callback = CreateMonIcon;
    SetSpritePaletteNum(sprite, gAgbPmRomParams->monIconPaletteIds[a0->species]);
    SetSpriteTileOffset(sprite, a0->unk8);
    CopyMonIconToVram(a0, 1);
    a0->monSprite = sprite;
    return a0->species;
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

        r9->unk14 = CreateSomeWindowParameterized(1, coords->x + 4, coords->y + 1, gAgbPmRomParams->pokemonNameLength2, 2, 8);
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
            sub_02002EE0(r9->win, r9);
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

        r9->unk14 = CreateSomeWindowParameterized(1, coords->x + 3, coords->y, gAgbPmRomParams->pokemonNameLength2, 2, 8);
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
            sub_02002EE0(r9->win, r9);
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

void sub_02001738(u32 selectMonsTextId)
{
    u8 text[8];
    DrawTextWindowBorder(0, 0x10, 0x18, 4, 0xE001);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    gUnknown_02021860.unk108 = AddWindow(0, &gUnknown_0201F8B0);
    SetTextColor(gUnknown_02021860.unk108, 1, 8);
    ClearWindowCharBuffer(gUnknown_02021860.unk108, 0xFFFF);
    if (gUnknown_02021860.unk123 != 0)
    {
        switch (selectMonsTextId)
        {
        case 0:
            text[0] = gUnknown_02021860.unk123 + CHAR_0;
            text[1] = EOS;
            BufferString(0, text);
            RenderText(gUnknown_02021860.unk108, gText_SelectNumberPokemon);
            break;
        case 1:
            RenderText(gUnknown_02021860.unk108, gText_SelectAdditionalPokemon);
            break;
        }
    }
    else
    {
        RenderText(gUnknown_02021860.unk108, gText_SelectPokemon);
    }
}

void sub_020017E8(struct Unk02021860Struct *a0)
{
    s32 i;
    const struct Unk02000D74Struct *coords;
    const struct SpritePalette *monIconPalettes;

    sSomeWindowBaseBlock = 0x80;
    ClearVram();
    REG_DISPCNT = DISPCNT_BG_ALL_ON | DISPCNT_OBJ_ON | DISPCNT_OBJ_1D_MAP;
    REG_BG0CNT = BGCNT_PRIORITY(2) | BGCNT_CHARBASE(1) | BGCNT_SCREENBASE(28);
    REG_BG1CNT = BGCNT_PRIORITY(3) | BGCNT_CHARBASE(0) | BGCNT_SCREENBASE(29);
    REG_BG2CNT = BGCNT_PRIORITY(0) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(30);
    REG_BG3CNT = BGCNT_PRIORITY(2) | BGCNT_CHARBASE(0) | BGCNT_SCREENBASE(31);
    SetBgPos(3, 0, -1);
    AutoUnCompVram(gUnknown_0201B1A0, (void *) PLTT);
    AutoUnCompVram(gMonInfoIcons_Gfx, (void *) VRAM + 0x4000);
    AutoUnCompVram(gPartyMenu_Gfx, (void *) VRAM);
    AutoUnCompVram(gMessageBox_Gfx, (void *) VRAM + 0x8000);
    AutoUnCompVram(gPartyMenu_Tilemap, (void *) IWRAM_START + 0x1000);
    AutoUnCompVram(gTypeStatusIcons_Pal, (void *) PLTT + 0x200);
    AutoUnCompVram(gTypeStatusIcons_Gfx, (void *) VRAM + 0x10000);
    sub_2002E70(gUnknown_02021860.unk118);
    gBgTilemapBufferTransferScheduled[1] = TRUE;
    monIconPalettes = gAgbPmRomParams->monIconPalettes;
    DmaCopy16(3, monIconPalettes[0].data, (void *) PLTT + 0x200, 0x60);
    AutoUnCompVram(gPartySlots_Tilemap, (void *) VRAM + 0x14000);
    if (a0->unk11A == 0)
        coords = gUnknown_0201F9BC;
    else
        coords = gUnknown_0201F9D4;
    for (i = 0; i < PARTY_SIZE; i++, coords++)
    {
        if (coords->f2 == 0)
            sub_02000D74(a0, coords, i);
        else
            sub_02001258(a0, coords, i);
    }
    gBgTilemapBufferTransferScheduled[0] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;
    sub_02001738(0);
}

void sub_020019B4(u32 monId, u32 stringId)
{
    u8 name[24];

    if (gUnknown_02021860.unk114 != NULL)
    {
        MoveSpriteToHead(gUnknown_02021860.unk114);
        gUnknown_02021860.unk114 = NULL;
    }
    FillBgTilemapBufferRect(2, 0, 12, 30, 8, 0);
    DrawTextWindowBorder(3, 14, 24, 6, 0xE001);
    gUnknown_02021860.unk110 = AddWindow(0, &gUnknown_0201F8F0);
    SetTextColor(gUnknown_02021860.unk110, 1, 8);
    ClearWindowCharBuffer(gUnknown_02021860.unk110, 0xFFFF);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    GetMonData(&gPlayerPartyPtr[monId], MON_DATA_NICKNAME, name);
    BufferString(4, name);
    PlaySE(SONG_SE_FAILURE);
    RenderText(gUnknown_02021860.unk110, gBattleStringsTable[stringId]);
    FillBgTilemapBufferRect(2, 3, 14, 24, 6, 0);
}

s32 sub_02001A8C(u32 monId)
{
    s32 var;
    u32 keys;
    u8 monName[16];
    u32 i = 0;
    bool32 r9 = TRUE;

    while (TRUE)
    {
        if (!r9)
            break;
        switch (i)
        {
        case 0:
            ClearWindowCharBuffer(gUnknown_02021860.unk108, 0xFFFF);
            TextWindowFillTileBufferForText(gUnknown_02021860.unk108);
            DrawTextWindowBorder(0, 16, 20, 4, 0xE001);
            DrawTextWindowBorder(20, 12, 10, 8, 0xE001);
            GetMonData(&gPlayerPartyPtr[monId], MON_DATA_NICKNAME, monName);
            BufferString(4, monName);
            TextWindowSetXY(gUnknown_02021860.unk108, 0, 0);
            RenderText(gUnknown_02021860.unk108, gText_DoWhatWithMon);
            gUnknown_02021860.unk10C = AddWindow(2, &gUnknown_0201F8D0);
            SetTextColor(gUnknown_02021860.unk10C, 1, 8);
            TextWindowFillTileBufferForText(gUnknown_02021860.unk10C);
            ClearWindowCharBuffer(gUnknown_02021860.unk10C, 0xFFFF);
            if (gUnknown_02021860.unk125 == 0)
                RenderTextAt(gUnknown_02021860.unk10C, 0, 0, gText_Switch);
            else
                RenderTextAt(gUnknown_02021860.unk10C, 0, 0, gText_SendOut);
            RenderTextAt(gUnknown_02021860.unk10C, 0, 16, gText_Summary);
            RenderTextAt(gUnknown_02021860.unk10C, 0, 32, gText_Cancel);
            gUnknown_02021860.unk114 = AddSprite(0, 0, gUnknown_0201F910);
            SetSpritePaletteNum(gUnknown_02021860.unk114, 5);
            gUnknown_02021860.unk119 = 0;
            SetSpritePos(gUnknown_02021860.unk114, 168, 104);
            gBgTilemapBufferTransferScheduled[2] = TRUE;
            if (IsScreenFadedOut())
                FadeIn();
            i = 1;
            break;
        case 1:
            DelayFrames(1);
            keys = gNewKeys;
            if (keys & B_BUTTON)
                i = 2;
            if (keys & A_BUTTON)
            {
                if (gUnknown_02021860.unk119 == 0)
                    i = 3;
                else if (gUnknown_02021860.unk119 == 1)
                    i = 4;
                else
                    i = 2;
            }
            else
            {
                keys = gNewAndRepeatedKeys;
                if (keys & DPAD_DOWN)
                {
                    if (gUnknown_02021860.unk119 != 2)
                        gUnknown_02021860.unk119++;
                    else
                        gUnknown_02021860.unk119 = 0;
                    PlaySE(SONG_SE_SELECT);
                }
                if (keys & DPAD_UP)
                {
                    if (gUnknown_02021860.unk119 != 0)
                        gUnknown_02021860.unk119--;
                    else
                        gUnknown_02021860.unk119 = 2;
                    PlaySE(SONG_SE_SELECT);
                }
                SetSpritePos(gUnknown_02021860.unk114, 168, 104 + (gUnknown_02021860.unk119 * 16));
            }
            break;
        case 2:
            PlaySE(SONG_SE_SELECT);
            if (gUnknown_02021860.unk114 != NULL)
            {
                MoveSpriteToHead(gUnknown_02021860.unk114);
                gUnknown_02021860.unk114 = NULL;
            }
            FillBgTilemapBufferRect(2, 20, 12, 10, 8, 0);
            sub_02001738(0);
            return 0;
        case 3:
            var = sub_020063FC();
            if ((var & 0xFFFF) == 1)
            {
                PlaySE(SONG_SE_FAILURE);
                sub_020019B4(gUnknown_02021860.unk122, 0);
                i = 2;
            }
            else if ((var & 0xFFFF) == 2)
            {
                PlaySE(SONG_SE_FAILURE);
                BufferString(0, (void *) gUnknown_02024960.unk81C[var >> 16].str);
                sub_020019B4(gUnknown_02021860.unk122, 1);
                i = 2;
            }
            else if ((var & 0xFFFF) == 4)
            {
                PlaySE(SONG_SE_FAILURE);
                BufferString(0, (void *) gUnknown_02024960.unk81C[var >> 16].str);
                sub_020019B4(gUnknown_02021860.unk122, 2);
                i = 2;
            }
            else if ((var & 0xFFFF) == 3)
            {
                PlaySE(SONG_SE_FAILURE);
                BufferString(0, (void *) gUnknown_02024960.unk81C[var >> 16].str);
                sub_020019B4(gUnknown_02021860.unk122, 3);
                i = 2;
            }
            else
            {
                if (IsMonFainted(gUnknown_02021860.unk11B) == TRUE)
                {
                    PlaySE(SONG_SE_FAILURE);
                    sub_020019B4(gUnknown_02021860.unk11B, 10);
                    i = 2;
                }
                else if (gUnknown_02021860.unk122 == gUnknown_02021860.unk11B)
                {
                    PlaySE(SONG_SE_FAILURE);
                    sub_020019B4(gUnknown_02021860.unk11B, 11);
                    i = 2;
                }
                else
                {
                    switch (sub_020064BC(gUnknown_02024960.unk4, gUnknown_02021860.unk11B))
                    {
                    case 0:
                        PlaySE(SONG_SE_SELECT);
                        gUnknown_02024960.unk_87E = gUnknown_02021860.unk11B;
                        gUnknown_02024960.unk_87B = 2;
                        return -1;
                    case 1:
                        PlaySE(SONG_SE_FAILURE);
                        sub_020019B4(gUnknown_02021860.unk11B, 13);
                        break;
                    case 2:
                        PlaySE(SONG_SE_FAILURE);
                        sub_020019B4(gUnknown_02021860.unk11B, 11);
                        break;
                    case 3:
                        PlaySE(SONG_SE_FAILURE);
                        sub_020019B4(gUnknown_02021860.unk11B, 12);
                        break;
                    }
                    i = 2;
                }
            }
            break;
        case 4:
            PlaySE(SONG_SE_SELECT);
            FadeOut();
            gUnknown_02021860.unk11B = sub_020044F0(gUnknown_02021860.unk11B);
            monId = gUnknown_02021860.unk11B;
            if (gUnknown_02021860.unk11A == 1)
            {
                if (gUnknown_02021860.unk11B == 0)
                    gUnknown_02021860.unk11E = 2;
                else if (gUnknown_02021860.unk11B == 1)
                    gUnknown_02021860.unk11E = 4;
            }
            sub_020017E8(&gUnknown_02021860);
            i = 0;
            break;
        }
    }
    return 0;
}

s32 sub_02001F04(s32 ret)
{
    u32 keys;
    s32 j;
    u8 monName[16];
    struct UnkSpriteMonIconStruct *var_24 = &gUnknown_02021860.unk0[ret];
    u32 i = 0;
    bool32 r3 = TRUE;

    while (TRUE)
    {
        if (!r3)
            break;
        switch (i)
        {
        case 0:
            ClearWindowCharBuffer(gUnknown_02021860.unk108, 0xFFFF);
            TextWindowFillTileBufferForText(gUnknown_02021860.unk108);
            DrawTextWindowBorder(0, 16, 20, 4, 0xE001);
            DrawTextWindowBorder(20, 12, 10, 8, 0xE001);
            GetMonData(&gPlayerPartyPtr[ret], MON_DATA_NICKNAME, monName);
            BufferString(4, monName);
            TextWindowSetXY(gUnknown_02021860.unk108, 0, 0);
            RenderText(gUnknown_02021860.unk108, gText_DoWhatWithMon);
            gUnknown_02021860.unk10C = AddWindow(2, &gUnknown_0201F8D0);
            SetTextColor(gUnknown_02021860.unk10C, 1, 8);
            TextWindowFillTileBufferForText(gUnknown_02021860.unk10C);
            ClearWindowCharBuffer(gUnknown_02021860.unk10C, 0xFFFF);
            if (var_24->unk22 == 0)
                RenderTextAt(gUnknown_02021860.unk10C, 0, 0, gText_Select);
            else
                RenderTextAt(gUnknown_02021860.unk10C, 0, 0, gText_Deselect);
            RenderTextAt(gUnknown_02021860.unk10C, 0, 16, gText_Summary);
            RenderTextAt(gUnknown_02021860.unk10C, 0, 32, gText_Cancel);
            gUnknown_02021860.unk114 = AddSprite(0, 0, gUnknown_0201F910);
            SetSpritePaletteNum(gUnknown_02021860.unk114, 5);
            gUnknown_02021860.unk119 = 0;
            SetSpritePos(gUnknown_02021860.unk114, 168, 104);
            gBgTilemapBufferTransferScheduled[2] = TRUE;
            if (IsScreenFadedOut())
                FadeIn();
            else
                PlaySE(SONG_SE_SELECT);
            i = 1;
            break;
        case 1:
            DelayFrames(1);
            keys = gNewAndRepeatedKeys;
            if (keys & B_BUTTON)
                i = 2;
            if (keys & A_BUTTON)
            {
                if (gUnknown_02021860.unk119 == 0)
                    i = 3;
                else if (gUnknown_02021860.unk119 == 1)
                    i = 4;
                else
                    i = 2;
            }
            else
            {
                if (keys & DPAD_DOWN)
                {
                    if (gUnknown_02021860.unk119 != 2)
                        gUnknown_02021860.unk119++;
                    else
                        gUnknown_02021860.unk119 = 0;
                    PlaySE(SONG_SE_SELECT);
                }
                else if (keys & DPAD_UP)
                {
                    if (gUnknown_02021860.unk119 != 0)
                        gUnknown_02021860.unk119--;
                    else
                        gUnknown_02021860.unk119 = 2;
                    PlaySE(SONG_SE_SELECT);
                }
                else
                {
                    SetSpritePos(gUnknown_02021860.unk114, 168, 104 + (gUnknown_02021860.unk119 * 16));
                }
            }
            break;
        case 2:
            PlaySE(SONG_SE_SELECT);
            if (gUnknown_02021860.unk114 != NULL)
            {
                MoveSpriteToHead(gUnknown_02021860.unk114);
                gUnknown_02021860.unk114 = NULL;
            }
            FillBgTilemapBufferRect(2, 20, 12, 10, 8, 0);
            sub_02001738(0);
            return ret;
        case 3:
            if (var_24->unk22 == 0)
            {
                if (gUnknown_02021860.unk124 == gUnknown_02021860.unk123)
                {
                    PlaySE(SONG_SE_FAILURE);
                    i = 1;
                }
                else
                {
                    PlaySE(SONG_SE_SELECT);
                    var_24->unk22 = ++gUnknown_02021860.unk124;
                    sub_02002EE0(var_24->win, var_24);
                    REG_JOY_TRANS = 0x1000000;
                    if (gUnknown_02021860.unk124 == gUnknown_02021860.unk123)
                        gUnknown_02021860.unk11B = 6;
                    i = 2;
                }
            }
            else
            {
                for (j = 0; j < 6; j++)
                {
                    if (gUnknown_02021860.unk0[j].unk22 > var_24->unk22)
                    {
                        gUnknown_02021860.unk0[j].unk22--;
                        sub_02002EE0(gUnknown_02021860.unk0[j].win, &gUnknown_02021860.unk0[j]);
                    }
                }
                var_24->unk22 = 0;
                sub_02002EE0(var_24->win, var_24);
                REG_JOY_TRANS = 0xFF000000;
                gUnknown_02021860.unk124--;
                i = 2;
            }
            break;
        case 4:
            PlaySE(SONG_SE_SELECT);
            FadeOut();
            gUnknown_02021860.unk11B = sub_020044F0(gUnknown_02021860.unk11B);
            if (gUnknown_02021860.unk11A == 1)
            {
                if (gUnknown_02021860.unk11B == 0)
                    gUnknown_02021860.unk11E = 2;
                else if (gUnknown_02021860.unk11B == 1)
                    gUnknown_02021860.unk11E = 4;
            }
            sub_020017E8(&gUnknown_02021860);
            ret = gUnknown_02021860.unk11B;
            var_24 = &gUnknown_02021860.unk0[ret];
            i = 0;
            break;
        }
    }

    return ret;
}

s32 sub_020023E8(void)
{
    u16 keys;
    u32 monId;
    const struct Struct0201F9A8 *r9 = gUnknown_0201F9A8[gUnknown_02021860.unk11A];
    const struct Struct0201F9E *var_24 = gUnknown_0201F9EC[gUnknown_02021860.unk11A];
    const struct Struct0201F9E *r4;
    const struct Unk201F9B0Struct *r5;

    while (TRUE)
    {
        DelayFrames(1);
        keys = gNewAndRepeatedKeys;
        if (keys == 0)
            continue;

        if (keys & B_BUTTON)
        {
            if (gUnknown_02021860.unk125 == 0)
            {
                PlaySE(SONG_SE_SELECT);
                return -1;
            }
            else
            {
                PlaySE(SONG_SE_FAILURE);
                continue;
            }
        }
        if (keys & A_BUTTON)
        {
            if (gUnknown_02021860.unk11B == PARTY_SIZE)
            {
                if (gUnknown_02021860.unk125 == 0)
                {
                    PlaySE(SONG_SE_SELECT);
                    return -1;
                }
                else
                {
                    PlaySE(SONG_SE_FAILURE);
                    continue;
                }
            }
            else
            {
                s32 var = 0;

                PlaySE(SONG_SE_SELECT);
                var = sub_02001A8C(gUnknown_02021860.unk11B);
                if (var == -1)
                    return -1;
            }
        }

        monId = gUnknown_02021860.unk11B;
        if (keys & DPAD_UP)
        {
            PlaySE(SONG_SE_SELECT);
            if (gUnknown_02021860.unk11B == 0)
                gUnknown_02021860.unk11B = PARTY_SIZE;
            else if (gUnknown_02021860.unk11B == PARTY_SIZE)
                gUnknown_02021860.unk11B = gUnknown_02021860.unk120;
            else
                gUnknown_02021860.unk11B--;
            gUnknown_02021860.unk11E = r9[gUnknown_02021860.unk11B].a2;
        }
        if (keys & DPAD_DOWN)
        {
            PlaySE(SONG_SE_SELECT);
            if (gUnknown_02021860.unk11B == gUnknown_02021860.unk120)
                gUnknown_02021860.unk11B = PARTY_SIZE;
            else if (gUnknown_02021860.unk11B == PARTY_SIZE)
                gUnknown_02021860.unk11B = 0;
            else
                gUnknown_02021860.unk11B++;
            gUnknown_02021860.unk11E = r9[gUnknown_02021860.unk11B].a2;
        }
        if (keys & DPAD_LEFT)
        {
            PlaySE(SONG_SE_SELECT);
            if (r9[gUnknown_02021860.unk11B].a1 != 0xFF)
            {
                gUnknown_02021860.unk11E = gUnknown_02021860.unk11B;
                gUnknown_02021860.unk11B = r9[gUnknown_02021860.unk11B].a1;
            }
        }
        if (keys & DPAD_RIGHT)
        {
            PlaySE(SONG_SE_SELECT);
            switch (r9[gUnknown_02021860.unk11B].a0)
            {
            case 0xFF:
                break;
            case 7:
                gUnknown_02021860.unk11B = gUnknown_02021860.unk11E;
                if (gUnknown_02021860.unk11B > gUnknown_02021860.unk120)
                {
                    gUnknown_02021860.unk11B = gUnknown_02021860.unk120;
                    if (gUnknown_02021860.unk11A == 1 && gUnknown_02021860.unk11B == 1 && monId == 0)
                        gUnknown_02021860.unk11B = monId;
                }
                break;
            default:
                gUnknown_02021860.unk11B = r9[gUnknown_02021860.unk11B].a0;
                break;
            }
        }

        if (monId == gUnknown_02021860.unk11B)
            continue;

        if (monId != PARTY_SIZE)
        {
            r4 = &var_24[monId];
            r5 = &gUnknown_0201F9B0[r4->a2];
            if (GetMonStatus(&gPlayerPartyPtr[monId]) != STATUS_PRIMARY_FAINTED)
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 3);
            else
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 5);
        }
        else
        {
            SetBgTilemapBufferPaletteRect(1, 24, 18, 6, 2, 1);
        }

        if (gUnknown_02021860.unk11B != PARTY_SIZE)
        {
            r4 = &var_24[gUnknown_02021860.unk11B];
            r5 = &gUnknown_0201F9B0[r4->a2];
            if (GetMonStatus(&gPlayerPartyPtr[gUnknown_02021860.unk11B]) != STATUS_PRIMARY_FAINTED)
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 7);
            else
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 9);
        }
        else
        {
            SetBgTilemapBufferPaletteRect(1, 24, 18, 6, 2, 2);
            if (gUnknown_02021860.unk11A == 0)
                gUnknown_02021860.unk11E = 1;
            else
                gUnknown_02021860.unk11E = 2;
        }

        gBgTilemapBufferTransferScheduled[3] = TRUE;
        gBgTilemapBufferTransferScheduled[1] = TRUE;
    }
    return 1;
}

inline s32 sub_02002F38(u32 val)
{
    s32 i;
    for (i = 0; i < PARTY_SIZE; i++)
    {
        if (gUnknown_02021860.unk0[i].unk22 == val)
            return i;
    }
    return -1;
}

inline void sub_02002F60(void)
{
    s32 i;
    u32 bits = 0;
    u32 r6 = 0;

    for (i = 1; i < gUnknown_02021860.unk124 + 1; i++)
    {
        s32 ret = sub_02002F38(i);
        if (ret != -1)
            bits |= (ret << r6);
        r6 += 4;
    }
    gUnknown_02024960.unk_880 = bits;
    gUnknown_02024960.unk_87F = 1;
}

s32 sub_020026F4(void)
{
    u16 keys;
    u32 monId;
    const struct Struct0201F9A8 *r9 = gUnknown_0201F9A8[gUnknown_02021860.unk11A];
    const struct Struct0201F9E *var_24 = gUnknown_0201F9EC[gUnknown_02021860.unk11A];
    const struct Struct0201F9E *r4;
    const struct Unk201F9B0Struct *r5;

    while (TRUE)
    {
        DelayFrames(1);
        keys = gNewAndRepeatedKeys;
        if (keys == 0)
            continue;

        monId = gUnknown_02021860.unk11B;
        if (keys & B_BUTTON)
        {
            if (gUnknown_02021860.unk124 != 0)
            {
                sub_02000BFC();
                PlaySE(SONG_SE_SELECT);
                REG_JOY_TRANS = 0xFF000000;
            }
            else
            {
                sub_02001738(1);
                PlaySE(SONG_SE_FAILURE);
            }
        }
        if (keys & A_BUTTON)
        {
            if (gUnknown_02021860.unk11B == PARTY_SIZE)
            {
                if (gUnknown_02021860.unk124 != gUnknown_02021860.unk123)
                {
                    PlaySE(SONG_SE_FAILURE);
                    sub_02001738(1);
                    continue;
                }
                else
                {
                    sub_02002F60();
                    return -1;
                }
            }
            else
            {
                s32 var = sub_02001F04(gUnknown_02021860.unk11B);
                if (var == -1)
                    return -1;
                else if (var != monId)
                    monId = var;
            }
        }

        if (keys & DPAD_UP)
        {
            PlaySE(SONG_SE_SELECT);
            if (gUnknown_02021860.unk11B == 0)
                gUnknown_02021860.unk11B = PARTY_SIZE;
            else if (gUnknown_02021860.unk11B == PARTY_SIZE)
                gUnknown_02021860.unk11B = gUnknown_02021860.unk120;
            else
                gUnknown_02021860.unk11B--;
            gUnknown_02021860.unk11E = r9[gUnknown_02021860.unk11B].a2;
        }
        if (keys & DPAD_DOWN)
        {
            PlaySE(SONG_SE_SELECT);
            if (gUnknown_02021860.unk11B == gUnknown_02021860.unk120)
                gUnknown_02021860.unk11B = PARTY_SIZE;
            else if (gUnknown_02021860.unk11B == PARTY_SIZE)
                gUnknown_02021860.unk11B = 0;
            else
                gUnknown_02021860.unk11B++;
            gUnknown_02021860.unk11E = r9[gUnknown_02021860.unk11B].a2;
        }
        if (keys & DPAD_LEFT)
        {
            PlaySE(SONG_SE_SELECT);
            if (r9[gUnknown_02021860.unk11B].a1 != 0xFF)
            {
                gUnknown_02021860.unk11E = gUnknown_02021860.unk11B;
                gUnknown_02021860.unk11B = r9[gUnknown_02021860.unk11B].a1;
            }
        }
        if (keys & DPAD_RIGHT)
        {
            PlaySE(SONG_SE_SELECT);
            switch (r9[gUnknown_02021860.unk11B].a0)
            {
            case 0xFF:
                break;
            case 7:
                gUnknown_02021860.unk11B = gUnknown_02021860.unk11E;
                if (gUnknown_02021860.unk11B > gUnknown_02021860.unk120)
                {
                    gUnknown_02021860.unk11B = gUnknown_02021860.unk120;
                    if (gUnknown_02021860.unk11A == 1 && gUnknown_02021860.unk11B == 1 && monId == 0)
                        gUnknown_02021860.unk11B = monId;
                }
                break;
            default:
                gUnknown_02021860.unk11B = r9[gUnknown_02021860.unk11B].a0;
                break;
            }
        }

        if (monId == gUnknown_02021860.unk11B)
            continue;

        if (monId != PARTY_SIZE)
        {
            r4 = &var_24[monId];
            r5 = &gUnknown_0201F9B0[r4->a2];
            if (GetMonStatus(&gPlayerPartyPtr[monId]) != STATUS_PRIMARY_FAINTED)
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 3);
            else
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 5);
        }
        else
        {
            SetBgTilemapBufferPaletteRect(1, 24, 18, 6, 2, 1);
        }

        if (gUnknown_02021860.unk11B != PARTY_SIZE)
        {
            r4 = &var_24[gUnknown_02021860.unk11B];
            r5 = &gUnknown_0201F9B0[r4->a2];
            if (GetMonStatus(&gPlayerPartyPtr[gUnknown_02021860.unk11B]) != STATUS_PRIMARY_FAINTED)
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 7);
            else
                SetBgTilemapBufferPaletteRect(3, r4->a0, r4->a1, r5->unk0, r5->unk1, 9);
        }
        else
        {
            SetBgTilemapBufferPaletteRect(1, 24, 18, 6, 2, 2);
            if (gUnknown_02021860.unk11A == 0)
                gUnknown_02021860.unk11E = 1;
            else
                gUnknown_02021860.unk11E = 2;
        }

        gBgTilemapBufferTransferScheduled[3] = TRUE;
        gBgTilemapBufferTransferScheduled[1] = TRUE;
    }
    return 1;
}

#ifdef NONMATCHING
void sub_02002A9C(s32 a0, u32 a1, u32 a2)
{
    s32 i, j;
    u16 maxHp;
    u16 pp;
    u32 status;

    gUnknown_02021860.unk122 = a1;
    gUnknown_02021860.unk11B = 0;
    gUnknown_02021860.unk125 = a2;
    gUnknown_02021860.unk11A = 0;

    if (gUnknown_02024960.unk_858 == 1)
    {
        gUnknown_02021860.unk11E = 1;
    }
    else if (gUnknown_02024960.unk_858 == 2)
    {
        gUnknown_02021860.unk11A = 1;
        gUnknown_02021860.unk11E = 2;
    }

    switch (a0)
    {
    case 0:
        gUnknown_02021860.unk118 = 0;
        gUnknown_02021860.unk123 = 0;
        sub_020017E8(&gUnknown_02021860);
        FadeIn();
        sub_020023E8();
        FadeOut();
        break;
    case 1:
        gUnknown_02021860.unk118 = 1;
        gUnknown_02021860.unk123 = gUnknown_02024960.unk_859;
        if (gUnknown_02021860.unk123 == 0 || gUnknown_02021860.unk123 > *gPlayerPartyCountPtr)
            gUnknown_02021860.unk123 = *gPlayerPartyCountPtr;
        gUnknown_02021860.unk124 = 0;
        for (i = 0; i < PARTY_SIZE; i++)
        {
            gUnknown_02021860.unk0[i].unk22 = 0;
            maxHp = GetMonData(&gPlayerPartyPtr[i], MON_DATA_MAX_HP, NULL);
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_HP, &maxHp);
            status = 0;
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_STATUS, &status);
            for (j = 0; j < 4; j++)
            {
                u16 move = GetBoxMonMoveBySlot(&gPlayerPartyPtr[i].box, j);
                u32 ppBonus = GetMonData(&gPlayerPartyPtr[i], MON_DATA_PP_BONUSES, NULL);
                pp = CalculatePPWithBonus(move, ppBonus, j);
                SetMonData(&gPlayerPartyPtr[i], MON_DATA_PP1 + j, &pp);
            }
        }
        sub_020017E8(&gUnknown_02021860);
        FadeIn();
        sub_020026F4();
        FadeOut();
        break;
    }
}
#else
void NAKED sub_02002A9C(s32 a0, u32 a1, u32 a2)
{
    asm_unified("	push {r4, r5, r6, r7, lr}\t\n\
	mov r7, sl\t\n\
	mov r6, sb\t\n\
	mov r5, r8\t\n\
	push {r5, r6, r7}\t\n\
	sub sp, #0xc\t\n\
	adds r4, r0, #0\t\n\
	ldr r3, =gUnknown_02021860\t\n\
	movs r5, #0x91\t\n\
	lsls r5, r5, #1\t\n\
	adds r0, r3, r5\t\n\
	movs r5, #0\t\n\
	strb r1, [r0]\t\n\
	ldr r1, =0x0000011B\t\n\
	adds r0, r3, r1\t\n\
	strb r5, [r0]\t\n\
	adds r1, #0xa\t\n\
	adds r0, r3, r1\t\n\
	strb r2, [r0]\t\n\
	movs r0, #0x8d\t\n\
	lsls r0, r0, #1\t\n\
	adds r2, r3, r0\t\n\
	strb r5, [r2]\t\n\
	ldr r1, =gUnknown_02024960\t\n\
	ldr r0, =0x00000858\t\n\
	adds r6, r1, r0\t\n\
	ldrb r0, [r6]\t\n\
	adds r7, r1, #0\t\n\
	cmp r0, #1\t\n\
	bne _02002AF4\t\n\
	movs r1, #0x8f\t\n\
	lsls r1, r1, #1\t\n\
	adds r2, r3, r1\t\n\
	strb r0, [r2]\t\n\
	b _02002B08\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_02002AF4:\t\n\
	ldrb r0, [r6]\t\n\
	adds r1, r0, #0\t\n\
	cmp r1, #2\t\n\
	bne _02002B08\t\n\
	movs r0, #1\t\n\
	strb r0, [r2]\t\n\
	movs r2, #0x8f\t\n\
	lsls r2, r2, #1\t\n\
	adds r0, r3, r2\t\n\
	strb r1, [r0]\t\n\
_02002B08:\t\n\
	cmp r4, #0\t\n\
	beq _02002B12\t\n\
	cmp r4, #1\t\n\
	beq _02002B38\t\n\
	b _02002C1E\t\n\
_02002B12:\t\n\
	movs r5, #0x8c\t\n\
	lsls r5, r5, #1\t\n\
	adds r0, r3, r5\t\n\
	strb r4, [r0]\t\n\
	ldr r1, =0x00000123\t\n\
	adds r0, r3, r1\t\n\
	strb r4, [r0]\t\n\
	adds r0, r3, #0\t\n\
	bl sub_020017E8\t\n\
	bl FadeIn\t\n\
	bl sub_020023E8\t\n\
	bl FadeOut\t\n\
	b _02002C1E\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_02002B38:\t\n\
	movs r2, #0x8c\t\n\
	lsls r2, r2, #1\t\n\
	adds r0, r3, r2\t\n\
	strb r4, [r0]\t\n\
	ldr r5, =0x00000859\t\n\
	adds r0, r7, r5\t\n\
	ldrb r0, [r0]\t\n\
	ldr r1, =0x00000123\t\n\
	adds r4, r3, r1\t\n\
	strb r0, [r4]\t\n\
	lsls r0, r0, #0x18\t\n\
	lsrs r1, r0, #0x18\t\n\
	ldr r2, =gPlayerPartyCountPtr\t\n\
	cmp r1, #0\t\n\
	beq _02002B5E\t\n\
	ldr r0, [r2]\t\n\
	ldrb r0, [r0]\t\n\
	cmp r1, r0\t\n\
	bls _02002B64\t\n\
_02002B5E:\t\n\
	ldr r0, [r2]\t\n\
	ldrb r0, [r0]\t\n\
	strb r0, [r4]\t\n\
_02002B64:\t\n\
	movs r2, #0x92\t\n\
	lsls r2, r2, #1\t\n\
	adds r0, r3, r2\t\n\
	movs r1, #0\t\n\
	strb r1, [r0]\t\n\
	movs r6, #0\t\n\
	mov r5, sp\t\n\
	adds r5, #4\t\n\
	str r5, [sp, #8]\t\n\
	mov r0, sp\t\n\
	adds r0, #2\t\n\
	mov sl, r6\t\n\
	ldr r7, =gPlayerPartyPtr\t\n\
	mov sb, r0\t\n\
_02002B80:\t\n\
	movs r0, #0x2c\t\n\
	muls r0, r6, r0\t\n\
	adds r0, r0, r3\t\n\
	adds r0, #0x22\t\n\
	mov r1, sl\t\n\
	strb r1, [r0]\t\n\
	movs r2, #0x64\t\n\
	adds r4, r6, #0\t\n\
	muls r4, r2, r4\t\n\
	ldr r0, [r7]\t\n\
	adds r0, r0, r4\t\n\
	movs r1, #0x3a\t\n\
	movs r2, #0\t\n\
	bl GetMonData\t\n\
	mov r1, sp\t\n\
	strh r0, [r1]\t\n\
	ldr r0, [r7]\t\n\
	adds r0, r0, r4\t\n\
	movs r1, #0x39\t\n\
	mov r2, sp\t\n\
	bl SetMonData\t\n\
	mov r5, sl\t\n\
	str r5, [sp, #4]\t\n\
	ldr r0, [r7]\t\n\
	adds r0, r0, r4\t\n\
	movs r1, #0x37\t\n\
	ldr r2, [sp, #8]\t\n\
	bl SetMonData\t\n\
	movs r5, #0\t\n\
	adds r6, #1\t\n\
	mov r8, r6\t\n\
	adds r6, r4, #0\t\n\
_02002BC6:\t\n\
	ldr r0, [r7]\t\n\
	adds r0, r0, r6\t\n\
	adds r1, r5, #0\t\n\
	bl GetBoxMonMoveBySlot\t\n\
	adds r4, r0, #0\t\n\
	lsls r4, r4, #0x10\t\n\
	lsrs r4, r4, #0x10\t\n\
	ldr r0, [r7]\t\n\
	adds r0, r0, r6\t\n\
	movs r1, #0x15\t\n\
	movs r2, #0\t\n\
	bl GetMonData\t\n\
	adds r1, r0, #0\t\n\
	adds r0, r4, #0\t\n\
	adds r2, r5, #0\t\n\
	bl CalculatePPWithBonus\t\n\
	mov r1, sb\t\n\
	strh r0, [r1]\t\n\
	ldr r0, [r7]\t\n\
	adds r0, r0, r6\t\n\
	adds r1, r5, #0\t\n\
	adds r1, #0x11\t\n\
	mov r2, sb\t\n\
	bl SetMonData\t\n\
	adds r5, #1\t\n\
	cmp r5, #3\t\n\
	ble _02002BC6\t\n\
	mov r6, r8\t\n\
	ldr r3, =gUnknown_02021860\t\n\
	cmp r6, #5\t\n\
	ble _02002B80\t\n\
	adds r0, r3, #0\t\n\
	bl sub_020017E8\t\n\
	bl FadeIn\t\n\
	bl sub_020026F4\t\n\
	bl FadeOut\t\n\
_02002C1E:\t\n\
	add sp, #0xc\t\n\
	pop {r3, r4, r5}\t\n\
	mov r8, r3\t\n\
	mov sb, r4\t\n\
	mov sl, r5\t\n\
	pop {r4, r5, r6, r7}\t\n\
	pop {r0}\t\n\
	bx r0\t\n\
	.align 2, 0\t\n\
	.pool");
}
#endif

void sub_02002C44(void)
{
    CpuFill16(0, &gUnknown_02021860, sizeof(gUnknown_02021860));
    gUnknown_02021860.unk11A = 0;
    gUnknown_02021860.unk11B = 0;
    gUnknown_02021860.unk11E = 1;
}

void sub_02002C80(void)
{
    gUnknown_02021860.unk11B = 0;
    if (gUnknown_02021860.unk11A == 0)
        gUnknown_02021860.unk11E = 1;
    else
        gUnknown_02021860.unk11E = 2;
}
