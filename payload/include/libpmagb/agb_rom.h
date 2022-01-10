#ifndef PMAGB_AGB_ROM_H
#define PMAGB_AGB_ROM_H

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
    /*0x50*/ u32 flagsOffs;
    /*0x54*/ u32 varsOffs;
    /*0x58*/ u32 pokedexOffs;
    /*0x5C*/ u32 dexSeen2Offs;
    /*0x60*/ u32 dexSeen3Offs;
    /*0x64*/ u32 pokedexVar;
    /*0x68*/ u32 pokedexFlag;
    /*0x6C*/ u32 mysteryEventFlag;
    /*0x70*/ u32 pokedexCount;
    /*0x74*/ u8 playerNameLength;
    /*0x75*/ u8 unk75;
    /*0x76*/ u8 pokemonNameLength_1;
    /*0x77*/ u8 pokemonNameLength_2;
    /*0x78*/ u8 unk78;
    /*0x79*/ u8 unk79;
    /*0x7A*/ u8 unk7A;
    /*0x7B*/ u8 unk7B;
    /*0x7C*/ u8 unk7C;
    /*0x7D*/ u8 unk7D;
    /*0x7E*/ u8 unk7E;
    /*0x7F*/ u8 unk7F;
    /*0x80*/ u8 unk80;
    /*0x81*/ u8 unk81;
    /*0x82*/ u8 unk82;
    /*0x83*/ u8 unk83;
    /*0x84*/ u8 unk84;
    /*0x88*/ size_t saveBlock2Size;
    /*0x8C*/ size_t saveBlock1Size;
    /*0x90*/ u32 playerPartyCountOffs;
    /*0x94*/ u32 playerPartyOffs;
    /*0x98*/ u32 sb2SpecialSaveWarpOffs;
    /*0x9C*/ u32 sb2PlayerIdOffs;
    /*0xA0*/ u32 sb2PlayerNameOffs;
    /*0xA4*/ u32 sb2PlayerGenderOffs;
    /*0xA8*/ u32 unkA8;
    /*0xAC*/ u32 unkAC;
    /*0xB0*/ u32 externalEventFlagsOffs;
    /*0xB4*/ u32 externalEventDataOffs;
    /*0xB8*/ u8 unkB8_0:1;
    /*0xB8*/ u8 unkB8_1:1;
    /*0xBC*/ const struct BaseStats *baseStats;
    /*0xC0*/ const u8 *abilityNames;
    /*0xC4*/ const u8 *abilityDescriptions;
    /*0xC8*/ const struct Item *items;
    /*0xCC*/ const struct BattleMove *battleMoves;
    /*0xD0*/ const struct CompressedSpriteSheet *ballSpriteSheets;
    /*0xD4*/ const struct CompressedSpritePalette *ballSpritePalettes;
    /*0xD8*/ u32 gcnLinkFlagsOffs;
    /*0xDC*/ u32 sysGameClearFlagIdx;
    /*0xE0*/ u32 sysRibbonGetFlagIdx;
    /*0xE4*/ u8 bagCountItems;
    /*0xE5*/ u8 bagCountKeyItems;
    /*0xE6*/ u8 bagCountPokeballs;
    /*0xE7*/ u8 bagCountTMHMs;
    /*0xE8*/ u8 bagCountBerries;
    /*0xE9*/ u8 pcItemsCount;
    /*0xEC*/ u32 pcItemsOffs;
    /*0xF0*/ u32 giftRibbonsOffs;
    /*0xF4*/ u32 enigmaBerryOffs;
    /*0xF8*/ size_t enigmaBerrySize;
    /*0xFC*/ const u8 *moveDescriptions;
};

const struct RomInfo * gAgbPmRomParams;

extern void * gSaveBlock1Ptr;
extern void * gSaveBlock1BakPtr;
extern void * gSaveBlock2Ptr;
extern struct PokemonStorage * gPokemonStoragePtr;

extern struct Pokemon * gPlayerPartyPtr;
extern struct Pokemon * gPlayerPartyBakPtr;
extern u8 * gPlayerPartyCountPtr;
extern struct Pokedex * gPokedexPtr;
extern u8 * gDexSeen2Ptr;
extern u8 * gDexSeen3Ptr;
extern struct ItemSlot * gPcItemsPtr;
extern u8 * gFlagsPtr;
extern u16 * gVarsPtr;
extern u8 * gGiftRibbonsPtr;
extern struct EnigmaBerry * gEnigmaBerryPtr;

#endif //PMAGB_AGB_ROM_H
