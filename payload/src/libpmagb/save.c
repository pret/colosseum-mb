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

#define HALL_OF_FAME_SECTOR 28

#define NUM_SECTORS_PER_SAVE_SLOT 14  // Number of sectors occupied by a save slot
#define NUM_HALL_OF_FAME_SECTORS 2

#define SAVEBLOCK_CHUNK_EX(structure, size, chunkNum)         \
{                                                             \
    (u8 *)structure + chunkNum * SECTOR_DATA_SIZE,            \
    min(size - chunkNum * SECTOR_DATA_SIZE, SECTOR_DATA_SIZE) \
}                                                             \

#define SAVEBLOCK_CHUNK(structure, chunkNum) SAVEBLOCK_CHUNK_EX(&structure, sizeof(structure), chunkNum)

u16 gFirstSaveSector;
u32 gPrevSaveCounter;
u16 gLastKnownGoodSector;
u32 gDamagedSaveSectors;
u32 gSaveCounter;
struct SaveSector *gFastSaveSection; // the pointer is in fast IWRAM but may sometimes point to the slower EWRAM.
EWRAM_DATA struct SaveSector gSaveReadBuffer = {0};
u16 gUnknown_03005EB4;
u16 gSaveFileStatus;
u32 gGameContinueCallback;
u16 gUnknown_02023F40;
struct {
    u8 unk_0;
    u8 unk_1;
    u8 unk_2;
    u8 unk_3;
    u8 unk_4;
    u8 unk_5;
    u8 unk_6;
    u8 unk_7;
    u32 unk_8;
    u8 fill12;
    u8 fill13;
    u8 fill14;
    u8 fill15;
    u16 unk16;
} gUnknown_02022F10;
extern u32 gSaveValidStatus;
extern u8 sWipeTries;

bool8 WipeFailedSectors(void);

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

