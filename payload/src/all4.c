#include "global.h"
#include "gflib.h"
#include "all.h"
#include "strings.h"
#include "graphics.h"
#include "unk_200C5DC.h"
#include "gflib/text.h"
#include "gflib/gfxload.h"
#include "libpmagb/pic_uncomp.h"
#include "libpmagb/agb_rom.h"
#include "libpmagb/save.h"
#include "pokemon.h"
#include "pokedex.h"
#include "constants/pokemon.h"
#include "constants/species.h"
#include "constants/moves.h"
#include "constants/items.h"
#include "constants/songs.h"

extern void sub_02002C80(void);

extern const struct Window gUnknown_0201FE3C;
extern const struct Window gUnknown_0201FE5C;

extern const struct Subsprites *gUnknown_0201FC44[];
extern const struct Subsprites gUnknown_0201FC4C[];

struct Unk2021A20Str
{
    struct Sprite *unk0;
    struct Sprite *unk4;
    struct Sprite *unk8;
    u16 unkC;
    u16 unkE;
    u8 unk10;
    u8 fill11[3];
    struct Window *unk14;
    struct Window *unk18;
};

extern struct Unk2021A20Str gUnknown_02021A20;

// Error related
extern u8 gUnknown_020217B4;
extern u8 gRomDetection_IsEnglishROM;
extern u8 gUnknown_020217B8;
extern const struct Window gFont0LatinInfo;
extern const struct Window gUnknown_0201FB90;
extern struct Window *gMessageWindowPtr;

extern const u8 *gErrorMessagePtrs[];

s32 sub_02006058(void);
s32 sub_02006264(void);
u32 sub_020064BC(u32 a0, s32 a1);

static void sub_0200465C(void)
{
    ClearVram();
    REG_DISPCNT = DISPCNT_BG0_ON | DISPCNT_BG2_ON | DISPCNT_OBJ_ON | DISPCNT_OBJ_1D_MAP;
    REG_BG0CNT = BGCNT_PRIORITY(1) | BGCNT_CHARBASE(0) | BGCNT_SCREENBASE(31);
    REG_BG2CNT = BGCNT_PRIORITY(0) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(30);
    REG_BG0CNT |= BGCNT_256COLOR;
    AutoUnCompVram(gUnknown_0201B1A0, (void *) PLTT);
    AutoUnCompVram(gUnknown_0201A894, (void *) PLTT + 0x1C0);
    AutoUnCompVram(gMessageBox_Gfx, (void *) VRAM + 0x8000);
    AutoUnCompVram(gTitle_Pal, (void *) PLTT);
    AutoUnCompVram(gTitle_Gfx, (void *) VRAM);
    AutoUnCompVram(gTitle_Tilemap, (void *) IWRAM_START );
    DrawTextWindowBorder(0, 16, 30, 4, 0xE001);
    gMessageWindowPtr = AddWindow(0, &gUnknown_0201FB90);
    SetTextColor(gMessageWindowPtr, 1, 8);
    gBgTilemapBufferTransferScheduled[0] = TRUE;
    gBgTilemapBufferTransferScheduled[2] = TRUE;
}

static inline void PrintErrorMsg(struct Window *win, u32 msgId)
{
    ClearWindowCharBuffer(win, 0xFFFF);
    RenderText(win, gErrorMessagePtrs[msgId]);
}

static void sub_0200472C(void)
{
    switch (gUnknown_020217B4)
    {
    case 2:
        PrintErrorMsg(gMessageWindowPtr, 6);
        break;
    case 0xFF:
        PrintErrorMsg(gMessageWindowPtr, 7);
        break;
    case 0:
        PrintErrorMsg(gMessageWindowPtr, 8);
        break;
    default:
        PrintErrorMsg(gMessageWindowPtr, 1);
        break;
    }
}

// Same as ErrorPrint
static inline void ErrorPrintInline(u32 msgId)
{
    struct Window *win;
    struct Window winTemplate;

    winTemplate = gFont0LatinInfo;
    FillBgTilemapBufferRect(2, 0, 16, 30, 4, 0);
    DrawTextWindowBorder(3, 14, 24, 6, 0xE001);
    win = AddWindow(0, &winTemplate);
    SetTextColor(win, 1, 8);
    ClearWindowCharBuffer(win, 0xFFFF);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    if (IsScreenFadedOut() == TRUE)
        FadeIn();
    RenderText(win, gErrorMessagePtrs[msgId]);
    // Game stuck
    while (1)
    {
        DelayFrames(100);
    }
}

u32 sub_020047D4(void)
{
    s32 r5;

    gUnknown_02024960.unk_87B = 4;
    sub_0200465C();
    if (gAgbPmRomParams->blockLinkColoXD || !gRomDetection_IsEnglishROM)
    {
        u8 UNUSED buff[8]; // Needed to match stack.
        OverrideScreenFadeState(TRUE);
        // Inline call needed to match.
        ErrorPrintInline(9);
    }

    if (gUnknown_020217B8 != 1)
        sub_0200472C();
    else
        ClearWindowCharBuffer(gMessageWindowPtr, 0xFFFF);

    gUnknown_02024960.unk_859 = 0;
    gUnknown_02024960.unk84C_01 = 0;
    gUnknown_02024960.unk_87A = 0;
    gUnknown_02024960.unk84C_00 = 0;
    FadeIn();
    if (gUnknown_020217B4 == 2 || gUnknown_020217B4 == 0xFF || gUnknown_020217B4 == 0)
    {
        // Game stuck
        while (1)
        {
            DelayFrames(0xFF);
        }
    }

    if (gUnknown_020217B8 == 1)
    {
        RenderText(gMessageWindowPtr, gText_BerryProgramUpdated);
        sub_0200472C();
    }
    if (gUnknown_02024960.unk_87F != 0)
    {
        REG_JOY_TRANS = gUnknown_02024960.unk_880;
        gUnknown_02024960.unk_87F = 0;
    }
    r5 = 0;
    while (r5 == 0)
    {
        DelayFrames(1);
        if (gUnknown_02024960.unk_859 != 0 && sub_0200CB54() == 1)
            r5 = 2;
        if (gUnknown_02024960.unk84C_00 == 1)
        {
            gUnknown_02024960.unk84C_00 = 0;
            sub_02006058();
        }
        if (gUnknown_02024960.unk_87A == 1)
            r5 = 1;
        if (gUnknown_02024960.unk_85A == 1)
        {
            gUnknown_02024960.unk_85A = 0;
            sub_02006264();
            PrintErrorMsg(gMessageWindowPtr, 1);
        }
    }
    FadeOut();
    return r5 - 1;
}

