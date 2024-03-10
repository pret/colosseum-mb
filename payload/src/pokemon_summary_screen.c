#include "global.h"
#include "gflib.h"
#include "all.h"
#include "strings.h"
#include "unk_200C5DC.h"
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
#include "constants/songs.h"

extern u8 gIsNotShowingMoveDetails; // Occupies the same memory as gMonSummaryScreen.isNotShowingMoveDetails
extern u8 gCurrentMoveSlot; // Occupies the same memory as gMonSummaryScreen.currentMoveSlot
extern u16 gSummaryCurrentMonMoves[]; // Occupies the same memory as gMonSummaryScreen.moves

extern const u32 gSummaryScreen_Pal[];
extern const u32 gSummaryScreen_Gfx[];
extern const u32 gSummaryIcons_Gfx[];
extern const u32 gSummaryScreen_Moves_Tilemap[];
extern const u32 gSummaryScreen_Skills_Tilemap[];
extern const u32 gTypeStatusIcons_Pal[];
extern const u32 gTypeStatusIcons_Gfx[];

struct PokemonSummaryScreenData
{
    /*0x00*/ struct Sprite *monSprite;
    /*0x04*/ struct Sprite *type1Sprite;
    /*0x08*/ struct Sprite *type2Sprite;
    /*0x0C*/ struct Sprite *ballSprite;
    /*0x10*/ struct Sprite *statusSprite;
    /*0x14*/ u16 species;
    /*0x16*/ u16 speciesPic;
    /*0x18*/ bool8 statsPrinted;
    /*0x19*/ u8 unused1[3];
    /*0x1C*/ struct Window *titleWindow;
    /*0x20*/ struct Window *leftWindow;
    /*0x24*/ struct Window *mainWindow;
    /*0x28*/ struct Window *inputWindow;
    /*0x2C*/ struct Sprite *moveTypeSprites[MAX_MON_MOVES];
    /*0x3C*/ u32 unused2;
    /*0x40*/ struct Sprite *moveSelectorSprite;
    /*0x44*/ u16 moves[MAX_MON_MOVES + 1]; // gSummaryCurrentMonMoves
    /*0x4E*/ u8 currentMoveSlot; // gCurrentMoveSlot
    /*0x4F*/ u8 isNotShowingMoveDetails; // gIsNotShowingMoveDetails
    /*0x50*/ u8 currentMonId;
    /*0x51*/ u8 unused4;
};

extern struct PokemonSummaryScreenData gMonSummaryScreen;

extern const struct Window gWindowTemplateSummaryMainPane;
extern const struct Window gWindowTemplateSummaryLeftPane;
extern const struct Window gWindowTemplateSummaryInputPane;
extern const struct Window gWindowTemplateSummaryTitlePane;

extern const struct Subsprites *const gMonFrontPicSubspriteTable[];
extern const struct Subsprites gSubspriteType[];
extern const struct Subsprites gSubspriteStatus[];
extern const struct Subsprites gSubspritePokeBall[];
extern const struct Subsprites gSubspriteMoveSelector[];

static void PrintMainInfo(u32 monId, bool32 skipInitialDraws);
static void sub_0200461C(struct Sprite *sprite);

// This file's functions
static void InitGraphics(void)
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

    CpuFill16(0, &gMonSummaryScreen, sizeof(gMonSummaryScreen));

    gMonSummaryScreen.mainWindow = AddWindow(0, &gWindowTemplateSummaryMainPane);
    gMonSummaryScreen.leftWindow = AddWindow(3, &gWindowTemplateSummaryLeftPane);
}

static void CreatePartyMonFrontPic(struct PokemonSummaryScreenData *sum, u32 monId, s32 x, s32 y)
{
    void *bufferPic, *bufferPal;
    const struct CompressedSpriteSheet *frontPicSheet;
    const struct CompressedSpritePalette *frontPicPal;
    u32 personality;
    bool32 noFlip;
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->baseStats;

    sum->species = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_SPECIES, NULL);

    if (sum->species == SPECIES_NONE)
        return;

    personality = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_PERSONALITY, NULL);
    sum->speciesPic = FixUnownSpecies(sum->species, personality);

    if (sum->monSprite != NULL)
        MoveSpriteToHead(sum->monSprite);

    noFlip = speciesInfo[sum->species].noFlip;
    DelayFrames(1);

    frontPicSheet = &gAgbPmRomParams->monFrontPicTable[sum->speciesPic];
    bufferPic = GetPicUncompPtr();
    LZ77UnCompVram(frontPicSheet->data, bufferPic);
    DrawSpindasSpots(sum->species, personality, bufferPic);

    frontPicPal = GetBoxMonPalettePtr(monId);
    bufferPal = bufferPic + 0x2000;
    LZ77UnCompWram(frontPicPal->data, bufferPal);
    sum->monSprite = AddSprite(x, y, gMonFrontPicSubspriteTable[noFlip]);
    SetSpritePaletteNum(sum->monSprite, 4);

    if (!noFlip)
        CpuCopy16(bufferPic, (void *)VRAM + 0x16000, 0x800);
    else
        CpuCopy16(bufferPic, (void *)VRAM + 0x12000, 0x800);

    CpuCopy16(bufferPal, (void *)PLTT + 0x280, 0x20);
}

