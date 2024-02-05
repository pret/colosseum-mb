#include "global.h"
#include "libpmagb/agb_rom.h"
#include "rom_info.h"

// Ruby rev0
struct RomInfo gAgbPmRomParams_AXVE_rev0 = {
    .gameVersion = VERSION_RUBY,
    .gameLanguage = LANGUAGE_ENGLISH,
    .gameTitle = "pokemon ruby version",
    .monFrontPicTable = (const struct CompressedSpriteSheet *)0x081e8354,
    .monBackPicTable = (const struct CompressedSpriteSheet *)0x081e97f4,
    .monPaletteTable = (const struct CompressedSpritePalette *)0x081ea5b4,
    .monShinyPaletteTable = (const struct CompressedSpritePalette *)0x081eb374,
    .monIconTable = (const u8 *const *)0x083bbd20,
    .gMonIconPaletteIndices = (const u8 *)0x083bc400,
    .monIconPaletteTable = (const struct SpritePalette *)0x083bc5b8,
    .speciesNames = (const u8 *)0x081f716c,
    .moveNames = (const u8 *)0x081f8320,
    .decorations = (const struct Decoration *)0x083eb6c4,
    .flagsOffs = offsetof(struct SaveBlock1, flags),
    .varsOffs = offsetof(struct SaveBlock1, vars),
    .pokedexOffs = offsetof(struct SaveBlock2, pokedex),
    .dexSeen2Offs = offsetof(struct SaveBlock1, dexSeen2),
    .dexSeen3Offs = offsetof(struct SaveBlock1, dexSeen3),
    .pokedexVar = VAR_NATIONAL_DEX - VARS_START,
    .pokedexFlag = FLAG_SYS_NATIONAL_DEX,
    .mysteryEventFlag = FLAG_SYS_EXDATA_ENABLE,
    .pokedexCount = NATIONAL_DEX_COUNT,
    .playerNameLength = PLAYER_NAME_LENGTH,
    .unk75 = 10,
    .pokemonNameLength_1 = POKEMON_NAME_LENGTH,
    .pokemonNameLength_2 = POKEMON_NAME_LENGTH,
    .unk78 = 12,
    .unk79 = 12,
    .unk7A = 6,
    .unk7B = 12,
    .unk7C = 6,
    .unk7D = 16,
    .unk7E = 18,
    .unk7F = 12,
    .unk80 = 15,
    .unk81 = 11,
    .unk82 = 1,
    .unk83 = 8,
    .unk84 = 12,
    .saveBlock2Size = sizeof(struct SaveBlock2),
    .saveBlock1Size = sizeof(struct SaveBlock1),
    .playerPartyCountOffs = offsetof(struct SaveBlock1, playerPartyCount),
    .playerPartyOffs = offsetof(struct SaveBlock1, playerParty),
    .sb2SpecialSaveWarpOffs = offsetof(struct SaveBlock2, specialSaveWarp),
    .sb2PlayerIdOffs = offsetof(struct SaveBlock2, playerTrainerId),
    .sb2PlayerNameOffs = offsetof(struct SaveBlock2, playerName),
    .sb2PlayerGenderOffs = offsetof(struct SaveBlock2, playerGender),
    .unkA8 = offsetof(struct SaveBlock2, battleTower.var_4AE[0]),
    .unkAC = offsetof(struct SaveBlock2, battleTower.var_4AE[1]),
    .externalEventFlagsOffs = offsetof(struct SaveBlock1, externalEventFlags),
    .externalEventDataOffs = offsetof(struct SaveBlock1, externalEventData),
    .unkB8_0 = FALSE,
    .unkB8_1 = FALSE,
    .baseStats = (const struct BaseStats *)0x081fec18,
    .abilityNames = (const u8 *)0x081fa248,
    .abilityDescriptions = (const u8 *)0x081fa110,
    .items = (const struct Item *)0x083c5564,
    .battleMoves = (const struct BattleMove *)0x081fb12c,
    .ballSpriteSheets = (const struct CompressedSpriteSheet *)0x0820a92c,
    .ballSpritePalettes = (const struct CompressedSpritePalette *)0x0820a98c,
    .sysGameClearFlagIdx = FLAG_SYS_GAME_CLEAR,
    .sysRibbonGetFlagIdx = FLAG_SYS_RIBBON_GET,
    .bagCountItems = BAG_ITEMS_COUNT,
    .bagCountKeyItems = BAG_KEYITEMS_COUNT,
    .bagCountPokeballs = BAG_POKEBALLS_COUNT,
    .bagCountTMHMs = BAG_TMHM_COUNT,
    .bagCountBerries = BAG_BERRIES_COUNT,
    .pcItemsCount = PC_ITEMS_COUNT,
    .pcItemsOffs = offsetof(struct SaveBlock1, pcItems),
    .giftRibbonsOffs = offsetof(struct SaveBlock1, giftRibbons),
    .enigmaBerryOffs = offsetof(struct SaveBlock1, enigmaBerry),
    .enigmaBerrySize = sizeof(struct EnigmaBerry),
    .moveDescriptions = (const u8 *)0x083c09d8,
};

