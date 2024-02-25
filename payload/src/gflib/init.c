#include "global.h"
#include "gflib/init.h"
#include "gflib/bg.h"
#include "gflib/sprite.h"
#include "gflib/keys.h"
#include "gflib/sound.h"

extern void GF_Main(void);

extern char bss_start[], bss_end[];

IntrFunc gIntrTable[14u];
u32 gVBlankCounter;
IntrFunc gVBlankCallback;

static void InitIntr(void);
static void VBlankIntr(void);
static void IntrDummy(void);

#define SR_KEYS (A_BUTTON | B_BUTTON | SELECT_BUTTON | START_BUTTON)

void AgbMain(void)
{
    REG_IME = 0;
    RegisterRamReset(RESET_ALL & ~(RESET_EWRAM | RESET_IWRAM));
    CpuFill16(0, bss_start, bss_end - bss_start);
    REG_WAITCNT = WAITCNT_SRAM_4 | WAITCNT_WS0_N_3 | WAITCNT_WS0_S_1 | WAITCNT_WS1_N_3 | WAITCNT_WS1_S_1 | WAITCNT_WS2_N_3 | WAITCNT_WS2_S_1 | WAITCNT_PREFETCH_ENABLE;
    InitIntr();
    ResetGpuBuffers();
    ResetSprites();
    GF_Main();
    SoftReset(RESET_ALL);
}

u32 GetFrameTotal(void)
{
    return gVBlankCounter;
}

void DelayFrames(u32 frames)
{
    for (; frames != 0; frames--)
    {
        UpdateSprites();
        VBlankIntrWait();
        ReadKeys();
        if (TEST_BUTTON(gHeldKeys, SR_KEYS) == SR_KEYS)
            SoftReset(0);
    }
}

static void InitIntr(void)
{
    u32 i;

    gVBlankCallback = NULL;

    for (i = 0; i < 14u; i++)
        gIntrTable[i] = IntrDummy;

    if (VBlankIntr != NULL)
        gIntrTable[1] = VBlankIntr;
    else
        gIntrTable[1] = IntrDummy;
}

void SetIntrFunc(u32 i, IntrFunc func)
{
    if (func != NULL)
        gIntrTable[i] = func;
    else
        gIntrTable[i] = IntrDummy;
}

void SetVBlankCallback(IntrFunc cb)
{
    u16 imeBak = REG_IME;
    REG_IME = 0;
    gVBlankCallback = cb;
    REG_IME = imeBak;
}

static void VBlankIntr(void)
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

static void IntrDummy(void)
{

}
