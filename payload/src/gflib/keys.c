#include "global.h"
#include "gflib/keys.h"

u16 gUnknown_02022EB0;
u16 gUnknown_02022EB4;
u16 gUnknown_02022EB8;

BSS_DATA u16 gUnknown_02021360;
BSS_DATA u16 gUnknown_02021362;
BSS_DATA u16 gUnknown_02021364;

void sub_02009228(void)
{
    u32 keyInput;
    u16 * prevKeys_p = &gUnknown_02022EB8;
    u16 newKeys = (keyInput = REG_KEYINPUT ^ KEYS_MASK) & ~*prevKeys_p;
    gUnknown_02022EB0 = newKeys;
    if (gUnknown_02022EB8 != keyInput)
    {
        gUnknown_02022EB4 = keyInput;
        gUnknown_02021364 = gUnknown_02021360;
    }
    else if (--gUnknown_02021364 == 0)
    {
        gUnknown_02022EB4 = keyInput;
        gUnknown_02021364 = gUnknown_02021362;
    }
    else
    {
        gUnknown_02022EB4 = 0;
    }
    gUnknown_02022EB8 = keyInput;
}

void sub_020092A4(u16 a0, u16 a1)
{
    gUnknown_02021360 = a0;
    gUnknown_02021362 = a1;
    gUnknown_02021364 = 1;
}
