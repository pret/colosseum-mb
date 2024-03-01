#include "global.h"
#include "libpmagb/agb_rom.h"
#include "libpmagb/save.h"
#include "gflib/characters.h"
#include "gflib/keys.h"
#include "gflib/init.h"
#include "pokeball.h"
#include "all.h"
#include "pokedex.h"
#include "mb_20094A8.h"
#include "unk_200C5DC.h"
#include "rom_info.h"
#include "constants/items.h"
#include "constants/maps.h"

// This file's functions
u8 GetPlayerMapType(void);
static u8 GetRSPlayerMapType(struct SaveBlock1 *sav1);
static bool8 CheckIfPokedexIsObtained(void);
static bool32 IsFRLG(void);
static u8 ExtCtrlCodeGetLength(u8 c);

u8 UNUSED ItemIdToBallId(u16 ballItem)
{
    switch (ballItem)
    {
    case ITEM_MASTER_BALL:
        return BALL_MASTER;
    case ITEM_ULTRA_BALL:
        return BALL_ULTRA;
    case ITEM_GREAT_BALL:
        return BALL_GREAT;
    case ITEM_SAFARI_BALL:
        return BALL_SAFARI;
    case ITEM_NET_BALL:
        return BALL_NET;
    case ITEM_DIVE_BALL:
        return BALL_DIVE;
    case ITEM_NEST_BALL:
        return BALL_NEST;
    case ITEM_REPEAT_BALL:
        return BALL_REPEAT;
    case ITEM_TIMER_BALL:
        return BALL_TIMER;
    case ITEM_LUXURY_BALL:
        return BALL_LUXURY;
    case ITEM_PREMIER_BALL:
        return BALL_PREMIER;
    case ITEM_POKE_BALL:
    default:
        return BALL_POKE;
    }
}

bool32 GetSetPokedexFlag(u16 nationalDexNo, u8 caseID)
{
    u8 index;
    u8 bit;
    u8 mask;
    bool8 retVal;

    nationalDexNo--;
    index = nationalDexNo / 8;
    bit = nationalDexNo % 8;
    mask = 1 << bit;
    retVal = FALSE;

    switch (caseID)
    {
    case FLAG_GET_SEEN:
        if (gPokedexPtr->seen[index] & mask)
        {
            if ((gPokedexPtr->seen[index] & mask) == (gDexSeen2Ptr[index] & mask)
             && (gPokedexPtr->seen[index] & mask) == (gDexSeen3Ptr[index] & mask))
            {
                retVal = TRUE;
            }
            else
            {
                gPokedexPtr->seen[index] &= ~mask;
                gDexSeen2Ptr[index] &= ~mask;
                gDexSeen3Ptr[index] &= ~mask;
                retVal = FALSE;
            }
        }
        break;
    case FLAG_GET_CAUGHT:
        if (gPokedexPtr->owned[index] & mask)
        {
            if ((gPokedexPtr->owned[index] & mask) == (gPokedexPtr->seen[index] & mask)
             && (gPokedexPtr->owned[index] & mask) == (gDexSeen2Ptr[index] & mask)
             && (gPokedexPtr->owned[index] & mask) == (gDexSeen3Ptr[index] & mask))
            {
                retVal = TRUE;
            }
            else
            {
                gPokedexPtr->owned[index] &= ~mask;
                gPokedexPtr->seen[index] &= ~mask;
                gDexSeen2Ptr[index] &= ~mask;
                gDexSeen3Ptr[index] &= ~mask;
                retVal = FALSE;
            }
        }
        break;
    case FLAG_SET_SEEN:
        gPokedexPtr->seen[index] |= mask;
        gDexSeen2Ptr[index] |= mask;
        gDexSeen3Ptr[index] |= mask;
        break;
    case FLAG_SET_CAUGHT:
        gPokedexPtr->owned[index] |= mask;
        break;
    }

    return retVal;
}

extern const u16 gSpeciesToNationalPokedexNum[];

