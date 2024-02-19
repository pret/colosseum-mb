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
    u32 data[4];
};

struct SpriteSheet
{
    const u8 *data;  // Raw uncompressed pixel data
    u16 size;
    u16 tag;
};

struct CompressedSpriteSheet
{
    const u32 *data;  // LZ77 compressed pixel data
    u16 size;        // Uncompressed size of pixel data
    u16 tag;
};

struct SpritePalette
{
    const u16 *data;  // Raw uncompressed palette data
    u16 tag;
};

struct CompressedSpritePalette
{
    const u32 *data;  // LZ77 compressed palette data
    u16 tag;
};

void ResetSprites(void);
void UpdateSprites(void);
void DoOamBufferTransfer(void);
struct Sprite * AddSprite(s32 x, s32 y, const struct Subsprites * subsprites);
void MoveSpriteToHead(struct Sprite * sprite);
void SetSpritePos(struct Sprite * sprite, s32 x, s32 y);
void AddSpritePos(struct Sprite * sprite, s32 x, s32 y);
void SetSpritePaletteNum(struct Sprite * sprite, s32 paletteNum);
void SetSpriteTileOffset(struct Sprite * sprite, s32 tileOffset);
void SetSpriteInvisible(struct Sprite * sprite, s32 invisible);

#endif //GFLIB_SPRITE_H