struct SaveBlockChunk gUnknown_020205BC[] = {
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

void ReadSaveChunkI(u32 sector, u32 chunk, const struct SaveBlockChunk * chunks)
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

u32 ReadSaveBlockChunks(void)
{
    s32 i;
    u32 status;
    u32 firstSector;
    const struct SaveBlockChunk * chunks = sSaveBlockChunks;
    gFastSaveSection = &gSaveReadBuffer;
    firstSector = (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    for (i = 0; i < NUM_SECTORS_PER_SAVE_SLOT; i++)
    {
        ReadSaveChunkI(i + firstSector, i, chunks);
    }
    status = gSaveValidStatus;
    CpuCopy16(gSaveBlock1Ptr, gSaveBlock1BakPtr, gAgbPmRomParams->saveBlock1Size);
    return status;
}

u8 * ReadFirstSaveSector(void)
{
    const struct SaveBlockChunk * chunks = gUnknown_020205BC;
    gFastSaveSection = &gSaveReadBuffer;
    gSaveValidStatus = GetSaveValidStatus(chunks);
    ReadSaveChunkI((gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT, 0, chunks);
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

u16 WriteSingleChunk(u16 chunk, const struct SaveBlockChunk * chunks)
{
    u16 i;
    u16 r5;
    u8 * data;
    u16 size;

    r5 = gFirstSaveSector + chunk;
    r5 %= NUM_SECTORS_PER_SAVE_SLOT;
    r5 += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    data = chunks[chunk].data;
    size = chunks[chunk].size;

    for (i = 0; i < sizeof(struct SaveSector); i++)
    {
        ((u8 *)gFastSaveSection)[i] = 0;
    }
    gFastSaveSection->id = chunk;
    gFastSaveSection->signature = FILE_SIGNATURE;
    gFastSaveSection->counter = gSaveCounter;
    for (i = 0; i < size; i++)
    {
        gFastSaveSection->data[i] = data[i];
    }
    gFastSaveSection->checksum = CalculateChecksum(data, size);

    return TryWriteSector(r5, (void *)gFastSaveSection);
}

static inline u32 WriteSaveBlockChunksInternal(u16 chunkId, const struct SaveBlockChunk * chunks)
{
    u32 retVal;
    s32 i;

    gFastSaveSection = &gSaveReadBuffer;

    if (chunkId != 0xFFFF)  // write single chunk
    {
        retVal = WriteSingleChunk(chunkId, chunks);
    }
    else  // write all chunks
    {
        gLastKnownGoodSector = gFirstSaveSector;
        gPrevSaveCounter = gSaveCounter;
        gFirstSaveSector++;
        gFirstSaveSector %= NUM_SECTORS_PER_SAVE_SLOT;
        gSaveCounter++;
        retVal = SAVE_STATUS_OK;

        for (i = 0; i < NUM_SECTORS_PER_SAVE_SLOT; i++)
            WriteSingleChunk(i, chunks);

        // Check for any bad sectors
        if (gDamagedSaveSectors != 0) // skip the damaged sector.
        {
            retVal = SAVE_STATUS_ERROR;
            gFirstSaveSector = gLastKnownGoodSector;
            gSaveCounter = gPrevSaveCounter;
        }
    }

    return retVal;
}

u32 WriteSaveBlockChunks(void)
{
    return WriteSaveBlockChunksInternal(0xFFFF, sSaveBlockChunks);
}

u8 sub_02009F4C(u16 chunk, const struct SaveBlockChunk * chunks)
{
    u16 i;
    u16 sectorId;
    u8 * data;
    u16 size;
    u8 ret;

    sectorId = chunk + gFirstSaveSector;
    sectorId %= NUM_SECTORS_PER_SAVE_SLOT;
    sectorId += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;
    data = chunks[chunk].data;
    size = chunks[chunk].size;

    for (i = 0; i < sizeof(struct SaveSector); i++)
    {
        ((u8 *)gFastSaveSection)[i] = 0;
    }

    gFastSaveSection->id = chunk;
    gFastSaveSection->signature = FILE_SIGNATURE;
    gFastSaveSection->counter = gSaveCounter;
    for (i = 0; i < size; i++)
    {
        gFastSaveSection->data[i] = data[i];
    }
    gFastSaveSection->checksum = CalculateChecksum(data, size);
    EraseFlashSector(sectorId);
    ret = SAVE_STATUS_OK;
    for (i = 0; i < 0xFF8; i++)
    {
        if (ProgramFlashByte(sectorId, i, gFastSaveSection->data[i]) != 0)
        {
            ret = SAVE_STATUS_ERROR;
            break;
        }
    }
    if (ret == SAVE_STATUS_ERROR)
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, sectorId);
        return SAVE_STATUS_ERROR;
    }
    else
    {
        ret = SAVE_STATUS_OK;
        for (i = 0; i < 7; i++)
        {
            if (ProgramFlashByte(sectorId, i + 0xFF9, ((u8 *)gFastSaveSection)[i + 0xFF9]) != 0)
            {
                ret = SAVE_STATUS_ERROR;
                break;
            }
        }
        if (ret == SAVE_STATUS_ERROR)
        {
            SetSectorDamagedStatus(SECTOR_DAMAGED, sectorId);
            return SAVE_STATUS_ERROR;
        }
        else
        {
            SetSectorDamagedStatus(SECTOR_OK, sectorId);
            return SAVE_STATUS_OK;
        }
    }
}

u8 sub_0200A118(u16 sectorNum, const struct SaveBlockChunk * chunks)
{
    u16 r4 = sectorNum + gFirstSaveSector - 1;
    r4 %= NUM_SECTORS_PER_SAVE_SLOT;
    r4 += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;

    SoundVSyncOff();
    if (ProgramFlashByte(r4, 0xFF8, ((u8 *)gFastSaveSection)[0xFF8]))
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, r4);
        SoundVSyncOn();
        return SAVE_STATUS_ERROR;
    }
    else
    {
        SetSectorDamagedStatus(SECTOR_OK, r4);
        SoundVSyncOn();
        return SAVE_STATUS_OK;
    }
}

u8 sub_0200A1B8(u16 sectorNum)
{
    u16 r4 = sectorNum + gFirstSaveSector - 1;
    r4 %= NUM_SECTORS_PER_SAVE_SLOT;
    r4 += (gSaveCounter % 2) * NUM_SECTORS_PER_SAVE_SLOT;

    SoundVSyncOff();
    if (ProgramFlashByte(r4, 0xFF8, ~((u8 *)gFastSaveSection)[0xFF8]))
    {
        SetSectorDamagedStatus(SECTOR_DAMAGED, r4);
        SoundVSyncOn();
        return SAVE_STATUS_ERROR;
    }
    else
    {
        SetSectorDamagedStatus(SECTOR_OK, r4);
        SoundVSyncOn();
        return SAVE_STATUS_OK;
    }
}

