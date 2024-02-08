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

struct UnkStruct_02024960
{
    u32 unk_00:24;
    u32 unk_03_0:7;
    u32 unk_03_7:1;
    u8 filler_04;
    u8 filler_05;
    u8 filler_06;
    u8 unk7;
    u8 unk8[0x24-8];
    u32 unk24[5];
    u8 unk38[8];
    u8 unk40[0x81c-0x40];
    u32 unk81C;
    u8 unk820[0x84c-0x820];
    u32 unk84C_00:1;
    u32 unk84C_01:1;
    u32 unk84C_02:1;
    u32 unk84C_03:1;
    u32 unk84C_1:4;
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

#endif // GUARD_ALL_H