static inline void PrintStat(struct Window *win, s32 x, u32 monId, s32 monData, u8 *statText, s32 toAdd, s32 y)
{
    s32 digits;
    s32 stat = GetMonData(&gPlayerPartyPtr[monId], monData, NULL);

    NumToPmString3RightAlign(statText, stat);

    if (stat < 10)
        digits = 1;
    else if (stat < 100)
        digits = 2;
    else
        digits = 3;

    x = (x + toAdd) - (digits * 3);
    TextWindowSetXY(win, x, y);
    RenderText(win, &statText[3 - digits]);
}

static void PrintTrainerMemoPage(u32 monId)
{
    u8 text[16];
    u8 statText[8];
    s32 hp, var;
    u32 type1, type2;
    u32 ability;

    SetBgPos(2, -160, 0);
    TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 0);
    SetTextColor(gMonSummaryScreen.mainWindow, 1, 8);
    SetBgTilemapBufferPaletteRect(0, 11, 8, 18, 2, 15);
    SetBgTilemapBufferPaletteRect(0, 16, 11, 6, 2, 15);
    SetBgTilemapBufferPaletteRect(0, 17, 13, 5, 4, 15);
    SetBgTilemapBufferPaletteRect(0, 27, 11, 3, 6, 15);
    SetBgTilemapBufferPaletteRect(0, 11, 18, 18, 2, 15);
    RenderText(gMonSummaryScreen.mainWindow, gText_Type);
    type1 = GetMonType(&gPlayerPartyPtr[monId], 1);
    type2 = GetMonType(&gPlayerPartyPtr[monId], 2);

    if (gMonSummaryScreen.type1Sprite == NULL)
    {
        gMonSummaryScreen.type1Sprite = AddSprite(122, 24, gSubspriteType);
        gMonSummaryScreen.type2Sprite = AddSprite(162, 24, gSubspriteType);
    }

    SetSpriteTileOffset(gMonSummaryScreen.type1Sprite, type1 * 8);
    SetSpritePaletteNum(gMonSummaryScreen.type1Sprite, GetMonSpritePaletteNumByBaseBlock(type1));

    if (type2 != 0 && type1 != type2)
    {
        SetSpriteTileOffset(gMonSummaryScreen.type2Sprite, type2 * 8);
        SetSpritePaletteNum(gMonSummaryScreen.type2Sprite, GetMonSpritePaletteNumByBaseBlock(type2));
        SetSpriteInvisible(gMonSummaryScreen.type2Sprite, FALSE);
    }
    else
    {
        SetSpriteInvisible(gMonSummaryScreen.type2Sprite, TRUE);
    }

    // Ability
    ability = GetBoxMonAbility(&gPlayerPartyPtr[monId].box);
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 0, 3, 18, 4, 0);
    TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 24);
    RenderText(gMonSummaryScreen.mainWindow, GetAbilityName(ability));
    TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 40);
    RenderText(gMonSummaryScreen.mainWindow, GetAbilityDescription(ability));

    // hp/max hp
    if (!gMonSummaryScreen.statsPrinted)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 15, 64);
        RenderText(gMonSummaryScreen.mainWindow, gText_HP);
    }

    hp = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HP, NULL);
    NumToPmString3RightAlign(text, hp);
    text[3] = CHAR_SLASH;
    var = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_MAX_HP, NULL);
    NumToPmString3RightAlign(text + 4, var);
    TextWindowSetXY(gMonSummaryScreen.mainWindow, 45, 64);
    gMonSummaryScreen.mainWindow->glyphWidth = 6;
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 5, 8, 6, 2, 0);
    RenderText(gMonSummaryScreen.mainWindow, text);

    // Atk
    if (!gMonSummaryScreen.statsPrinted)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 2, 80);
        RenderText(gMonSummaryScreen.mainWindow, gText_Attack);
    }

    gMonSummaryScreen.mainWindow->glyphWidth = 6;
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 5, 10, 6, 2, 0);
    PrintStat(gMonSummaryScreen.mainWindow, 45, monId, MON_DATA_ATK, statText, 21, 80);

    //Def
    if (!gMonSummaryScreen.statsPrinted)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 96);
        RenderText(gMonSummaryScreen.mainWindow, gText_Defense);
    }

    gMonSummaryScreen.mainWindow->glyphWidth = 6;
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 6, 12, 5, 2, 0);
    PrintStat(gMonSummaryScreen.mainWindow, 45, monId, MON_DATA_DEF, statText, 21, 96);

    // Sp Atk
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 16, 8, 3, 6, 0);

    if (!gMonSummaryScreen.statsPrinted)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 88, 64);
        RenderText(gMonSummaryScreen.mainWindow, gText_SpAtk);
    }

    PrintStat(gMonSummaryScreen.mainWindow, 128, monId, MON_DATA_SPATK, statText, 9, 64);

    // Sp Def
    if (!gMonSummaryScreen.statsPrinted)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 88, 80);
        RenderText(gMonSummaryScreen.mainWindow, gText_SpDef);
    }

    PrintStat(gMonSummaryScreen.mainWindow, 128, monId, MON_DATA_SPDEF, statText, 9, 80);

    // Speed
    if (!gMonSummaryScreen.statsPrinted)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 88, 96);
        RenderText(gMonSummaryScreen.mainWindow, gText_Speed);
    }

    PrintStat(gMonSummaryScreen.mainWindow, 128, monId, MON_DATA_SPEED, statText, 9, 96);

    // Item
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 0, 15, 18, 2, 0);
    TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 120);
    var = GetMonData(&gPlayerPartyPtr[monId], MON_DATA_HELD_ITEM, NULL);

    if (var == ITEM_NONE)
    {
        RenderText(gMonSummaryScreen.mainWindow, gText_None);
    }
    else
    {
        CopyItemName(var, text, gText_Berry);
        RenderText(gMonSummaryScreen.mainWindow, text);
    }

    if (gMonSummaryScreen.inputWindow == NULL)
        gMonSummaryScreen.inputWindow = AddWindow(1, &gWindowTemplateSummaryInputPane);

    ClearWindowCharBuffer(gMonSummaryScreen.inputWindow, 0);
    SetBgTilemapBufferTileAt(0, 23, 0, 0xF00B);
    SetBgTilemapBufferTileAt(0, 24, 0, 0xF00D);
    SetBgTilemapBufferTileAt(0, 23, 1, 0xF00C);
    SetBgTilemapBufferTileAt(0, 24, 1, 0xF00E);
    SetTextColor(gMonSummaryScreen.inputWindow, 1, 8);
    TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 0);
    RenderText(gMonSummaryScreen.inputWindow, gText_Cancel2);
    CopyRectWithinBgTilemapBuffer(3, 0, 20, 4, 2, 11, 0);
    ClearWindowCharBuffer(gMonSummaryScreen.titleWindow, 0);
    RenderText(gMonSummaryScreen.titleWindow, gText_PokemonSkills);
    gBgTilemapBufferTransferScheduled[0] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;
    gMonSummaryScreen.statsPrinted = TRUE;
}

