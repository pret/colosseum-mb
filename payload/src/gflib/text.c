#include "global.h"
#include "gflib/text.h"

IWRAM_DATA u32 *sFontHalfrowLookupTablePtr;

/*
void DrawGlyphOnWindow_NoShadow(struct Window * window, u32 glyphId, u32 fgColor)
{
    u32 * vaddr;
    u32 * curpos;
    u32 xpixel;
    s32 i;
    const u8 * glyphData;
    u16 currentPixel;

    vaddr = window->vramCharBase + (window->currentY / 8) * window->width * 32 + 32 * (window->currentX / 8);
    xpixel = 8 - (window->currentX & 7);
    glyphData = window->glyphGfx + glyphId * window->glyphSize;
    curpos = vaddr - 1;
    for (i = 0; i < window->glyphSize; i++)
    {
        if (i != 8)
            curpos++;
        else
            curpos = (void *)vaddr + 32 * window->width;
        currentPixel = (*glyphData++) << xpixel;
        if (currentPixel != 0)
        {
            u32 mask;

            mask = sFontHalfrowLookupTablePtr[currentPixel >> 8] * 0xF;
            curpos[0] &= ~mask;
            curpos[0] |= fgColor * mask;

            mask = sFontHalfrowLookupTablePtr[currentPixel & 0xFF] * 0xF;
            curpos[8] &= ~mask;
            curpos[8] |= fgColor * mask;
        }
    }
    if (window->glyphWidth == 0)
    {
        window->currentX += 3 + window->glyphWidths[glyphId];
    }
    else
    {
        window->currentX += window->glyphWidth;
    }
}
*/
