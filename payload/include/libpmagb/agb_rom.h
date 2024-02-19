#ifndef PMAGB_AGB_ROM_H
#define PMAGB_AGB_ROM_H

struct GFRomHeader
{
    u32 version;
    u32 language;
    u8 gameName[32];
    const struct CompressedSpriteSheet * monFrontPics;
    const struct CompressedSpriteSheet * monBackPics;
    const struct CompressedSpritePalette * monNormalPalettes;
    const struct CompressedSpritePalette * monShinyPalettes;
    const u8 * const * monIcons;
    const u8 * monIconPaletteIds;
    const struct SpritePalette * monIconPalettes;
    const u8 (* monSpeciesNames)[][POKEMON_NAME_LENGTH + 1];
    const u8 (* moveNames)[][MOVE_NAME_LENGTH + 1];
    const struct Decoration * decorations;
    u32 flagsOffset;
    u32 varsOffset;
    u32 pokedexOffset;
    u32 seen1Offset;
    u32 seen2Offset;
    u32 pokedexVar;
    u32 pokedexFlag;
    u32 mysteryEventFlag;
    u32 pokedexCount;
    u8 playerNameLength;
    u8 trainerNameLength;
    u8 pokemonNameLength1;
    u8 pokemonNameLength2;
    u8 moveNameLength;
    u8 itemNameLength;
    u8 berryNameLength;
    u8 abilityNameLength;
    u8 typeNameLength;
    u8 mapNameLength1;
    u8 mapNameLength2;
    u8 trainerClassNameLength;
    u8 decorationNameLength;
    u8 dexCategoryNameLength;
    u8 endOfStringLength;
    u8 frontierTrainerNameLength;
    u8 easyChatWordLength;
    u32 saveBlock2Size;
    u32 saveBlock1Size;
    u32 partyCountOffset;
    u32 partyOffset;
    u32 warpFlagsOffset;
    u32 trainerIdOffset;
    u32 playerNameOffset;
    u32 playerGenderOffset;
    u32 frontierStatusOffset;
    u32 frontierStatusOffset2;
    u32 externalEventFlagsOffset;
    u32 externalEventDataOffset;
    u32 blockLinkBoxRS:1;
    u32 blockLinkColoXD:1;
    u32 blockLinkUnused:30;
    const struct SpeciesInfo * speciesInfo;
    const u8 (* abilityNames)[][ABILITY_NAME_LENGTH + 1];
    const u8 **abilityDescriptions;
    const struct Item * items;
    const struct BattleMove * moves;
    const struct CompressedSpriteSheet * ballGfx;
    const struct CompressedSpritePalette * ballPalettes;
    u32 gcnLinkFlagsOffset;
    s32 gameClearFlag;
    u32 ribbonFlag;
    u8 bagCountItems;
    u8 bagCountKeyItems;
    u8 bagCountPokeballs;
    u8 bagCountTMHMs;
    u8 bagCountBerries;
    u8 pcItemsCount;
    u32 pcItemsOffset;
    u32 giftRibbonsOffset;
    u32 enigmaBerryOffset;
    u32 enigmaBerrySize;
    const u8 * moveDescriptions;
};

const struct GFRomHeader * gAgbPmRomParams;

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

void SaveBlocksInit(void);

#endif //PMAGB_AGB_ROM_H