static void PrintMovesPage(u32 monId)
{
    u8 text[16];
    s32 i;
    u32 move, moveType;
    s32 ppCurr, ppBonuses, ppMax;
    struct Pokemon *mon = &gPlayerPartyPtr[monId];
    const struct BattleMove *battleMoves = gAgbPmRomParams->battleMoves;

    SetTextColor(gMonSummaryScreen.mainWindow, 1, 8);
    SetBgTilemapBufferPaletteRect(0, 24, 4, 5, 8, 15);
    gMonSummaryScreen.moves[MAX_MON_MOVES] = 0xFFFF;

    for (i = 0; i < MAX_MON_MOVES; i++)
    {
        move = GetBoxMonMoveBySlot(&mon->box, i);
        ppCurr = GetBoxMonPPByMoveSlot(&mon->box, i);
        ppBonuses = GetMonData(mon, MON_DATA_PP_BONUSES, NULL);
        ppMax = CalculatePPWithBonus(move, ppBonuses, i);
        moveType = battleMoves[move].type;

        gMonSummaryScreen.moves[i] = move;

        if (gMonSummaryScreen.moveTypeSprites[i] == NULL)
            gMonSummaryScreen.moveTypeSprites[i] = AddSprite(87, (i * 16) + 32, gSubspriteType);

        if (move != MOVE_NONE)
        {
            SetSpriteTileOffset(gMonSummaryScreen.moveTypeSprites[i], moveType * 8);
            SetSpritePaletteNum(gMonSummaryScreen.moveTypeSprites[i], GetMonSpritePaletteNumByBaseBlock(moveType));
            SetSpriteInvisible(gMonSummaryScreen.moveTypeSprites[i], FALSE);
        }
        else
        {
            SetSpriteInvisible(gMonSummaryScreen.moveTypeSprites[i], TRUE);
        }

        FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 4, 1 + (i * 2), 9, 2, 0);
        CopyMoveName(text, move);
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 0x20, 8 + (i * 16));
        RenderText(gMonSummaryScreen.mainWindow, text);
        FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 13, 1 + (i * 2), 5, 2, 0);

        if (move != MOVE_NONE)
        {
            NumToPmString3RightAlign(text, ppCurr);
            text[3] = CHAR_SLASH;
            NumToPmString3RightAlign(text + 4, ppMax);
            text[4] = text[5];
            text[5] = text[6];
            text[6] = text[7];
            gMonSummaryScreen.mainWindow->glyphWidth = 6;
            TextWindowSetXY(gMonSummaryScreen.mainWindow, 108, 8 + (i * 16));
            RenderText(gMonSummaryScreen.mainWindow, text);
            SetBgTilemapBufferTileAt(0, 24, 4 + (i * 2), 0xF003);
            SetBgTilemapBufferTileAt(0, 24, 5 + (i * 2), 0xF004);
        }
        else
        {
            TextWindowSetXY(gMonSummaryScreen.mainWindow, 120, 8 + (i * 16));
            RenderText(gMonSummaryScreen.mainWindow, gText_2Dashes);
            SetBgTilemapBufferTileAt(0, 24, 4 + (i * 2), 0xF000);
            SetBgTilemapBufferTileAt(0, 24, 5 + (i * 2), 0xF000);
        }
    }

    if (gMonSummaryScreen.inputWindow == NULL)
        gMonSummaryScreen.inputWindow = AddWindow(1, &gWindowTemplateSummaryInputPane);

    ClearWindowCharBuffer(gMonSummaryScreen.inputWindow, 0);
    SetBgTilemapBufferTileAt(0, 23, 0, 0xF00B);
    SetBgTilemapBufferTileAt(0, 24, 0, 0xF00D);
    SetBgTilemapBufferTileAt(0, 23, 1, 0xF00C);
    SetBgTilemapBufferTileAt(0, 24, 1, 0xF00E);
    SetTextColor(gMonSummaryScreen.inputWindow, 1, 8);
    TextWindowSetXY(gMonSummaryScreen.inputWindow, 0, 0);
    RenderText(gMonSummaryScreen.inputWindow, gText_Info);
    CopyRectWithinBgTilemapBuffer(3, 4, 20, 4, 2, 11, 0);
    ClearWindowCharBuffer(gMonSummaryScreen.titleWindow, 0);
    RenderText(gMonSummaryScreen.titleWindow, gText_BattleMoves);
    gBgTilemapBufferTransferScheduled[0] = TRUE;
    gBgTilemapBufferTransferScheduled[2] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;
}