// Needed to match.
static inline u16 SpeciesToNationalDexNumInline(u16 species)
{
    if (species == SPECIES_NONE)
    {
        return 0;
    }
    else
    {
        u32 tableId = species - 1;

        if (tableId < NUM_SPECIES - 1)
            return gSpeciesToNationalPokedexNum[tableId];

        return species;
    }
}

static u16 SpeciesToNationalDexNum(u16 species)
{
    if (species == SPECIES_NONE)
    {
        return 0;
    }
    else
    {
        u32 tableId = species - 1;

        if (tableId < NUM_SPECIES - 1)
            return gSpeciesToNationalPokedexNum[tableId];

        return species;
    }
}

void SetSpeciesCaughtFlag(u32 species, struct Pokemon *mon)
{
    u32 nationalDexNo = SpeciesToNationalDexNumInline(species);

    if (!GetSetPokedexFlag(nationalDexNo, FLAG_GET_CAUGHT))
    {
        if (species == SPECIES_UNOWN)
            gPokedexPtr->unownPersonality = mon->box.personality;

        if (species == SPECIES_SPINDA)
            gPokedexPtr->spindaPersonality = mon->box.personality;
    }

    GetSetPokedexFlag(nationalDexNo, FLAG_SET_SEEN);
    GetSetPokedexFlag(nationalDexNo, FLAG_SET_CAUGHT);
}

struct PlayerLinkInfo
{
    u32 hasPokedex:1;
    u32 isInPokeCenter:1;
    u32 isFRLG:1;
    u32 isChampion:1;
    u32 language:4;
    u32 errorCode:2;
    u32 unused:15;
    u8 playerName[PLAYER_NAME_LENGTH + 1];
    u32 playerGender;
    u8 playerTrainerId[TRAINER_ID_LENGTH];
    struct Pokemon party[PARTY_SIZE];
    u8 giftRibbons[GIFT_RIBBONS_COUNT];
};

extern struct PlayerLinkInfo gPlayerLinkInfo;

struct PlayerLinkInfo *SetPlayerLinkInfo(u8 *sav2, u8 *sav1, u32 saveStatus)
{
    s32 i;
    struct PlayerLinkInfo* structPtr = &gPlayerLinkInfo;

    CpuFill16(0, &gPlayerLinkInfo, sizeof(struct PlayerLinkInfo));

    if (saveStatus == SAVE_STATUS_OK)
    {
        u8 *saveData;

        if (!gAgbPmRomParams->blockLinkColoXD)
        {
            structPtr->hasPokedex = CheckIfPokedexIsObtained();
            structPtr->isInPokeCenter = ((GetPlayerMapType() & POKECENTER_SAVEWARP) != 0);
            structPtr->isFRLG = IsFRLG();
            structPtr->isChampion = ((GetPlayerMapType() & CHAMPION_SAVEWARP) != 0);
            structPtr->language = gAgbPmRomParams->language;
        }

        saveData = &sav2[gAgbPmRomParams->playerNameOffset];
        StringCopy(structPtr->playerName, saveData);

        saveData = &sav2[gAgbPmRomParams->playerGenderOffset];
        structPtr->playerGender = *saveData;

        saveData = &sav2[gAgbPmRomParams->trainerIdOffset];

        for (i = 0; i < TRAINER_ID_LENGTH; i++)
            structPtr->playerTrainerId[i] = saveData[i];

        for (i = 0; i < PARTY_SIZE; i++)
            CpuCopy16(&gPlayerPartyPtr[i], &structPtr->party[i], sizeof(struct Pokemon));

        for (i = 0; i < GIFT_RIBBONS_COUNT; i++)
            structPtr->giftRibbons[i] = gGiftRibbonsPtr[i];
    }
    else if (saveStatus == SAVE_STATUS_CORRUPT)
    {
        structPtr->errorCode = 1;
    }
    else if (saveStatus == SAVE_STATUS_ERROR)
    {
        structPtr->errorCode = 2;
    }
    else if (saveStatus == SAVE_STATUS_EMPTY)
    {
        structPtr->errorCode = 3;
    }

