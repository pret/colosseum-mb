#ifndef GFLIB_TEXT_H
#define GFLIB_TEXT_H

#ifdef __cplusplus
// To allow the use of C++ reserved keywords in this header
extern "C" {
#endif

#include "gflib/characters.h"

struct Window
{
    u8 bg; // 0x0
    u8 left; // 0x1
    u8 top; // 0x2
    u8 width; // 0x3
    u8 height; // 0x4
    u16 baseBlock; // 0x6
    u8 fillValue; // 0x8
    u8 glyphSize; // 0x9
    void *vramCharBase; // 0xC
    const u8 *glyphGfx; // 0x10
    const u8 *glyphWidths; // 0x14
    u8 fgColor; // 0x18
    u8 shadowColor; // 0x19
    u8 currentX; // 0x1A
    u8 currentY; // 0x1B
    u8 glyphWidth; // 0x1C
    u8 startX; // 0x1D
    u8 startY; // 0x1E
};

void DrawGlyphOnWindow_NoShadow(struct Window *window, u32 glyphId, u32 fgColor);
void DrawGlyphOnWindow_WithShadow(struct Window *window, u32 glyphId, u32 fgColor, u32 shadowColor);
struct Window *AddWindow(u32 windowId, const struct Window *template);
void GenerateFontHalfrowLookupTable(u32 * buffer);
void ClearWindowCharBuffer(struct Window * window, u32 tile);
void FillWindowCharBufferRect(struct Window * window, s32 x, s32 y, s32 width, s32 height, u32 fillValue);
void SetTextColor(struct Window * window, u8 fg, u8 shadow);
void TextWindowNextLine(struct Window * window);
void TextWindowSetXY(struct Window * window, u32 x, u32 y);
void TextWindowShiftXY(struct Window * window, s32 dx, s32 dy);
void UNUSED TextWindowPrintSimpleString(struct Window * window, const u8 * glyphs);
void TextWindowFillTileBufferForText(struct Window * window);

#ifdef __cplusplus
}
#endif

#endif //GFLIB_TEXT_H
