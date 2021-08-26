#include "global.h"
#include "gflib/types.h"
#include "gflib/save.h"
#include "gflib/agb_rom.h"
#include "gba/flash_internal.h"

struct SaveBlockChunk
{
    u8 *data;
    u16 size;
};

struct SaveSector
{
    u8 data[0xFF4];
    u16 id;
    u16 checksum;
    u32 signature;
    u32 counter;
}; // size is 0x1000


// Each 4 KiB flash sector contains 3968 bytes of actual data followed by a 128 byte footer
#define SECTOR_DATA_SIZE 3968u
#define SECTOR_FOOTER_SIZE 128

#define HALL_OF_FAME_SECTOR 28

#define NUM_SECTORS_PER_SAVE_SLOT 14  // Number of sectors occupied by a save slot
#define NUM_HALL_OF_FAME_SECTORS 2

#define SAVEBLOCK_CHUNK_EX(structure, size, chunkNum)         \
{                                                             \
    (u8 *)structure + chunkNum * SECTOR_DATA_SIZE,            \
    min(size - chunkNum * SECTOR_DATA_SIZE, SECTOR_DATA_SIZE) \
}                                                             \

#define SAVEBLOCK_CHUNK(structure, chunkNum) SAVEBLOCK_CHUNK_EX(&structure, sizeof(structure), chunkNum)

struct SaveBlockChunk sSaveBlockChunks[] = {
    {(u8 *)&gSaveBlock2Ptr, 0x00000004},
    {(u8 *)&gSaveBlock1Ptr + SECTOR_DATA_SIZE * 0, SECTOR_DATA_SIZE},
    {(u8 *)&gSaveBlock1Ptr + SECTOR_DATA_SIZE * 1, SECTOR_DATA_SIZE},
    {(u8 *)&gSaveBlock1Ptr + SECTOR_DATA_SIZE * 2, SECTOR_DATA_SIZE},
    {(u8 *)&gSaveBlock1Ptr + SECTOR_DATA_SIZE * 3, 0x0c40},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 0, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 1, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 2, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 3, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 4, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 5, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 6, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 7, SECTOR_DATA_SIZE},
    {(u8 *)&gPokemonStoragePtr + SECTOR_DATA_SIZE * 8, 0x0004},
};

u16 gFirstSaveSector;
u32 gPrevSaveCounter;
u16 gLastKnownGoodSector;
u32 gDamagedSaveSectors;
u32 gSaveCounter;
struct SaveSector *gFastSaveSection; // the pointer is in fast IWRAM but may sometimes point to the slower EWRAM.
u16 gUnknown_03005EB4;
u16 gSaveFileStatus;
u32 gGameContinueCallback;
extern u32 gSaveValidStatus;
extern u8 sWipeTries;

s32 sub_020098D8(u32 timerNum, IntrFunc * intrFunc)
{
    sSaveBlockChunks[0].size = gAgbPmRomParams->saveBlock2Size;
    sSaveBlockChunks[4].size = gAgbPmRomParams->saveBlock1Size % SECTOR_DATA_SIZE;
    sSaveBlockChunks[13].size = sizeof(struct PokemonStorage) % SECTOR_DATA_SIZE;

    if (!IdentifyFlash() && !SetFlashTimerIntr(timerNum, intrFunc))
    {
        gSaveCounter = 0;
        gFirstSaveSector = 0;
        gDamagedSaveSectors = 0;
        gSaveValidStatus = 0x80;
        return 0;
    }
    return -1;

}
