#include "global.h"
#include "gflib.h"

struct UnkStruct_02024960
{
    u32 unk_00:24;
    u32 unk_03_0:7;
    u32 unk_03_7:1;
    u8 filler_04[0x854];
    vu8 unk_858;
    u8 filler_859[0x22];
    u8 unk_87B;
    u8 filler_87C[2];
    u8 unk_87E;
    u8 unk_87F;
    u32 unk_880;
};

EWRAM_DATA volatile struct UnkStruct_02024960 gUnknown_02024960 = {0};

u32 sub_02006490(void);
void sub_02002A9C(u8, u32, u8);

bool8 sub_0200023C(void)
{
    u32 r0;

    sub_02006490();
    if (gUnknown_02024960.unk_03_0 == 0)
    {
        gUnknown_02024960.unk_858 = 1;
    }
    else
    {
        gUnknown_02024960.unk_858 = 2;
    }
    sub_02002A9C(0, sub_02006490(), 1);
    r0 = gUnknown_02024960.unk_87E | (gUnknown_02024960.unk_87B << 16);
    gUnknown_02024960.unk_880 = r0;
    gUnknown_02024960.unk_87F = 1;
    return FALSE;
}
