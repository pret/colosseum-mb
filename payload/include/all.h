#ifndef GUARD_ALL_H
#define GUARD_ALL_H

struct UnkStruct868
{
    u32 a0;
    u32 a4;
    u32 a8_0:24;
    u32 a11_0:1;
    u32 a11_1:1;
    u32 a11_2:1;
    u32 a11_3:1;
    u32 a11_4:4;
    u32 a12:24;
    u32 a15:8;
};

#define UNK81C_ARR_SIZE 12

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
    u8 fill20[4];
    u32 unk24[5];
    u8 unk38[8];
    u8 unk40[0x81c-0x40];
    u8 unk81C[4][UNK81C_ARR_SIZE];
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
    u32 field85C[3];
    struct UnkStruct868 unk868;
    u8 unk_878;
    u8 unk_879;
    u8 unk_87A;
    u8 unk_87B;
    u8 filler_87C[2];
    u8 unk_87E;
    u8 unk_87F;
    u32 unk_880;
};

extern volatile struct UnkStruct_02024960 gUnknown_02024960;

#include "gflib/text.h"

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
