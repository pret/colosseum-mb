#ifndef GUARD_IWRAM_H
#define GUARD_IWRAM_H

IWRAM_DATA u8 _Iwram[0x8000];

#define gBgTilemapBuffers                         ((u16 *)IWRAM_START)
#define BG_TILEMAP_BUFFER(i)                      ((u16 *)(IWRAM_START + BG_SCREEN_SIZE * (i)))
#define BG_TILEMAP_BUFFERS_SIZE                   (BG_SCREEN_SIZE * 4)
#define gFontHalfrowLookupTable                   ((u32 *)(IWRAM_START + 0x4000))
#define FONT_HALFROW_LOOKUP_TABLE_SIZE            (0x400)
#define gPicUncompBuffer                          ((u8 *)(IWRAM_START + 0x4400))
#define PIC_UNCOMP_BUFFER_SIZE                    (0x800)

#endif //GUARD_IWRAM_H
