#include "global.h"
#include "gflib/bg.h"
#include "gflib/sprite.h"
#include "gflib/keys.h"
#include "gflib/sound.h"

extern void GF_Main(void);

extern char bss_start[], bss_end[];

void (*gIntrTable[14u])(void);
u32 gVBlankCounter;
void (*gVBlankCallback)(void);

void InitIntr(void);
void VBlankIntr(void);
void IntrDummy(void);

#define SR_KEYS (A_BUTTON | B_BUTTON | SELECT_BUTTON | START_BUTTON)

#define TEST_BUTTON(arr, flags) ({(arr) & (flags);})

void AgbMain(void)
{
    REG_IME = 0;
    RegisterRamReset(RESET_ALL & ~(RESET_EWRAM | RESET_IWRAM));
    CpuFill16(0, bss_start, bss_end - bss_start);
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
        gIntrTable[i] = IntrDummy;
    if (VBlankIntr != NULL)
        gIntrTable[1] = VBlankIntr;
    else
        gIntrTable[1] = IntrDummy;
}

void SetIntrFunc(int i, void (*func)(void))
{
    if (func != NULL)
        gIntrTable[i] = func;
    else
        gIntrTable[i] = IntrDummy;
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