static void PrintPowerAndAccuracy(u32 monId, u32 moveSlot)
{
    u8 text[8];
    struct Pokemon *mon = &gPlayerPartyPtr[monId];
    const struct BattleMove *battleMoves = gAgbPmRomParams->battleMoves;

    FillWindowCharBufferRect(gMonSummaryScreen.leftWindow, 6, 3, 3, 4, 0);
    SetBgTilemapBufferPaletteRect(0, 7, 15, 3, 4, 15);

    if (moveSlot == MAX_MON_MOVES)
    {
        TextWindowSetXY(gMonSummaryScreen.leftWindow, 48, 24);
        RenderText(gMonSummaryScreen.leftWindow, gText_3Dashes);
        TextWindowSetXY(gMonSummaryScreen.leftWindow, 48, 40);
        RenderText(gMonSummaryScreen.leftWindow, gText_3Dashes);
    }
    else
    {
        u32 move = GetBoxMonMoveBySlot(&mon->box, moveSlot);
        if (move != MOVE_UNAVAILABLE)
        {
            TextWindowSetXY(gMonSummaryScreen.leftWindow, 52, 24);
            gMonSummaryScreen.leftWindow->glyphWidth = 6;

            if (battleMoves[move].power <= 1)
            {
                RenderText(gMonSummaryScreen.leftWindow, gText_3Dashes);
            }
            else
            {
                NumToPmString3RightAlign(text, battleMoves[move].power);
                RenderText(gMonSummaryScreen.leftWindow, text);
            }

            TextWindowSetXY(gMonSummaryScreen.leftWindow, 52, 40);
            gMonSummaryScreen.leftWindow->glyphWidth = 6;

            if (battleMoves[move].accuracy == 0)
            {
                RenderText(gMonSummaryScreen.leftWindow, gText_3Dashes);
            }
            else
            {
                NumToPmString3RightAlign(text, battleMoves[move].accuracy);
                RenderText(gMonSummaryScreen.leftWindow, text);
            }
        }

        gBgTilemapBufferTransferScheduled[0] = TRUE;
    }
}