    return structPtr;
}

static struct PlayerLinkInfo *GetPlayerLinkInfo(void)
{
    return &gPlayerLinkInfo;
}

extern u8 gUnknown_020241D0[][320];
extern bool8 gUnknownBoolean; // 16 bytes reserved?

u8 *sub_0200CB34(u32 id)
{
    return gUnknown_020241D0[id];
}

static void SetUnknownBoolean(bool32 val)
{
    gUnknownBoolean = val;
}

bool32 GetUnknownBoolean(void)
{
    return gUnknownBoolean;
}

bool32 SetFlag(s32 flag)
{
    if (flag != 0)
    {
        u8 *flagPtr = &gFlagsPtr[flag / 8];

        if (flagPtr != NULL)
            *flagPtr |= 1 << (flag % 8);
    }

    return FALSE;
}

bool32 UNUSED ClearFlag(s32 flag)
{
    u8 *flagPtr;

    if (flag == 0)
        return FALSE;

    flagPtr = &gFlagsPtr[flag / 8];

    if (flagPtr != NULL)
        *flagPtr &= ~(1 << (flag % 8));

    return FALSE;
}

static bool32 CheckFlag(s32 flag)
{
    u8 *flagPtr;

    if (flag == 0)
        return FALSE;

    flagPtr = &gFlagsPtr[flag / 8];

    if (flagPtr != NULL && *flagPtr & (1 << (flag % 8)))
        return TRUE;

    return FALSE;
}

extern bool8 gRomDetection_IsRubySapphire;
extern bool8 gRomDetection_IsEnglishROM;

extern void SoftResetRom(u32);
extern void SoftReset(u32);

void DetectROM(void)
{
    u32 gameCode, rsVersion, notEnglishRS;

    gRomDetection_IsRubySapphire = FALSE;
    gRomDetection_IsEnglishROM = FALSE;
    rsVersion = 0;
    gameCode = *(u32 *)(0x80000AC);

    switch (gameCode)
    {
    default:
        notEnglishRS = TRUE;
        gRomDetection_IsEnglishROM = TRUE;
        break;
    case 0x45565841: // AXVE
        gRomDetection_IsEnglishROM = TRUE;
        rsVersion = VERSION_RUBY;
        notEnglishRS = FALSE;
        gRomDetection_IsRubySapphire = TRUE;
        break;
    case 0x45505841: // AXPE
        gRomDetection_IsEnglishROM = TRUE;
        rsVersion = VERSION_SAPPHIRE;
        notEnglishRS = FALSE;
        gRomDetection_IsRubySapphire = TRUE;
        break;
    case 0x46505841: // AXPF
    case 0x44565841: // AXVD
    case 0x44505841: // AXPD
    case 0x49565841: // AXVI
    case 0x46565841: // AXVF
    case 0x49505841: // AXPI
    case 0x53505841: // AXPS
    case 0x53565841: // AXVS
        notEnglishRS = TRUE;
        gRomDetection_IsRubySapphire = TRUE;
        break;
    }

    if (notEnglishRS)
    {
        gAgbPmRomParams = (void*)(0x8000100);
    }
    else if (rsVersion == VERSION_RUBY)
    {
        if (*(u8*)(0x80000BC) == 0)
            gAgbPmRomParams = &gAgbPmRomParams_AXVE_rev0;
        else
            gAgbPmRomParams = &gAgbPmRomParams_AXVE_rev2;
    }
    else
    {
        if (*(u8*)(0x80000BC) == 0)
            gAgbPmRomParams = &gAgbPmRomParams_AXPE_rev0;
        else
            gAgbPmRomParams = &gAgbPmRomParams_AXPE_rev2;
    }

    if (notEnglishRS == TRUE)
    {
        if (gAgbPmRomParams->language == LANGUAGE_ENGLISH)
            gRomDetection_IsEnglishROM = TRUE;
        else
            gRomDetection_IsEnglishROM = FALSE;
    }
}

