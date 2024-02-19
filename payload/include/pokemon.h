#ifndef GUARD_POKEMON_H
#define GUARD_POKEMON_H

// Property labels for Get(Box)MonData / Set(Box)MonData
enum {
    MON_DATA_PERSONALITY,
    MON_DATA_OT_ID,
    MON_DATA_NICKNAME,
    MON_DATA_LANGUAGE,
    MON_DATA_SANITY_IS_BAD_EGG,
    MON_DATA_SANITY_HAS_SPECIES,
    MON_DATA_SANITY_IS_EGG,
    MON_DATA_OT_NAME,
    MON_DATA_MARKINGS,
    MON_DATA_CHECKSUM,
    MON_DATA_ENCRYPT_SEPARATOR,
    MON_DATA_SPECIES,
    MON_DATA_HELD_ITEM,
    MON_DATA_MOVE1,
    MON_DATA_MOVE2,
    MON_DATA_MOVE3,
    MON_DATA_MOVE4,
    MON_DATA_PP1,
    MON_DATA_PP2,
    MON_DATA_PP3,
    MON_DATA_PP4,
    MON_DATA_PP_BONUSES,
    MON_DATA_COOL,
    MON_DATA_BEAUTY,
    MON_DATA_CUTE,
    MON_DATA_EXP,
    MON_DATA_HP_EV,
    MON_DATA_ATK_EV,
    MON_DATA_DEF_EV,
    MON_DATA_SPEED_EV,
    MON_DATA_SPATK_EV,
    MON_DATA_SPDEF_EV,
    MON_DATA_FRIENDSHIP,
    MON_DATA_SMART,
    MON_DATA_POKERUS,
    MON_DATA_MET_LOCATION,
    MON_DATA_MET_LEVEL,
    MON_DATA_MET_GAME,
    MON_DATA_POKEBALL,
    MON_DATA_HP_IV,
    MON_DATA_ATK_IV,
    MON_DATA_DEF_IV,
    MON_DATA_SPEED_IV,
    MON_DATA_SPATK_IV,
    MON_DATA_SPDEF_IV,
    MON_DATA_IS_EGG,
    MON_DATA_ABILITY_NUM,
    MON_DATA_TOUGH,
    MON_DATA_SHEEN,
    MON_DATA_OT_GENDER,
    MON_DATA_COOL_RIBBON,
    MON_DATA_BEAUTY_RIBBON,
    MON_DATA_CUTE_RIBBON,
    MON_DATA_SMART_RIBBON,
    MON_DATA_TOUGH_RIBBON,
    MON_DATA_STATUS,
    MON_DATA_LEVEL,
    MON_DATA_HP,
    MON_DATA_MAX_HP,
    MON_DATA_ATK,
    MON_DATA_DEF,
    MON_DATA_SPEED,
    MON_DATA_SPATK,
    MON_DATA_SPDEF,
    MON_DATA_MAIL,
    MON_DATA_SPECIES_OR_EGG,
    MON_DATA_IVS,
    MON_DATA_CHAMPION_RIBBON,
    MON_DATA_WINNING_RIBBON,
    MON_DATA_VICTORY_RIBBON,
    MON_DATA_ARTIST_RIBBON,
    MON_DATA_EFFORT_RIBBON,
    MON_DATA_MARINE_RIBBON,
    MON_DATA_LAND_RIBBON,
    MON_DATA_SKY_RIBBON,
    MON_DATA_COUNTRY_RIBBON,
    MON_DATA_NATIONAL_RIBBON,
    MON_DATA_EARTH_RIBBON,
    MON_DATA_WORLD_RIBBON,
    MON_DATA_MODERN_FATEFUL_ENCOUNTER,
    MON_DATA_KNOWN_MOVES,
    MON_DATA_RIBBON_COUNT,
    MON_DATA_RIBBONS,
    MON_DATA_83,
    MON_DATA_ATK2,
    MON_DATA_DEF2,
    MON_DATA_SPEED2,
    MON_DATA_SPATK2,
    MON_DATA_SPDEF2,
};

struct PokemonSubstruct0
{
    u16 species;
    u16 heldItem;
    u32 experience;
    u8 ppBonuses;
    u8 friendship;
    u16 filler;
};

struct PokemonSubstruct1
{
    u16 moves[MAX_MON_MOVES];
    u8 pp[MAX_MON_MOVES];
};

struct PokemonSubstruct2
{
    u8 hpEV;
    u8 attackEV;
    u8 defenseEV;
    u8 speedEV;
    u8 spAttackEV;
    u8 spDefenseEV;
    u8 cool;
    u8 beauty;
    u8 cute;
    u8 smart;
    u8 tough;
    u8 sheen;
};

