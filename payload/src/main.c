#include "global.h"
#include "gflib.h"
#include "all.h"
#include "libpmagb/agb_rom.h"
#include "libpmagb/save.h"
#include "unk_200E344.h"
#include "unk_200C5DC.h"
#include "gflib/keys.h"
#include "gflib/bg.h"
#include "gflib/text.h"
#include "gflib/characters.h"
#include "gflib/gfxload.h"
#include "constants/pokemon.h"
#include "constants/items.h"
#include "constants/songs.h"
#include "pokemon.h"
#include "strings.h"
#include "graphics.h"

struct RomHeader
{
    u8 a0[0xA8];
    u8 unkA8[8];
};

extern void sub_0200D9EC(void);
extern const struct RomHeader gRomHeader;
extern u8 gSaveStatus;
extern u8 gUnknown_020217B8;

extern IntrFunc *gTimer1InterruptFunction;
extern struct Unk02021860Struct gUnknown_02021860;
extern s32 sub_020063FC(void);
extern s32 sub_020064BC(u32 a0, u32 a1);
extern u32 sub_020044F0(u32 a0);
extern void sub_0200D924(const u8*);

void sub_02002A9C(s32 a0, u32 a1, u32 a2);
void sub_02002C44(void);
void sub_02006344(void);
void sub_02005BB8(void);
void FadeOut(void);
u32 sub_020047D4(void);
u32 sub_020064B0(void);
bool32 sub_02005704(u32);
bool32 IsMonFainted(u32 monId);
extern u32 sub_02006490(void);
extern void sub_02002A9C(s32 a0, u32 a1, u32 a2);

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

inline u32 sub_0200043C(void)
{
    u8 buffer[64];
    u32 var18 = 0;
    u32 r4 = 0;
    u32 language = gAgbPmRomParams->language;

    if (language != LANGUAGE_ENGLISH)
        return 0;

    if (language == LANGUAGE_ENGLISH)
    {
        while (1)
        {
            main_callback(&var18, buffer, 0);
            if (var18 == 5)
                r4 = 1;
            if (var18 == 11)
                r4 = 2;
            if (var18 == 6 || var18 == 7 || var18 == 11)
                break;
        }
    }

    return r4;
}

#ifdef NONMATCHING
void GF_Main(void)
{
    s32 i;
    u16 monStatus;

    DetectROM();
    InitFlash(2, gTimer1InterruptFunction);
    SaveBlocksInit();
    SetSaveSectorPtrs();
    gSaveStatus = ReadSaveBlockChunks();

    gUnknown_020217B8 = sub_0200043C();

    InitSound();
    sub_02002C44();
    SetKeyRepeatTiming(0x28, 5);
    REG_IE = 1;
    REG_DISPSTAT = 8;
    REG_DISPCNT &= (0xFF7F);
    REG_IME = 1;
    SetPlayerLinkInfo(gSaveBlock2Ptr, gSaveBlock1Ptr, gSaveStatus);

    sub_0200D924(gRomHeader.unkA8);

    SetVBlankCallback(sub_0200D9EC);
    PauseSoundVSync();
    GenerateFontHalfrowLookupTable((u32 *) 0x03004000);
    FadeOut();
    for (;;)
    {
        if (sub_020047D4() == 0)
        {
            sub_02006344();
            sub_02005BB8();
            if (sub_020064B0() == 0)
            {
                sub_02005704((gUnknown_02024960.unk_03_0 != 0) ? gUnknown_02024960.unk_03_0 - 1 : 0);
            }
            else
            {
                sub_0200023C();
            }
        }
        else
        {
            CpuCopy16(gSaveBlock1BakPtr, gSaveBlock1Ptr, gAgbPmRomParams->saveBlock1Size);
            monStatus = 0;
            for (i = 0; i < PARTY_SIZE; i++)
            {
                SetMonData(&gPlayerPartyPtr[i], MON_DATA_STATUS, &monStatus);
            }
            sub_02002A9C(1, 0, 0);
        }
    }
}

#else

