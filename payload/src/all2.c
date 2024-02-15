#include "global.h"
#include "gflib.h"
#include "all.h"
#include "strings.h"
#include "gflib/text.h"
#include "gflib/gfxload.h"
#include "libpmagb/pic_uncomp.h"
#include "libpmagb/agb_rom.h"
#include "libpmagb/berry.h"
#include "pokemon.h"
#include "constants/pokemon.h"
#include "constants/species.h"
#include "constants/moves.h"
#include "constants/items.h"

extern const u32 gSummaryScreen_Pal[];
extern const u32 gSummaryScreen_Gfx[];
extern const u32 gSummaryIcons_Gfx[];
extern const u32 gSummaryScreen_Moves_Tilemap[];
extern const u32 gSummaryScreen_Skills_Tilemap[];
extern const u32 gTypeStatusIcons_Pal[];
extern const u32 gTypeStatusIcons_Gfx[];

struct UnkStruct02021990
{
    struct Sprite *unk0;
    struct Sprite *type1Sprite; // 0x4
    struct Sprite *type2Sprite; // 0x8
    u8 fillC[0x14-0xc];
    u16 species; // 0x14
    u16 speciesPic; // 0x16 - for Unown
    bool8 statsPrinted;
    u8 fill19;
    u8 fill1A;
    u8 fill1B;
    struct Window *unk1C;
    struct Window *unk20;
    struct Window *unk24;
    struct Window *unk28;
    struct Sprite *unk2C;
    u16 unk44;
    u16 unk4C;
};

extern struct UnkStruct02021990 gUnknown_02021990;

extern const struct Window gUnknown_0201FB50;
extern const struct Window gUnknown_0201FB30;
extern const struct Window gUnknown_0201FB70;

extern const struct Subsprites *const gMonFrontPicSubspriteTable[];
extern const struct Subsprites gUnknown_0201FA44[];

void sub_02002FEC(void)
{
    ClearVram();
    REG_DISPCNT = DISPCNT_BG_ALL_ON | DISPCNT_OBJ_ON | DISPCNT_OBJ_1D_MAP;
    REG_BG0CNT = BGCNT_PRIORITY(0) | BGCNT_CHARBASE(0) | BGCNT_SCREENBASE(27);
    REG_BG1CNT = BGCNT_PRIORITY(1) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(28);
    REG_BG2CNT = BGCNT_PRIORITY(2) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(30) | BGCNT_TXT512x256;
    REG_BG3CNT = BGCNT_PRIORITY(3) | BGCNT_CHARBASE(2) | BGCNT_SCREENBASE(29);
    AutoUnCompVram(gSummaryScreen_Pal, (void *) PLTT);
    AutoUnCompVram(gSummaryScreen_Gfx, (void *) VRAM + 0x8000);
    AutoUnCompVram(gSummaryIcons_Gfx, (void *) VRAM);
    AutoUnCompVram(gSummaryScreen_Moves_Tilemap, (void *) IWRAM_START + 0x2000);
    AutoUnCompVram(gSummaryScreen_Skills_Tilemap, (void *) IWRAM_START + 0x3000);

    gBgTilemapBufferTransferScheduled[2] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;

    AutoUnCompVram(gTypeStatusIcons_Pal, (void *) PLTT + 0x200);
    AutoUnCompVram(gTypeStatusIcons_Gfx, (void *) VRAM + 0x10000);

    CpuFill16(0, &gUnknown_02021990, sizeof(gUnknown_02021990));

    gUnknown_02021990.unk24 = AddWindow(0, &gUnknown_0201FB50);
    gUnknown_02021990.unk20 = AddWindow(3, &gUnknown_0201FB30);
}

void CreatePartyMonFrontPic(struct UnkStruct02021990 *a0, u32 monId, s32 x, s32 y)
{
    void *bufferPic, *bufferPal;
    const struct CompressedSpriteSheet *frontPicSheet;
    const struct CompressedSpritePalette *frontPicPal;
    u32 personality;
    bool32 noFlip;
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->baseStats;

    a0->species = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_SPECIES, NULL);
    if (a0->species == SPECIES_NONE)
        return;

    personality = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_PERSONALITY, NULL);
    a0->speciesPic = FixUnownSpecies(a0->species, personality);
    if (a0->unk0 != NULL)
        MoveSpriteToHead(a0->unk0);

    noFlip = speciesInfo[a0->species].noFlip;
    DelayFrames(1);

    frontPicSheet = &gAgbPmRomParams->monFrontPicTable[a0->speciesPic];
    bufferPic = GetPicUncompPtr();
    LZ77UnCompVram(frontPicSheet->data, bufferPic);
    DrawSpindasSpots(a0->species, personality, bufferPic);

    frontPicPal = GetBoxMonPalettePtr(monId);
    bufferPal = bufferPic + 0x2000;
    LZ77UnCompWram(frontPicPal->data, bufferPal);
    a0->unk0 = AddSprite(x, y, gMonFrontPicSubspriteTable[noFlip]);
    SetSpritePaletteNum(a0->unk0, 4);
    if (!noFlip)
        CpuCopy16(bufferPic, (void *)VRAM + 0x16000, 0x800);
    else
        CpuCopy16(bufferPic, (void *)VRAM + 0x12000, 0x800);
    CpuCopy16(bufferPal, (void *)PLTT + 0x280, 0x20);
}

