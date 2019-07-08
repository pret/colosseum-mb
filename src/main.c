#include "gba/gba.h"
#include "m4a.h"

extern u8 gUnknown_02020A34[];
extern u32 gUnknown_02022C08;
extern void (*gUnknown_02022BD0[])(void);
extern void (*gUnknown_02022C0C)(void);
extern u16 gUnknown_02022EB8;
extern u8 gUnknown_0202526C[];

void sub_02008638(void);
void sub_020086B8(void);
void sub_02008708(void);
void sub_0200870C(void);
void sub_020087B4(void);
void sub_02008C00(void);
void sub_02008C80(void);
void sub_02008D1C(void);
void sub_02009228(void);
bool32 sub_02009324(u8);

extern void sub_020002B4(void);

#define SR_KEYS (A_BUTTON | B_BUTTON | SELECT_BUTTON | START_BUTTON)

#define TEST_BUTTON(arr, flags) ({(arr) & (flags);})

void AgbMain(void)
{
    REG_IME = 0;
    RegisterRamReset(RESET_ALL & ~(RESET_EWRAM | RESET_IWRAM));
    CpuFill16(0, gUnknown_02020A34, gUnknown_0202526C - gUnknown_02020A34);
    REG_WAITCNT = 0x45B4;
    sub_02008638();
    sub_020087B4();
    sub_02008C80();
    sub_020002B4();
    SoftReset(RESET_ALL);
}

u32 sub_020085F4(void)
{
    return gUnknown_02022C08;
}

void sub_02008600(u32 a0)
{
    for (; a0 != 0; a0--)
    {
        sub_02008C00();
        VBlankIntrWait();
        sub_02009228();
        if (TEST_BUTTON(gUnknown_02022EB8, SR_KEYS) == SR_KEYS)
            SoftReset(0);
    }
}

void sub_02008638(void)
{
    int i;
    gUnknown_02022C0C = NULL;
    for (i = 0; i < 14u; i++)
        gUnknown_02022BD0[i] = sub_02008708;
    if (sub_020086B8 != NULL)
        gUnknown_02022BD0[1] = sub_020086B8;
    else
        gUnknown_02022BD0[1] = sub_02008708;
}

void sub_02008674(int i, void (*func)(void))
{
    if (func != NULL)
        gUnknown_02022BD0[i] = func;
    else
        gUnknown_02022BD0[i] = sub_02008708;
}

void sub_020086A0(void (*a0)(void))
{
    u16 imeBak = REG_IME;
    REG_IME = 0;
    gUnknown_02022C0C = a0;
    REG_IME = imeBak;
}

void sub_020086B8(void)
{
    if (sub_02009324(0))
        m4aSoundVSync();
    sub_02008D1C();
    sub_0200870C();
    gUnknown_02022C08++;
    INTR_CHECK = TRUE;
    if (gUnknown_02022C0C != NULL)
        gUnknown_02022C0C();
    if (sub_02009324(1))
        m4aSoundMain();
}
