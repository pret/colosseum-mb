#ifndef GFLIB_SPRITE_H
#define GFLIB_SPRITE_H

struct Subsprites
{
    u32 oam;
    s16 x;
    s16 y;
    u16 baseBlock;
    u16 unk_a;
};

struct Sprite
{
    u8 prev;
    u8 next;
    u8 flag;
    u16 paletteNum;
    u16 tileOffset;
    s16 x;
    s16 y;
    const struct Subsprites * spriteTemplates;
    void (*callback)(struct Sprite *);
    void * unk14[4];
};

struct CompressedSpritePalette
{
    const u8 *data;  // LZ77 compressed palette data
    u16 tag;
};

void ResetSprites(void);
void UpdateSprites(void);
void DoOamBufferTransfer(void);
struct Sprite * AddSprite(s32 x, s32 y, const struct Subsprites * subsprites);
void MoveSpriteToHead(struct Sprite * a0);
void SetSpritePos(struct Sprite * r0, s32 r1, s32 r2);
void AddSpritePos(struct Sprite * r0, s32 r1, s32 r2);
void SetSpritePaletteNum(struct Sprite * r0, s32 r1);
void SetSpriteTileOffset(struct Sprite * r0, s32 r1);
void SetSpriteInvisible(struct Sprite * r0, s32 r1);

#endif //GFLIB_SPRITE_H
