#include "global.h"
#include "libpmagb/agb_rom.h"
#include "gflib/characters.h"
#include "pokeball.h"
#include "all.h"
#include "pokedex.h"
#include "mb_20094A8.h"
#include "unk_200C5DC.h"
#include "rom_info.h"
#include "constants/items.h"

// This file's functions
u8 GetPlayerMapType(void);
u8 USRom_GetPlayerMapType(struct SaveBlock1 *sav1);
bool8 sub_0200CD88(void);
bool32 IsFRLG(void);
u8 ExtCtrlCodeGetLength(u8 c);

u8 ItemIdToBallId(u16 ballItem)
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
                retVal = TRUE;
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
                retVal = TRUE;
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

u16 SpeciesToNationalDexNum(u16 species)
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

struct Struct_gUnknown_02023F50
{
    u32 field0_0:1;
    u32 field0_1:1;
    u32 field0_2:1;
    u32 field0_3:1;
    u32 field0_4:4;
    u32 field1_0:2;
    u32 unused:15;
    u8 field4[8];
    u32 field12;
    u8 field16[4];
    struct Pokemon party[PARTY_SIZE];
    u8 giftRibbons[11];
};

extern struct Struct_gUnknown_02023F50 gUnknown_02023F50;

struct Struct_gUnknown_02023F50 *sub_0200C9C0(u8 *sav2, u8 *sav1, u32 arg2)
{
    s32 i;
    struct Struct_gUnknown_02023F50* structPtr = &gUnknown_02023F50;

    CpuFill16(0, &gUnknown_02023F50, sizeof(struct Struct_gUnknown_02023F50));
    if (arg2 == 1)
    {
        u8 *saveData;

        if (!gAgbPmRomParams->unkB8_1)
        {
            structPtr->field0_0 = sub_0200CD88();
            structPtr->field0_1 = ((GetPlayerMapType() & 2) != 0);
            structPtr->field0_2 = IsFRLG();
            structPtr->field0_3 = ((GetPlayerMapType() & 0x80) != 0);
            structPtr->field0_4 = gAgbPmRomParams->gameLanguage;
        }
        saveData = &sav2[gAgbPmRomParams->sb2PlayerNameOffs];
        StringCopy(structPtr->field4, saveData);

        saveData = &sav2[gAgbPmRomParams->sb2PlayerGenderOffs];
        structPtr->field12 = *saveData;

        saveData = &sav2[gAgbPmRomParams->sb2PlayerIdOffs];
        for (i = 0; i < 4; i++)
            structPtr->field16[i] = saveData[i];

        for (i = 0; i < PARTY_SIZE; i++)
            CpuCopy16(&gPlayerPartyPtr[i], &structPtr->party[i], sizeof(struct Pokemon));
        for (i = 0; i < 11; i++)
            structPtr->giftRibbons[i] = gGiftRibbonsPtr[i];
    }
    else if (arg2 == 2)
    {
        structPtr->field1_0 = 1;
    }
    else if (arg2 == 0xFF)
    {
        structPtr->field1_0 = 2;
    }
    else if (arg2 == 0)
    {
        structPtr->field1_0 = 3;
    }
    return structPtr;
}

struct Struct_gUnknown_02023F50 *sub_0200CB2C(void)
{
    return &gUnknown_02023F50;
}

extern u8 gUnknown_020241D0[][320];
extern u8 gUnknown_02024950;

void *sub_0200CB34(u32 id)
{
    return gUnknown_020241D0[id];
}

void sub_0200CB48(u32 val)
{
    gUnknown_02024950 = val;
}