static inline void PrintStat(struct Window *win, s32 x, u32 monId, s32 monData, u8 *statText, s32 toAdd, s32 y)
{
    s32 xStat;

    s32 stat = GetMonData(&gPlayerPartyPtr[monId], monData, NULL);
    NumToPmString3RightAlign(statText, stat);
    if (stat < 10)
        xStat = 1;
    else if (stat < 100)
        xStat = 2;
    else
        xStat = 3;
    x = (x + toAdd) - (xStat * 3);
    TextWindowSetXY(win, x, y);
    RenderText(win, &statText[3 - xStat]);
}

void sub_020031F8(u32 monId)
{
    u8 text[16];
    u8 statText[8];
    s32 hp, var;
    u32 type1, type2;
    u32 ability;

    SetBgPos(2, -160, 0);
    TextWindowSetXY(gUnknown_02021990.unk24, 0, 0);
    SetTextColor(gUnknown_02021990.unk24, 1, 8);
    SetBgTilemapBufferPaletteRect(0, 11, 8, 18, 2, 15);
    SetBgTilemapBufferPaletteRect(0, 16, 11, 6, 2, 15);
    SetBgTilemapBufferPaletteRect(0, 17, 13, 5, 4, 15);
    SetBgTilemapBufferPaletteRect(0, 27, 11, 3, 6, 15);
    SetBgTilemapBufferPaletteRect(0, 11, 18, 18, 2, 15);
    RenderText(gUnknown_02021990.unk24, gText_Type);
    type1 = GetMonType(&gPlayerPartyPtr[monId], 1);
    type2 = GetMonType(&gPlayerPartyPtr[monId], 2);
    if (gUnknown_02021990.type1Sprite == NULL)
    {
        gUnknown_02021990.type1Sprite = AddSprite(122, 24, gUnknown_0201FA44);
        gUnknown_02021990.type2Sprite = AddSprite(162, 24, gUnknown_0201FA44);
    }
    SetSpriteTileOffset(gUnknown_02021990.type1Sprite, type1 * 8);
    SetSpritePaletteNum(gUnknown_02021990.type1Sprite, GetMonSpritePaletteNumByBaseBlock(type1));
    if (type2 != 0 && type1 != type2)
    {
        SetSpriteTileOffset(gUnknown_02021990.type2Sprite, type2 * 8);
        SetSpritePaletteNum(gUnknown_02021990.type2Sprite, GetMonSpritePaletteNumByBaseBlock(type2));
        SetSpriteInvisible(gUnknown_02021990.type2Sprite, FALSE);
    }
    else
    {
        SetSpriteInvisible(gUnknown_02021990.type2Sprite, TRUE);
    }

    // Ability
    ability = GetBoxMonAbility(&gPlayerPartyPtr[monId].box);
    FillWindowCharBufferRect(gUnknown_02021990.unk24, 0, 3, 18, 4, 0);
    TextWindowSetXY(gUnknown_02021990.unk24, 0, 24);
    RenderText(gUnknown_02021990.unk24, GetAbilityName(ability));
    TextWindowSetXY(gUnknown_02021990.unk24, 0, 40);
    RenderText(gUnknown_02021990.unk24, GetAbilityDescription(ability));

    // hp/max hp
    if (!gUnknown_02021990.statsPrinted)
    {
        TextWindowSetXY(gUnknown_02021990.unk24, 15, 64);
        RenderText(gUnknown_02021990.unk24, gText_HP);
    }
    hp = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HP, NULL);
    NumToPmString3RightAlign(text, hp);
    text[3] = CHAR_SLASH;
    var = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_MAX_HP, NULL);
    NumToPmString3RightAlign(text + 4, var);
    TextWindowSetXY(gUnknown_02021990.unk24, 45, 64);
    gUnknown_02021990.unk24->glyphWidth = 6;
    FillWindowCharBufferRect(gUnknown_02021990.unk24, 5, 8, 6, 2, 0);
    RenderText(gUnknown_02021990.unk24, text);

    // Atk
    if (!gUnknown_02021990.statsPrinted)
    {
        TextWindowSetXY(gUnknown_02021990.unk24, 2, 80);
        RenderText(gUnknown_02021990.unk24, gText_Attack);
    }
    gUnknown_02021990.unk24->glyphWidth = 6;
    FillWindowCharBufferRect(gUnknown_02021990.unk24, 5, 10, 6, 2, 0);
    PrintStat(gUnknown_02021990.unk24, 45, monId, MON_DATA_ATK, statText, 21, 80);

    //Def
    if (!gUnknown_02021990.statsPrinted)
    {
        TextWindowSetXY(gUnknown_02021990.unk24, 0, 96);
        RenderText(gUnknown_02021990.unk24, gText_Defense);
    }
    gUnknown_02021990.unk24->glyphWidth = 6;
    FillWindowCharBufferRect(gUnknown_02021990.unk24, 6, 12, 5, 2, 0);
    PrintStat(gUnknown_02021990.unk24, 45, monId, MON_DATA_DEF, statText, 21, 96);

    // Sp Atk
    FillWindowCharBufferRect(gUnknown_02021990.unk24, 16, 8, 3, 6, 0);
    if (!gUnknown_02021990.statsPrinted)
    {
        TextWindowSetXY(gUnknown_02021990.unk24, 88, 64);
        RenderText(gUnknown_02021990.unk24, gText_SpAtk);
    }
    PrintStat(gUnknown_02021990.unk24, 128, monId, MON_DATA_SPATK, statText, 9, 64);

    // Sp Def
    if (!gUnknown_02021990.statsPrinted)
    {
        TextWindowSetXY(gUnknown_02021990.unk24, 88, 80);
        RenderText(gUnknown_02021990.unk24, gText_SpDef);
    }
    PrintStat(gUnknown_02021990.unk24, 128, monId, MON_DATA_SPDEF, statText, 9, 80);

    // Speed
    if (!gUnknown_02021990.statsPrinted)
    {
        TextWindowSetXY(gUnknown_02021990.unk24, 88, 96);
        RenderText(gUnknown_02021990.unk24, gText_Speed);
    }
    PrintStat(gUnknown_02021990.unk24, 128, monId, MON_DATA_SPEED, statText, 9, 96);

    // Item
    FillWindowCharBufferRect(gUnknown_02021990.unk24, 0, 15, 18, 2, 0);
    TextWindowSetXY(gUnknown_02021990.unk24, 0, 120);
    var = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HELD_ITEM, NULL);
    if (var == ITEM_NONE)
    {
        RenderText(gUnknown_02021990.unk24, gText_None);
    }
    else
    {
        CopyItemName(var, text, gText_Berry);
        RenderText(gUnknown_02021990.unk24, text);
    }

    if (gUnknown_02021990.unk28 == NULL)
        gUnknown_02021990.unk28 = AddWindow(1, &gUnknown_0201FB70);
    ClearWindowCharBuffer(gUnknown_02021990.unk28, 0);
    SetBgTilemapBufferTileAt(0, 23, 0, 0xF00B);
    SetBgTilemapBufferTileAt(0, 24, 0, 0xF00D);
    SetBgTilemapBufferTileAt(0, 23, 1, 0xF00C);
    SetBgTilemapBufferTileAt(0, 24, 1, 0xF00E);
    SetTextColor(gUnknown_02021990.unk28, 1, 8);
    TextWindowSetXY(gUnknown_02021990.unk24, 0, 0);
    RenderText(gUnknown_02021990.unk28, gText_Cancel2);
    CopyRectWithinBgTilemapBuffer(3, 0, 20, 4, 2, 11, 0);
    ClearWindowCharBuffer(gUnknown_02021990.unk1C, 0);
    RenderText(gUnknown_02021990.unk1C, gText_PokemonSkills);
    gBgTilemapBufferTransferScheduled[0] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;
    gUnknown_02021990.statsPrinted = TRUE;
}

