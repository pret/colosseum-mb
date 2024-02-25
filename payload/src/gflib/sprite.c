#include "global.h"
#include "gflib/sprite.h"

static struct Sprite sSprites[18];

struct OamBuffer
{
    struct OamData oamBuffer[0x80];
    u8 numSprites;
};

static struct OamBuffer sOamBuffer;

static void InsertSprite(struct Sprite * sprite1, struct Sprite * sprite2)
{
    sprite2->next = sprite1->next;
    sprite2->prev = sprite1 - sSprites;
    sprite1->next = sSprites[sprite1->next].prev = sprite2 - sSprites;
}

struct Sprite * AddSprite(s32 x, s32 y, const struct Subsprites * subsprites)
{
    s32 i;
    struct Sprite * newSprite = &sSprites[sSprites[0].next];

    sSprites[newSprite->prev].next = newSprite->next;
    sSprites[newSprite->next].prev = newSprite->prev;
    InsertSprite(&sSprites[1], newSprite);
    newSprite->x = x;
    newSprite->y = y;
    newSprite->spriteTemplates = subsprites;
    newSprite->flag = 0;
    newSprite->paletteNum = 0;
    newSprite->tileOffset = 0;
    newSprite->callback = NULL;
    for (i = 0; i < 4; i++)
        newSprite->data[i] = 0;
    return newSprite;
}

static void BufferSpriteOAM(struct Sprite * sprite)
{
    u32 numSprites;
    struct OamData * oam;
    const struct Subsprites * templates;
    s32 width;
    s32 left;
    s32 top;
    s32 height;
    u32 size;
    u32 flags;

    numSprites = sOamBuffer.numSprites;
    oam = &sOamBuffer.oamBuffer[numSprites];
    templates = sprite->spriteTemplates;

    while (templates->oam != 0xFFFF)
    {
        if (numSprites == 0x80)
            return;

        if ((left = templates->x + sprite->x) < 0xF0 && (top = templates->y + sprite->y) < 0xA0)
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
                    *(u32 *)oam = top | ((left << 16) | flags);
                    *((u16 *)oam + 2) = ((templates->baseBlock & 0xFFF) | sprite->paletteNum) + sprite->tileOffset;
                    oam++;
                    numSprites++;
                }
            }
        }
        templates++;
    }
    sOamBuffer.numSprites = numSprites;
}

void UpdateSprites(void)
{
    s32 numSprites;
    s32 i;
    struct OamData * oam;
    struct Sprite * sprite;

    i = sSprites[1].next;

    while (i != 1)
    {
        sprite = &sSprites[i];

        if (sprite->callback != NULL)
            sprite->callback(sprite);

        if (!(sprite->flag & 1))
            BufferSpriteOAM(sprite);
        i = sprite->next;
    }

    oam = &sOamBuffer.oamBuffer[sOamBuffer.numSprites];
    for (numSprites = sOamBuffer.numSprites; numSprites < 0x80 && *(u16 *)oam != 0x200; numSprites++, oam++)
    {
        *(u16 *)oam = 0x200;
    }
    sOamBuffer.numSprites = 0;
}

void ResetSprites(void)
{
    s32 i;
    struct OamData * oam;
    struct Sprite * sprite;

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
    oam = &sOamBuffer.oamBuffer[0];
    for (i = 0; i < 0x80; i++, oam++)
        *(u16 *)oam = 0x200;
}

void MoveSpriteToHead(struct Sprite * sprite)
{
    sSprites[sprite->prev].next = sprite->next;
    sSprites[sprite->next].prev = sprite->prev;
    InsertSprite(&sSprites[0], sprite);
}

void DoOamBufferTransfer(void)
{
    DmaCopy32(3, sOamBuffer.oamBuffer, (void *)OAM, OAM_SIZE);
}

void SetSpritePos(struct Sprite * sprite, s32 x, s32 y)
{
    sprite->x = x;
    sprite->y = y;
}

void AddSpritePos(struct Sprite * sprite, s32 x, s32 y)
{
    sprite->x += x;
    sprite->y += y;
}

void SetSpritePaletteNum(struct Sprite * sprite, s32 paletteNum)
{
    sprite->paletteNum = paletteNum << 12;
}

void SetSpriteTileOffset(struct Sprite * sprite, s32 tileOffset)
{
    sprite->tileOffset = tileOffset;
}

void SetSpriteInvisible(struct Sprite * sprite, s32 invisible)
{
    sprite->flag = ((sprite->flag & ~1) | invisible);
}
