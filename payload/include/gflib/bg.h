#ifndef GFLIB_BG_H
#define GFLIB_BG_H

#define gBGTilemapBuffers      ((void *)0x03000000)

extern u16 gBgHofsBuffer[4];
extern u16 gBgVofsBuffer[4];
extern bool8 gBgTilemapBufferTransferScheduled[4];

void ResetGpuBuffers(void);
void DoGpuUpdateAndTilemapTransfers(void);

#endif //GFLIB_BG_H