// Ruby rev1
struct RomInfo gAgbPmRomParams_AXVE_rev2 = {
    .gameVersion = VERSION_RUBY,
    .gameLanguage = LANGUAGE_ENGLISH,
    .gameTitle = "pokemon ruby version",
    .monFrontPicTable = (const struct CompressedSpriteSheet *)0x081e836c,
    .monBackPicTable = (const struct CompressedSpriteSheet *)0x081e980c,
    .monPaletteTable = (const struct CompressedSpritePalette *)0x081ea5cc,
    .monShinyPaletteTable = (const struct CompressedSpritePalette *)0x081eb38c,
    .monIconTable = (const u8 *const *)0x083bbd3c,
    .gMonIconPaletteIndices = (const u8 *)0x083bc41c,
    .monIconPaletteTable = (const struct SpritePalette *)0x083bc5d4,
    .speciesNames = (const u8 *)0x081f7184,
    .moveNames = (const u8 *)0x081f8338,
    .decorations = (const struct Decoration *)0x083eb6e0,
    .flagsOffs = offsetof(struct SaveBlock1, flags),
    .varsOffs = offsetof(struct SaveBlock1, vars),
    .pokedexOffs = offsetof(struct SaveBlock2, pokedex),
    .dexSeen2Offs = offsetof(struct SaveBlock1, dexSeen2),
    .dexSeen3Offs = offsetof(struct SaveBlock1, dexSeen3),
    .pokedexVar = VAR_NATIONAL_DEX - VARS_START,
    .pokedexFlag = FLAG_SYS_NATIONAL_DEX,
    .mysteryEventFlag = FLAG_SYS_EXDATA_ENABLE,
    .pokedexCount = NATIONAL_DEX_COUNT,
    .playerNameLength = PLAYER_NAME_LENGTH,
    .unk75 = 10,
    .pokemonNameLength_1 = POKEMON_NAME_LENGTH,
    .pokemonNameLength_2 = POKEMON_NAME_LENGTH,
    .unk78 = 12,
    .unk79 = 12,
    .unk7A = 6,
    .unk7B = 12,
    .unk7C = 6,
    .unk7D = 16,
    .unk7E = 18,
    .unk7F = 12,
    .unk80 = 15,
    .unk81 = 11,
    .unk82 = 1,
    .unk83 = 8,
    .unk84 = 12,
    .saveBlock2Size = sizeof(struct SaveBlock2),
    .saveBlock1Size = sizeof(struct SaveBlock1),
    .playerPartyCountOffs = offsetof(struct SaveBlock1, playerPartyCount),
    .playerPartyOffs = offsetof(struct SaveBlock1, playerParty),
    .sb2SpecialSaveWarpOffs = offsetof(struct SaveBlock2, specialSaveWarp),
    .sb2PlayerIdOffs = offsetof(struct SaveBlock2, playerTrainerId),
    .sb2PlayerNameOffs = offsetof(struct SaveBlock2, playerName),
    .sb2PlayerGenderOffs = offsetof(struct SaveBlock2, playerGender),
    .unkA8 = offsetof(struct SaveBlock2, battleTower.var_4AE[0]),
    .unkAC = offsetof(struct SaveBlock2, battleTower.var_4AE[1]),
    .externalEventFlagsOffs = offsetof(struct SaveBlock1, externalEventFlags),
    .externalEventDataOffs = offsetof(struct SaveBlock1, externalEventData),
    .unkB8_0 = FALSE,
    .unkB8_1 = FALSE,
    .baseStats = (const struct BaseStats *)0x081fec30,
    .abilityNames = (const u8 *)0x081fa260,
    .abilityDescriptions = (const u8 *)0x081fa128,
    .items = (const struct Item *)0x083c5580,
    .battleMoves = (const struct BattleMove *)0x081fb144,
    .ballSpriteSheets = (const struct CompressedSpriteSheet *)0x0820a944,
    .ballSpritePalettes = (const struct CompressedSpritePalette *)0x0820a9a4,
    .sysGameClearFlagIdx = FLAG_SYS_GAME_CLEAR,
    .sysRibbonGetFlagIdx = FLAG_SYS_RIBBON_GET,
    .bagCountItems = BAG_ITEMS_COUNT,
    .bagCountKeyItems = BAG_KEYITEMS_COUNT,
    .bagCountPokeballs = BAG_POKEBALLS_COUNT,
    .bagCountTMHMs = BAG_TMHM_COUNT,
    .bagCountBerries = BAG_BERRIES_COUNT,
    .pcItemsCount = PC_ITEMS_COUNT,
    .pcItemsOffs = offsetof(struct SaveBlock1, pcItems),
    .giftRibbonsOffs = offsetof(struct SaveBlock1, giftRibbons),
    .enigmaBerryOffs = offsetof(struct SaveBlock1, enigmaBerry),
    .enigmaBerrySize = sizeof(struct EnigmaBerry),
    .moveDescriptions = (const u8 *)0x083c09f4,
};

