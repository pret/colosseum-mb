#include "global.h"
#include "gflib/types.h"
#include "gflib/save.h"
#include "gflib/agb_rom.h"
#include "gba/flash_internal.h"

#define FILE_SIGNATURE 0x08012025  // signature value to determine if a sector is in use

//#define TOTAL_FLASH_SECTORS ((ARRAY_COUNT(sSaveBlockChunks) * 2) + (ARRAY_COUNT(sHallOfFameChunks) * 2)) // there are 2 slots, so double each array count and get the sum.
#define TOTAL_FLASH_SECTORS 32

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

void SetSaveSectorPtrs(void)
{
    sSaveBlockChunks[0].data = gSaveBlock2Ptr;
    sSaveBlockChunks[1].data = gSaveBlock1Ptr + 0 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[2].data = gSaveBlock1Ptr + 1 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[3].data = gSaveBlock1Ptr + 2 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[4].data = gSaveBlock1Ptr + 3 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[5].data = (void *)gPokemonStoragePtr + 0 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[6].data = (void *)gPokemonStoragePtr + 1 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[7].data = (void *)gPokemonStoragePtr + 2 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[8].data = (void *)gPokemonStoragePtr + 3 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[9].data = (void *)gPokemonStoragePtr + 4 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[10].data = (void *)gPokemonStoragePtr + 5 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[11].data = (void *)gPokemonStoragePtr + 6 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[12].data = (void *)gPokemonStoragePtr + 7 * SECTOR_DATA_SIZE;
    sSaveBlockChunks[13].data = (void *)gPokemonStoragePtr + 8 * SECTOR_DATA_SIZE;
}

static inline u16 CalculateChecksum(void * data, s32 size)
{
    s32 i;
    u32 checksum = 0;

    for (i = 0; i < (size / 4); i++)
    {
        checksum += *((u32 *)data);
        data += sizeof(u32);
    }

    return ((checksum >> 16) + checksum);
}

static inline void DoReadFlashWholeSection(u8 sector, void * dest)
{
    ReadFlash(sector, 0, dest, sizeof(struct SaveSector));
}

u8 GetSaveValidStatus(const struct SaveBlockChunk *chunks)
{
    u16 sector;
    bool8 signatureValid;
    u16 checksum;
    u32 slot1saveCounter = 0;
    u32 slot2saveCounter = 0;
    u8 slot1Status;
    u8 slot2Status;
    u32 validSectors;
    const u32 ALL_SECTORS = (1 << NUM_SECTORS_PER_SAVE_SLOT) - 1;  // bitmask of all saveblock sectors

    // check save slot 1.
    validSectors = 0;
    signatureValid = FALSE;
    for (sector = 0; sector < NUM_SECTORS_PER_SAVE_SLOT; sector++)
    {
        DoReadFlashWholeSection(sector, gFastSaveSection);
        if (gFastSaveSection->signature == FILE_SIGNATURE)
        {
            signatureValid = TRUE;
            checksum = CalculateChecksum(gFastSaveSection->data, chunks[gFastSaveSection->id].size);
            if (gFastSaveSection->checksum == checksum)
            {
                slot1saveCounter = gFastSaveSection->counter;
                validSectors |= 1 << gFastSaveSection->id;
            }
        }
    }

    if (signatureValid)
    {
        if (validSectors == ALL_SECTORS)
            slot1Status = SAVE_STATUS_OK;
        else
            slot1Status = SAVE_STATUS_ERROR;
    }
    else
    {
        slot1Status = SAVE_STATUS_EMPTY;
    }

    // check save slot 2.
    validSectors = 0;
    signatureValid = FALSE;
    for (sector = 0; sector < NUM_SECTORS_PER_SAVE_SLOT; sector++)
    {
        DoReadFlashWholeSection(NUM_SECTORS_PER_SAVE_SLOT + sector, gFastSaveSection);
        if (gFastSaveSection->signature == FILE_SIGNATURE)
        {
            signatureValid = TRUE;
            checksum = CalculateChecksum(gFastSaveSection->data, chunks[gFastSaveSection->id].size);
            if (gFastSaveSection->checksum == checksum)
            {
                slot2saveCounter = gFastSaveSection->counter;
                validSectors |= 1 << gFastSaveSection->id;
            }
        }
    }

    if (signatureValid)
    {
        if (validSectors == ALL_SECTORS)
            slot2Status = SAVE_STATUS_OK;
        else
            slot2Status = SAVE_STATUS_ERROR;
    }
    else
    {
        slot2Status = SAVE_STATUS_EMPTY;
    }

    if (slot1Status == SAVE_STATUS_OK && slot2Status == SAVE_STATUS_OK)
    {
        // Choose counter of the most recent save file
        if ((slot1saveCounter == -1 && slot2saveCounter == 0) || (slot1saveCounter == 0 && slot2saveCounter == -1))
        {
            if ((unsigned)(slot1saveCounter + 1) < (unsigned)(slot2saveCounter + 1))
                gSaveCounter = slot2saveCounter;
            else
                gSaveCounter = slot1saveCounter;
        }
        else
        {
            if (slot1saveCounter < slot2saveCounter)
                gSaveCounter = slot2saveCounter;
            else
                gSaveCounter = slot1saveCounter;
        }
        return SAVE_STATUS_OK;
    }

    if (slot1Status == SAVE_STATUS_OK)
    {
        gSaveCounter = slot1saveCounter;
        if (slot2Status == SAVE_STATUS_ERROR)
            return SAVE_STATUS_ERROR;
        else
            return SAVE_STATUS_OK;
    }

    if (slot2Status == SAVE_STATUS_OK)
    {
        gSaveCounter = slot2saveCounter;
        if (slot1Status == SAVE_STATUS_ERROR)
            return SAVE_STATUS_ERROR;
        else
            return SAVE_STATUS_OK;
    }

    if (slot1Status == SAVE_STATUS_EMPTY && slot2Status == SAVE_STATUS_EMPTY)
    {
        gSaveCounter = 0;
        gFirstSaveSector = 0;
        return SAVE_STATUS_EMPTY;
    }

    gSaveCounter = 0;
    gFirstSaveSector = 0;
    return 2;
}

void ReadSaveChunkI(u8 sector, u32 chunk, const struct SaveBlockChunk * chunks)
{
    s32 i;
    u32 checksum;
    u16 sectorId;
    DoReadFlashWholeSection(sector, gFastSaveSection);
    sectorId = gFastSaveSection->id;
    if (sectorId == 0)
    {
        gFirstSaveSector = chunk;
    }
    checksum = CalculateChecksum(gFastSaveSection->data, chunks[sectorId].size);
    if (gFastSaveSection->signature == FILE_SIGNATURE && gFastSaveSection->checksum == checksum)
    {
        for (i = 0; i < chunks[sectorId].size; i++)
            chunks[sectorId].data[i] = gFastSaveSection->data[i];
    }
}