void WarningPrint(u32 msgId)
{
    struct Window *win = gMessageWindowPtr;

    ClearWindowCharBuffer(win, 0xFFFF);
    RenderText(win, gErrorMessagePtrs[msgId]);
}

void ErrorPrint(u32 msgId)
{
    struct Window *win;
    struct Window winTemplate;

    winTemplate = gFont0LatinInfo;
    FillBgTilemapBufferRect(2, 0, 16, 30, 4, 0);
    DrawTextWindowBorder(3, 14, 24, 6, 0xE001);
    win = AddWindow(0, &winTemplate);
    SetTextColor(win, 1, 8);
    ClearWindowCharBuffer(win, 0xFFFF);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    if (IsScreenFadedOut() == TRUE)
        FadeIn();
    RenderText(win, gErrorMessagePtrs[msgId]);
    // Game stuck
    while (1)
    {
        DelayFrames(100);
    }
}

void sub_02004AC4(void)
{
    ClearVram();
    REG_DISPCNT = DISPCNT_BG_ALL_ON | DISPCNT_OBJ_ON | DISPCNT_OBJ_1D_MAP;
    REG_BG0CNT = BGCNT_PRIORITY(0) | BGCNT_CHARBASE(0) | BGCNT_SCREENBASE(27);
    REG_BG1CNT = BGCNT_PRIORITY(1) | BGCNT_CHARBASE(0) | BGCNT_SCREENBASE(15);
    REG_BG2CNT = BGCNT_PRIORITY(2) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(28) | BGCNT_TXT512x256;
    REG_BG3CNT = BGCNT_PRIORITY(3) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(30);
    AutoUnCompVram(gUnknown_0201B1A0, (void *) PLTT);
    AutoUnCompVram(gMonInfoIcons_Gfx, (void *) VRAM);
    AutoUnCompVram(gBattleScreen_Gfx, (void *) VRAM + 0x8000);
    AutoUnCompVram(gBattleScreen_Pal, (void *) PLTT + 0x140);

    AutoUnCompVram(gBattleScreen_Tilemap, (void *) IWRAM_START + 0x3000);
    AutoUnCompVram(gBattleWindows_Tilemap, (void *) IWRAM_START + 0x2800);

    gBgTilemapBufferTransferScheduled[2] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;

    AutoUnCompVram(gTypeStatusIcons_Pal, (void *) PLTT + 0x200);
    AutoUnCompVram(gTypeStatusIcons_Gfx, (void *) VRAM + 0x10000);

    *(u16 *)(PLTT) = 0x5108;

    CpuFill16(0, &gUnknown_02021A20, sizeof(gUnknown_02021A20));

    gUnknown_02021A20.unk14 = AddWindow(0, &gUnknown_0201FE3C);
    gUnknown_02021A20.unk18 = AddWindow(1, &gUnknown_0201FE5C);

    SetTextColor(gUnknown_02021A20.unk14, 1, 8);
    SetTextColor(gUnknown_02021A20.unk18, 1, 8);
}

void sub_02004BEC(struct Unk2021A20Str *a0, u32 monId, s32 x, s32 y)
{
    void *buffer;
    u32 personality;
    const struct CompressedSpriteSheet *monFrontSheet;
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->speciesInfo;

    a0->unkC = gUnknown_02024960.unk10;
    if (a0->unkC == SPECIES_NONE)
        return;

    personality = gUnknown_02024960.unk8;
    a0->unkE = FixUnownSpecies(a0->unkC, personality);
    if (a0->unk0 != NULL)
        MoveSpriteToHead(a0->unk0);

    a0->unk0 = AddSprite(x, y, gUnknown_0201FC44[speciesInfo[a0->unkC].noFlip]);
    SetSpritePaletteNum(a0->unk0, 4);
    monFrontSheet = &gAgbPmRomParams->monFrontPics[a0->unkE];
    buffer = GetPicUncompPtr();
    LZ77UnCompVram(monFrontSheet->data, buffer);
    if (a0->unkC == SPECIES_CASTFORM)
        buffer += (gUnknown_02024960.unk12 * 0x800);
    DrawSpindasSpots(a0->unkC, personality, buffer);
    CpuCopy16(buffer, (void *)VRAM + 0x12000, 0x800);
    LZ77UnCompWram(GetMonPalettePtrBySpeciesIdPersonality(a0->unkC, gUnknown_02024960.unkC, personality)->data, buffer);
    if (a0->unkC == SPECIES_CASTFORM)
        buffer += (gUnknown_02024960.unk12 * 32);
    CpuCopy16(buffer, (void *)PLTT + 0x280, 0x20);
}