// Sapphire rev0
struct RomInfo gAgbPmRomParams_AXPE_rev0 = {
    .gameVersion = VERSION_SAPPHIRE,
    .gameLanguage = LANGUAGE_ENGLISH,
    .gameTitle = "pokemon sapphire version",
    .monFrontPicTable = (const struct CompressedSpriteSheet *)0x081e82e4,
    .monBackPicTable = (const struct CompressedSpriteSheet *)0x081e9784,
    .monPaletteTable = (const struct CompressedSpritePalette *)0x081ea544,
    .monShinyPaletteTable = (const struct CompressedSpritePalette *)0x081eb304,
    .monIconTable = (const u8 *const *)0x083bbd78,
    .gMonIconPaletteIndices = (const u8 *)0x083bc458,
    .monIconPaletteTable = (const struct SpritePalette *)0x083bc610,
    .speciesNames = (const u8 *)0x081f70fc,
    .moveNames = (const u8 *)0x081f82b0,
    .decorations = (const struct Decoration *)0x083eb71c,
    .flagsOffs = offsetof(struct SaveBlock1, flags),
    .varsOffs = offsetof(struct SaveBlock1, vars),
    .pokedexOffs = offsetof(struct SaveBlock2, pokedex),
    .dexSeen2Offs = offsetof(struct SaveBlock1, dexSeen2),
    .dexSeen3Offs = offsetof(struct SaveBlock1, dexSeen3),
    .pokedexVar = VAR_NATIONAL_DEX - VARS_START,
    .pokedexFlag = FLAG_SYS_NATIONAL_DEX,
    .mysteryEventFlag = FLAG_SYS_EXDATA_ENABLE,
    .pokedexCount = NATIONAL_DEX_COUNT,
    .playerNameLength = PLAYER_NAME_LENGTH,
    .unk75 = 10,
    .pokemonNameLength_1 = POKEMON_NAME_LENGTH,
    .pokemonNameLength_2 = POKEMON_NAME_LENGTH,
    .unk78 = 12,
    .unk79 = 12,
    .unk7A = 6,
    .unk7B = 12,
    .unk7C = 6,
    .unk7D = 16,
    .unk7E = 18,
    .unk7F = 12,
    .unk80 = 15,
    .unk81 = 11,
    .unk82 = 1,
    .unk83 = 8,
    .unk84 = 12,
    .saveBlock2Size = sizeof(struct SaveBlock2),
    .saveBlock1Size = sizeof(struct SaveBlock1),
    .playerPartyCountOffs = offsetof(struct SaveBlock1, playerPartyCount),
    .playerPartyOffs = offsetof(struct SaveBlock1, playerParty),
    .sb2SpecialSaveWarpOffs = offsetof(struct SaveBlock2, specialSaveWarp),
    .sb2PlayerIdOffs = offsetof(struct SaveBlock2, playerTrainerId),
    .sb2PlayerNameOffs = offsetof(struct SaveBlock2, playerName),
    .sb2PlayerGenderOffs = offsetof(struct SaveBlock2, playerGender),
    .unkA8 = offsetof(struct SaveBlock2, battleTower.var_4AE[0]),
    .unkAC = offsetof(struct SaveBlock2, battleTower.var_4AE[1]),
    .externalEventFlagsOffs = offsetof(struct SaveBlock1, externalEventFlags),
    .externalEventDataOffs = offsetof(struct SaveBlock1, externalEventData),
    .unkB8_0 = FALSE,
    .unkB8_1 = FALSE,
    .baseStats = (const struct BaseStats *)0x081feba8,
    .abilityNames = (const u8 *)0x081fa1d8,
    .abilityDescriptions = (const u8 *)0x081fa0a0,
    .items = (const struct Item *)0x083c55bc,
    .battleMoves = (const struct BattleMove *)0x081fb0bc,
    .ballSpriteSheets = (const struct CompressedSpriteSheet *)0x0820a8bc,
    .ballSpritePalettes = (const struct CompressedSpritePalette *)0x0820a91c,
    .sysGameClearFlagIdx = FLAG_SYS_GAME_CLEAR,
    .sysRibbonGetFlagIdx = FLAG_SYS_RIBBON_GET,
    .bagCountItems = BAG_ITEMS_COUNT,
    .bagCountKeyItems = BAG_KEYITEMS_COUNT,
    .bagCountPokeballs = BAG_POKEBALLS_COUNT,
    .bagCountTMHMs = BAG_TMHM_COUNT,
    .bagCountBerries = BAG_BERRIES_COUNT,
    .pcItemsCount = PC_ITEMS_COUNT,
    .pcItemsOffs = offsetof(struct SaveBlock1, pcItems),
    .giftRibbonsOffs = offsetof(struct SaveBlock1, giftRibbons),
    .enigmaBerryOffs = offsetof(struct SaveBlock1, enigmaBerry),
    .enigmaBerrySize = sizeof(struct EnigmaBerry),
    .moveDescriptions = (const u8 *)0x083c0a30,
};

