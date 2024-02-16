#include "global.h"
#include "gflib.h"
#include "all.h"

extern const u32 gUnknown_0201B1A0[];
extern const u32 gUnknown_0201A894[];
extern const u32 gMessageBox_Gfx[];
extern const u32 gTitle_Pal[];
extern const u32 gTitle_Gfx[];
extern const u32 gTitle_Tilemap[];

/*
void sub_0200465C(void)
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
}

*/