void sub_0200378C(u32 monId)
{
    u8 text[16];
    s32 i;
    struct Pokemon *mon = &gPlayerPartyPtr[monId];
    const struct BattleMove *battleMoves = gAgbPmRomParams->battleMoves;

    SetTextColor(gUnknown_02021990.unk24, 1, 8);
    SetBgTilemapBufferPaletteRect(0, 24, 4, 5, 8, 15);
    gUnknown_02021990.unk4C = 0xFFFF;

    for (i = 0; i < 4; i++)
    {
        u32 move = GetBoxMonMoveBySlot(&mon->box, i);
        s32 pp = GetBoxMonPPByMoveSlot(&mon->box, i);
        s32 ppBonuses = GetMonData(&mon->box, MON_DATA_PP_BONUSES, NULL);
        s32 ppWithBonus = CalculatePPWithBonus(move, ppBonuses, i);
        u32 moveType = battleMoves[move].type;

        gUnknown_02021990.unk44[i] = move;
        if (gUnknown_02021990.unk2C == NULL)
            gUnknown_02021990.unk2C = AddSprite(87, (i * 16) + 32, gUnknown_0201FA44);
        if (move != MOVE_NONE)
        {
            SetSpriteTileOffset(gUnknown_02021990.unk2C, moveType * 8);
            SetSpritePaletteNum(gUnknown_02021990.unk2C, GetMonSpritePaletteNumByBaseBlock(moveType));
            SetSpriteInvisible(gUnknown_02021990.unk2C, FALSE);
        }
        else
        {
            SetSpriteInvisible(gUnknown_02021990.unk2C, TRUE);
        }
        FillWindowCharBufferRect(gUnknown_02021990.unk2C, 4, 1 + (i * 2), 9, 2, 0);
        CopyMoveName(text, move);
        TextWindowSetXY(gUnknown_02021990.unk2C, 0x20, 8 + (i * 16));
        Renjd
    }
}