// Sapphire rev2
struct RomInfo gAgbPmRomParams_AXPE_rev2 = {
    .gameVersion = VERSION_SAPPHIRE,
    .gameLanguage = LANGUAGE_ENGLISH,
    .gameTitle = "pokemon sapphire version",
    .monFrontPicTable = (const struct CompressedSpriteSheet *)0x081e82fc,
    .monBackPicTable = (const struct CompressedSpriteSheet *)0x081e979c,
    .monPaletteTable = (const struct CompressedSpritePalette *)0x081ea55c,
    .monShinyPaletteTable = (const struct CompressedSpritePalette *)0x081eb31c,
    .monIconTable = (const u8 *const *)0x083bbd98,
    .gMonIconPaletteIndices = (const u8 *)0x083bc478,
    .monIconPaletteTable = (const struct SpritePalette *)0x083bc630,
    .speciesNames = (const u8 *)0x081f7114,
    .moveNames = (const u8 *)0x081f82c8,
    .decorations = (const struct Decoration *)0x083eb73c,
    .flagsOffs = offsetof(struct SaveBlock1, flags),
    .varsOffs = offsetof(struct SaveBlock1, vars),
    .pokedexOffs = offsetof(struct SaveBlock2, pokedex),
    .dexSeen2Offs = offsetof(struct SaveBlock1, dexSeen2),
    .dexSeen3Offs = offsetof(struct SaveBlock1, dexSeen3),
    .pokedexVar = VAR_NATIONAL_DEX - VARS_START,
    .pokedexFlag = FLAG_SYS_NATIONAL_DEX,
    .mysteryEventFlag = FLAG_SYS_EXDATA_ENABLE,
    .pokedexCount = NATIONAL_DEX_COUNT,
    .playerNameLength = PLAYER_NAME_LENGTH,
    .unk75 = 10,
    .pokemonNameLength_1 = POKEMON_NAME_LENGTH,
    .pokemonNameLength_2 = POKEMON_NAME_LENGTH,
    .unk78 = 12,
    .unk79 = 12,
    .unk7A = 6,
    .unk7B = 12,
    .unk7C = 6,
    .unk7D = 16,
    .unk7E = 18,
    .unk7F = 12,
    .unk80 = 15,
    .unk81 = 11,
    .unk82 = 1,
    .unk83 = 8,
    .unk84 = 12,
    .saveBlock2Size = sizeof(struct SaveBlock2),
    .saveBlock1Size = sizeof(struct SaveBlock1),
    .playerPartyCountOffs = offsetof(struct SaveBlock1, playerPartyCount),
    .playerPartyOffs = offsetof(struct SaveBlock1, playerParty),
    .sb2SpecialSaveWarpOffs = offsetof(struct SaveBlock2, specialSaveWarp),
    .sb2PlayerIdOffs = offsetof(struct SaveBlock2, playerTrainerId),
    .sb2PlayerNameOffs = offsetof(struct SaveBlock2, playerName),
    .sb2PlayerGenderOffs = offsetof(struct SaveBlock2, playerGender),
    .unkA8 = offsetof(struct SaveBlock2, battleTower.var_4AE[0]),
    .unkAC = offsetof(struct SaveBlock2, battleTower.var_4AE[1]),
    .externalEventFlagsOffs = offsetof(struct SaveBlock1, externalEventFlags),
    .externalEventDataOffs = offsetof(struct SaveBlock1, externalEventData),
    .unkB8_0 = FALSE,
    .unkB8_1 = FALSE,
    .baseStats = (const struct BaseStats *)0x081febc0,
    .abilityNames = (const u8 *)0x081fa1f0,
    .abilityDescriptions = (const u8 *)0x081fa0b8,
    .items = (const struct Item *)0x083c55dc,
    .battleMoves = (const struct BattleMove *)0x081fb0d4,
    .ballSpriteSheets = (const struct CompressedSpriteSheet *)0x0820a8d4,
    .ballSpritePalettes = (const struct CompressedSpritePalette *)0x0820a934,
    .sysGameClearFlagIdx = FLAG_SYS_GAME_CLEAR,
    .sysRibbonGetFlagIdx = FLAG_SYS_RIBBON_GET,
    .bagCountItems = BAG_ITEMS_COUNT,
    .bagCountKeyItems = BAG_KEYITEMS_COUNT,
    .bagCountPokeballs = BAG_POKEBALLS_COUNT,
    .bagCountTMHMs = BAG_TMHM_COUNT,
    .bagCountBerries = BAG_BERRIES_COUNT,
    .pcItemsCount = PC_ITEMS_COUNT,
    .pcItemsOffs = offsetof(struct SaveBlock1, pcItems),
    .giftRibbonsOffs = offsetof(struct SaveBlock1, giftRibbons),
    .enigmaBerryOffs = offsetof(struct SaveBlock1, enigmaBerry),
    .enigmaBerrySize = sizeof(struct EnigmaBerry),
    .moveDescriptions = (const u8 *)0x083c0a50,
};