NAKED void GF_Main(void)
{
    asm_unified("push {r4, r5, r6, r7, lr}\t\n\
	sub sp, #0x48\t\n\
	bl DetectROM\t\n\
	ldr r0, =gTimer1InterruptFunction\t\n\
	ldr r1, [r0]\t\n\
	movs r0, #2\t\n\
	bl InitFlash\t\n\
	bl SaveBlocksInit\t\n\
	bl SetSaveSectorPtrs\t\n\
	ldr r4, =gSaveStatus\t\n\
	bl ReadSaveBlockChunks\t\n\
	strb r0, [r4]\t\n\
	ldr r5, =gUnknown_020217B8\t\n\
	movs r0, #0\t\n\
	str r0, [sp, #0x44]\t\n\
	movs r4, #0\t\n\
	ldr r0, =gAgbPmRomParams\t\n\
	ldr r0, [r0]\t\n\
	ldr r0, [r0, #4]\t\n\
	cmp r0, #2\t\n\
	beq _02000304\t\n\
	movs r0, #0\t\n\
	ldr r6, =gRomHeader + 0xA8\t\n\
	add r7, sp, #0x40\t\n\
	b _0200032C\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_02000304:\t\n\
	ldr r6, =gRomHeader + 0xA8\t\n\
	add r7, sp, #0x40\t\n\
_02000308:\t\n\
	add r0, sp, #0x44\t\n\
	mov r1, sp\t\n\
	movs r2, #0\t\n\
	bl main_callback\t\n\
	ldr r1, [sp, #0x44]\t\n\
	cmp r1, #5\t\n\
	bne _0200031A\t\n\
	movs r4, #1\t\n\
_0200031A:\t\n\
	cmp r1, #0xb\t\n\
	bne _02000320\t\n\
	movs r4, #2\t\n\
_02000320:\t\n\
	subs r0, r1, #6\t\n\
	cmp r0, #1\t\n\
	bls _0200032A\t\n\
	cmp r1, #0xb\t\n\
	bne _02000308\t\n\
_0200032A:\t\n\
	adds r0, r4, #0\t\n\
_0200032C:\t\n\
	strb r0, [r5]\t\n\
	bl InitSound\t\n\
	bl sub_02002C44\t\n\
	movs r0, #0x28\t\n\
	movs r1, #5\t\n\
	bl SetKeyRepeatTiming\t\n\
	ldr r0, =0x04000200\t\n\
	movs r3, #1\t\n\
	strh r3, [r0]\t\n\
	ldr r1, =0x04000004\t\n\
	movs r0, #8\t\n\
	strh r0, [r1]\t\n\
	movs r2, #0x80\t\n\
	lsls r2, r2, #0x13\t\n\
	ldrh r1, [r2]\t\n\
	ldr r0, =0x0000FF7F\t\n\
	ands r0, r1\t\n\
	strh r0, [r2]\t\n\
	ldr r0, =0x04000208\t\n\
	strh r3, [r0]\t\n\
	ldr r0, =gSaveBlock2Ptr\t\n\
	ldr r0, [r0]\t\n\
	ldr r1, =gSaveBlock1Ptr\t\n\
	ldr r1, [r1]\t\n\
	ldr r2, =gSaveStatus\t\n\
	ldrb r2, [r2]\t\n\
	bl SetPlayerLinkInfo\t\n\
	adds r0, r6, #0\t\n\
	bl sub_0200D924\t\n\
	ldr r0, =sub_0200D9EC\t\n\
	bl SetVBlankCallback\t\n\
	bl PauseSoundVSync\t\n\
	ldr r0, =0x03004000\t\n\
	bl GenerateFontHalfrowLookupTable\t\n\
	bl FadeOut\t\n\
_02000384:\t\n\
	bl sub_020047D4\t\n\
	cmp r0, #0\t\n\
	bne _020003EA\t\n\
	bl sub_02006344\t\n\
	bl sub_02005BB8\t\n\
	bl sub_020064B0\t\n\
	cmp r0, #0\t\n\
	bne _020003E4\t\n\
	ldr r1, =gUnknown_02024960\t\n\
	ldrb r0, [r1, #3]\t\n\
	lsls r0, r0, #0x19\t\n\
	cmp r0, #0\t\n\
	beq _020003DC\t\n\
	ldrb r0, [r1, #3]\t\n\
	lsls r0, r0, #0x19\t\n\
	lsrs r0, r0, #0x19\t\n\
	subs r0, #1\t\n\
	b _020003DE\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_020003DC:\t\n\
	movs r0, #0\t\n\
_020003DE:\t\n\
	bl sub_02005704\t\n\
	b _02000384\t\n\
_020003E4:\t\n\
	bl sub_0200023C\t\n\
	b _02000384\t\n\
_020003EA:\t\n\
	ldr r0, =gSaveBlock1BakPtr\t\n\
	ldr r0, [r0]\t\n\
	ldr r1, =gSaveBlock1Ptr\t\n\
	ldr r1, [r1]\t\n\
	ldr r2, =gAgbPmRomParams\t\n\
	ldr r2, [r2]\t\n\
	adds r2, #0x8c\t\n\
	ldr r2, [r2]\t\n\
	lsls r2, r2, #0xa\t\n\
	lsrs r2, r2, #0xb\t\n\
	bl CpuSet\t\n\
	movs r0, #0\t\n\
	strh r0, [r7]\t\n\
	movs r5, #0\t\n\
	ldr r6, =gPlayerPartyPtr\t\n\
	movs r4, #0\t\n\
_0200040C:\t\n\
	ldr r0, [r6]\t\n\
	adds r0, r0, r4\t\n\
	movs r1, #0x37\t\n\
	adds r2, r7, #0\t\n\
	bl SetMonData\t\n\
	adds r4, #0x64\t\n\
	adds r5, #1\t\n\
	cmp r5, #5\t\n\
	ble _0200040C\t\n\
	movs r0, #1\t\n\
	movs r1, #0\t\n\
	movs r2, #0\t\n\
	bl sub_02002A9C\t\n\
	b _02000384\t\n\
	.align 2, 0\t\n\
	.pool");
}

#endif // NONMATCHING