void sub_02004CE4(struct Pokemon *mon)
{
    u8 text[16];
    u32 gender = GetMonGender(mon);
    if (gender == MON_MALE || gender == MON_FEMALE)
    {
        text[1] = EOS;
        TextWindowSetXY(gUnknown_02021A20.unk14, 72, 16);
        if (gender == MON_MALE)
        {
            text[0] = CHAR_MALE;
            SetTextColor(gUnknown_02021A20.unk14, 4, 5);
        }
        else
        {
            text[0] = CHAR_FEMALE;
            SetTextColor(gUnknown_02021A20.unk14, 7, 8);
        }
        RenderText(gUnknown_02021A20.unk14, text);
        SetBgTilemapBufferPaletteRect(0, 20, 8, 1, 2, 0);
        SetTextColor(gUnknown_02021A20.unk14, 1, 8);
    }
}

void sub_02004D68(u32 monId)
{
    s32 i;
    u8 text[32];
    u32 level, species;
    s32 var;
    struct Pokemon *mon = &gPlayerPartyPtr[monId];

    sub_02004BEC(&gUnknown_02021A20, monId, 8, 32);
    text[0] = 0x34;
    text[1] = EOS;
    TextWindowSetXY(gUnknown_02021A20.unk14, 8, 0);
    RenderText(gUnknown_02021A20.unk14, text);

    level = GetMonData(mon, MON_DATA_LEVEL, NULL);
    NumToPmString3CustomZeroChar(level, text, CHAR_0);
    for (i = 0; text[i] == CHAR_0; i++)
        ;
    if (text[i] == EOS)
        i--;
    TextWindowSetXY(gUnknown_02021A20.unk14, 17, 0);
    RenderText(gUnknown_02021A20.unk14, text + i);

    GetMonData(mon, MON_DATA_NICKNAME, text);
    BufferString(4, text);
    TextWindowSetXY(gUnknown_02021A20.unk14, 44, 0);
    RenderText(gUnknown_02021A20.unk14, text);

    species = GetMonData(mon, MON_DATA_SPECIES, NULL);
    if (species != SPECIES_NIDORAN_M && species != SPECIES_NIDORAN_F)
        sub_02004CE4(mon);

    GetSpeciesName(text, species);
    TextWindowSetXY(gUnknown_02021A20.unk14, 8, 16);
    RenderText(gUnknown_02021A20.unk14, text);

    var = GetMonStatus(mon);
    if (var != STATUS_PRIMARY_NONE)
    {
        if (gUnknown_02021A20.unk4 == NULL)
            gUnknown_02021A20.unk4 = AddSprite(166, 68, gUnknown_0201FC4C);
        SetSpriteInvisible(gUnknown_02021A20.unk4, FALSE);
        SetSpriteTileOffset(gUnknown_02021A20.unk4, (var - 1) * 4);
    }

    DrawPartyMonHealthBar(1, 12, 10, monId);
    SetBgPos(1, 0, -4);
    gBgTilemapBufferTransferScheduled[1] = TRUE;

    var = GetMonData(mon, MON_DATA_HP, NULL);
    NumToPmString3RightAlign(text, var);
    text[3] = CHAR_SLASH;
    var = GetMonData(mon, MON_DATA_MAX_HP, NULL);
    NumToPmString3RightAlign(text + 4, var);
    TextWindowSetXY(gUnknown_02021A20.unk14, 80, 32);
    gUnknown_02021A20.unk14->glyphWidth = 6;
    RenderText(gUnknown_02021A20.unk14, text);
    gBgTilemapBufferTransferScheduled[0] = TRUE;
}

struct StrCoords
{
    u8 x;
    u8 y;
    u8 unk2;
    const u8 *str;
    void (*callback)(s32 id);
};

extern const struct Subsprites gUnknown_0201FC64[];
extern const struct Subsprites gUnknown_0201FCA0[];
extern const struct Subsprites gUnknown_0201FCF4[];
extern const struct Subsprites gUnknown_0201FD60[];

extern const struct StrCoords gText_BattleOptions[];
extern const struct StrCoords gUnknown_0201FDC4[];
extern const struct StrCoords gUnknown_0201FDF4[];
extern const struct StrCoords gUnknown_0201FE24[];

static inline void sub_02004F04Inline(struct Window *window, const struct StrCoords *strInfo, s32 count)
{
    s32 i;

    for (i = 0; i < count; i++, strInfo++)
        RenderTextAt(window, strInfo->x - (window->left * 8), strInfo->y - (window->top * 8), strInfo->str);
}

void sub_02004F04(struct Window *window, const struct StrCoords *strInfo, s32 count)
{
    sub_02004F04Inline(window, strInfo, count);

    if (gUnknown_02021A20.unk8 != NULL)
    {
        MoveSpriteToHead(gUnknown_02021A20.unk8);
        gUnknown_02021A20.unk8 = NULL;
    }

    if (strInfo == gText_BattleOptions)
        gUnknown_02021A20.unk8 = AddSprite(0, 0, gUnknown_0201FC64);
    else if (strInfo == gUnknown_0201FDC4)
        gUnknown_02021A20.unk8 = AddSprite(0, 0, gUnknown_0201FCA0);
    else if (strInfo == gUnknown_0201FDF4)
        gUnknown_02021A20.unk8 = AddSprite(0, 0, gUnknown_0201FCF4);
    else if (strInfo == gUnknown_0201FE24)
        gUnknown_02021A20.unk8 = AddSprite(0, 0, gUnknown_0201FD60);

    SetSpritePaletteNum(gUnknown_02021A20.unk8, 5);
    SetSpritePos(gUnknown_02021A20.unk8, strInfo[0].x, strInfo[0].y);
}

