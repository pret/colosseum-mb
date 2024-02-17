#include "global.h"
#include "gflib.h"
#include "all.h"
#include "graphics.h"
#include "libpmagb/agb_rom.h"
#include "strings.h"
#include "unk_200C5DC.h"

extern u8 gUnknown_020217B4;
extern u8 gRomDetection_IsEnglishROM;
extern u8 gUnknown_020217B8;
extern const struct Window gFont0LatinInfo;
extern const struct Window gUnknown_0201FB90;
extern struct Window *gMessageWindowPtr;

extern const u8 *gErrorMessagePtrs[];

void sub_02006058(void);
void sub_02006264(void);

void sub_0200465C(void)
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

void sub_0200472C(void)
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

/*
u32 sub_020047D4(void)
{
    s32 r5;
    struct Window winTemplate;
    struct Window *win;

    gUnknown_02024960.unk_87B = 4;
    sub_0200465C();
    if (gAgbPmRomParams->unkB8_1 || !gRomDetection_IsEnglishROM)
    {
        OverrideScreenFadeState(TRUE);
        winTemplate = gFont0LatinInfo;
        FillBgTilemapBufferRect(2, 0, 16, 30, 4, 0);
        DrawTextWindowBorder(3, 14, 24, 6, 0xE001);
        win = AddWindow(0, &winTemplate);
        SetTextColor(win, 1, 8);
        ClearWindowCharBuffer(win, 0xFFFF);
        gBgTilemapBufferTransferScheduled[2] = TRUE;
        if (IsScreenFadedOut() == TRUE)
            FadeIn();
        RenderText(win, gErrorMessagePtrs[9]);
        // Game stuck
        while (1)
        {
            DelayFrames(100);
        }
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
*/