u8 GetPlayerMapType(void)
{
    u8 retVal;

    if (!gRomDetection_IsRubySapphire)
    {
        retVal = *((u8 *)(gSaveBlock2Ptr) + gAgbPmRomParams->warpFlagsOffset);
    }
    else
    {
        retVal = GetRSPlayerMapType(gSaveBlock1Ptr);
        if (retVal & CONTINUE_GAME_WARP)
            retVal |= CHAMPION_SAVEWARP;
    }

    return retVal;
}

static void UNUSED EmptyFunction(void)
{

}

static u8 CheckIfPokedexIsObtained(void)
{
    bool32 val;

    if (!gRomDetection_IsRubySapphire)
        val = ((*((u8 *)(gSaveBlock2Ptr) + gAgbPmRomParams->gcnLinkFlagsOffset) & 1));
    else
        val = CheckFlag(FLAG_SYS_POKEDEX_GET);

    if (!val)
        return FALSE;
    else
        return TRUE;
}

static bool32 IsFRLG(void)
{
    if (gAgbPmRomParams->version == VERSION_FIRE_RED || gAgbPmRomParams->version == VERSION_LEAF_GREEN)
        return TRUE;
    else
        return FALSE;
}

static bool32 CheckGameClear(void)
{
    u8 *flagsPtr = gSaveBlock1Ptr + gAgbPmRomParams->flagsOffset + (gAgbPmRomParams->gameClearFlag / 8);

    return (*flagsPtr & (1 << (gAgbPmRomParams->gameClearFlag % 8))) != 0;
}

u16 GetStringSizeHandleExtCtrlCodes(u8 *str)
{
    u16 i = 0;

    while (str[i] != EOS)
    {
        if (str[i++] == EXT_CTRL_CODE_BEGIN)
            i += ExtCtrlCodeGetLength(str[i]);
    }

    return i;
}

// Needed to match.
static inline u8 *StringCopyInline(u8 *dst, const u8 *src)
{
    while (*src != EOS)
    {
        *dst = *src;
        dst++, src++;
    }

    *dst = EOS;

    return dst;
}

u8 *StringCopy(u8 *dst, const u8 *src)
{
    while (*src != EOS)
    {
        *dst = *src;
        dst++, src++;
    }

    *dst = EOS;

    return dst;
}

u8 *StringAppend(u8 *dst, const u8 *src)
{
    while (*dst != EOS)
        dst++;

    return StringCopyInline(dst, src);
}

s32 StringCompare(const u8 *str1, const u8 *str2)
{
    while (*str1 == *str2)
    {
        if (*str1 == EOS)
            return 0;

        str1++;
        str2++;
    }

    return *str1 - *str2;
}

static u8 ExtCtrlCodeGetLength(u8 c)
{
    u8 len = 0;

    if (c <= EXT_CTRL_CODE_ENG)
        len = gExtCtrlCodeLengths[c];

    return len;
}

static u8 GetRSPlayerMapType(struct SaveBlock1 *sav1)
{
    s32 i;
    u16 mapGroup = sav1->location.mapGroup;
    u16 map = (mapGroup << 8) + sav1->location.mapNum;

    for (i = 0; gRSPokemonCenterMaps[i] != MAP_UNDEFINED; i++)
    {
        if (gRSPokemonCenterMaps[i] == map)
            return POKECENTER_SAVEWARP;
    }

    for (i = 0; gRSSpecialAreaMaps[i] != MAP_UNDEFINED; i++)
    {
        if (gRSSpecialAreaMaps[i] == map)
            return LOBBY_SAVEWARP;
    }

    return 0;
}

