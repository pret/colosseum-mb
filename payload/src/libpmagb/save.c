#include "global.h"
#include "gflib/types.h"
#include "libpmagb/save.h"
#include "libpmagb/agb_rom.h"
#include "gba/flash_internal.h"
#include "gflib/sound.h"
#include "gflib/init.h"

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
#define SECTOR_SIGNATURE_OFFSET 0x0FF8

#define HALL_OF_FAME_SECTOR 28

#define NUM_SECTORS_PER_SAVE_SLOT 14  // Number of sectors occupied by a save slot
#define NUM_HALL_OF_FAME_SECTORS 2

#define SAVEBLOCK_CHUNK(structure, chunkNum)                            \
{                                                                       \
    (u8 *)&structure + chunkNum * SECTOR_DATA_SIZE, SECTOR_DATA_SIZE    \
}                                                                       \

#define SAVEBLOCK_CHUNK_FALSE_SIZE(structure, chunkNum, size)           \
{                                                                       \
    (u8 *)&structure + chunkNum * SECTOR_DATA_SIZE, size                \
}                                                                       \

u16 gLastWrittenSector;
u32 gLastSaveCounter;
u16 gLastKnownGoodSector;
u32 gDamagedSaveSectors;
u32 gSaveCounter;
struct SaveSector *gReadWriteSector; // the pointer is in fast IWRAM but may sometimes point to the slower EWRAM.
EWRAM_DATA struct SaveSector gSaveReadBuffer = {0};
u16 unused;
u16 gSaveFileStatus;
u32 gGameContinueCallback;
u16 gIncrementalSectorId;
struct {
    u8 unused1;
    u8 neverRead1;
    u8 unused2;
    u8 unused3;
    u8 failedSectorsWiped;
    u8 unused4;
    u8 unused5;
    u8 unused6;
    u32 neverRead2;
    u8 unused7;
    u8 unused8;
    u8 unused9;
    u8 unused10;
    u16 neverRead3;
} gSaveStatusFlags;

static u8 sWipeTries;
static u32 gSaveValidStatus;

bool8 WipeFailedSectors(void);

struct SaveBlockChunk sSaveBlockChunks[] = {
    SAVEBLOCK_CHUNK_FALSE_SIZE(gSaveBlock2Ptr, 0, 0x0004),
    SAVEBLOCK_CHUNK(gSaveBlock1Ptr, 0),
    SAVEBLOCK_CHUNK(gSaveBlock1Ptr, 1),
    SAVEBLOCK_CHUNK(gSaveBlock1Ptr, 2),
    SAVEBLOCK_CHUNK_FALSE_SIZE(gSaveBlock1Ptr, 3, 0x0C40),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 0),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 1),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 2),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 3),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 4),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 5),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 6),
    SAVEBLOCK_CHUNK(gPokemonStoragePtr, 7),
    SAVEBLOCK_CHUNK_FALSE_SIZE(gPokemonStoragePtr, 8, 0x0004),
};

struct SaveBlockChunk sSaveBlockChunkBuffer[] = {
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
    {(void *)&gSaveReadBuffer, SECTOR_DATA_SIZE},
};

inline void ResetSaveCounters(void)
{
    gSaveCounter = 0;
    gLastWrittenSector = 0;
    gDamagedSaveSectors = 0;
    gSaveValidStatus = 0x80;
}

inline void ClearSaveData(void)
{
    s32 i;

    for (i = 0; i < NUM_SECTORS; i++)
    {
        EraseFlashSector(i);
    }
    ResetSaveCounters();
}

