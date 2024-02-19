#ifndef GUARD_unk_200C5DC_H
#define GUARD_unk_200C5DC_H

#define CONTINUE_GAME_WARP           (1 << 0)
#define POKECENTER_SAVEWARP          (1 << 1)
#define LOBBY_SAVEWARP               (1 << 2)
#define CHAMPION_SAVEWARP            (1 << 7)

struct UnkStruct_020251F0
{
    volatile u32 *field0;
    u32 field4;
    u8 field8[2];
    vu8 state;
    u8 field11;
    u8 field12;
    u8 field13;
    u8 field14;
    u8 field15;
    u8 field16;
    u8 field17;
    u8 field18;
    u8 fill19;
    u8 field20;
    u8 fill21;
    u8 fill22;
    u8 fill23;
    u8 fill24;
    u8 fill25;
    u8 fill26;
    u8 fill27;
    u32 field28;
    u32 field32;
    u32 field36;
    u32 field40;
    u32 field44;
    u32 field48;
};

extern volatile struct UnkStruct_020251F0 gUnknown_020251F0;

void SetSpeciesCaughtFlag(u32 species, struct Pokemon *mon);
u8 GetPlayerMapType(void);
u8 *sub_0200CB34(u32 id);
struct PlayerLinkInfo *SetPlayerLinkInfo(u8 *sav2, u8 *sav1, u32 saveStatus);
s32 StringCompare(const u8 *str1, const u8 *str2);
u8 *StringCopy(u8 *dst, const u8 *src);
u16 GetStringSizeHandleExtCtrlCodes(u8 *str);
bool32 SetFlag(s32 flag);
u32 sub_0200CB54(void);

#endif // GUARD_unk_200C5DC_H
