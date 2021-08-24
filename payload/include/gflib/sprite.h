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

void InitOam(void);
void UpdateSprites(void);
void DoOamBufferTransfer(void);

#endif //GFLIB_SPRITE_H