s32 InitFlash(u32 timerNum, IntrFunc * intrFunc)
{
    sSaveBlockChunks[0].size = gAgbPmRomParams->saveBlock2Size;
    sSaveBlockChunks[4].size = gAgbPmRomParams->saveBlock1Size % SECTOR_DATA_SIZE;
    sSaveBlockChunks[13].size = sizeof(struct PokemonStorage) % SECTOR_DATA_SIZE;

    if (!IdentifyFlash() && !SetFlashTimerIntr(timerNum, intrFunc))
    {
        ResetSaveCounters();
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

enum
{
    SECTOR_DAMAGED,
    SECTOR_OK,
    SECTOR_CHECK, // unused
};

static inline bool32 SetSectorDamagedStatus(u8 op, u8 sectorNum)
{
    bool32 retVal = FALSE;

    switch (op)
    {
    case SECTOR_DAMAGED:
        gDamagedSaveSectors |= (1 << sectorNum);
        break;
    case SECTOR_OK:
        gDamagedSaveSectors &= ~(1 << sectorNum);
        break;
    case SECTOR_CHECK: // unused
        if (gDamagedSaveSectors & (1 << sectorNum))
            retVal = TRUE;
        break;
    }

    return retVal;
}

u16 GetSaveValidStatus(const struct SaveBlockChunk *chunks)
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
        DoReadFlashWholeSection(sector, gReadWriteSector);
        if (gReadWriteSector->signature == FILE_SIGNATURE)
        {
            signatureValid = TRUE;
            checksum = CalculateChecksum(gReadWriteSector->data, chunks[gReadWriteSector->id].size);
            if (gReadWriteSector->checksum == checksum)
            {
                slot1saveCounter = gReadWriteSector->counter;
                validSectors |= 1 << gReadWriteSector->id;
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
        DoReadFlashWholeSection(NUM_SECTORS_PER_SAVE_SLOT + sector, gReadWriteSector);
        if (gReadWriteSector->signature == FILE_SIGNATURE)
        {
            signatureValid = TRUE;
            checksum = CalculateChecksum(gReadWriteSector->data, chunks[gReadWriteSector->id].size);
            if (gReadWriteSector->checksum == checksum)
            {
                slot2saveCounter = gReadWriteSector->counter;
                validSectors |= 1 << gReadWriteSector->id;
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
            if ((u32)(slot1saveCounter + 1) < (u32)(slot2saveCounter + 1))
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
        gLastWrittenSector = 0;
        return SAVE_STATUS_EMPTY;
    }

    gSaveCounter = 0;
    gLastWrittenSector = 0;

    return 2;
}

void ReadSaveChunk(u32 sector, u32 chunk, const struct SaveBlockChunk * chunks)
{
    s32 i;
    u32 checksum;
    u16 sectorId;

    DoReadFlashWholeSection(sector, gReadWriteSector);
    sectorId = gReadWriteSector->id;

    if (sectorId == 0)
    {
        gLastWrittenSector = chunk;
    }

    checksum = CalculateChecksum(gReadWriteSector->data, chunks[sectorId].size);

    if (gReadWriteSector->signature == FILE_SIGNATURE && gReadWriteSector->checksum == checksum)
    {
        for (i = 0; i < chunks[sectorId].size; i++)
            chunks[sectorId].data[i] = gReadWriteSector->data[i];
    }
}

inline bool32 ReadAllSaveChunks(const struct SaveBlockChunk * chunks)
{
    s32 i;
    u32 firstSector = (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;

    for (i = 0; i < NUM_SECTORS_PER_SAVE_SLOT; i++)
    {
        ReadSaveChunk(i + firstSector, i, chunks);
    }
    return TRUE;
}

inline UNUSED u32 UnusedReadSaveData(s32 allChunks, const struct SaveBlockChunk *chunks)
{
    gReadWriteSector = &gSaveReadBuffer;

    switch (allChunks)
    {
    case FALSE:
        gSaveValidStatus = GetSaveValidStatus(chunks);
        ReadSaveChunk((gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT, 0, chunks);
    
        return gSaveValidStatus;
    case TRUE:
        ReadAllSaveChunks(chunks);
    
        return gSaveValidStatus;
    }
}

u32 ReadSaveBlockChunks(void)
{
    u32 status;
    const struct SaveBlockChunk * chunks = sSaveBlockChunks;

    gReadWriteSector = &gSaveReadBuffer;
    ReadAllSaveChunks(chunks);
    status = gSaveValidStatus;
    CpuCopy16(gSaveBlock1Ptr, gSaveBlock1BakPtr, gAgbPmRomParams->saveBlock1Size);

    return status;
}

u8 * ReadFirstSaveSector(void)
{
    const struct SaveBlockChunk * chunks = sSaveBlockChunkBuffer;

    gReadWriteSector = &gSaveReadBuffer;
    gSaveValidStatus = GetSaveValidStatus(chunks);
    ReadSaveChunk((gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT, 0, chunks);

    return gSaveReadBuffer.data;
}

static inline u32 TryWriteSector(u8 sectorNum, void * data)
{
    u32 ret;

    SoundVSyncOff();
    ret = ProgramFlashSectorAndVerify(sectorNum, data);
    SoundVSyncOn();

    if (ret != 0)
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, sectorNum);
        return SAVE_STATUS_ERROR;
    }
    else
    {
        SetSectorDamagedStatus(SECTOR_OK, sectorNum);
        return SAVE_STATUS_OK;
    }
}

u32 HandleWriteSector(u16 sectorId, const struct SaveBlockChunk * chunks)
{
    u16 i;
    u16 sector;
    u8 * chunkData;
    u16 chunkSize;

    sector = sectorId + gLastWrittenSector;
    sector %= NUM_SECTORS_PER_SAVE_SLOT;
    sector += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    chunkData = chunks[sectorId].data;
    chunkSize = chunks[sectorId].size;

    for (i = 0; i < sizeof(struct SaveSector); i++)
    {
        ((u8 *)gReadWriteSector)[i] = 0;
    }

    gReadWriteSector->id = sectorId;
    gReadWriteSector->signature = FILE_SIGNATURE;
    gReadWriteSector->counter = gSaveCounter;

    for (i = 0; i < chunkSize; i++)
    {
        gReadWriteSector->data[i] = chunkData[i];
    }

    gReadWriteSector->checksum = CalculateChecksum(chunkData, chunkSize);

    return TryWriteSector(sector, (void *)gReadWriteSector);
}

inline u32 WriteSaveSectorOrSlot(u16 sectorId, const struct SaveBlockChunk * chunks)
{
    u32 retVal;
    s32 i;

    gReadWriteSector = &gSaveReadBuffer;

    if (sectorId != 0xFFFF)  // write single chunk
    {
        retVal = HandleWriteSector(sectorId, chunks);
    }
    else  // write all chunks
    {
        gLastKnownGoodSector = gLastWrittenSector;
        gLastSaveCounter = gSaveCounter;
        gLastWrittenSector++;
        gLastWrittenSector %= NUM_SECTORS_PER_SAVE_SLOT;
        gSaveCounter++;
        retVal = SAVE_STATUS_OK;

        for (i = 0; i < NUM_SECTORS_PER_SAVE_SLOT; i++)
            HandleWriteSector(i, chunks);

        // Check for any bad sectors
        if (gDamagedSaveSectors != 0) // skip the damaged sector.
        {
            retVal = SAVE_STATUS_ERROR;
            gLastWrittenSector = gLastKnownGoodSector;
            gSaveCounter = gLastSaveCounter;
        }
    }

    return retVal;
}

u32 WriteSaveBlockChunks(void)
{
    return WriteSaveSectorOrSlot(0xFFFF, sSaveBlockChunks);
}

u8 HandleReplaceSector(u16 sectorId, const struct SaveBlockChunk * chunks)
{
    u16 i;
    u16 sector;
    u8 * chunkData;
    u16 chunkSize;
    u8 ret;

    sector = sectorId + gLastWrittenSector;
    sector %= NUM_SECTORS_PER_SAVE_SLOT;
    sector += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    chunkData = chunks[sectorId].data;
    chunkSize = chunks[sectorId].size;

    for (i = 0; i < sizeof(struct SaveSector); i++)
    {
        ((u8 *)gReadWriteSector)[i] = 0;
    }

    gReadWriteSector->id = sectorId;
    gReadWriteSector->signature = FILE_SIGNATURE;
    gReadWriteSector->counter = gSaveCounter;

    for (i = 0; i < chunkSize; i++)
    {
        gReadWriteSector->data[i] = chunkData[i];
    }

    gReadWriteSector->checksum = CalculateChecksum(chunkData, chunkSize);
    EraseFlashSector(sector);
    ret = SAVE_STATUS_OK;

    for (i = 0; i < 0xFF8; i++)
    {
        if (ProgramFlashByte(sector, i, gReadWriteSector->data[i]) != 0)
        {
            ret = SAVE_STATUS_ERROR;
            break;
        }
    }

    if (ret == SAVE_STATUS_ERROR)
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, sector);
        return SAVE_STATUS_ERROR;
    }
    else
    {
        ret = SAVE_STATUS_OK;
        for (i = 0; i < 7; i++)
        {
            if (ProgramFlashByte(sector, i + 0xFF9, ((u8 *)gReadWriteSector)[i + 0xFF9]) != 0)
            {
                ret = SAVE_STATUS_ERROR;
                break;
            }
        }
        if (ret == SAVE_STATUS_ERROR)
        {
            SetSectorDamagedStatus(SECTOR_DAMAGED, sector);
            return SAVE_STATUS_ERROR;
        }
        else
        {
            SetSectorDamagedStatus(SECTOR_OK, sector);
            return SAVE_STATUS_OK;
        }
    }
}

u8 WriteSectorSignatureByte(u16 sectorId, const struct SaveBlockChunk * chunks)
{
    u16 sector = sectorId + gLastWrittenSector - 1;

    sector %= NUM_SECTORS_PER_SAVE_SLOT;
    sector += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    SoundVSyncOff();

    if (ProgramFlashByte(sector, SECTOR_SIGNATURE_OFFSET, ((u8 *)gReadWriteSector)[SECTOR_SIGNATURE_OFFSET]) != 0)
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, sector);
        SoundVSyncOn();
        return SAVE_STATUS_ERROR;
    }
    else
    {
        SetSectorDamagedStatus(SECTOR_OK, sector);
        SoundVSyncOn();
        return SAVE_STATUS_OK;
    }
}

u8 WriteSectorSignatureByteInverse(u16 sectorId, const struct SaveBlockChunk * chunks)
{
    u16 sector = sectorId + gLastWrittenSector - 1;

    sector %= NUM_SECTORS_PER_SAVE_SLOT;
    sector += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    SoundVSyncOff();

    if (ProgramFlashByte(sector, SECTOR_SIGNATURE_OFFSET, ~((u8 *)gReadWriteSector)[SECTOR_SIGNATURE_OFFSET]) != 0)
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, sector);
        SoundVSyncOn();
        return SAVE_STATUS_ERROR;
    }
    else
    {
        SetSectorDamagedStatus(SECTOR_OK, sector);
        SoundVSyncOn();
        return SAVE_STATUS_OK;
    }
}