struct PokemonSubstruct3
{
    u8 pokerus;
    u8 metLocation;

    u16 metLevel:7;
    u16 metGame:4;
    u16 pokeball:4;
    u16 otGender:1;

    u32 hpIV:5;
    u32 attackIV:5;
    u32 defenseIV:5;
    u32 speedIV:5;
    u32 spAttackIV:5;
    u32 spDefenseIV:5;
    u32 isEgg:1;
    u32 abilityNum:1;

    u32 coolRibbon:3;               // Stores the highest contest rank achieved in the Cool category.
    u32 beautyRibbon:3;             // Stores the highest contest rank achieved in the Beauty category.
    u32 cuteRibbon:3;               // Stores the highest contest rank achieved in the Cute category.
    u32 smartRibbon:3;              // Stores the highest contest rank achieved in the Smart category.
    u32 toughRibbon:3;              // Stores the highest contest rank achieved in the Tough category.
    u32 championRibbon:1;           // Given when defeating the Champion. Because both RSE and FRLG use it, later generations don't specify from which region it comes from.
    u32 winningRibbon:1;            // Given at the Battle Tower's Level 50 challenge by winning a set of seven battles that extends the current streak to 56 or more.
    u32 victoryRibbon:1;            // Given at the Battle Tower's Level 100 challenge by winning a set of seven battles that extends the current streak to 56 or more.
    u32 artistRibbon:1;             // Given at the Contest Hall by winning a Master Rank contest with at least 800 points, and agreeing to have the Pokémon's portrait placed in the museum after being offered.
    u32 effortRibbon:1;             // Given at Slateport's market to Pokémon with maximum EVs.
    u32 marineRibbon:1;             // Never distributed.
    u32 landRibbon:1;               // Never distributed.
    u32 skyRibbon:1;                // Never distributed.
    u32 countryRibbon:1;            // Distributed during Pokémon Festa '04 and '05 to tournament winners.
    u32 nationalRibbon:1;           // Given to purified Shadow Pokémon in Colosseum/XD.
    u32 earthRibbon:1;              // Given to teams that have beaten Mt. Battle's 100-battle challenge in Colosseum/XD.
    u32 worldRibbon:1;              // Distributed during Pokémon Festa '04 and '05 to tournament winners.

    u32 modernFatefulEncounter:5;
    // Emerald's definition of these 5 bits are below:
    //u32 unusedRibbons:4;            // Discarded in Gen 4.

    // The functionality of this bit changed in FRLG:
    // In RS, this bit does nothing, is never set, & is accidentally unset when hatching Eggs.
    // In FRLG & Emerald, this controls Mew & Deoxys obedience and whether they can be traded.
    // If set, a Pokémon is a fateful encounter in FRLG's summary screen if hatched & for all Pokémon in Gen 4+ summary screens.
    // Set for in-game event island legendaries, events distributed after a certain date, & Pokémon from XD: Gale of Darkness.
    // Not to be confused with METLOC_FATEFUL_ENCOUNTER.
    //u32 modernFatefulEncounter:5;
};

union PokemonSubstruct
{
    struct PokemonSubstruct0 type0;
    struct PokemonSubstruct1 type1;
    struct PokemonSubstruct2 type2;
    struct PokemonSubstruct3 type3;
    u16 raw[6];
};

struct BoxPokemon
{
    u32 personality;
    u32 otId;
    u8 nickname[POKEMON_NAME_LENGTH];
    u8 language;
    u8 isBadEgg:1;
    u8 hasSpecies:1;
    u8 isEgg:1;
    u8 blockBoxRS:1; // Unused, but Pokémon Box Ruby & Sapphire will refuse to deposit a Pokémon with this flag set
    u8 unused:4;
    u8 otName[PLAYER_NAME_LENGTH];
    u8 markings;
    u16 checksum;
    u16 unknown;

    union
    {
        u32 raw[12];
        union PokemonSubstruct substructs[4];
    } secure;
};

struct Pokemon
{
    struct BoxPokemon box;
    u32 status;
    u8 level;
    u8 mail;
    u16 hp;
    u16 maxHP;
    u16 attack;
    u16 defense;
    u16 speed;
    u16 spAttack;
    u16 spDefense;
};