static void sub_0200CF50(u32 val)
{
    u32 speciesLower1, speciesLower2, speciesUpper;

    switch (gTransferData.state)
    {
    case 0:
        gMonLinkData.monId = (u8)(val & 0x7);
        gTransferData.state++;
        break;
    case 1:
        gMonLinkData.species2 = val & 0xFFFF;

        // Weird bitwise operations needed to match.
        speciesLower1 = (val >> 16) & 0xFFFF;
        speciesLower2 = speciesLower1 & 0xFF;
        gMonLinkData.speciesLowerByte = speciesLower2;

        speciesUpper = (((val >> 16) & 0xFFFF) >> 8) & 0xFF;
        gMonLinkData.speciesUpperByte = speciesUpper;

        gMonLinkData.monPtr = (void*) &gPlayerPartyPtr[gMonLinkData.monId];
        gTransferData.transferSize = 100;
        gTransferData.transferBytes = 0;
        gTransferData.state++;
        break;
    case 2:
        gMonLinkData.monPtr[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            gTransferData.data = (void *) gMonLinkData.giftRibbons;
            gTransferData.transferSize = sizeof(gMonLinkData.giftRibbons);
            gTransferData.transferBytes = 0;
            gTransferData.state++;
        }
        break;
    case 3:
        gTransferData.data[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            gMonLinkData.transferComplete = 1;
            gTransferData.field17 = 0;
        }
        break;
    }
}

void sub_0200D08C(u32 val)
{
    s32 i;

    switch (gTransferData.state)
    {
    case 0:
        gTransferData.data[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            u32 partyCountNibbles = gMonLinkData.partyCountNibblefield;
            gMonLinkData.partyCount = 0;

            for (i = 0; i < PARTY_SIZE; i++)
            {
                if ((partyCountNibbles & 0xF) != 0xF)
                    gMonLinkData.partyCount++;
                partyCountNibbles >>= 4;
            }

            gTransferData.transferBytes = 0;
            gTransferData.data = (void *) gMonLinkData.monData;
            gTransferData.transferSize = gMonLinkData.partyCount * sizeof(struct MonData);
            gTransferData.state++;
        }
        break;
    case 1:
        gTransferData.data[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            gTransferData.transferBytes = 0;
            gTransferData.data = (void*) gMonLinkData.monName;
            gTransferData.transferSize = gMonLinkData.unk7 * sizeof(struct MonName);
            gTransferData.state++;
        }
        break;
    case 2:
        gTransferData.data[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            gTransferData.field17 = 0;
            gMonLinkData.unk_87A = 1;
        }
        break;
    }
}

static inline void CopyN(s32 n, u8 *dst, const u8 *src)
{
    while (n != 0)
    {
        *dst = *src;
        src++, dst++;
        n--;
    }
}