inline u32 RestoreSaveBackupVarsAndIncrement(void)
{
    gReadWriteSector = &gSaveReadBuffer;
    gLastKnownGoodSector = gLastWrittenSector;
    gLastSaveCounter = gSaveCounter;
    gLastWrittenSector++;
    gLastWrittenSector %= NUM_SECTORS_PER_SAVE_SLOT;
    gSaveCounter++;
    gIncrementalSectorId = 0;
    gDamagedSaveSectors = 0;

    return 0;
}

inline UNUSED u32 RestoreSaveBackupVars(void)
{
    gReadWriteSector = &gSaveReadBuffer;
    gLastKnownGoodSector = gLastWrittenSector;
    gLastSaveCounter = gSaveCounter;
    gIncrementalSectorId = 0;
    gDamagedSaveSectors = 0;

    return 0;
}

inline UNUSED u32 RevertSaveCounters(void)
{
    gLastWrittenSector = gLastKnownGoodSector;
    gSaveCounter = gLastSaveCounter;

    return gSaveCounter;
}

inline u8 HandleWriteIncrementalSector(u16 numSectors, const struct SaveBlockChunk * chunks)
{
    u8 status;

    if (gIncrementalSectorId < numSectors - 1)
    {
        HandleWriteSector(gIncrementalSectorId, chunks);
        if (gDamagedSaveSectors)
            status = SAVE_STATUS_ERROR;
        else
        {
            status = SAVE_STATUS_OK;
            gIncrementalSectorId++;
        }
    }
    else
    {
        status = SAVE_STATUS_ERROR;
    }

    return status;
}