static void ToggleMoveDetails(u32 monId, u32 moveSlot)
{
    struct PokemonSummaryScreenData *strPtr = &gMonSummaryScreen;

    if (gIsNotShowingMoveDetails == FALSE)
    {
        FillWindowCharBufferRect(strPtr->leftWindow, 0, 2, 9, 6, 0);

        if (strPtr->statusSprite != NULL)
            SetSpriteInvisible(strPtr->statusSprite, TRUE);

        TextWindowFillTileBufferForText(strPtr->leftWindow);
        FillBgTilemapBufferRect(3, 0, 18, 10, 2, 0xF000);
        gBgTilemapBufferTransferScheduled[3] = TRUE;
        CopyRectWithinBgTilemapBuffer(2, 20, 20, 3, 7, 7, 13);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        DelayFrames(1);
        CopyRectWithinBgTilemapBuffer(2, 20, 20, 6, 7, 4, 13);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        DelayFrames(1);
        CopyRectWithinBgTilemapBuffer(2, 20, 20, 10, 7, 0, 13);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        SetSpriteInvisible(strPtr->ballSprite, TRUE);
        TextWindowSetXY(strPtr->leftWindow, 0, 24);
        RenderText(strPtr->leftWindow, gText_Power);
        TextWindowSetXY(strPtr->leftWindow, 0, 40);
        RenderText(strPtr->leftWindow, gText_Accuracy);
        PrintPowerAndAccuracy(monId, moveSlot);
        DelayFrames(1);
        gIsNotShowingMoveDetails = TRUE;
    }
    else
    {
        FillWindowCharBufferRect(strPtr->leftWindow, 0, 2, 9, 5, 0);
        CopyRectWithinBgTilemapBuffer(2, 0, 0, 10, 7, 0, 13);
        CopyRectWithinBgTilemapBuffer(2, 20, 20, 6, 7, 4, 13);
        SetSpriteInvisible(strPtr->ballSprite, FALSE);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        DelayFrames(1);
        CopyRectWithinBgTilemapBuffer(2, 0, 0, 9, 7, 1, 13);
        CopyRectWithinBgTilemapBuffer(2, 20, 20, 3, 7, 7, 13);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        DelayFrames(1);
        CopyRectWithinBgTilemapBuffer(2, 0, 0, 9, 7, 1, 13);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        PrintMainInfo(monId, TRUE);
        gIsNotShowingMoveDetails = FALSE;
    }
}

