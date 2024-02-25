#include "global.h"
#include "gflib/bg.h"

u16 gBgHofsBuffer[NUM_BACKGROUNDS];
u16 gBgVofsBuffer[NUM_BACKGROUNDS];
bool8 gBgTilemapBufferTransferScheduled[NUM_BACKGROUNDS];
u32 filler1;
u32 filler2;
u32 filler3;

void DoGpuUpdateAndTilemapTransfers(void)
{
    s32 i;
    u16 bgCnt;
    void * screenBase;
    u32 size;
    s32 r2;

    REG_BG0HOFS = gBgHofsBuffer[0];
    REG_BG1HOFS = gBgHofsBuffer[1];
    REG_BG2HOFS = gBgHofsBuffer[2];
    REG_BG3HOFS = gBgHofsBuffer[3];
    REG_BG0VOFS = gBgVofsBuffer[0];
    REG_BG1VOFS = gBgVofsBuffer[1];
    REG_BG2VOFS = gBgVofsBuffer[2];
    REG_BG3VOFS = gBgVofsBuffer[3];
    for (i = 0; i < NUM_BACKGROUNDS; i++)
    {
        if (gBgTilemapBufferTransferScheduled[i])
        {
            gBgTilemapBufferTransferScheduled[i] = 0;
            bgCnt = *(vu16 *)(REG_ADDR_BG0CNT + 2 * i);
            screenBase = (void *)(BG_VRAM + ((bgCnt & 0x1F00) << 3));
            r2 = bgCnt & 0xC000 ? 2 : 1;
            CpuCopy32((void *)(gBGTilemapBuffers + 0x1000 * i), screenBase, r2 * BG_SCREEN_SIZE);
        }
    }
}

void ResetGpuBuffers(void)
{
    CpuFill16(0, (void *)gBGTilemapBuffers, 0x4000);
    CpuFill16(0, gBgHofsBuffer, 8);
    CpuFill16(0, gBgVofsBuffer, 8);
    gBgTilemapBufferTransferScheduled[3] = 0;
    gBgTilemapBufferTransferScheduled[2] = 0;
    gBgTilemapBufferTransferScheduled[1] = 0;
    gBgTilemapBufferTransferScheduled[0] = 0;
}

void CopyToBgTilemapBufferRect(u32 bgNum, u32 left, u32 top, s32 width, u32 height, const u16 * src)
{
    s32 x;
    u16 * ptr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++, src++)
        {
            ptr[x] = *src;
        }
        ptr += 32;
        height--;
    }
}

void UNUSED CopyFromBgTilemapBufferRect(u32 bgNum, u32 left, u32 top, s32 width, u32 height, u16 * dest)
{
    s32 x;
    u16 * ptr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++, dest++)
        {
            *dest = ptr[x];
        }
        ptr += 32;
        height--;
    }
}

void SetBgTilemapBufferPaletteRect(u32 bgNum, u32 left, u32 top, s32 width, u32 height, u32 paletteNum)
{
    s32 x;
    u16 * ptr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++)
        {
            ptr[x] &= 0xFFF;
            ptr[x] |= paletteNum << 12;
        }
        ptr += 32;
        height--;
    }
}

void SetBgTilemapBufferTileAt(u32 bgNum, u32 x, u32 y, u16 tileNum)
{
    u16 * ptr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (y << 6) + (x << 1));
    *ptr = tileNum;
}

void FillBgTilemapBufferRect(u32 bgNum, u32 left, u32 top, s32 width, u32 height, u16 tileNum)
{
    s32 x;
    u16 * ptr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (top << 6) + (left << 1));

    while (height)
    {
        for (x = 0; x < width; x++)
        {
            ptr[x] = tileNum;
        }
        ptr += 32;
        height--;
    }
}

void CopyRectWithinBgTilemapBuffer(u32 bgNum, u32 srcLeft, u32 srcTop, s32 width, u32 height, u32 destLeft, u32 destTop)
{
    s32 x;
    const u16 * srcPtr;
    u16 * destPtr;

    srcPtr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (srcTop << 6) + (srcLeft << 1));
    destPtr = (void *)(gBGTilemapBuffers + (bgNum << 12) + (destTop << 6) + (destLeft << 1));

    while (height)
    {
        for (x = 0; x < width; x++)
        {
            destPtr[x] = srcPtr[x];
        }
        srcPtr += 32;
        destPtr += 32;
        height--;
    }
}

void SetBgPos(u32 bgNum, s32 x, s32 y)
{
    gBgHofsBuffer[bgNum] = x;
    gBgVofsBuffer[bgNum] = y;
}
