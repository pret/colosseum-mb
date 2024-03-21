#include "global.h"
#include "libpmagb/agb_rom.h"
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

        if (!gAgbPmRomParams->blockLinkColoXD)
        {
            structPtr->field0_0 = sub_0200CD88();
            structPtr->field0_1 = ((GetPlayerMapType() & 2) != 0);
            structPtr->field0_2 = IsFRLG();
            structPtr->field0_3 = ((GetPlayerMapType() & 0x80) != 0);
            structPtr->field0_4 = gAgbPmRomParams->language;
        }
        saveData = &sav2[gAgbPmRomParams->playerNameOffset];
        StringCopy(structPtr->field4, saveData);

        saveData = &sav2[gAgbPmRomParams->playerGenderOffset];
        structPtr->field12 = *saveData;

        saveData = &sav2[gAgbPmRomParams->trainerIdOffset];
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

u8 *sub_0200CB34(u32 id)
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

extern void SoftResetRom(u32);
extern void SoftReset(u32);

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
        if (gAgbPmRomParams->language == LANGUAGE_ENGLISH)
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
        ret = *((u8 *)(gSaveBlock2Ptr) + gAgbPmRomParams->warpFlagsOffset);
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
        val = ((*((u8 *)(gSaveBlock2Ptr) + gAgbPmRomParams->gcnLinkFlagsOffset) & 1));
    else
        val = CheckFlag(0x801);

    if (!val)
        return FALSE;
    else
        return TRUE;
}

bool32 IsFRLG(void)
{
    if (gAgbPmRomParams->version == VERSION_FIRE_RED || gAgbPmRomParams->version == VERSION_LEAF_GREEN)
        return TRUE;
    else
        return FALSE;
}

bool32 CheckGameClear(void)
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

void sub_0200CF50(u32 val)
{
    u32 a, b, c;
    switch (gUnknown_020251F0.field10)
    {
    case 0:
        gUnknown_02024960.unk84C_1 = (u8)(val & 0x7);
        gUnknown_020251F0.field10++;
        break;
    case 1:
        gUnknown_02024960.unk84C_2 = val & 0x0000FFFF;

        // Weird bitwise operations needed to match.
        a = (val >> 16) & 0xFFFF;
        b = a & 0xFF;
        gUnknown_02024960.unk84C_3 = b;

        c = (((val >> 16) & 0xFFFF) >> 8) & 0xFF;
        gUnknown_02024960.unk850_1 = c;

        gUnknown_02024960.field854 = (void*) &gPlayerPartyPtr[gUnknown_02024960.unk84C_1];
        gUnknown_020251F0.field4 = 100;
        gUnknown_020251F0.field28 = 0;
        gUnknown_020251F0.field10++;
        break;
    case 2:
        gUnknown_02024960.field854[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_020251F0.field0 = (void *) gUnknown_02024960.field85C;
            gUnknown_020251F0.field4 = sizeof(gUnknown_02024960.field85C);
            gUnknown_020251F0.field28 = 0;
            gUnknown_020251F0.field10++;
        }
        break;
    case 3:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_02024960.unk84C_01 = 1;
            gUnknown_020251F0.field17 = 0;
        }
        break;
    }
}

