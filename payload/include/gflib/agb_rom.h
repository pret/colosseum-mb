#ifndef GFLIB_AGB_ROM_H
#define GFLIB_AGB_ROM_H

struct RomInfo
{
    /*0x00*/ int gameVersion;
    /*0x04*/ int gameLanguage;
    /*0x08*/ char gameTitle[32];
    /*0x28*/ const struct CompressedSpriteSheet *monFrontPicTable;
    /*0x2C*/ const struct CompressedSpriteSheet * monBackPicTable;
    /*0x30*/ const struct CompressedSpritePalette *monPaletteTable;
    /*0x34*/ const struct CompressedSpritePalette *monShinyPaletteTable;
    /*0x38*/ const u8 *const *monIconTable;
    /*0x3C*/ const u8 *gMonIconPaletteIndices;
    /*0x40*/ const struct SpritePalette *monIconPaletteTable;
    /*0x44*/ const u8 *speciesNames;
    /*0x48*/ const u8 *moveNames;
    /*0x4C*/ const struct Decoration *decorations;
    /*0x50*/ ptrdiff_t unk50;
    /*0x54*/ ptrdiff_t unk54;
    /*0x58*/ ptrdiff_t unk58;
    /*0x5C*/ ptrdiff_t unk5C;
    /*0x60*/ ptrdiff_t unk60;
    /*0x64*/ ptrdiff_t unk64;
    /*0x68*/ ptrdiff_t unk68;
    /*0x6C*/ ptrdiff_t unk6C;
    /*0x70*/ ptrdiff_t unk70;
    /*0x74*/ u8 unk74[16];
    /*0x84*/ ptrdiff_t unk84;
    /*0x88*/ ptrdiff_t unk88;
    /*0x8C*/ ptrdiff_t unk8C;
    /*0x90*/ ptrdiff_t unk90;
    /*0x94*/ ptrdiff_t unk94;
    /*0x98*/ ptrdiff_t unk98;
    /*0x9C*/ ptrdiff_t unk9C;
    /*0xA0*/ ptrdiff_t unkA0;
    /*0xA4*/ ptrdiff_t unkA4;
    /*0xA8*/ ptrdiff_t unkA8;
    /*0xAC*/ ptrdiff_t unkAC;
    /*0xB0*/ ptrdiff_t unkB0;
    /*0xB4*/ ptrdiff_t unkB4;
    /*0xB8*/ ptrdiff_t unkB8;
    /*0xBC*/ const struct BaseStats *baseStats;
    /*0xC0*/ const u8 *abilityNames;
    /*0xC4*/ const u8 *abilityDescriptions;
    /*0xC8*/ const struct Item *items;
    /*0xCC*/ const struct BattleMove *unkCC;
    /*0xD0*/ const struct CompressedSpriteSheet *ballSpriteSheets;
    /*0xD4*/ const struct CompressedSpritePalette *ballSpritePalettes;
    /*0xD8*/ ptrdiff_t unkD8;
    /*0xDC*/ ptrdiff_t unkDC;
    /*0xE0*/ ptrdiff_t unkE0;
    /*0xE4*/ ptrdiff_t unkE4;
    /*0xE8*/ ptrdiff_t unkE8;
    /*0xEC*/ ptrdiff_t unkEC;
    /*0xF0*/ ptrdiff_t unkF0;
    /*0xF4*/ ptrdiff_t unkF4;
    /*0xF8*/ ptrdiff_t unkF8;
    /*0xFC*/ const u8 *moveDescriptions;
};

#endif //GFLIB_AGB_ROM_H