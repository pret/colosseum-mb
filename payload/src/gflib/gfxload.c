#include "global.h"
#include "gflib/gfxload.h"

void AutoUnCompVram(const void * src, void * dest)
{
    switch (*(u8 *)src & 0xF0)
    {
    case 0x10:
        LZ77UnCompVram(src, dest);
        break;
    case 0x20:
        HuffUnComp(src, dest);
        break;
    case 0x30:
        RLUnCompVram(src, dest);
        break;
    }
}
