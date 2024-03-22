#ifndef GUARD_unk_200C5DC_H
#define GUARD_unk_200C5DC_H

#define CONTINUE_GAME_WARP           (1 << 0)
#define POKECENTER_SAVEWARP          (1 << 1)
#define LOBBY_SAVEWARP               (1 << 2)
#define CHAMPION_SAVEWARP            (1 << 7)

#define LINK_CMD_RESET              0x00
#define LINK_CMD_0x01               0x01
#define LINK_CMD_TRAN_PLAYER_DATA2  0x04
#define LINK_CMD_RECV_GIFT_DATA     0x22
#define LINK_CMD_TRAN_GIFT_DATA     0x33
#define LINK_CMD_0x44               0x44
#define LINK_CMD_RECV_PARTY_MON     0x55
#define LINK_CMD_SOFT_RESET_ROM     0x60
#define LINK_CMD_SOFT_RESET         0x61
#define LINK_CMD_RECV_MON_DATA      0x66
#define LINK_CMD_RECV_UNKNOWN       0x77
#define LINK_CMD_RECV_TEXT          0x88
#define LINK_CMD_TRAN_PLAYER_DATA1  0x99
#define LINK_CMD_READ_INPUT         0xAA

struct TransferData
{
    volatile u32 *data;
    u32 transferSize;
    u8 field8[2];
    vu8 state;
    u8 field11;
    u8 field12;
    u8 field13;
    u8 field14;
    u8 field15;
    u8 field16;
    u8 currentCmd;
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
    u32 transferBytes;
    u32 gameCode;
    u32 field36;
    u32 lowerCaseGameCode;
    u32 gameCode2;
    u32 makerCode;
};

extern volatile struct TransferData gTransferData;

void SetSpeciesCaughtFlag(u32 species, struct Pokemon *mon);
u8 GetPlayerMapType(void);
u8 *GetTextBufferPointer(u32 id);
struct PlayerLinkInfo *SetPlayerLinkInfo(u8 *sav2, u8 *sav1, u32 saveStatus);
s32 StringCompare(const u8 *str1, const u8 *str2);
u8 *StringCopy(u8 *dst, const u8 *src);
u16 GetStringSizeHandleExtCtrlCodes(u8 *str);
bool32 SetFlag(s32 flag);
bool32 GetUnknownBoolean(void);

#endif // GUARD_unk_200C5DC_H