static void PrintMainInfo(u32 monId, bool32 skipInitialDraws)
{
    bool32 partyHasHadPokerus;
    s32 i;
    u32 lvl, species, primaryStatus;
    u8 text[16];
    u8 speciesText[16];
    struct Pokemon *mon = &gPlayerPartyPtr[monId];

    if (!skipInitialDraws)
    {
        CreatePartyMonFrontPic(&gMonSummaryScreen, monId, 8, 0x20);

        if (gMonSummaryScreen.titleWindow == NULL)
        {
            gMonSummaryScreen.titleWindow = AddWindow(2, &gWindowTemplateSummaryTitlePane);
            SetTextColor(gMonSummaryScreen.titleWindow, 1, 8);
        }

        ClearWindowCharBuffer(gMonSummaryScreen.leftWindow, 0);
        SetTextColor(gMonSummaryScreen.leftWindow, 1, 8);
        GetMonData(mon, MON_DATA_NICKNAME, text);
        TextWindowSetXY(gMonSummaryScreen.leftWindow, 0, 0);
        RenderText(gMonSummaryScreen.leftWindow, text);
    }

    text[0] = CHAR_LV;
    text[1] = EOS;
    TextWindowSetXY(gMonSummaryScreen.leftWindow, 16, 32);
    RenderText(gMonSummaryScreen.leftWindow, text);
    lvl = GetMonData(mon, MON_DATA_LEVEL, NULL);
    NumToPmString3CustomZeroChar(lvl, text, CHAR_0);

    for (i = 0; text[i] == CHAR_0; i++)
        ;

    if (text[i] == EOS)
        i--;

    TextWindowSetXY(gMonSummaryScreen.leftWindow, 25, 32);
    gMonSummaryScreen.leftWindow->glyphWidth = 6;
    RenderText(gMonSummaryScreen.leftWindow, &text[i]);
    SetBgTilemapBufferPaletteRect(0, 1, 14, 9, 2, 13);
    species = GetMonData(mon, MON_DATA_SPECIES, NULL);
    GetSpeciesName(speciesText + 1, species);
    speciesText[0] = CHAR_SLASH;
    TextWindowSetXY(gMonSummaryScreen.leftWindow, 0, 16);
    RenderText(gMonSummaryScreen.leftWindow, speciesText);

    if (species != SPECIES_NIDORAN_M && species != SPECIES_NIDORAN_F)
    {
        u32 palNum = 0;
        u8 gender = GetMonGender(mon);

        if (gender == MON_MALE || gender == MON_FEMALE)
        {
            switch (gender)
            {
            case MON_FEMALE:
                text[0] = CHAR_FEMALE;
                palNum = 12;
                break;
            case MON_MALE:
                text[0] = CHAR_MALE;
                palNum = 11;
                break;
            default:
                break;
            }

            text[1] = EOS;
            TextWindowSetXY(gMonSummaryScreen.leftWindow, 48, 32);
            SetBgTilemapBufferPaletteRect(0, 7, 16, 1, 2, palNum);
            RenderText(gMonSummaryScreen.leftWindow, text);
        }

    }

    if (gMonSummaryScreen.ballSprite == NULL)
        gMonSummaryScreen.ballSprite = AddSprite(0, 128, gSubspritePokeBall);

    SetSpritePaletteNum(gMonSummaryScreen.ballSprite, 3);
    LZ77UnCompVram(BoxMonCaughtBallToItemId(&mon->box), (void *)VRAM + 0x12800);
    LZ77UnCompVram(BoxMonGetCaughtBallItemPalette(&mon->box), (void *)PLTT + 0x260);
    primaryStatus = GetMonStatus(mon);

    if (primaryStatus != STATUS_PRIMARY_NONE)
    {
        CopyRectWithinBgTilemapBuffer(3, 8, 20, 10, 2, 0, 18);
        RenderTextAt(gMonSummaryScreen.leftWindow, 0, 48, gText_Status);

        if (gMonSummaryScreen.statusSprite == NULL)
            gMonSummaryScreen.statusSprite = AddSprite(47, 148, gSubspriteStatus);

        SetSpriteInvisible(gMonSummaryScreen.statusSprite, FALSE);
        SetSpriteTileOffset(gMonSummaryScreen.statusSprite, (primaryStatus - 1) * 4);
    }
    else
    {
        FillBgTilemapBufferRect(3, 0, 18, 10, 2, 0);

        if (gMonSummaryScreen.statusSprite != NULL)
            SetSpriteInvisible(gMonSummaryScreen.statusSprite, TRUE);
    }

    partyHasHadPokerus = CheckPartyHasHadPokerus(mon, 0);

    if (!CheckPartyPokerus(mon, 0) && partyHasHadPokerus)
        SetBgTilemapBufferTileAt(0, 2, 0x11, 0xF013);
    else
        SetBgTilemapBufferTileAt(0, 2, 0x11, 0xF000);

    gBgTilemapBufferTransferScheduled[0] = TRUE;
    gBgTilemapBufferTransferScheduled[3] = TRUE;
}

static s32 TrainerMemoHandleInput(s32 monId)
{
    u32 keys;
    gMonSummaryScreen.statsPrinted = FALSE;

    PrintTrainerMemoPage(monId);

    while (1)
    {
        DelayFrames(1);
        keys = gNewKeys;

        if (keys & DPAD_UP && monId != 0)
        {
            PlaySE(SONG_SE_SELECT);
            monId--;
            PrintMainInfo(monId, FALSE);
            PrintTrainerMemoPage(monId);
        }

        if (keys & DPAD_DOWN && monId != PARTY_SIZE - 1 && GetMonData(&gPlayerPartyPtr[monId + 1], MON_DATA_SPECIES, NULL) != SPECIES_NONE)
        {
            PlaySE(SONG_SE_SELECT);
            monId++;
            PrintMainInfo(monId, FALSE);
            PrintTrainerMemoPage(monId);
        }

        if (keys & DPAD_RIGHT)
        {
            PlaySE(SONG_SE_SELECT);
            break;
        }

        if (keys & (A_BUTTON | B_BUTTON))
        {
            PlaySE(SONG_SE_SELECT);
            gMonSummaryScreen.currentMonId = monId;
            monId = -1;
            break;
        }
    }

    if (monId != -1)
    {
        MoveSpriteToHead(gMonSummaryScreen.type1Sprite);
        MoveSpriteToHead(gMonSummaryScreen.type2Sprite);
    }

    gMonSummaryScreen.type1Sprite = NULL;
    gMonSummaryScreen.type2Sprite = NULL;

    return monId;
}