void sub_0200D08C(u32 val)
{
    s32 i;
    switch (gUnknown_020251F0.field10)
    {
    case 0:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            u32 r3 = gUnknown_02024960.unk_00;
            gUnknown_02024960.unk_879 = 0;
            for (i = 0; i < 6; i++)
            {
                if ((r3 & 0xF) != 0xF)
                    gUnknown_02024960.unk_879++;
                r3 >>= 4;
            }
            gUnknown_020251F0.field28 = 0;
            gUnknown_020251F0.field0 = (void *) gUnknown_02024960.unk24;
            gUnknown_020251F0.field4 = gUnknown_02024960.unk_879 * 340;
            gUnknown_020251F0.field10++;
        }
        break;
    case 1:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_020251F0.field28 = 0;
            gUnknown_020251F0.field0 = (void*) gUnknown_02024960.unk81C;
            gUnknown_020251F0.field4 = gUnknown_02024960.unk7 * sizeof(struct UnkStruct81C);
            gUnknown_020251F0.field10++;
        }
        break;
    case 2:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_020251F0.field17 = 0;
            gUnknown_02024960.unk_87A = 1;
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
    // It's possible only certain members of gUnknown_02024960 were volatile.
    struct UnkStruct868 *unkStruct = (struct UnkStruct868 *) &gUnknown_02024960.unk868;

    switch (gUnknown_020251F0.field10)
    {
    case 0:
        unkStruct->a8_0 = val;
        gUnknown_020251F0.field10++;
        break;
    case 1:
        unkStruct->a12 = val;
        gUnknown_020251F0.field10++;
        break;
    case 2:
        unkStruct->a11_3 = 0;
        unkStruct->a11_2 = 0;
        unkStruct->a11_1 = 0;
        unkStruct->a11_0 = 0;
        if (val & 1)
            unkStruct->a11_0 = 1;
        if (val & 2)
            unkStruct->a11_1 = 1;
        if (val & 4)
            unkStruct->a11_2 = 1;
        if (val & 8)
            unkStruct->a11_3 = 1;

        CopyN(sizeof(*unkStruct), ptr, (void*) unkStruct);
        gUnknown_020251F0.field10++;
        break;
    case 3:
        gUnknown_02024960.unk_85B = val >> 16;
        gUnknown_020251F0.field4 = val & 0xFFFF;
        gUnknown_020251F0.field28 = 0;
        gUnknown_020251F0.field0 = (void *) gPcItemsPtr;
        gUnknown_020251F0.field10++;
        break;
    case 4:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28++] = val;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            if (gUnknown_02024960.unk_85B == 0)
            {
                gUnknown_020251F0.field17 = 0;
                gUnknown_02024960.unk_85A = 1;
            }
            else
            {
                gUnknown_020251F0.field4 = 100;
                gUnknown_020251F0.field28 = 0;
                gUnknown_020251F0.field0 = (void *) GetPtrToEmptyPartySlot();
                gUnknown_020251F0.field10++;
            }
        }
        break;
    case 5:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_020251F0.field4 = sizeof(gUnknown_02024960.field85C);
            gUnknown_020251F0.field28 = 0;
            gUnknown_020251F0.field0 = (void *) gUnknown_02024960.field85C;
            gUnknown_020251F0.field10++;
        }
        break;
    case 6:
        gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
        gUnknown_020251F0.field28 += 4;
        if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
        {
            gUnknown_02024960.unk_85A = 1;
            gUnknown_020251F0.field17 = 0;
        }
        break;
    }
}