struct BattleTowerPokemon
{
    u16 species;
    u16 heldItem;
    u16 moves[MAX_MON_MOVES];
    u8 level;
    u8 ppBonuses;
    u8 hpEV;
    u8 attackEV;
    u8 defenseEV;
    u8 speedEV;
    u8 spAttackEV;
    u8 spDefenseEV;
    u32 otId;
    u32 hpIV:5;
    u32 attackIV:5;
    u32 defenseIV:5;
    u32 speedIV:5;
    u32 spAttackIV:5;
    u32 spDefenseIV:5;
    u32 gap:1;
    u32 abilityNum:1;
    u32 personality;
    u8 nickname[POKEMON_NAME_LENGTH + 1];
    u8 friendship;
};

struct SpeciesInfo
{
 /* 0x00 */ u8 baseHP;
 /* 0x01 */ u8 baseAttack;
 /* 0x02 */ u8 baseDefense;
 /* 0x03 */ u8 baseSpeed;
 /* 0x04 */ u8 baseSpAttack;
 /* 0x05 */ u8 baseSpDefense;
 /* 0x06 */ u8 types[2];
 /* 0x08 */ u8 catchRate;
 /* 0x09 */ u8 expYield;
 /* 0x0A */ u16 evYield_HP:2;
 /* 0x0A */ u16 evYield_Attack:2;
 /* 0x0A */ u16 evYield_Defense:2;
 /* 0x0A */ u16 evYield_Speed:2;
 /* 0x0B */ u16 evYield_SpAttack:2;
 /* 0x0B */ u16 evYield_SpDefense:2;
 /* 0x0C */ u16 itemCommon;
 /* 0x0E */ u16 itemRare;
 /* 0x10 */ u8 genderRatio;
 /* 0x11 */ u8 eggCycles;
 /* 0x12 */ u8 friendship;
 /* 0x13 */ u8 growthRate;
 /* 0x14 */ u8 eggGroups[2];
 /* 0x16 */ u8 abilities[2];
 /* 0x18 */ u8 safariZoneFleeRate;
 /* 0x19 */ u8 bodyColor : 7;
            u8 noFlip : 1;
};

struct PokemonStorage
{
    /*0x0000*/ u8 currentBox;
    /*0x0004*/ struct BoxPokemon boxes[14][30];
    /*0x8344*/ u8 boxNames[14][9];
    /*0x83c2*/ u8 wallpaper[14];
};

struct BattleMove
{
    u8 effect;
    u8 power;
    u8 type;
    u8 accuracy;
    u8 pp;
    u8 secondaryEffectChance;
    u8 target;
    s8 priority;
    u8 flags;
};

struct SpindaSpot
{
    u8 x, y;
    u16 image[16];
};

u32 GetBoxMonData(struct BoxPokemon *boxMon, s32 field, u8 *data);
const struct CompressedSpritePalette *GetBoxMonPalettePtr(u32 partyId);
u32 GetBoxMonAbility(struct BoxPokemon *boxMon);
const u32 *BoxMonGetCaughtBallItemSpriteSheet(struct BoxPokemon *boxMon);
const u32 *BoxMonGetCaughtBallItemPalette(struct BoxPokemon *boxMon);
u32 GetBoxMonMoveBySlot(struct BoxPokemon *boxMon, s32 slot);
u32 GetBoxMonPPByMoveSlot(struct BoxPokemon *boxMon, u8 slot);
u32 CheckPartyPokerus(struct Pokemon *party, u8 selection);
u32 GetMonStatus(struct Pokemon *mon);
u32 CheckPartyHasHadPokerus(struct Pokemon *party, u8 selection);
void DrawSpindasSpots(u16 species, u32 personality, u8 *dest);
void SetBoxMonData(struct BoxPokemon *boxMon, s32 field, const void *dataArg);
void SetMonData(struct Pokemon *mon, s32 field, const void *dataArg);
void GiveGiftRibbonToParty(s32 index_, s32 ribbonId);
u32 GetMonData(struct Pokemon *mon, s32 field, u8 *data);
u8 GetMonGender(struct Pokemon *mon);
const struct CompressedSpritePalette *GetMonPalettePtrBySpeciesIdPersonality(u16 species, u32 otId, u32 personality);
u16 FixUnownSpecies(u16 species, u32 personality);
void GetSpeciesName(u8 *name, s32 species);
u32 GetMonType(struct Pokemon *mon, u32 which);
u32 GetMonSpritePaletteNumByBaseBlock(u32 id);
const u8 *GetAbilityName(u32 ability);
const u8 *GetAbilityDescription(u32 ability);
s32 CalculatePPWithBonus(u32 move, s32 ppBonuses, u32 moveIndex);
void CopyMoveName(u8 *dst, u32 move);
struct Pokemon *GetPtrToEmptyPartySlot(void);

#endif // GUARD_POKEMON_H