static inline void PrintMoveDescription(s32 monId, u32 moveSlot)
{
    u8 *txt = GetTextBufferPointer(monId);

    SetBgTilemapBufferPaletteRect(0, 11, 15, 18, 4, 15);
    FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 0, 12, 18, 4, 0);

    if (moveSlot != MAX_MON_MOVES)
    {
        TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 0x60);
        RenderText(gMonSummaryScreen.mainWindow, &txt[moveSlot * 80]);
        gBgTilemapBufferTransferScheduled[0] = TRUE;
    }
}

static s32 MovesPageHandleInput(s32 monId)
{
    s32 i, newMoveSlot;
    u8 *txtPtr;
    u16 moveDetailsState;
    u32 previousMoveSlot;
    u16 keys;

    gMonSummaryScreen.statsPrinted = FALSE;
    SetBgPos(2, 0, 0);
    PrintMovesPage(monId);
    moveDetailsState = 0;

    while (1)
    {
        DelayFrames(1);
        keys = gNewKeys;
        if (keys & DPAD_UP && monId != 0)

        {
            PlaySE(SONG_SE_SELECT);
            monId--;
            PrintMainInfo(monId, FALSE);
            PrintMovesPage(monId);
        }

        if (keys & DPAD_DOWN && monId != PARTY_SIZE - 1 && GetMonData(&gPlayerPartyPtr[monId + 1], MON_DATA_SPECIES, NULL) != SPECIES_NONE)
        {
            PlaySE(SONG_SE_SELECT);
            monId++;
            PrintMainInfo(monId, FALSE);
            PrintMovesPage(monId);
        }

        if (keys & DPAD_LEFT)
        {
            PlaySE(SONG_SE_SELECT);
            break;
        }

        if (keys & B_BUTTON)
        {
            PlaySE(SONG_SE_SELECT);
            gMonSummaryScreen.currentMonId = monId;
            monId = -1;
            break;
        }

        switch (moveDetailsState)
        {
        case 0:
            if (keys & A_BUTTON)
            {
                PlaySE(SONG_SE_SELECT);
                moveDetailsState = 1;
            }
            break;
        case 1:
            gMonSummaryScreen.currentMoveSlot = 0;
            gMonSummaryScreen.moveSelectorSprite = AddSprite(80, 32, gSubspriteMoveSelector);
            SetSpritePaletteNum(gMonSummaryScreen.moveSelectorSprite, 5);
            gMonSummaryScreen.moveSelectorSprite->callback = sub_0200461C;
            CopyRectWithinBgTilemapBuffer(2, 0, 20, 20, 3, 10, 11);
            TextWindowSetXY(gMonSummaryScreen.mainWindow, 32, 72);
            RenderText(gMonSummaryScreen.mainWindow, gText_Cancel3);
            ClearWindowCharBuffer(gMonSummaryScreen.inputWindow, 0);
            RenderText(gMonSummaryScreen.inputWindow, gText_Cancel3);
            gBgTilemapBufferTransferScheduled[0] = TRUE;
            ToggleMoveDetails(monId, 0);
            txtPtr = GetTextBufferPointer(monId);
            SetBgTilemapBufferPaletteRect(0, 11, 15, 18, 4, 15);
            FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 0, 12, 18, 4, 0);
            TextWindowSetXY(gMonSummaryScreen.mainWindow, 0, 96);
            RenderText(gMonSummaryScreen.mainWindow, txtPtr);
            gBgTilemapBufferTransferScheduled[0] = TRUE;
            moveDetailsState = 2;
            // fallthrough
        case 2:
            do
            {
                s32 tempMoveSlot;

                DelayFrames(1);
                keys = gNewKeys;
                previousMoveSlot = gCurrentMoveSlot;

                if (keys & DPAD_DOWN)
                {
                    PlaySE(SONG_SE_SELECT);

                    for (newMoveSlot = -1, tempMoveSlot = gCurrentMoveSlot + 1; newMoveSlot == -1; tempMoveSlot++)
                    {
                        if (tempMoveSlot == 5)
                            tempMoveSlot = 0;

                        if (gSummaryCurrentMonMoves[tempMoveSlot] != MOVE_NONE) // if (gMonSummaryScreen.moves[tempMoveSlot] != MOVE_NONE)
                            newMoveSlot = tempMoveSlot;
                    }

                    gCurrentMoveSlot = newMoveSlot;
                }

                if (keys & DPAD_UP)
                {
                    PlaySE(SONG_SE_SELECT);

                    for (newMoveSlot = -1, tempMoveSlot = gCurrentMoveSlot - 1; newMoveSlot == -1; tempMoveSlot--)
                    {
                        if (tempMoveSlot == -1)
                            tempMoveSlot = 4;

                        if (gSummaryCurrentMonMoves[tempMoveSlot] != MOVE_NONE) // if (gMonSummaryScreen.moves[tempMoveSlot] != MOVE_NONE)
                            newMoveSlot = tempMoveSlot;
                    }

                    gCurrentMoveSlot = newMoveSlot;
                }

                if (previousMoveSlot != gMonSummaryScreen.currentMoveSlot) // if (previousMoveSlot != gCurrentMoveSlot)
                {
                    PrintPowerAndAccuracy(monId, gMonSummaryScreen.currentMoveSlot);
                    PrintMoveDescription(monId, gMonSummaryScreen.currentMoveSlot);
                    SetSpritePos(gMonSummaryScreen.moveSelectorSprite, 80, 32 + (gMonSummaryScreen.currentMoveSlot * 16));

                    if (previousMoveSlot == MAX_MON_MOVES || gMonSummaryScreen.currentMoveSlot == MAX_MON_MOVES)
                        ToggleMoveDetails(monId, gMonSummaryScreen.currentMoveSlot);
                }

                if (keys & (A_BUTTON | B_BUTTON))
                {
                    PlaySE(SONG_SE_SELECT);
                    moveDetailsState = 3;
                }
            } while (moveDetailsState == 2);
            break;
        case 3:
            MoveSpriteToHead(gMonSummaryScreen.moveSelectorSprite);
            CopyRectWithinBgTilemapBuffer(2, 0, 23, 20, 3, 10, 11);
            FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 4, 9, 5, 2, 0);
            TextWindowSetXY(gMonSummaryScreen.mainWindow, 32, 72);
            FillWindowCharBufferRect(gMonSummaryScreen.mainWindow, 0, 12, 18, 4, 0);
            ClearWindowCharBuffer(gMonSummaryScreen.inputWindow, 0);
            RenderText(gMonSummaryScreen.inputWindow, gText_Info);
            gBgTilemapBufferTransferScheduled[0] = TRUE;
            gBgTilemapBufferTransferScheduled[2] = TRUE;

            if (gMonSummaryScreen.currentMoveSlot != MAX_MON_MOVES)
                ToggleMoveDetails(monId, 0);

            moveDetailsState = 0;
            break;
        }
    }

    if (monId != -1)
    {
        for (i = 0; i < MAX_MON_MOVES; i++)
            MoveSpriteToHead(gMonSummaryScreen.moveTypeSprites[i]);
    }

    for (i = 0; i < MAX_MON_MOVES; i++)
        gMonSummaryScreen.moveTypeSprites[i] = 0;

    return monId;
}