bool32 sub_0200D394(u32 val)
{
    u32 r3 = gUnknown_020251F0.field12;
    if (r3 == 0)
    {
        if (gUnknown_020251F0.field13 != 2)
        {
            RET_FALSE:
                return FALSE;
        }

        if (val == gUnknown_020251F0.field40)
        {
            REG_JOYSTAT = 0x10;
            gUnknown_020251F0.field36 = val;
            gUnknown_020251F0.field12 = 1;
            gUnknown_020251F0.field17 = 1;
        }
        else if (val == gUnknown_020251F0.field44)
        {
            REG_JOYSTAT = r3;
            gUnknown_020251F0.field36 = val;
            gUnknown_020251F0.field12 = 1;
            gUnknown_020251F0.field17 = 0;
        }
        else
        {
            return FALSE;
        }

        gUnknown_020251F0.field13 = 0;
        gUnknown_020251F0.field16 = 0;
        return TRUE;
    }
    else
    {
        s32 r6 = gUnknown_020251F0.field17;
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
                gUnknown_020251F0.field0 = (void *)sub_0200CB2C();
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field4 = 0x278;
                gUnknown_020251F0.field28 = r6;
                gUnknown_020251F0.field17 = 4;
            }
            else if (val == 0x88)
            {
                gUnknown_020251F0.field0 = (void *) sub_0200CB34(0);
                sub_0200CB48(0);
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field4 = 0x780;
                gUnknown_020251F0.field28 = r6;
                gUnknown_020251F0.field17 = val;
            }
            else if (val == 0x77)
            {
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field17 = val;
            }
            else if (val == 0x66)
            {
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field17 = val;
                gUnknown_020251F0.field0 = (void*) &gUnknown_02024960;
                gUnknown_020251F0.field4 = 0x24;
                gUnknown_020251F0.field28 = r6;
                gUnknown_020251F0.field10 = r6;
                gUnknown_02024960.unk_87A = r6;
            }
            else if (val == 0x55)
            {
                gUnknown_02024960.unk84C_00 = 1;
                gUnknown_02024960.unk84C_01 = 0;
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field17 = val;
                gUnknown_020251F0.field10 = r6;
            }
            else if (val == 0x44)
            {
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field17 = val;
                gUnknown_02024960.unk84C_02 = 1;
                gUnknown_02024960.unk84C_03 = 1;
            }
            else if (val == 0x33 || val == 0x22)
            {
                REG_JOY_TRANS = val;
                gUnknown_020251F0.field17 = val;
                gUnknown_020251F0.field10 = 0;
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
            gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4] = val;
            gUnknown_020251F0.field28 += 4;
            if (gUnknown_020251F0.field28 >= gUnknown_020251F0.field4)
            {
                REG_JOYSTAT = 0;
                gUnknown_020251F0.field17 = 0;
                gUnknown_020251F0.field12 = 0;
                sub_0200CB48(1);
            }
            break;
        case 119:
            gUnknown_02024960.unk_858 = val >> 24;
            gUnknown_02024960.unk_859 = val;
            gUnknown_02024960.unk_878 = 1;
            gUnknown_020251F0.field17 = 0;
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
    struct UnkStruct868 *unkStruct = (struct UnkStruct868 *) &gUnknown_02024960.unk868;

    switch (gUnknown_020251F0.field10)
    {
    case 0:
        CopyN(sizeof(*unkStruct), (void*) unkStruct, ptr);
        REG_JOY_TRANS = unkStruct->a8_0;
        gUnknown_020251F0.field10++;
        break;
    case 1:
        REG_JOY_TRANS = unkStruct->a12;
        gUnknown_020251F0.field10++;
        break;
    case 2:
        gameClear = CheckGameClear();
        joyTransVal = (unkStruct->a11_0 << 0) | (unkStruct->a11_1 << 1) | (unkStruct->a11_2 << 2) | (unkStruct->a11_3 << 3) | (gameClear << 4);
        REG_JOY_TRANS = joyTransVal;
        gUnknown_020251F0.field10++;
        break;
    case 3:
        gUnknown_020251F0.field4 = gAgbPmRomParams->pcItemsCount;
        gUnknown_020251F0.field28 = 0;
        joyTransVal = (*gPlayerPartyCountPtr << 16);
        joyTransVal |= gUnknown_020251F0.field4;
        REG_JOY_TRANS = joyTransVal;
        gUnknown_020251F0.field0 = (void *) gPcItemsPtr;
        gUnknown_020251F0.field10++;
        break;
    case 4:
        REG_JOY_TRANS = gUnknown_020251F0.field0[gUnknown_020251F0.field28++];
        if (gUnknown_020251F0.field28 == gUnknown_020251F0.field4)
        {
            gUnknown_020251F0.field17 = 0;
            gUnknown_020251F0.field12 = 0;
        }
        break;
    }
}