inline u32 HandleReplaceSectorAndVerify(u16 chunk, const struct SaveBlockChunk * chunks)
{
    u32 status = SAVE_STATUS_OK;

    SoundVSyncOff();
    HandleReplaceSector(chunk - 1, chunks);
    SoundVSyncOn();

    if (gDamagedSaveSectors != 0)
        status = SAVE_STATUS_ERROR;

    return status;
}

bool32 FullSaveAndLoopOverFailedSectors(void)
{
    u8 status;

retry:
    status = HandleWriteIncrementalSector(NUM_SECTORS_PER_SAVE_SLOT, sSaveBlockChunks);

    if (gDamagedSaveSectors != 0)
    {
        if (!WipeFailedSectors())
        {
            goto retry;
        }
        gSaveStatusFlags.failedSectorsWiped |= 1;
    }

    if (status == SAVE_STATUS_ERROR)
        return TRUE;
    else
        return FALSE;
}

#ifdef NONMATCHING

bool32 sub_0200A2C8(s32 a)
{
    u8 i;

    switch (a)
    {
    case 0:
    {
        u32 i;
        s32 j;
        u8 *sav2;

        gSaveStatusFlags.neverRead2 |= 1;
        gSaveStatusFlags.failedSectorsWiped &= ~(1);
        gSaveStatusFlags.neverRead2 &= ~(2 | 4);
        sav2 = gSaveBlock2Ptr;

        for (i = 0; i < gAgbPmRomParams->saveBlock2Size; i++)
        {
            if (sav2[i] != 0)
                goto _DontClearSaveData;
        }

        ClearSaveData();
        gSaveStatusFlags.neverRead2 |= 8;
        gSaveStatusFlags.neverRead1 = 4;
        gSaveStatusFlags.neverRead3 = 0;
    _DontClearSaveData:
        RestoreSaveBackupVarsAndIncrement();
        gSaveStatusFlags.neverRead1++;
        gSaveStatusFlags.neverRead3 = 0;
        DelayFrames(5);

        while (1)
        {
            if (FullSaveAndLoopOverFailedSectors() != FALSE)
                break;
            if (gSaveStatusFlags.failedSectorsWiped & 1)
                return TRUE;
        }

        sWipeTries = 0;

        while (1)
        {
            HandleReplaceSectorAndVerify(14, sSaveBlockChunks);
            if (gDamagedSaveSectors != 0)
            {
                if (WipeFailedSectors())
                {
                    gSaveStatusFlags.failedSectorsWiped |= 1;
                    break;
                }
                continue;
            }
            break;
        }

        if (gSaveStatusFlags.failedSectorsWiped & 1)
            return TRUE;
        else
            return FALSE;
    }
    case 1:
        i = 0;

        while (1)
        {
            const struct SaveBlockChunk *chunks = sSaveBlockChunks;
            WriteSectorSignatureByte(14, chunks);

            if (gDamagedSaveSectors != 0)
            {
                if (++i >= 4)
                {
                    gSaveStatusFlags.failedSectorsWiped |= 1;
                    break;
                }

                gDamagedSaveSectors = 0;
                continue;
            }
            break;
        }

        if (gSaveStatusFlags.failedSectorsWiped & 1)
            return TRUE;
        else
            return FALSE;
    case 2:
        i = 0;

        while (1)
        {
            const struct SaveBlockChunk *chunks = sSaveBlockChunks;
            WriteSectorSignatureByteInverse(14, chunks);

            if (gDamagedSaveSectors != 0)
            {
                if (++i >= 4)
                {
                    gSaveStatusFlags.failedSectorsWiped |= 1;
                    break;
                }

                gDamagedSaveSectors = 0;
                continue;
            }
            break;
        }
        return FALSE;
    }

    return FALSE;
}
#else

