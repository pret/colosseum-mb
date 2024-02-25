#include "global.h"
#include "libpmagb/agb_rom.h"
#include "libpmagb/save.h"

u16 gSaveRngValue;
void * gSaveBlock1Ptr;
void * gSaveBlock1BakPtr;
void * gSaveBlock2Ptr;
struct PokemonStorage * gPokemonStoragePtr;
struct Pokemon * gPlayerPartyPtr;
struct Pokemon * gPlayerPartyBakPtr;
u8 * gPlayerPartyCountPtr;
struct Pokedex * gPokedexPtr;
u8 * gDexSeen2Ptr;
u8 * gDexSeen3Ptr;
struct ItemSlot * gPcItemsPtr;
u8 * gFlagsPtr;
u16 * gVarsPtr;
u8 * gGiftRibbonsPtr;
struct EnigmaBerry * gEnigmaBerryPtr;

static u16 SaveRandom(void);

void * gLastSaveBlockPtr;
u8 gSaveBlockLoadRegions[0xE000];

static inline void SeedSaveRng(void)
{
    u8 * firstSector;
    s32 sum;
    s32 i;

    firstSector = ReadFirstSaveSector();

    for (sum = 0, i = 0; i < 0x1000; i++)
    {
        sum += firstSector[i];
    }

    gLastSaveBlockPtr = gSaveBlockLoadRegions + 4 * (sum & 0xFF);
    gSaveRngValue = sum;

    for (i = 0; i < (sum & 0xFF); i++)
    {
        SaveRandom();
    }
}

static inline void * UpdateSaveBlockPtr(u32 size)
{
    void * ret = gLastSaveBlockPtr;

    gLastSaveBlockPtr = (gLastSaveBlockPtr + size) + ((SaveRandom() & 15) * 4);

    return ret;
}

static inline void SetSaveBlockPtr(void ** dest, u32 size)
{
    *dest = UpdateSaveBlockPtr(size);
}

static inline void SetSaveBlock1Ptr(void)
{
    void ** ptr = (void**)&gSaveBlock1Ptr;
    u32 size = gAgbPmRomParams->saveBlock1Size;

    SetSaveBlockPtr(ptr, size);
}

static inline void SetSaveBlock1BakPtr(void)
{
    void ** ptr = (void**)&gSaveBlock1BakPtr;
    u32 size = gAgbPmRomParams->saveBlock1Size;

    SetSaveBlockPtr(ptr, size);
}

static inline void SetSaveBlock2Ptr(void)
{
    void ** ptr = (void**)&gSaveBlock2Ptr;
    u32 size = gAgbPmRomParams->saveBlock2Size;

    SetSaveBlockPtr(ptr, size);
}

static inline void SetPokemonStoragePtr(void)
{
    void ** ptr = (void**)&gPokemonStoragePtr;
    u32 size = sizeof(struct PokemonStorage);

    SetSaveBlockPtr(ptr, size);
}

void SaveBlocksInit(void)
{
    SeedSaveRng();

    switch (SaveRandom() & 3)
    {
    case 0:
        SetSaveBlock1Ptr();
        SetSaveBlock2Ptr();
        SetPokemonStoragePtr();
        SetSaveBlock1BakPtr();
        break;
    case 1:
        SetPokemonStoragePtr();
        SetSaveBlock1BakPtr();
        SetSaveBlock1Ptr();
        SetSaveBlock2Ptr();
        break;
    case 2:
        SetSaveBlock2Ptr();
        SetSaveBlock1Ptr();
        SetSaveBlock1BakPtr();
        SetPokemonStoragePtr();
        break;
    case 3:
        SetSaveBlock1BakPtr();
        SetPokemonStoragePtr();
        SetSaveBlock2Ptr();
        SetSaveBlock1Ptr();
        break;
    }

    gPlayerPartyPtr = gSaveBlock1Ptr + gAgbPmRomParams->partyOffset;
    gPlayerPartyBakPtr = gSaveBlock1BakPtr + gAgbPmRomParams->partyOffset;
    gPlayerPartyCountPtr = gSaveBlock1Ptr + gAgbPmRomParams->partyCountOffset;
    gPokedexPtr = gSaveBlock2Ptr + gAgbPmRomParams->pokedexOffset;
    gDexSeen2Ptr = gSaveBlock1Ptr + gAgbPmRomParams->seen1Offset;
    gDexSeen3Ptr = gSaveBlock1Ptr + gAgbPmRomParams->seen2Offset;
    gFlagsPtr = gSaveBlock1Ptr + gAgbPmRomParams->flagsOffset;
    gVarsPtr = gSaveBlock1Ptr + gAgbPmRomParams->varsOffset;
    gGiftRibbonsPtr = gSaveBlock1Ptr + gAgbPmRomParams->giftRibbonsOffset;
    gEnigmaBerryPtr = gSaveBlock1Ptr + gAgbPmRomParams->enigmaBerryOffset;
    gPcItemsPtr = gSaveBlock1Ptr + gAgbPmRomParams->pcItemsOffset;
}

static u16 SaveRandom(void)
{
    gSaveRngValue = gSaveRngValue * 2061 + 7;

    return gSaveRngValue;
}

void * UNUSED UpdateSaveBlockPtr_(u32 size)
{
    return UpdateSaveBlockPtr(size);
}
