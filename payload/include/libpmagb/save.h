#ifndef PMAGB_SAVE_H
#define PMAGB_SAVE_H

#include "gflib/types.h"

#define NUM_SECTORS 32 // defined in agb_flash but not in a header

#define SAVE_STATUS_EMPTY 0
#define SAVE_STATUS_OK 1
#define SAVE_STATUS_CORRUPT 2
#define SAVE_STATUS_NO_FLASH 4
#define SAVE_STATUS_ERROR 0xFF

bool32 sub_0200A2C8(s32 a);
u8* ReadFirstSaveSector(void);
void SetSaveSectorPtrs(void);
u32 ReadSaveBlockChunks(void);
s32 InitFlash(u32 timerNum, IntrFunc * intrFunc);

#endif //PMAGB_SAVE_H