bool32 NAKED sub_0200A2C8(s32 a)
{
    asm_unified("push {r4, r5, lr}\t\n\
	cmp r0, #1\t\n\
	bne _0200A2D0\t\n\
	b _0200A42C\t\n\
_0200A2D0:\t\n\
	cmp r0, #1\t\n\
	bgt _0200A2DA\t\n\
	cmp r0, #0\t\n\
	beq _0200A2E2\t\n\
	b _0200A4AE\t\n\
_0200A2DA:\t\n\
	cmp r0, #2\t\n\
	bne _0200A2E0\t\n\
	b _0200A478\t\n\
_0200A2E0:\t\n\
	b _0200A4AE\t\n\
_0200A2E2:\t\n\
	ldr r2, =gSaveStatusFlags\t\n\
	ldr r1, [r2, #8]\t\n\
	movs r0, #1\t\n\
	orrs r1, r0\t\n\
	movs r0, #0xfe\t\n\
	ldrb r3, [r2, #4]\t\n\
	ands r0, r3\t\n\
	strb r0, [r2, #4]\t\n\
	movs r0, #7\t\n\
	rsbs r0, r0, #0\t\n\
	ands r1, r0\t\n\
	str r1, [r2, #8]\t\n\
	ldr r0, =gSaveBlock2Ptr\t\n\
	ldr r3, [r0]\t\n\
	movs r1, #0\t\n\
	ldr r0, =gAgbPmRomParams\t\n\
	ldr r0, [r0]\t\n\
	adds r0, #0x88\t\n\
	ldr r0, [r0]\t\n\
	cmp r1, r0\t\n\
	bhs _0200A31C\t\n\
	adds r2, r0, #0\t\n\
_0200A30E:\t\n\
	adds r0, r3, r1\t\n\
	ldrb r0, [r0]\t\n\
	cmp r0, #0\t\n\
	bne _0200A354\t\n\
	adds r1, #1\t\n\
	cmp r1, r2\t\n\
	blo _0200A30E\t\n\
_0200A31C:\t\n\
	movs r4, #0\t\n\
	ldr r5, =EraseFlashSector\t\n\
_0200A320:\t\n\
	lsls r0, r4, #0x10\t\n\
	lsrs r0, r0, #0x10\t\n\
	ldr r1, [r5]\t\n\
	bl _call_via_r1\t\n\
	adds r4, #1\t\n\
	cmp r4, #0x1f\t\n\
	ble _0200A320\t\n\
	ldr r0, =gSaveCounter\t\n\
	movs r3, #0\t\n\
	str r3, [r0]\t\n\
	ldr r0, =gLastWrittenSector\t\n\
	strh r3, [r0]\t\n\
	ldr r0, =gDamagedSaveSectors\t\n\
	str r3, [r0]\t\n\
	ldr r1, =gSaveValidStatus\t\n\
	movs r0, #0x80\t\n\
	str r0, [r1]\t\n\
	ldr r2, =gSaveStatusFlags\t\n\
	ldr r0, [r2, #8]\t\n\
	movs r1, #8\t\n\
	orrs r0, r1\t\n\
	str r0, [r2, #8]\t\n\
	movs r0, #4\t\n\
	strb r0, [r2, #1]\t\n\
	strh r3, [r2, #0x10]\t\n\
_0200A354:\t\n\
	ldr r1, =gReadWriteSector\t\n\
	ldr r0, =gSaveReadBuffer\t\n\
	str r0, [r1]\t\n\
	ldr r0, =gLastKnownGoodSector\t\n\
	ldr r4, =gLastWrittenSector\t\n\
	ldrh r1, [r4]\t\n\
	strh r1, [r0]\t\n\
	ldr r2, =gLastSaveCounter\t\n\
	ldr r5, =gSaveCounter\t\n\
	ldr r0, [r5]\t\n\
	str r0, [r2]\t\n\
	adds r1, #1\t\n\
	strh r1, [r4]\t\n\
	ldrh r0, [r4]\t\n\
	movs r1, #0xe\t\n\
	bl __umodsi3\t\n\
	strh r0, [r4]\t\n\
	ldr r0, [r5]\t\n\
	adds r0, #1\t\n\
	str r0, [r5]\t\n\
	ldr r1, =gIncrementalSectorId\t\n\
	movs r0, #0\t\n\
	strh r0, [r1]\t\n\
	ldr r0, =gDamagedSaveSectors\t\n\
	movs r1, #0\t\n\
	str r1, [r0]\t\n\
	ldr r4, =gSaveStatusFlags\t\n\
	ldrb r0, [r4, #1]\t\n\
	adds r0, #1\t\n\
	strb r0, [r4, #1]\t\n\
	strh r1, [r4, #0x10]\t\n\
	movs r0, #5\t\n\
	bl DelayFrames\t\n\
	movs r5, #1\t\n\
	b _0200A3DE\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_0200A3D4:\t\n\
	adds r0, r5, #0\t\n\
	ldrb r1, [r4, #4]\t\n\
	ands r0, r1\t\n\
	cmp r0, #0\t\n\
	bne _0200A46E\t\n\
_0200A3DE:\t\n\
	bl FullSaveAndLoopOverFailedSectors\t\n\
	cmp r0, #0\t\n\
	beq _0200A3D4\t\n\
	ldr r1, =sWipeTries\t\n\
	movs r0, #0\t\n\
	strb r0, [r1]\t\n\
_0200A3EC:\t\n\
	ldr r4, =sSaveBlockChunks\t\n\
	bl SoundVSyncOff\t\n\
	movs r0, #0xd\t\n\
	adds r1, r4, #0\t\n\
	bl HandleReplaceSector\t\n\
	bl SoundVSyncOn\t\n\
	ldr r0, =gDamagedSaveSectors\t\n\
	ldr r0, [r0]\t\n\
	cmp r0, #0\t\n\
	beq _0200A462\t\n\
	bl WipeFailedSectors\t\n\
	lsls r0, r0, #0x18\t\n\
	cmp r0, #0\t\n\
	beq _0200A3EC\t\n\
	ldr r0, =gSaveStatusFlags\t\n\
	movs r1, #1\t\n\
	ldrb r2, [r0, #4]\t\n\
	orrs r1, r2\t\n\
	b _0200A460\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_0200A42C:\t\n\
	movs r4, #0\t\n\
_0200A42E:\t\n\
	ldr r1, =sSaveBlockChunks\t\n\
	movs r0, #0xe\t\n\
	bl WriteSectorSignatureByte\t\n\
	ldr r1, =gDamagedSaveSectors\t\n\
	ldr r0, [r1]\t\n\
	cmp r0, #0\t\n\
	beq _0200A462\t\n\
	adds r0, r4, #1\t\n\
	lsls r0, r0, #0x18\t\n\
	lsrs r4, r0, #0x18\t\n\
	cmp r4, #3\t\n\
	bhi _0200A458\t\n\
	movs r0, #0\t\n\
	str r0, [r1]\t\n\
	b _0200A42E\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_0200A458:\t\n\
	ldr r0, =gSaveStatusFlags\t\n\
	movs r1, #1\t\n\
	ldrb r3, [r0, #4]\t\n\
	orrs r1, r3\t\n\
_0200A460:\t\n\
	strb r1, [r0, #4]\t\n\
_0200A462:\t\n\
	ldr r1, =gSaveStatusFlags\t\n\
	movs r0, #1\t\n\
	ldrb r1, [r1, #4]\t\n\
	ands r0, r1\t\n\
	cmp r0, #0\t\n\
	beq _0200A4AE\t\n\
_0200A46E:\t\n\
	movs r0, #1\t\n\
	b _0200A4B0\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_0200A478:\t\n\
	movs r4, #0\t\n\
_0200A47A:\t\n\
	ldr r1, =sSaveBlockChunks\t\n\
	movs r0, #0xe\t\n\
	bl WriteSectorSignatureByteInverse\t\n\
	ldr r1, =gDamagedSaveSectors\t\n\
	ldr r0, [r1]\t\n\
	cmp r0, #0\t\n\
	beq _0200A4AE\t\n\
	adds r0, r4, #1\t\n\
	lsls r0, r0, #0x18\t\n\
	lsrs r4, r0, #0x18\t\n\
	cmp r4, #3\t\n\
	bhi _0200A4A4\t\n\
	movs r0, #0\t\n\
	str r0, [r1]\t\n\
	b _0200A47A\t\n\
	.align 2, 0\t\n\
	.pool\t\n\
_0200A4A4:\t\n\
	ldr r0, =gSaveStatusFlags\t\n\
	movs r1, #1\t\n\
	ldrb r2, [r0, #4]\t\n\
	orrs r1, r2\t\n\
	strb r1, [r0, #4]\t\n\
_0200A4AE:\t\n\
	movs r0, #0\t\n\
_0200A4B0:\t\n\
	pop {r4, r5}\t\n\
	pop {r1}\t\n\
	bx r1\t\n\
	.align 2, 0\t\n\
	.pool");
}

