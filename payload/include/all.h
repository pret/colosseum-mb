#ifndef GUARD_ALL_H
#define GUARD_ALL_H

struct ExternalEventData2
{
    u32 unknownExternalDataFields1;
    u32 unknownExternalDataFields2;
    u32 currentPokeCoupons:24;
    u32 gotGoldPokeCouponTitleReward:1;
    u32 gotSilverPokeCouponTitleReward:1;
    u32 gotBronzePokeCouponTitleReward:1;
    u32 receivedAgetoCelebi:1;
    u32 unknownExternalDataFields3:4;
    u32 totalEarnedPokeCoupons:24;
    u32 unknownExternalDataFields4:8;
};

struct UnkStruct81C
{
    u8 str[10];
    u32 unk826_0:3;
    u32 unk826_1:1;
    u32 unk826_2:1;
    u32 unk826_3:1;
    u32 unk826_4:2;
};

struct UnkStruct24
{
    u16 hp; // 0x24
    u32 status:12; // 0x26
    u32 unk27_0:1;
    u32 unk27_1:1;
    u32 unk27_2:1;
    u32 unk27_3:1;
    u16 heldItem; // 0x28
    u16 unk2A;
    u16 moves[MAX_MON_MOVES]; // 0x2C , 0x2E , 0x30, 0x32
    u8 pps[MAX_MON_MOVES]; // 0x34-0x37
    u8 unk38[320];
};

struct UnkStruct_02024960
{
    u32 unk_00:24;
    u32 unk_03_0:7;
    u32 unk_03_7:1;
    u32 unk4:24;
    u32 unk7:8;
    u32 unk8;
    u32 unkC;
    u16 unk10;
    u16 unk12;
    u16 unk14[MAX_MON_MOVES];
    u8 unk1C[MAX_MON_MOVES];
    u16 unk20;
    u8 unk22_0:4;
    u8 unk22_4:4;
    u8 unk23_0:4;
    u8 unk23_4:4;
    struct UnkStruct24 unk24[PARTY_SIZE];
    struct UnkStruct81C unk81C[4];
    u8 unk84C_00:1;
    u8 unk84C_01:1;
    u8 unk84C_02:1;
    u8 unk84C_03:1;
    u8 unk84C_1:4;
    u32 unk84C_2:16;
    u32 unk84C_3:8;
    u32 unk850_1:8;
    u32 unk850_2:24;
    u32 *field854;
    u8 unk_858;
    u8 unk_859;
    u8 unk_85A;
    u8 unk_85B;
    u8 ALIGNED(4) field85C[12]; // Aligned for u32 copy
    struct ExternalEventData2 externalEventData;
    u8 unk_878;
    u8 unk_879;
    u8 unk_87A;
    u8 unk_87B;
    u8 unk_87C;
    u8 filler_87D;
    u8 unk_87E;
    u8 unk_87F;
    u32 unk_880;
};

extern volatile struct UnkStruct_02024960 gUnknown_02024960;

#include "gflib/text.h"

void sub_02002A9C(s32 a0, u32 a1, u32 a2);
void BufferString(u32 bufferId, const u8 *src);
void DrawPartyMonHealthBar(int bgNum, int x, int y, u32 monId);
void FadeIn(void);
void OverrideScreenFadeState(bool32 faded);
bool32 IsScreenFadedOut(void);
void FadeOut(void);
void DrawTextWindowBorder(u32 a0, u32 a1, s32 a2, s32 a3, u32 a4);
u8 *NumToPmString3CustomZeroChar(s32 num, u8 *str, u32 zeroChar);
void RenderText(struct Window *win, const u8 *str);
void RenderTextAt(struct Window *win, u32 x, u32 y, const u8 *str);
u8 *NumToPmString3RightAlign(u8 *str, s32 num);
void ClearVram(void);

#endif // GUARD_ALL_H
