#include "global.h"
#include "gflib/keys.h"

u16 gNewKeys;
u16 gNewAndRepeatedKeys;
u16 gHeldKeys;

static u16 sKeyRepeatDelay;
static u16 sKeyRepeatRate;
static u16 sKeyRepeatTimer;

void ReadKeys(void)
{
    u32 keyInput;
    u16 * prevKeys = &gHeldKeys;
    u16 newKeys = (keyInput = REG_KEYINPUT ^ KEYS_MASK) & ~*prevKeys;
    gNewKeys = newKeys;

    if (gHeldKeys != keyInput)
    {
        gNewAndRepeatedKeys = keyInput;
        sKeyRepeatTimer = sKeyRepeatDelay;
    }
    else if (--sKeyRepeatTimer == 0)
    {
        gNewAndRepeatedKeys = keyInput;
        sKeyRepeatTimer = sKeyRepeatRate;
    }
    else
    {
        gNewAndRepeatedKeys = 0;
    }

    gHeldKeys = keyInput;
}

void SetKeyRepeatTiming(u16 delay, u16 rate)
{
    sKeyRepeatDelay = delay;
    sKeyRepeatRate = rate;
    sKeyRepeatTimer = 1;
}