void sub_0200D1AC(u32 val)
{
    u8 *ptr = (u8 *)(gSaveBlock1Ptr) + gAgbPmRomParams->externalEventDataOffset;
    // Note: cast is needed here to make the code match. The whole struct is declared as volatile, but unkStruct isn't treated as volatile in this function.
    // It's possible only certain members of gMonLinkData were volatile.
    struct ExternalEventData2 *externalEventData = (struct ExternalEventData2 *) &gMonLinkData.externalEventData;

    switch (gTransferData.state)
    {
    case 0:
        externalEventData->currentPokeCoupons = val;
        gTransferData.state++;
        break;
    case 1:
        externalEventData->totalEarnedPokeCoupons = val;
        gTransferData.state++;
        break;
    case 2:
        externalEventData->receivedAgetoCelebi = 0;
        externalEventData->gotBronzePokeCouponTitleReward = 0;
        externalEventData->gotSilverPokeCouponTitleReward = 0;
        externalEventData->gotGoldPokeCouponTitleReward = 0;

        if (val & 1)
            externalEventData->gotGoldPokeCouponTitleReward = 1;

        if (val & 2)
            externalEventData->gotSilverPokeCouponTitleReward = 1;

        if (val & 4)
            externalEventData->gotBronzePokeCouponTitleReward = 1;

        if (val & 8)
            externalEventData->receivedAgetoCelebi = 1;

        CopyN(sizeof(*externalEventData), ptr, (void*) externalEventData);
        gTransferData.state++;
        break;
    case 3:
        gMonLinkData.species3 = val >> 16;
        gTransferData.transferSize = val & 0xFFFF;
        gTransferData.transferBytes = 0;
        gTransferData.data = (void *) gPcItemsPtr;
        gTransferData.state++;
        break;
    case 4:
        gTransferData.data[gTransferData.transferBytes++] = val;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            if (gMonLinkData.species3 == SPECIES_NONE)
            {
                gTransferData.field17 = 0;
                gMonLinkData.unk_85A = 1;
            }
            else
            {
                gTransferData.transferSize = 100;
                gTransferData.transferBytes = 0;
                gTransferData.data = (void *) GetPtrToEmptyPartySlot();
                gTransferData.state++;
            }
        }
        break;
    case 5:
        gTransferData.data[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            gTransferData.transferSize = sizeof(gMonLinkData.giftRibbons);
            gTransferData.transferBytes = 0;
            gTransferData.data = (void *) gMonLinkData.giftRibbons;
            gTransferData.state++;
        }
        break;
    case 6:
        gTransferData.data[gTransferData.transferBytes / 4] = val;
        gTransferData.transferBytes += 4;

        if (gTransferData.transferBytes >= gTransferData.transferSize)
        {
            gMonLinkData.unk_85A = 1;
            gTransferData.field17 = 0;
        }
        break;
    }
}

bool32 sub_0200D394(u32 val)
{
    u32 r3 = gTransferData.field12;

    if (r3 == 0)
    {
        if (gTransferData.field13 != 2)
        {
            RET_FALSE:
                return FALSE;
        }

        if (val == gTransferData.field40)
        {
            REG_JOYSTAT = 0x10;
            gTransferData.field36 = val;
            gTransferData.field12 = 1;
            gTransferData.field17 = 1;
        }
        else if (val == gTransferData.field44)
        {
            REG_JOYSTAT = r3;
            gTransferData.field36 = val;
            gTransferData.field12 = 1;
            gTransferData.field17 = 0;
        }
        else
        {
            return FALSE;
        }

        gTransferData.field13 = 0;
        gTransferData.field16 = 0;
        return TRUE;
    }
    else
    {
        s32 r6 = gTransferData.field17;

        switch (r6)
        {
        case 0:
            val >>= 24;
            if (val == 0xAA)
            {
                REG_JOY_TRANS = (gHeldKeys << 0x10) | val;
            }
            else if (val == 0x99)
            {
                gTransferData.data = (void *)GetPlayerLinkInfo();
                REG_JOY_TRANS = val;
                gTransferData.transferSize = 0x278;
                gTransferData.transferBytes = r6;
                gTransferData.field17 = 4;
            }
            else if (val == 0x88)
            {
                gTransferData.data = (void *) sub_0200CB34(0);
                SetUnknownBoolean(0);
                REG_JOY_TRANS = val;
                gTransferData.transferSize = 0x780;
                gTransferData.transferBytes = r6;
                gTransferData.field17 = val;
            }
            else if (val == 0x77)
            {
                REG_JOY_TRANS = val;
                gTransferData.field17 = val;
            }
            else if (val == 0x66)
            {
                REG_JOY_TRANS = val;
                gTransferData.field17 = val;
                gTransferData.data = (void*) &gMonLinkData;
                gTransferData.transferSize = 0x24;
                gTransferData.transferBytes = r6;
                gTransferData.state = r6;
                gMonLinkData.unk_87A = r6;
            }
            else if (val == 0x55)
            {
                gMonLinkData.unk84C_00 = 1;
                gMonLinkData.transferComplete = 0;
                REG_JOY_TRANS = val;
                gTransferData.field17 = val;
                gTransferData.state = r6;
            }
            else if (val == 0x44)
            {
                REG_JOY_TRANS = val;
                gTransferData.field17 = val;
                gMonLinkData.unk84C_02 = 1;
                gMonLinkData.unk84C_03 = 1;
            }
            else if (val == 0x33 || val == 0x22)
            {
                REG_JOY_TRANS = val;
                gTransferData.field17 = val;
                gTransferData.state = 0;
            }
            else if (val == 0x60)
            {
                REG_JOY_TRANS = val;
                REG_IME = 0;
                SoftResetRom(0);
            }
            else if (val == 0x61)
            {
                REG_JOY_TRANS = val;
                REG_IME = 0;
                SoftReset(0);
            }
            break;
        case 136:
            gTransferData.data[gTransferData.transferBytes / 4] = val;
            gTransferData.transferBytes += 4;

            if (gTransferData.transferBytes >= gTransferData.transferSize)
            {
                REG_JOYSTAT = 0;
                gTransferData.field17 = 0;
                gTransferData.field12 = 0;
                SetUnknownBoolean(1);
            }
            break;
        case 119:
            gMonLinkData.unk_858 = val >> 24;
            gMonLinkData.unk_859 = val;
            gMonLinkData.unk_878 = 1;
            gTransferData.field17 = 0;
            break;
        case 102:
            sub_0200D08C(val);
            break;
        case 85:
            sub_0200CF50(val);
            break;
        case 34:
            sub_0200D1AC(val);
            break;
        default:
            goto RET_FALSE; // return FALSE doesn't match
        }
    }
    return TRUE;
}