s32 sub_02004FB8(const struct StrCoords *strInfo, s32 count)
{
    u32 keys;
    const struct StrCoords *curr;
    s32 i, previousId;

    for (i = 0; strInfo[i].str[0] == EOS; i++)
        ;

    if (strInfo == gUnknown_0201FDF4 && i == 1 && strInfo[2].str[0] != EOS)
        i = 2;

    if (i < count)
    {
        SetSpritePos(gUnknown_02021A20.unk8, strInfo[i].x, strInfo[i].y);
        curr = &strInfo[i];
        while (1)
        {
            DelayFrames(1);
            keys = gNewKeys;
            previousId = i;
            if (keys & DPAD_RIGHT)
            {
                if (i == 0)
                {
                    if (strInfo[1].str[0] != EOS && strInfo[1].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[1];
                        i = 1;
                    }
                    else if (strInfo[3].str[0] != EOS && strInfo[3].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[3];
                        i = 3;
                    }
                }
                if (i == 2)
                {
                    if (strInfo[3].str[0] != EOS && strInfo[3].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[3];
                        i = 3;
                    }
                    else if (strInfo[1].str[0] != EOS && strInfo[1].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[1];
                        i = 1;
                    }
                }
            }
            if (keys & DPAD_LEFT)
            {
                if (i == 1)
                {
                    if (strInfo[0].str[0] != EOS && strInfo[0].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[0];
                        i = 0;
                    }
                    else if (strInfo[2].str[0] != EOS && strInfo[2].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[2];
                        i = 2;
                    }
                }
                if (i == 3)
                {
                    if (strInfo[2].str[0] != EOS && strInfo[2].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[2];
                        i = 2;
                    }
                    else if (strInfo[0].str[0] != EOS && strInfo[0].str[0] != CHAR_HYPHEN)
                    {
                        curr = &strInfo[0];
                        i = 0;
                    }
                }
            }
            if (keys & DPAD_DOWN)
            {
                if (i + 2 < count && curr[2].str[0] != EOS)
                {
                    curr += 2;
                    i += 2;
                }
            }
            if (keys & DPAD_UP)
            {
                if (i - 2 >= 0 && curr[-2].str[0] != EOS)
                {
                    curr -= 2;
                    i -= 2;
                }
            }

            if (previousId != i)
            {
                PlaySE(SONG_SE_SELECT);
                SetSpritePos(gUnknown_02021A20.unk8, curr->x, curr->y);
                if (curr->callback != NULL)
                    curr->callback(i);
            }

            if (keys & B_BUTTON)
            {
                PlaySE(SONG_SE_SELECT);
                return 0;
            }
            if (keys & A_BUTTON)
            {
                PlaySE(SONG_SE_SELECT);
                gUnknown_02021A20.unk10 = i;
                return curr->unk2;
            }
        }
    }
    return 0;
}

static u32 gUnknown_02020A48;

void sub_02005168(s32 id)
{
    u8 text[16];
    s32 ppBonuses, ppTotal, ppCurr, type;
    struct Pokemon *mon = &gPlayerPartyPtr[gUnknown_02020A48];
    const struct BattleMove *moves = gAgbPmRomParams->moves;
    u32 move = gUnknown_02024960.unk14[id];

    FillWindowCharBufferRect(gUnknown_02021A20.unk18, 22, 2, 6, 2, 0);
    type = moves[move].type;
    RenderTextAt(gUnknown_02021A20.unk18, 176, 16, gTypeNames[type]);

    FillWindowCharBufferRect(gUnknown_02021A20.unk18, 24, 0, 4, 2, 0);
    ppCurr = gUnknown_02024960.unk1C[id];
    ppBonuses = GetMonData(mon, MON_DATA_PP_BONUSES, NULL);
    ppTotal = CalculatePPWithBonus(move, ppBonuses, id);
    NumToPmString3RightAlign(text, ppCurr);
    text[3] = CHAR_SLASH;
    NumToPmString3RightAlign(text + 4, ppTotal);
    text[4] = text[5];
    text[5] = text[6];
    text[6] = text[7];
    RenderTextAt(gUnknown_02021A20.unk18, 191, 0, text);
}

s32 sub_02005264(s32 monId)
{
    u8 text[16];
    s32 i, count;

    CopyRectWithinBgTilemapBuffer(2, 0, 38, 30, 6, 0, 14);
    FillBgTilemapBufferRect(3, 0, 14, 30, 6, 0);
    ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0);
    RenderTextAt(gUnknown_02021A20.unk18, 176, 0, gText_PP);
    sub_02005168(0);

    for (count = 0, i = 0; i < MAX_MON_MOVES; i++)
    {
        u32 move = gUnknown_02024960.unk14[i];
        if (move != MOVE_NONE)
        {
            CopyMoveName(text, move);
            count++;
        }
        else
        {
            StringCopy(text, gText_1Dash);
        }
        BufferString(i, text);
    }

    sub_02004F04(gUnknown_02021A20.unk18, gUnknown_0201FDC4, 4);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;

    return count;
}

extern u8 gUnknown_02021A00[];
extern u8 gStringBuffers[][32];

