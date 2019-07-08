#include "gba/gba.h"
#include "siirtc.h"

#define NELEMS(arr) (sizeof(arr)/sizeof(*(arr)))

struct RomHeader
{
    u32 initialBranch;
    u8 nintendoLogo[0xA0-0x04];
    char title[12];    // a0
    char code[4];      // ac
    char makerCode[2]; // b0
    char fixed;        // b2
    char unitCode;     // b3
    char deviceType;   // b4
    char filler[7];
    char gameVersion;  // bc
    char complement;   // bd
    short checksum;    // be
};

extern u32 gUnknown_02025250;

extern const u8 ROMHeader_Title[15];
extern const u8 ROMHeader_Language;
extern const u8 ROMHeader_MakerCodeLo;
extern const u8 ROMHeader_MakerCodeHi;
extern const u8 ROMHeader_Magic;
extern const u8 ROMHeader_Version;

extern const struct RomHeader gROMHeader;

extern const u8 gUnknown_0201F298[6][2];
extern const u8 gUnknown_0201F2A4[16];
extern const u8 gUnknown_0201F2B4[16];

bool32 sub_0200E344(const u8 * a0, const u8 * a1, u32 a2)
{
    u32 i;

    for (i = 0; i < a2; i++)
    {
        if (a0[i] != a1[i])
        {
            return FALSE;
        }
    }

    return TRUE;
}

int sub_0200E38C(void)
{
    int i;
    int sp4;
    s32 languageCode;
    s32 version;

    languageCode = ROMHeader_Language;
    version = ROMHeader_Version;
    sp4 = -1;
    for (i = 0; i < NELEMS(gUnknown_0201F298); i++)
    {
        if (languageCode != gUnknown_0201F298[i][0])
        {
            continue;
        }
        if (version >= gUnknown_0201F298[i][1])
        {
            sp4 = 0;
        }
        else
        {
            sp4 = 1;
        }
        break;
    }
    if (sp4 == -1)
    {
        return 6;
    }
    if (sub_0200E344(ROMHeader_Title, gUnknown_0201F2A4, 15) == TRUE)
    {
        if (sp4 == 0)
        {
            return 5;
        }
        else
        {
            gUnknown_02025250 = 2;
            return 3;
        }
    }
    if (sub_0200E344(ROMHeader_Title, gUnknown_0201F2B4, 15) == TRUE)
    {
        if (sp4 == 0)
        {
            return 4;
        }
        else
        {
            gUnknown_02025250 = 1;
            return 2;
        }
    }

    return 6;
}

int sub_0200E478(void)
{
    if (ROMHeader_MakerCodeLo != '0')
        return 6;
    
    if (ROMHeader_MakerCodeHi != '1')
        return 6;
    
    if (ROMHeader_Magic != 0x96)
        return 6;
    
    return sub_0200E38C();
}

extern u32 gUnknown_02021380;
extern u32 gUnknown_0202524C;
bool32 sub_0200E674(void);
bool32 sub_0200E6D0(u8 *);
void sub_0200E934(void);
bool32 sub_0200F3A0(void);
bool32 sub_0200F3E4(void);

void sub_0200E4BC(u32 * pstate, u8 * buffer, u32 unk2)
{
    u8 sp0C;
    int sp10;
    switch (*pstate)
    {
    case 0:
        gUnknown_02021380 = 0;
        gUnknown_0202524C = 0;
        sp10 = sub_0200E478();
        switch (sp10)
        {
        case 6:
            *pstate = 11;
            break;
        case 5:
        case 4:
            *pstate = 6;
            break;
        case 3:
        case 2:
            (*pstate)++;
            break;
        }
        break;
    case 1:
        if (sub_0200E674() == 0)
        {
            *pstate = 11;
        }
        else
        {
            (*pstate)++;
        }
        break;
    case 2:
        (*pstate)++;
        break;
    case 3:
        (*pstate)++;
        break;
    case 4:
        if (sub_0200E6D0(&sp0C) == 1)
        {
            if (sp0C == 0)
            {
                (*pstate)++;
            }
            else
            {
                *pstate = 9;
            }
        }
        else
        {
            if (sp0C != 1)
            {
                *pstate = 7;
            }
            else
            {
                (*pstate)++;
            }
        }
        break;
    case 5:
        sub_0200E934();
        gUnknown_0202524C |= 1;
        *pstate = 9;
        break;
    case 9:
        if (sub_0200F3A0() == 1)
        {
            *pstate = 8;
        }
        else
        {
            *pstate = 10;
        }
        break;
    case 10:
        if (sub_0200F3E4() == 1)
        {
            gUnknown_0202524C |= 1;
            *pstate = 8;
        }
        else
        {
            *pstate = 11;
        }
        break;
    case 8:
        *pstate = 6;
        break;
    case 6:
        break;
    case 7:
        break;
    case 11:
        break;
    }
}

void sub_0200ED5C(void);
u16 sub_0200EDEC(void);

bool32 sub_0200E674(void)
{
    sub_0200ED5C();
    if (sub_0200EDEC() & 0xFF0)
        return FALSE;
    else
        return TRUE;
}

void sub_0200E6A0(struct SiiRtcInfo *rtc)
{
    u16 imeBak;
    imeBak = REG_IME;
    REG_IME = 0;
    SiiRtcSetDateTime(rtc);
    REG_IME = imeBak;
}