#endif // NONMATCHING

static inline bool8 WipeSector_Sub(void)
{
    u16 i;
    u32 *ptr = (void *)&gSaveReadBuffer;

    for (i = 0; i < sizeof(struct SaveSector) / 4; i++, ptr++)
    {
        if (*ptr != 0)
            return TRUE;
    }

    return FALSE;
}

bool8 WipeSector(u16 sectorNum)
{
    u16 i;
    bool8 ret;
    u16 r5 = 0;

    SoundVSyncOff();

    while (r5 < 130)
    {
        for (i = 0; i < sizeof(struct SaveSector); i++)
        {
            ProgramFlashByte(sectorNum, i, 0);
        }
        ReadFlash(sectorNum, 0, &gSaveReadBuffer, sizeof(struct SaveSector));
        ret = WipeSector_Sub();
        r5++;
        if (!ret)
            break;
    }

    SoundVSyncOn();

    return ret;
}

bool8 WipeFailedSectors(void)
{
    u32 bits;
    u16 i;

    gSaveStatusFlags.neverRead2 |= 2;

    if (gDamagedSaveSectors != 0 && sWipeTries <= 2)
    {
        bits = gDamagedSaveSectors;
        bits++;
        bits--; // Needed to match;

        for (i = 0; i < NUM_SECTORS; i++)
        {
            #ifdef NONMATCHING
            u32 currBits = 1 << i;
            #else
            register u32 currBits asm("r5") = 1 << i;
            #endif // NONMATCHING

            if (bits & (currBits))
            {
                if (!WipeSector(i))
                    bits &= ~(currBits);
            }
        }

        gDamagedSaveSectors = bits;
        sWipeTries++;

        if (bits == 0)
            return FALSE;
    }

    return TRUE;
}

static UNUSED void *GetSaveReadBufferPointer(void)
{
    return &gSaveReadBuffer;
}