u8 *sub_0200531C(s32 id)
{
    u8 UNUSED unusedVar[4];
    u8 text[16];
    s32 len, i;
    u8 *txtPtr = gUnknown_02021A00;

    CpuFill16(0, txtPtr, 0x20);
    if (gUnknown_02024960.unk81C[id].str[0] == EOS)
    {
        txtPtr[0] = EOS;
    }
    else
    {
        txtPtr[0] = gUnknown_02024960.unk81C[id].unk826_0 + CHAR_0;
        txtPtr[1] = CHAR_P;
        txtPtr[2] = CHAR_COLON;
        txtPtr[3] = CHAR_SPACE;
        len = 4;
        if (gUnknown_02024960.unk81C[id].unk826_1)
        {
            txtPtr[4] = EXT_CTRL_CODE_BEGIN;
            txtPtr[5] = 0x15;
            len = 6;
        }
        for (i = 0; i < gAgbPmRomParams->pokemonNameLength2; i++)
        {
            if (gUnknown_02024960.unk81C[id].str[i] == EOS)
                break;
            txtPtr[i + len] = gUnknown_02024960.unk81C[id].str[i];
        }
        i += len;
        if (gUnknown_02024960.unk81C[id].unk826_3 || gUnknown_02024960.unk81C[id].unk826_2)
        {
            u32 species;

            if (gUnknown_02024960.unk81C[id].unk826_3)
                species = SPECIES_NIDORAN_M;
            else
                species = SPECIES_NIDORAN_F;
            GetSpeciesName(text, species);
            if (StringCompare((u8 *)gUnknown_02024960.unk81C[id].str, text) == 0)
            {
                if (gUnknown_02024960.unk81C[id].unk826_4 == 0)
                    txtPtr[i++] = CHAR_MALE;
                else if (gUnknown_02024960.unk81C[id].unk826_4 == 1)
                    txtPtr[i++] = CHAR_FEMALE;
            }
        }
        else
        {
            if (gUnknown_02024960.unk81C[id].unk826_4 == 0)
                txtPtr[i++] = CHAR_MALE;
            else if (gUnknown_02024960.unk81C[id].unk826_4 == 1)
                txtPtr[i++] = CHAR_FEMALE;
        }
        txtPtr[i] = EOS;
    }

    return txtPtr;
}

s32 sub_02005468(void)
{
    u8 text[1];

    text[0] = EOS;
    CopyRectWithinBgTilemapBuffer(3, 0, 20, 30, 6, 0, 14);
    FillBgTilemapBufferRect(2, 0, 14, 30, 6, 0);
    ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0xFFFF);
    StringCopy(gStringBuffers[0], sub_0200531C(0));
    StringCopy(gStringBuffers[1], sub_0200531C(1));
    if (gUnknown_02024960.unk7 == 4)
    {
        StringCopy(gStringBuffers[2], sub_0200531C(2));
        StringCopy(gStringBuffers[3], sub_0200531C(3));
    }
    else
    {
        StringCopy(gStringBuffers[2], text);
        StringCopy(gStringBuffers[3], text);
    }
    sub_02004F04(gUnknown_02021A20.unk18, gUnknown_0201FDF4, 4);
    gBgTilemapBufferTransferScheduled[3] = TRUE;
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    return gUnknown_02024960.unk7;
}

s32 sub_02005548(void)
{
    s32 var;

    CopyRectWithinBgTilemapBuffer(3, 0, 20, 30, 6, 0, 14);
    FillBgTilemapBufferRect(2, 0, 14, 30, 6, 0);
    ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0xFFFF);
    RenderTextAt(gUnknown_02021A20.unk18, 0, 0, gText_WillYouGiveIn);
    sub_02004F04(gUnknown_02021A20.unk18, gUnknown_0201FE24, 2);
    gBgTilemapBufferTransferScheduled[3] = TRUE;
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    var = sub_02004FB8(gUnknown_0201FE24, 2);
    if (var != 1)
        ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0);
    return var;
}

static inline void sub_2005E68_Inline(void)
{
    CopyRectWithinBgTilemapBuffer(2, 0, 32, 30, 6, 0, 14);
    FillWindowCharBufferRect(gUnknown_02021A20.unk18, 18, 0, 10, 4, 0);
    RenderTextAt(gUnknown_02021A20.unk18, 0, 0, gText_WhatWillMonDo);
    sub_02004F04(gUnknown_02021A20.unk18, gText_BattleOptions, 4);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
}

static inline void sub_2005F08_Inline(u32 unused, s32 moveSlot)
{
    u8 text[28];
    u32 move = gUnknown_02024960.unk14[moveSlot];
    if (move != MOVE_NONE)
        CopyMoveName(text, move);
    else
        StringCopy(text, gText_1Dash);
    BufferString(0, text);
}

void sub_020055D4(s32 monId, s32 moveSlot, u32 stringId, bool32 arg3)
{
    u8 text[24];

    FillBgTilemapBufferRect(2, 0, 14, 30, 6, 0);
    CopyRectWithinBgTilemapBuffer(3, 0, 20, 30, 6, 0, 14);
    ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0);
    MoveSpriteToHead(gUnknown_02021A20.unk8);
    gUnknown_02021A20.unk8 = NULL;

    if (moveSlot != 0)
        sub_2005F08_Inline(0, moveSlot - 1);

    GetMonData(&gPlayerPartyPtr[monId], MON_DATA_NICKNAME, text);
    BufferString(4, text);
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;
    RenderText(gUnknown_02021A20.unk18, gBattleStringsTable[stringId]);
    if (!arg3)
    {
        ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0);
        sub_2005E68_Inline();
    }
}

u32 sub_02006414(s32 moveSlot);
u32 sub_0200645C(void);
u32 sub_0200644C(void);
u32 sub_02006430(s32 moveSlot);