static inline u8 sub_0200A260_sub(u16 limit, const struct SaveBlockChunk * chunks)
{
    u8 ret;

    if (gUnknown_02023F40 < limit - 1)
    {
        WriteSingleChunk(gUnknown_02023F40, chunks);
        if (gDamagedSaveSectors)
            ret = SAVE_STATUS_ERROR;
        else
        {
            ret = SAVE_STATUS_OK;
            gUnknown_02023F40++;
        }
    }
    else
    {
        ret = SAVE_STATUS_ERROR;
    }
    return ret;
}

bool32 sub_0200A260(void)
{
    u8 status;

retry:
    status = sub_0200A260_sub(NUM_SECTORS_PER_SAVE_SLOT, sSaveBlockChunks);
    if (gDamagedSaveSectors != 0)
    {
        if (!WipeFailedSectors())
        {
            goto retry;
        }
        gUnknown_02022F10.unk_4 |= 1;
    }
    if (status == SAVE_STATUS_ERROR)
        return TRUE;
    else
        return FALSE;
}
/*
static inline void Hmm(const struct SaveBlockChunk *a)
{
    u8 i = 0;
    while (1)
    {
        sub_0200A118(14, sSaveBlockChunks);
        if (gDamagedSaveSectors == 0)
            return;
        if (++i > 3)
            break;
        gDamagedSaveSectors = 0;
    }
    gUnknown_02022F10.unk_4 |= 1;
}

bool32 sub_0200A2C8(s32 a)
{
    switch (a)
    {
    case 0:
    {
        u32 i;
        s32 j;
        u8 *sav2;

        gUnknown_02022F10.unk_8 |= 1;
        gUnknown_02022F10.unk_4 &= ~(1);
        gUnknown_02022F10.unk_8 &= ~(2 | 4);
        sav2 = gSaveBlock2Ptr;
        for (i = 0; i < gAgbPmRomParams->saveBlock2Size; i++)
        {
            if (sav2[i] != 0)
                goto _0200A354;
        }
        for (j = 0; j < NUM_SECTORS; j++)
        {
            EraseFlashSector(j);
        }
        gSaveCounter = 0;
        gFirstSaveSector = 0;
        gDamagedSaveSectors = 0;
        gSaveValidStatus = 0x80;
        gUnknown_02022F10.unk_8 |= 8;
        gUnknown_02022F10.unk_1 = 4;
        gUnknown_02022F10.unk16 = 0;
    _0200A354:
        gFastSaveSection = &gSaveReadBuffer;
        gLastKnownGoodSector = gFirstSaveSector;
        gPrevSaveCounter = gSaveCounter;
        gFirstSaveSector++;
        gFirstSaveSector %= NUM_SECTORS_PER_SAVE_SLOT;
        gSaveCounter++;
        gUnknown_02023F40 = 0;
        gDamagedSaveSectors = 0;
        gUnknown_02022F10.unk_1++;
        gUnknown_02022F10.unk16 = 0;
        DelayFrames(5);
        while (1)
        {
            if (sub_0200A260() != 0)
                break;
            if (gUnknown_02022F10.unk_4 & 1)
                return TRUE;
        }
        sWipeTries = 0;
        for (;;)
        {
            SoundVSyncOff();
            sub_02009F4C(13, sSaveBlockChunks);
            SoundVSyncOn();
            if (gDamagedSaveSectors == 0)
                break;
            if (WipeFailedSectors())
            {
                gUnknown_02022F10.unk_4 |= 1;
                break;
            }
        }
        return (gUnknown_02022F10.unk_4 & 1) != 0;
    }
    break;
    case 1:
    {
        Hmm(sSaveBlockChunks);
        if (gUnknown_02022F10.unk_4 & 1)
            return TRUE;
        else
            return FALSE;
    }
    break;
    case 2:
    {
        Hmm(sSaveBlockChunks);
        return FALSE;
    }
    break;
    }
    return FALSE;
}
*/
