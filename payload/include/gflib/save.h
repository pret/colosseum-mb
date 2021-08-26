#ifndef GFLIB_SAVE_H
#define GFLIB_SAVE_H

#define NUM_SECTORS 32 // defined in agb_flash but not in a header

#define SAVE_STATUS_EMPTY 0
#define SAVE_STATUS_OK 1
#define SAVE_STATUS_NO_FLASH 4
#define SAVE_STATUS_ERROR 0xFF

u8* ReadFirstSaveSector(void);

#endif //GFLIB_SAVE_H