static inline bool32 sub_2005F44_Inline(s32 monId, s32 moveSlot)
{
    switch (sub_02006414(moveSlot - 1))
    {
    case 0:
        return TRUE;
    case 1:
        sub_020055D4(monId, moveSlot, 4, FALSE);
        break;
    case 2:
        sub_020055D4(monId, moveSlot, 5, FALSE);
        break;
    case 3:
        sub_020055D4(monId, moveSlot, 6, FALSE);
        break;
    case 4:
        sub_020055D4(monId, moveSlot, 7, FALSE);
        break;
    case 5:
        sub_020055D4(monId, sub_0200645C(), 8, FALSE);
        break;
    case 6:
        sub_020055D4(monId, moveSlot, 9, FALSE);
        break;
    }
    return FALSE;
}

static inline void sub_2005ECC_Inline(void)
{
    CopyRectWithinBgTilemapBuffer(3, 0, 20, 30, 6, 0, 14);
    ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0);
    gBgTilemapBufferTransferScheduled[3] = TRUE;
}

struct TstStruct
{
    u8 state;
    u8 u1;
    u8 moveSlot;
};

extern struct TstStruct gUnknown_020219F0;

bool32 sub_02005704(u32 monId)
{
    u32 r2;
    bool32 loop;
    u32 r9;
    struct TstStruct *r7 = &gUnknown_020219F0;

    gUnknown_02020A48 = monId;
    sub_02004AC4();
    sub_02004D68(monId);
    sub_2005E68_Inline();
    FadeIn();
    loop = TRUE;
    while (loop)
    {
        switch (r7->state)
        {
        case 0:
            sub_2005E68_Inline();
            r7->state = sub_02004FB8(gText_BattleOptions, 4);
            if (r7->state == 0 && gUnknown_02024960.unk_03_0 == 2)
            {
                gUnknown_02024960.unk_87B = 0;
                loop = FALSE;
            }
            break;
        case 1:
            if (sub_0200644C() == 1)
            {
                sub_020055D4(gUnknown_02020A48, 0, 14, 1);
                gUnknown_02024960.unk_87C = 0;
                gUnknown_02024960.unk_87B = 1;
                r7->state = 0;
                loop = FALSE;
            }
            else if (sub_0200644C() == 2)
            {
                gUnknown_02024960.unk_87C = 0;
                gUnknown_02024960.unk_87B = 1;
                r7->state = 0;
                loop = FALSE;
            }
            else
            {
                u32 var = sub_02005264(monId);
                r7->moveSlot = sub_02004FB8(gUnknown_0201FDC4, var);
                if (r7->moveSlot == 0)
                {
                    r7->state = 0;
                    sub_2005ECC_Inline();
                }
                else if (sub_02006430(r7->moveSlot - 1) == 0)
                {
                    if (sub_2005F44_Inline(gUnknown_02020A48, r7->moveSlot))
                    {
                        gUnknown_02024960.unk_87C = r9,
                        gUnknown_02024960.unk_87B = 1,
                        loop = FALSE;
                    }
                    r7->state = 0;
                }
                else
                {
                    r7->state = 4;
                }
            }
            break;
        case 2:
            r9 = sub_02005548();
            r7->state = 0;
            if (r9 == 1)
            {
                gUnknown_02024960.unk_87B = 3;
                loop = FALSE;
            }
            break;
        case 3:
            FadeOut();
            sub_02002C80();
            if (gUnknown_02024960.unk_03_0 == 0)
                gUnknown_02024960.unk_858 = 1;
            else
                gUnknown_02024960.unk_858 = 2;
            sub_02002A9C(0, monId, 0);
            r7->state = 0;
            if (gUnknown_02024960.unk_87B != 4)
            {
                loop = FALSE;
            }
            else
            {
                sub_02004AC4();
                sub_02004D68(monId);
                sub_2005E68_Inline();
                FadeIn();
            }
            break;
        case 4:
            sub_02005468();
            r9 = sub_02004FB8(gUnknown_0201FDF4, 4);
            if (r9 == 0)
            {
                r7->state = 1;
            }
            else
            {
                if (sub_2005F44_Inline(gUnknown_02020A48, r7->moveSlot))
                {
                    gUnknown_02024960.unk_87C = r9,
                    gUnknown_02024960.unk_87B = 1,
                    loop = FALSE;
                }
                r7->state = 0;
            }
            break;
        }

        DelayFrames(1);
    }

    r2 = 0;
    switch (gUnknown_02024960.unk_87B)
    {
    case 1:
        r2 = r7->moveSlot - 1;
        r2 |= (((gUnknown_02024960.unk_87C - 1) << 8) & 0xFF00);
        break;
    case 2:
        r2 = gUnknown_02024960.unk_87E;
        break;
    }

    r2 |= (gUnknown_02024960.unk_87B) << 16;
    gUnknown_02024960.unk_880 = r2;
    gUnknown_02024960.unk_87F = 1;

    if (!IsScreenFadedOut())
        FadeOut();

    return FALSE;
}