s32 ShowPokemonSummaryScreen(u32 monId)
{
    s32 i;

    InitGraphics();
    PrintMainInfo(monId, FALSE);
    gMonSummaryScreen.statsPrinted = FALSE;
    PrintTrainerMemoPage(monId);
    FadeIn();

    while (1)
    {
        monId = TrainerMemoHandleInput(monId);

        if (monId == -1)
            break;

        ClearWindowCharBuffer(gMonSummaryScreen.mainWindow, 0);
        TextWindowFillTileBufferForText(gMonSummaryScreen.mainWindow);

        for (i = 4; i != -1; i--)
        {
            DelayFrames(1);
            SetBgPos(2, -(i * 32), 0);
        }

        monId = MovesPageHandleInput(monId);

        if (monId == -1)
            break;

        ClearWindowCharBuffer(gMonSummaryScreen.mainWindow, 0);
        TextWindowFillTileBufferForText(gMonSummaryScreen.mainWindow);

        for (i = 0; i < 5; i++)
        {
            DelayFrames(1);
            SetBgPos(2, -32 -(i * 32), 0);
        }
    }
    FadeOut();

    return gMonSummaryScreen.currentMonId;
}

// The same as PrintMoveDescription, but not inlined.
static void PrintMoveDescription_(s32 monId, u32 moveSlot)
{
    PrintMoveDescription(monId, moveSlot);
}

static void sub_0200461C(struct Sprite *sprite)
{
    switch (sprite->unk14[0])
    {
    case 1:
        SetSpriteInvisible(sprite, FALSE);
        break;
    case 36:
        SetSpriteInvisible(sprite, TRUE);
        break;
    case 39:
        sprite->unk14[0] = 0;
        break;
    }

    sprite->unk14[0]++;
}

