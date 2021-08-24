#include "global.h"
#include "gflib/sprite.h"

BSS_DATA struct Sprite sSprites[18];

struct OamBuffer
{
    struct OamData oamBuffer[0x80];
    u8 numSprites;
};

BSS_DATA struct OamBuffer sOamBuffer;

void InsertSprite(struct Sprite * a0, struct Sprite * a1)
{
    a1->next = a0->next;
    a1->prev = a0 - sSprites;
    a0->next = sSprites[a0->next].prev = a1 - sSprites;
}

struct Sprite * AddSprite(s32 x, s32 y, const struct Subsprites * subsprites)
{
    s32 i;
    struct Sprite * r7 = &sSprites[sSprites[0].next];
    sSprites[r7->prev].next = r7->next;
    sSprites[r7->next].prev = r7->prev;
    InsertSprite(&sSprites[1], r7);
    r7->x = x;
    r7->y = y;
    r7->spriteTemplates = subsprites;
    r7->flag = 0;
    r7->paletteNum = 0;
    r7->tileOffset = 0;
    r7->callback = NULL;
    for (i = 0; i < 4; i++)
        r7->unk14[i] = NULL;
    return r7;
}

void BufferSpriteOAM(struct Sprite * ptr)
{
    u32 num_sprites;
    struct OamData * oam_p;
    const struct Subsprites * templates;
    s32 width;
    s32 left;
    s32 top;
    s32 height;
    u32 size;
    u32 flags;

    num_sprites = sOamBuffer.numSprites;
    oam_p = &sOamBuffer.oamBuffer[num_sprites];

    templates = ptr->spriteTemplates;
    while (templates->oam != 0xFFFF)
    {
        if (num_sprites == 0x80)
            return;

        if ((left = templates->x + ptr->x) < 0xF0 && (top = templates->y + ptr->y) < 0xA0)
        {
            size = ((templates->oam & 0xC000) >> 12) + (templates->oam >> 30);
            flags = templates->oam;
            switch (size)
            {
            case SPRITE_SIZE_8x8:
            case SPRITE_SIZE_8x16:
            case SPRITE_SIZE_8x32:
                width = 8;
                break;
            case SPRITE_SIZE_16x16:
            case SPRITE_SIZE_16x8:
            case SPRITE_SIZE_16x32:
                width = 16;
                break;
            case SPRITE_SIZE_32x32:
            case SPRITE_SIZE_32x8:
            case SPRITE_SIZE_32x16:
            case SPRITE_SIZE_32x64:
                width = 32;
                break;;
            case SPRITE_SIZE_64x64:
            case SPRITE_SIZE_64x32:
                width = 64;
                break;
            default:
                width = 0;
                break;
            }
            if (left + width >= 0)
            {
                switch (size)
                {
                case SPRITE_SIZE_8x8:
                case SPRITE_SIZE_16x8:
                case SPRITE_SIZE_32x8:
                    height = 8;
                    break;
                case SPRITE_SIZE_16x16:
                case SPRITE_SIZE_32x16:
                case SPRITE_SIZE_8x16:
                    height = 16;
                    break;
                case SPRITE_SIZE_32x32:
                case SPRITE_SIZE_64x32:
                case SPRITE_SIZE_8x32:
                case SPRITE_SIZE_16x32:
                    height = 32;
                    break;
                case SPRITE_SIZE_64x64:
                case SPRITE_SIZE_32x64:
                    height = 64;
                    break;
                }
                if (top + height >= 0)
                {
                    left &= 0x1FF;
                    top &= 0xFF;
                    *(u32 *)oam_p = top | ((left << 16) | flags);
                    *((u16 *)oam_p + 2) = ((templates->baseBlock & 0xFFF) | ptr->paletteNum) + ptr->tileOffset;
                    oam_p++;
                    num_sprites++;
                }
            }
        }
        templates++;
    }
    sOamBuffer.numSprites = num_sprites;
}

void UpdateSprites(void)
{
    s32 r2;
    s32 i;
    struct OamData * r4;
    struct Sprite * ptr;

    i = sSprites[1].next;

    while (i != 1)
    {
        ptr = &sSprites[i];

        if (ptr->callback != NULL)
            ptr->callback(ptr);

        if (!(ptr->flag & 1))
            BufferSpriteOAM(ptr);
        i = ptr->next;
    }

    r4 = &sOamBuffer.oamBuffer[sOamBuffer.numSprites];
    for (r2 = sOamBuffer.numSprites; r2 < 0x80 && *(u16 *)r4 != 0x200; r2++, r4++)
    {
        *(u16 *)r4 = 0x200;
    }
    sOamBuffer.numSprites = 0;
}

void InitOam(void)
{
    s32 i;
    struct OamData * r2;
    struct Sprite * r4;

    CpuFill16(0, sSprites, sizeof(sSprites));
    sSprites[0].next = 0;
    sSprites[0].prev = 0;
    sSprites[1].next = 1;
    sSprites[1].prev = 1;

    for (i = 2; i < 18; i++)
    {
        InsertSprite(&sSprites[0], &sSprites[i]);
    }
    sOamBuffer.numSprites = 0;
    r2 = &sOamBuffer.oamBuffer[0];
    for (i = 0; i < 0x80; i++, r2++)
        *(u16 *)r2 = 0x200;
}

void MoveSpriteToHead(struct Sprite * a0)
{
    sSprites[a0->prev].next = a0->next;
    sSprites[a0->next].prev = a0->prev;
    InsertSprite(&sSprites[0], a0);
}

void DoOamBufferTransfer(void)
{
    DmaCopy32(3, sOamBuffer.oamBuffer, (void *)OAM, OAM_SIZE);
}

void SetSpritePos(struct Sprite * r0, s32 r1, s32 r2)
{
    r0->x = r1;
    r0->y = r2;
}

void AddSpritePos(struct Sprite * r0, s32 r1, s32 r2)
{
    r0->x += r1;
    r0->y += r2;
}

void SetSpritePaletteNum(struct Sprite * r0, s32 r1)
{
    r0->paletteNum = r1 << 12;
}

void SetSpriteTileOffset(struct Sprite * r0, s32 r1)
{
    r0->tileOffset = r1;
}

void SetSpriteInvisible(struct Sprite * r0, s32 r1)
{
    r0->flag = ((r0->flag & ~1) | r1);
}