bool32 sub_0200D748(void)
{
    if (gUnknown_020251F0.field12 == 0)
    {
        if (gUnknown_020251F0.field13 == 1)
        {
            gUnknown_020251F0.field13 = 2;
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        switch (gUnknown_020251F0.field17)
        {
        case 4:
            if (gUnknown_020251F0.field28 < gUnknown_020251F0.field4)
            {
                REG_JOY_TRANS = gUnknown_020251F0.field0[gUnknown_020251F0.field28 / 4];
                gUnknown_020251F0.field28 += 4;
            }
            else
            {
                REG_JOYSTAT = 0;
                gUnknown_020251F0.field17 = 0;
                gUnknown_020251F0.field12 = 0;
            }
            break;
        case 0x33:
            sub_0200D624();
            break;
        case 0x44:
            gUnknown_02024960.unk84C_03 = 0;
            gUnknown_020251F0.field17 = 0;
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
        gUnknown_020251F0.field11 = 1;
        if (sub_0200D394(REG_JOY_RECV) != 0)
            goto loc_200D850;
    }

    REG_JOYSTAT = 0;
    gUnknown_020251F0.field12 = 0;
    gUnknown_020251F0.field13 = 0;

loc_200D850:
    if (joyCnt & 1)
    {
        u16 UNUSED joyRcv = REG_JOY_RECV;
        REG_JOY_TRANS = gUnknown_020251F0.field32;
        REG_JOYSTAT = 0;
        gUnknown_020251F0.field12 = 0;
        gUnknown_020251F0.field13 = 1;
        gUnknown_020251F0.field20 = REG_VCOUNT;
    }

    REG_JOYCNT = joyCnt;
    gUnknown_020251F0.field15 = 0;
}

void sub_0200D8A4(void)
{
    u16 UNUSED joyRcv;
    u16 ime = REG_IME;

    REG_IME = 0;
    if (gUnknown_020251F0.field18 == 0)
        REG_RCNT = 0x8000;
    REG_RCNT = 0xC000;
    REG_JOYSTAT = 0;
    joyRcv = REG_JOY_RECV;
    REG_JOY_TRANS = 0;
    REG_JOYCNT = 0x47;
    REG_IF = 0x80;
    REG_IE |= 0x80;

    gUnknown_020251F0.field15 = 0;
    gUnknown_020251F0.field12 = 0;
    gUnknown_020251F0.field13 = 0;
    gUnknown_020251F0.field18 = 0;
    gUnknown_020251F0.field17 = 0;
    gUnknown_020251F0.field11 = 0;

    REG_IME = ime;
}

void sub_0200D924(const u8 *headerSth)
{
    s32 i;
    u16 ime = REG_IME;

    REG_IME = 0;
    for (i = 0; i < sizeof(gUnknown_020251F0); i++)
    {
        *((u8 *)(&gUnknown_020251F0) + i) = 0;
    }
    gUnknown_020251F0.field18 = 1;
    sub_0200D8A4();
    REG_IE |= 0x80;
    if (headerSth[0] == 0x54 && headerSth[1] == 0x45 && headerSth[2] == 0x53 && headerSth[3] == 0x54)
        gUnknown_020251F0.field14 = 0xFE;
    else
        gUnknown_020251F0.field14 = 0x28;
    gUnknown_020251F0.field32 = (headerSth[3] << 24) | (headerSth[2] << 16) | (headerSth[1] << 8) | (headerSth[0]);
    gUnknown_020251F0.field44 = gUnknown_020251F0.field32;
    gUnknown_020251F0.field40 = gUnknown_020251F0.field32 | 0x20202020;
    gUnknown_020251F0.field48 = (headerSth[4] << 24) | (headerSth[5] << 16) | (headerSth[6] << 8) | (headerSth[7]);
    SetIntrFunc(0, sub_0200D80C);

    REG_IME = ime;
}

bool32 sub_0200D9EC(void)
{
    if (*(u8*)(0x80000B2) != 0x96)
        SoftReset(0);

    if (gUnknown_020251F0.field15 <= gUnknown_020251F0.field14)
    {
        REG_IME = 0;
        gUnknown_020251F0.field15++;
        REG_IME = 1;
        return FALSE;
    }

    gUnknown_020251F0.field16 = 1;
    SoftReset(0);
}

void UNUSED sub_0200DA38(u8 *dst, const u8 *src, s32 n)
{
    CopyN(n, dst, src);
}