void sub_0200D624(void)
{
    bool32 gameClear;
    u32 joyTransVal;
    u8 *ptr = (u8 *)(gSaveBlock1Ptr) + gAgbPmRomParams->externalEventDataOffset;
    struct ExternalEventData2 *externalEventData = (struct ExternalEventData2 *) &gMonLinkData.externalEventData;

    switch (gTransferData.state)
    {
    case 0:
        CopyN(sizeof(*externalEventData), (void*) externalEventData, ptr);
        REG_JOY_TRANS = externalEventData->currentPokeCoupons;
        gTransferData.state++;
        break;
    case 1:
        REG_JOY_TRANS = externalEventData->totalEarnedPokeCoupons;
        gTransferData.state++;
        break;
    case 2:
        gameClear = CheckGameClear();
        joyTransVal = (externalEventData->gotGoldPokeCouponTitleReward << 0) | (externalEventData->gotSilverPokeCouponTitleReward << 1) | (externalEventData->gotBronzePokeCouponTitleReward << 2) | (externalEventData->receivedAgetoCelebi << 3) | (gameClear << 4);
        REG_JOY_TRANS = joyTransVal;
        gTransferData.state++;
        break;
    case 3:
        gTransferData.transferSize = gAgbPmRomParams->pcItemsCount;
        gTransferData.transferBytes = 0;
        joyTransVal = (*gPlayerPartyCountPtr << 16);
        joyTransVal |= gTransferData.transferSize;
        REG_JOY_TRANS = joyTransVal;
        gTransferData.data = (void *) gPcItemsPtr;
        gTransferData.state++;
        break;
    case 4:
        REG_JOY_TRANS = gTransferData.data[gTransferData.transferBytes++];

        if (gTransferData.transferBytes == gTransferData.transferSize)
        {
            gTransferData.field17 = 0;
            gTransferData.field12 = 0;
        }
        break;
    }
}