void sub_02005BB8(void)
{
    u16 var;
    u32 var_28;
    s32 i;

    CpuFill16(0, gPlayerPartyPtr, sizeof(struct Pokemon) * PARTY_SIZE);
    var_28 = gUnknown_02024960.unk_00;
    for (i = 0; i < PARTY_SIZE; i++, var_28 >>= 4)
    {
        u32 id = var_28 & 0xF;
        if ((id) != 0xF)
        {
            CpuCopy16(&gPlayerPartyBakPtr[id], &gPlayerPartyPtr[i], sizeof(struct Pokemon));

            var = gUnknown_02024960.unk24[i].hp;
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_HP, &var);

            var = gUnknown_02024960.unk24[i].status;
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_STATUS, &var);

            var = 0;
            if (gUnknown_02024960.unk24[i].unk27_0)
                var = 0xF;
            if (gUnknown_02024960.unk24[i].unk27_1)
                var |= 0xF0;
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_POKERUS, &var);

            if (gUnknown_02024960.unk24[i].unk27_2)
            {
                var = 1;
                SetMonData(&gPlayerPartyPtr[i], MON_DATA_MAIL, &var);
            }

            var = 0;
            if (gUnknown_02024960.unk24[i].unk27_3)
                var = gUnknown_02024960.unk24[i].heldItem;
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_HELD_ITEM, &var);

            var = gUnknown_02024960.unk24[i].moves[0];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_MOVE1, &var);
            var = gUnknown_02024960.unk24[i].moves[1];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_MOVE2, &var);
            var = gUnknown_02024960.unk24[i].moves[2];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_MOVE3, &var);
            var = gUnknown_02024960.unk24[i].moves[3];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_MOVE4, &var);

            var = gUnknown_02024960.unk24[i].pps[0];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_PP1, &var);
            var = gUnknown_02024960.unk24[i].pps[1];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_PP2, &var);
            var = gUnknown_02024960.unk24[i].pps[2];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_PP3, &var);
            var = gUnknown_02024960.unk24[i].pps[3];
            SetMonData(&gPlayerPartyPtr[i], MON_DATA_PP4, &var);

            CpuCopy16((void*) gUnknown_02024960.unk24[i].unk38, sub_0200CB34(i), 320);
        }
    }

    if (gUnknown_02024960.unk_03_0 != 0)
        gUnknown_02024960.unk_858 = 1;
    else
        gUnknown_02024960.unk_858 = 0;
}

static s32 UNUSED sub_02005DCC(s32 monId, u32 stringId)
{
    u8 text[24];

    gUnknown_02020A48 = monId;
    sub_02004AC4();
    sub_02004D68(monId);
    CopyRectWithinBgTilemapBuffer(2, 0, 38, 30, 6, 0, 14);
    FillBgTilemapBufferRect(3, 0, 14, 30, 6, 0);
    ClearWindowCharBuffer(gUnknown_02021A20.unk18, 0);
    GetMonData(&gPlayerPartyPtr[monId], MON_DATA_NICKNAME, text);
    BufferString(4, text);
    FadeIn();
    RenderText(gUnknown_02021A20.unk18, gBattleStringsTable[stringId]);
    FadeOut();

    return; // Garbage return
}

static void UNUSED sub_02005E68(void)
{
    sub_2005E68_Inline();
}

static void UNUSED sub_02005ECC(void)
{
    sub_2005ECC_Inline();
}

static void UNUSED sub_02005F08(u32 unused, s32 moveSlot)
{
    sub_2005F08_Inline(unused, moveSlot);
}

static bool32 UNUSED sub_02005F44(s32 monId, s32 moveSlot)
{
    return sub_2005F44_Inline(monId, moveSlot);
}

bool32 sub_02005FCC(void)
{
    bool32 val = sub_0200A2C8(0);

    gUnknown_02024960.unk84C_02 = 0;
    if (!val)
    {
        REG_JOY_TRANS = 0;
        while (!gUnknown_02024960.unk84C_02)
            ;
        val = sub_0200A2C8(1);
        while (gUnknown_02024960.unk84C_03)
            ;

        if (!val)
        {
            REG_JOY_TRANS = 0;
            return FALSE;
        }
    }

    REG_JOY_TRANS = -1;
    return TRUE;
}

extern u8 gRomDetection_IsRubySapphire;

static inline u16 Test(const struct GFRomHeader *rom, void *sav2)
{
    u16 *ptr = sav2 + rom->gcnLinkFlagsOffset;
    return *ptr;
}

static inline u8 Test2(const struct GFRomHeader *rom, void *sav2)
{
    u8 *ptr = sav2 + rom->warpFlagsOffset;
    return *ptr;
}

s32 sub_02006058(void)
{
    s32 i;
    s32 var;

    WarningPrint(2);
    while (!gUnknown_02024960.unk84C_01)
    {
        if (!gUnknown_020251F0.field12)
            return 2;
    }

    if (gRomDetection_IsRubySapphire)
    {
        if (!(GetPlayerMapType() & 2))
        {
            REG_JOY_TRANS = -1;
            WarningPrint(5);
            return 2;
        }
    }
    else
    {
        u16 metGame, f;
        u16 flags = Test(gAgbPmRomParams, gSaveBlock2Ptr);
        if (!(flags & 0xFFFE))
        {
            REG_JOY_TRANS = -1;
            ErrorPrint(10);
        }
        if (!(Test2(gAgbPmRomParams, gSaveBlock2Ptr) & 7))
        {
            REG_JOY_TRANS = -1;
            ErrorPrint(10);
        }

        metGame = GetMonData(&gPlayerPartyPtr[gUnknown_02024960.unk84C_1], MON_DATA_MET_GAME, NULL);
        f = 1 << metGame;
        if (!(flags & f))
        {
            REG_JOY_TRANS = -1;
            ErrorPrint(10);
        }
    }

    WarningPrint(3);
    SetSpeciesCaughtFlag(gUnknown_02024960.unk84C_2, &gPlayerPartyPtr[gUnknown_02024960.unk84C_2]);
    if ((gUnknown_02024960.unk84C_3 | (gUnknown_02024960.unk850_1 << 8)) != 0)
        SetSpeciesCaughtFlag((gUnknown_02024960.unk84C_3 | (gUnknown_02024960.unk850_1 << 8)),
                             &gPlayerPartyPtr[(gUnknown_02024960.unk84C_3 | (gUnknown_02024960.unk850_1 << 8))]);

    for (i = 0; i < 11; i++)
    {
        if (gGiftRibbonsPtr[i] == 0 && gUnknown_02024960.field85C[i] != 0)
        {
            gGiftRibbonsPtr[i] = gUnknown_02024960.field85C[i];
            GiveGiftRibbonToParty(i, gUnknown_02024960.field85C[i]);
        }
    }

    var = sub_02005FCC();
    DelayFrames(GetFrameTotal() & 0x3F);
    switch (var)
    {
    case 0:
        WarningPrint(1);
        break;
    case 1:
        WarningPrint(4);
        break;
    case 2:
        WarningPrint(5);
        break;
    }

    gUnknown_02024960.unk84C_00 = 0;
    gUnknown_02024960.unk84C_01 = 0;
    gUnknown_02024960.unk84C_02 = 0;
    return var;
}