u32 sub_0200CB54(void)
{
    return gUnknown_02024950;
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

bool32 ClearFlag(s32 flag)
{
    u8 *flagPtr;

    if (flag == 0)
        return FALSE;

    flagPtr = &gFlagsPtr[flag / 8];
    if (flagPtr != NULL)
        *flagPtr &= ~(1 << (flag % 8));
    return FALSE;
}

bool32 CheckFlag(s32 flag)
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

void DetectROM(void)
{
    u32 val, r4, r3;

    gRomDetection_IsRubySapphire = FALSE;
    gRomDetection_IsEnglishROM = FALSE;
    r4 = 0;
    val = *(u32 *)(0x80000AC);
    switch (val)
    {
    default:
        r3 = TRUE;
        gRomDetection_IsEnglishROM = TRUE;
        break;
    case 0x45565841: // AXVE
        gRomDetection_IsEnglishROM = TRUE;
        r4 = 2;
        r3 = FALSE;
        gRomDetection_IsRubySapphire = TRUE;
        break;
    case 0x45505841: // AXPE
        gRomDetection_IsEnglishROM = TRUE;
        r4 = 1;
        r3 = FALSE;
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
        r3 = TRUE;
        gRomDetection_IsRubySapphire = TRUE;
        break;
    }

    if (r3)
    {
        gAgbPmRomParams = (void*)(0x8000100);
    }
    else if (r4 == 2)
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

    if (r3 == 1)
    {
        if (gAgbPmRomParams->gameLanguage == LANGUAGE_ENGLISH)
            gRomDetection_IsEnglishROM = TRUE;
        else
            gRomDetection_IsEnglishROM = FALSE;
    }
}

u8 GetPlayerMapType(void)
{
    u8 ret;
    if (!gRomDetection_IsRubySapphire)
    {
        ret = *((u8 *)(gSaveBlock2Ptr) + gAgbPmRomParams->sb2SpecialSaveWarpOffs);
    }
    else
    {
        ret = USRom_GetPlayerMapType(gSaveBlock1Ptr);
        if (ret & 1)
            ret |= 0x80;
    }
    return ret;
}

static void UNUSED sub_0200CD84(void)
{

}

u8 sub_0200CD88(void)
{
    bool32 val;
    if (!gRomDetection_IsRubySapphire)
        val = ((*((u8 *)(gSaveBlock2Ptr) + gAgbPmRomParams->gcnLinkFlagsOffs) & 1));
    else
        val = CheckFlag(0x801);

    if (!val)
        return FALSE;
    else
        return TRUE;
}

bool32 IsFRLG(void)
{
    if (gAgbPmRomParams->gameVersion == VERSION_FIRE_RED || gAgbPmRomParams->gameVersion == VERSION_LEAF_GREEN)
        return TRUE;
    else
        return FALSE;
}

bool32 CheckGameClear(void)
{
    u8 *flagsPtr = gSaveBlock1Ptr + gAgbPmRomParams->flagsOffs + (gAgbPmRomParams->sysGameClearFlagIdx / 8);
    return (*flagsPtr & (1 << (gAgbPmRomParams->sysGameClearFlagIdx % 8))) != 0;
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

u8 ExtCtrlCodeGetLength(u8 c)
{
    u8 len = 0;
    if (c <= 22)
        len = gExtCtrlCodeLengths[c];
    return len;
}

u8 USRom_GetPlayerMapType(struct SaveBlock1 *sav1)
{
    s32 i;
    u16 mapGroup = sav1->location.mapGroup;
    u16 map = (mapGroup << 8) + sav1->location.mapNum;

    for (i = 0; gRSPokemonCenterMaps[i] != 0xFFFF; i++)
    {
        if (gRSPokemonCenterMaps[i] == map)
            return 2;
    }
    for (i = 0; gRSSpecialAreaMaps[i] != 0xFFFF; i++)
    {
        if (gRSSpecialAreaMaps[i] == map)
            return 4;
    }
    return 0;
}

struct UnkStruct_020251F0
{
    u8 unk0[4];
    u32 field4;
    u8 field8[2];
    vu8 field10;
    u8 unk11[15];
    u32 field28;
};

extern volatile struct UnkStruct_020251F0 gUnknown_020251F0;
/*
void sub_0200CF50(u32 val)
{
    switch (gUnknown_020251F0.field10)
    {
    case 0:
        gUnknown_02024960.unk84C_1 = val & 7;
        gUnknown_020251F0.field10++;
        break;
    case 1:
        gUnknown_02024960.unk84C_2 = val & 0x0000FFFF;
        gUnknown_02024960.unk84C_3 = ((val >> 16) & 0xFFFF);
        gUnknown_02024960.unk850_1 = ((val >> 24) & 0xFFFF);
        gUnknown_02024960.field854 = &gPlayerPartyPtr[gUnknown_02024960.unk84C_1];
        gUnknown_020251F0.field4 = 100;
        gUnknown_020251F0.field28 = 0;
        gUnknown_020251F0.field10++;
        break;
    case 2:
        gUnknown_02024960.field854
        gUnknown_020251F0.field4 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_020251F0.field4 = 0;
            gUnknown_020251F0.field28 = 0;
            gUnknown_020251F0.field10++;
        }
        break;
    case 3:
        gUnknown_020251F0.field10++;
        break;
    }
}
*/
