#include "global.h"
#include "gflib/text.h"
#include "gflib/bg.h"

IWRAM_DATA u32 *sFontHalfrowLookupTablePtr;

extern struct Window gWindows[];


static inline void *GetAddr(struct Window *window)
{
    void *vaddr = window->vramCharBase + (window->currentY / 8) * window->width * 32;
    u32 x = window->currentX;

    vaddr += 32 * (x / 8);
    // Needed to match.
    x++;
    x--;

    return vaddr;
}

void DrawGlyphOnWindow_NoShadow(struct Window * window, u32 glyphId, u32 fgColor)
{
    s32 i;
    u16 currentPixel;
    const u8 *glyphData;
    u32 xpixel;
    void *vaddr;
    u32 *curpos;

    vaddr = curpos = GetAddr(window);
    xpixel = 8 - (window->currentX & 7);
    glyphData = window->glyphGfx + glyphId * window->glyphSize;
    curpos--;

    for (i = 0; i < window->glyphSize; i++)
    {
        if (i != 8)
            curpos++;
        else
            curpos = (void *)vaddr + 32 * window->width;
        currentPixel = (*(glyphData++)) << xpixel;
        if (currentPixel != 0)
        {
            curpos[0] = (curpos[0]
                         & ~(sFontHalfrowLookupTablePtr[currentPixel >> 8] * 0xF)
                         | (fgColor * (sFontHalfrowLookupTablePtr[currentPixel >> 8])));

            curpos[8] = (curpos[8]
                         & ~(sFontHalfrowLookupTablePtr[currentPixel & 0xFF] * 0xF)
                         | (fgColor * (sFontHalfrowLookupTablePtr[currentPixel & 0xFF])));
        }
    }

    if (window->glyphWidth == 0)
        window->currentX += window->glyphWidths[glyphId] + 3;
    else
        window->currentX += window->glyphWidth;
}

void DrawGlyphOnWindow_WithShadow(struct Window *window, u32 glyphId, u32 fgColor, u32 shadowColor)
{
    s32 i;
    u16 currentPixel1, currentPixel2;
    const u8 *glyphData;
    u32 xpixel;
    void *vaddr;
    u32 *curpos;

    xpixel = 8 - (window->currentX & 7);
    glyphData = window->glyphGfx + (glyphId * window->glyphSize * 2);

    for (i = 0; i < window->glyphSize; i++)
    {
        vaddr = window->vramCharBase + ((window->currentY + i) >> 3) * window->width * 32 + (32 * (window->currentX >> 3));
        vaddr += ((window->currentY + i) & 7) * 4;
        curpos = vaddr;

        currentPixel1 = (*glyphData) << xpixel;
        currentPixel2 = (glyphData[window->glyphSize]) << xpixel;
        glyphData++;
        if ((currentPixel1 | currentPixel2) != 0)
        {
            curpos[0] = (curpos[0]
                         & ~((sFontHalfrowLookupTablePtr[currentPixel1 >> 8]
                         | sFontHalfrowLookupTablePtr[currentPixel2 >> 8]) * 0xF)
                         | (sFontHalfrowLookupTablePtr[currentPixel1 >> 8] * fgColor)
                         | (shadowColor * sFontHalfrowLookupTablePtr[currentPixel2 >> 8]));

            curpos[8] = (curpos[8]
                         & ~((sFontHalfrowLookupTablePtr[currentPixel1 & 0xFF]
                         | sFontHalfrowLookupTablePtr[currentPixel2 & 0xFF]) * 0xF)
                         | (sFontHalfrowLookupTablePtr[currentPixel1 & 0xFF] * fgColor)
                         | (shadowColor * sFontHalfrowLookupTablePtr[currentPixel2 & 0xFF]));
        }
    }

    if (window->glyphWidth == 0)
        window->currentX += window->glyphWidths[glyphId];
    else
        window->currentX += window->glyphWidth;
}

// The same as TextWindowFillTileBufferForText
static inline void TextWindowFillTileBufferForText_Inline(struct Window *win)
{
    s32 i, j;
    u16 *addr = (void *) IWRAM_START + (win->bg << 12);
    u16 blockVal = win->baseBlock;

    for (i = win->top; i < win->top + win->height; i++)
    {
        for (j = win->left; j < win->left + win->width; j++)
        {
            addr[i * 32 + j] = (win->fillValue << 12) | blockVal;
            blockVal++;
        }
    }

    gBgTilemapBufferTransferScheduled[win->bg] = TRUE;
}