bool32 sub_0200D748(void)
{
    if (gTransferData.field12 == 0)
    {
        if (gTransferData.field13 == 1)
        {
            gTransferData.field13 = 2;
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        switch (gTransferData.field17)
        {
        case 4:
            if (gTransferData.transferBytes < gTransferData.transferSize)
            {
                REG_JOY_TRANS = gTransferData.data[gTransferData.transferBytes / 4];
                gTransferData.transferBytes += 4;
            }
            else
            {
                REG_JOYSTAT = 0;
                gTransferData.field17 = 0;
                gTransferData.field12 = 0;
            }
            break;
        case 0x33:
            sub_0200D624();
            break;
        case 0x44:
            gMonLinkData.unk84C_03 = 0;
            gTransferData.field17 = 0;
            break;
        case 0x55:
        case 0x66:
        case 0x60:
        case 0x77:
        case 0x88:
        case 0x22:
            break;
        default:
            return FALSE;
        }
    }
    return TRUE;
}

void sub_0200D80C(void)
{
    u32 joyCnt = REG_JOYCNT;

    if (!(joyCnt & 4) || sub_0200D748() != 0)
    {
        if (!(joyCnt & 2))
            goto loc_200D850;

        gTransferData.field11 = 1;

        if (sub_0200D394(REG_JOY_RECV) != 0)
            goto loc_200D850;
    }

    REG_JOYSTAT = 0;
    gTransferData.field12 = 0;
    gTransferData.field13 = 0;

loc_200D850:
    if (joyCnt & 1)
    {
        u16 UNUSED joyRcv = REG_JOY_RECV;
        REG_JOY_TRANS = gTransferData.field32;
        REG_JOYSTAT = 0;
        gTransferData.field12 = 0;
        gTransferData.field13 = 1;
        gTransferData.field20 = REG_VCOUNT;
    }

    REG_JOYCNT = joyCnt;
    gTransferData.field15 = 0;
}

void sub_0200D8A4(void)
{
    u16 UNUSED joyRcv;
    u16 ime = REG_IME;

    REG_IME = 0;
    if (gTransferData.field18 == 0)
        REG_RCNT = 0x8000;
    REG_RCNT = 0xC000;
    REG_JOYSTAT = 0;
    joyRcv = REG_JOY_RECV;
    REG_JOY_TRANS = 0;
    REG_JOYCNT = 0x47;
    REG_IF = 0x80;
    REG_IE |= 0x80;

    gTransferData.field15 = 0;
    gTransferData.field12 = 0;
    gTransferData.field13 = 0;
    gTransferData.field18 = 0;
    gTransferData.field17 = 0;
    gTransferData.field11 = 0;

    REG_IME = ime;
}

void sub_0200D924(const u8 *headerSth)
{
    s32 i;
    u16 ime = REG_IME;

    REG_IME = 0;

    for (i = 0; i < sizeof(gTransferData); i++)
    {
        *((u8 *)(&gTransferData) + i) = 0;
    }

    gTransferData.field18 = 1;
    sub_0200D8A4();
    REG_IE |= 0x80;

    if (headerSth[0] == 0x54 && headerSth[1] == 0x45 && headerSth[2] == 0x53 && headerSth[3] == 0x54)
        gTransferData.field14 = 0xFE;
    else
        gTransferData.field14 = 0x28;

    gTransferData.field32 = (headerSth[3] << 24) | (headerSth[2] << 16) | (headerSth[1] << 8) | (headerSth[0]);
    gTransferData.field44 = gTransferData.field32;
    gTransferData.field40 = gTransferData.field32 | 0x20202020;
    gTransferData.field48 = (headerSth[4] << 24) | (headerSth[5] << 16) | (headerSth[6] << 8) | (headerSth[7]);
    SetIntrFunc(0, sub_0200D80C);

    REG_IME = ime;
}

bool32 sub_0200D9EC(void)
{
    if (*(u8*)(0x80000B2) != 0x96)
        SoftReset(0);

    if (gTransferData.field15 <= gTransferData.field14)
    {
        REG_IME = 0;
        gTransferData.field15++;
        REG_IME = 1;
        return FALSE;
    }

    gTransferData.field16 = 1;
    SoftReset(0);
}

void UNUSED sub_0200DA38(u8 *dst, const u8 *src, s32 n)
{
    CopyN(n, dst, src);
}