s32 sub_02006264(void)
{
    s32 i;
    s32 var;

    WarningPrint(3);
    if (gUnknown_02024960.unk_85B != 0)
    {
        (*gPlayerPartyCountPtr)++;
        if (!GetSetPokedexFlag(gUnknown_02024960.unk_85B, FLAG_GET_CAUGHT))
        {
            GetSetPokedexFlag(gUnknown_02024960.unk_85B, FLAG_SET_SEEN);
            GetSetPokedexFlag(gUnknown_02024960.unk_85B, FLAG_SET_CAUGHT);
        }
        for (i = 0; i < 11; i++)
        {
            if (gGiftRibbonsPtr[i] == 0 && gUnknown_02024960.field85C[i] != 0)
            {
                gGiftRibbonsPtr[i] = gUnknown_02024960.field85C[i];
                GiveGiftRibbonToParty(i, gUnknown_02024960.field85C[i]);
            }
        }
    }

    var = sub_02005FCC();
    switch (var)
    {
    case 0:
        WarningPrint(1);
        break;
    case 1:
        WarningPrint(4);
        break;
    case 2:
        WarningPrint(5);
        break;
    }

    gUnknown_02024960.unk84C_00 = 0;
    gUnknown_02024960.unk84C_01 = 0;
    gUnknown_02024960.unk84C_02 = 0;
    return var;
}

void sub_02006344(void)
{
    u16 species;
    u32 r6 = gUnknown_02024960.unk10;
    if (r6 != 0)
        return;

    gUnknown_02024960.unk_858 = 2;
    gUnknown_02024960.unk8 = GetMonData(&gPlayerPartyPtr[0], MON_DATA_PERSONALITY, NULL);
    gUnknown_02024960.unkC = GetMonData(&gPlayerPartyPtr[0], MON_DATA_OT_ID, NULL);
    species = GetMonData(&gPlayerPartyPtr[0], MON_DATA_SPECIES, NULL);
    gUnknown_02024960.unk10 = species;
    gUnknown_02024960.unk12 = r6;
    gUnknown_02024960.unk14[0] = GetBoxMonMoveBySlot(&gPlayerPartyPtr[0].box, 0);
    gUnknown_02024960.unk14[1] = GetBoxMonMoveBySlot(&gPlayerPartyPtr[0].box, 1);
    gUnknown_02024960.unk14[2] = GetBoxMonMoveBySlot(&gPlayerPartyPtr[0].box, 2);
    gUnknown_02024960.unk14[3] = GetBoxMonMoveBySlot(&gPlayerPartyPtr[0].box, 3);
    gUnknown_02024960.unk1C[0] = GetBoxMonPPByMoveSlot(&gPlayerPartyPtr[0].box, 0);
    gUnknown_02024960.unk1C[1] = GetBoxMonPPByMoveSlot(&gPlayerPartyPtr[0].box, 1);
    gUnknown_02024960.unk1C[2] = GetBoxMonPPByMoveSlot(&gPlayerPartyPtr[0].box, 2);
    gUnknown_02024960.unk1C[3] = GetBoxMonPPByMoveSlot(&gPlayerPartyPtr[0].box, 3);
}

u32 sub_020063FC(void)
{
    return (gUnknown_02024960.unk23_0) | (gUnknown_02024960.unk23_4 << 16);
}

u32 sub_02006414(s32 moveSlot)
{
    return sub_020064BC(gUnknown_02024960.unk20, moveSlot) & 7;
}

u32 sub_02006430(s32 moveSlot)
{
    return (sub_020064BC(gUnknown_02024960.unk20, moveSlot) >> 3) & 1;
}

u32 sub_0200644C(void)
{
    return gUnknown_02024960.unk22_0;
}

u32 sub_0200645C(void)
{
    return gUnknown_02024960.unk22_4 + 1;
}

bool32 IsMonFainted(u32 monId)
{
    bool32 ret;
    if (GetMonStatus(&gPlayerPartyPtr[monId]) == STATUS_PRIMARY_FAINTED)
        ret = TRUE;
    else
        ret = FALSE;
    return ret;
}

u32 sub_02006490(void)
{
    if (gUnknown_02024960.unk_03_0 != 0)
        return gUnknown_02024960.unk_03_0 - 1;
    else
        return 0;
}

u32 sub_020064B0(void)
{
    return gUnknown_02024960.unk_03_7;
}

u32 sub_020064BC(u32 a0, s32 a1)
{
    if (a1 > 0)
    {
        do
        {
            a0 >>= 4;
            a1--;
        } while (a1 != 0);
    }

    return a0 & 0xF;
}

u32 sub_020064D0(s32 a0)
{
    u32 r1 = gUnknown_02024960.unk_00;
    if (a0 > 0)
    {
        s32 r0 = a0;
        do
        {
            r1 >>= 4;
            r0--;
        } while (r0 != 0);
    }

    return r1 & 0xF;
}