struct Window *AddWindow(u32 windowId, const struct Window *template)
{
    s32 i, j;
    void *vAddr;
    u16 *addr;
    u16 blockVal;
    struct Window *win = &gWindows[windowId];

    win->bg = template->bg;
    win->glyphSize = template->glyphSize;
    win->left = template->left;
    win->top = template->top;
    win->width = template->width;
    win->height = template->height;
    win->baseBlock = template->baseBlock;
    win->fillValue = template->fillValue;
    win->vramCharBase = template->vramCharBase;
    win->glyphGfx = template->glyphGfx;
    win->glyphWidths = template->glyphWidths;
    win->currentY = 0;
    win->currentX = 0;
    win->glyphGfx = template->glyphGfx;
    win->glyphWidths = template->glyphWidths;
    win->shadowColor = 0;
    win->glyphWidth = 0;
    win->startX = 0;

    // This inline call is needed to match.
    TextWindowFillTileBufferForText_Inline(win);
    return win;
}

void GenerateFontHalfrowLookupTable(u32 *ptr)
{
    s32 i;

    sFontHalfrowLookupTablePtr = ptr;

    for (i = 0; i <= 0xFF; i++)
    {
        u32 r1 = 0;

        if (i & 0x80)
            r1 |= (1 << 0);
        if (i & 0x40)
            r1 |= (1 << 4);
        if (i & 0x20)
            r1 |= (1 << 8);
        if (i & 0x10)
            r1 |= (1 << 12);
        if (i & 0x8)
            r1 |= (1 << 16);
        if (i & 0x4)
            r1 |= (1 << 20);
        if (i & 0x2)
            r1 |= (1 << 24);
        if (i & 0x1)
            r1 |= (1 << 28);

        *(ptr++) = r1;
    }
}

void ClearWindowCharBuffer(struct Window *window, u32 fillValue)
{
    CpuFill16(fillValue, window->vramCharBase, (window->width * window->height) * 32);
    TextWindowSetXY(window, 0, 0);
}

void FillWindowCharBufferRect(struct Window * window, s32 x, s32 y, s32 width, s32 height, u32 fillValue)
{
    s32 i;

    for (i = y; i < y + height; i++)
    {
        CpuFill16(fillValue,
                  window->vramCharBase + (((window->width * i) + x) * 32),
                  (width * 32));
    }
}

void SetTextColor(struct Window * window, u8 fg, u8 shadow)
{
    window->fgColor = fg;
    window->shadowColor = shadow;
}

void TextWindowNextLine(struct Window * window)
{
    window->currentX = window->startX;
    window->currentY += window->glyphSize;
}

void TextWindowSetXY(struct Window * window, u32 x, u32 y)
{
    window->currentX = x;
    window->currentY = y;
}

void TextWindowShiftXY(struct Window * window, s32 dx, s32 dy)
{
    window->currentX += dx;
    window->currentY += dy;
}

void UNUSED TextWindowPrintSimpleString(struct Window * window, const u8 * glyphs)
{
    while (*glyphs != 0)
    {
        if (window->shadowColor == 0)
            DrawGlyphOnWindow_NoShadow(window, *glyphs, window->fgColor);
        else
            DrawGlyphOnWindow_WithShadow(window, *glyphs, window->fgColor, window->shadowColor);
        glyphs++;
    }
}

// The same as TextWindowFillTileBufferForText_Inline
void TextWindowFillTileBufferForText(struct Window * win)
{
    s32 i, j;

    u16 *addr = (void *) IWRAM_START + (win->bg << 12);
    u16 blockVal = win->baseBlock;
    for (i = win->top; i < win->top + win->height; i++)
    {
        for (j = win->left; j < win->left + win->width; j++)
        {
            addr[i * 32 + j] = (win->fillValue << 12) | blockVal;
            blockVal++;
        }
    }

    gBgTilemapBufferTransferScheduled[win->bg] = TRUE;
}
