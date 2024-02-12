#ifndef GFLIB_BG_H
#define GFLIB_BG_H

#define gBGTilemapBuffers      ((void *)0x03000000)

extern u16 gBgHofsBuffer[];
extern u16 gBgVofsBuffer[];
extern bool8 gBgTilemapBufferTransferScheduled[];

void ResetGpuBuffers(void);
void DoGpuUpdateAndTilemapTransfers(void);
void CopyToBgTilemapBufferRect(int bgNum, int left, int top, int width, int height, const u16 * src);
void CopyFromBgTilemapBufferRect(int bgNum, int left, int top, int width, int height, u16 * dest);
void SetBgTilemapBufferPaletteRect(int bgNum, int left, int top, int width, int height, int paletteNum);
void SetBgTilemapBufferTileAt(int bgNum, int x, int y, u16 tileNum);
void FillBgTilemapBufferRect(int bgNum, int left, int top, int width, int height, u16 tileNum);
void CopyRectWithinBgTilemapBuffer(int bgNum, int srcLeft, int srcTop, int width, int height, int destLeft, int destTop);
void SetBgPos(int bgNum, s32 x, s32 y);

#endif //GFLIB_BG_H
