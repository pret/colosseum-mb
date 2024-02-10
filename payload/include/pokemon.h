#ifndef GUARD_POKEMON_H
#define GUARD_POKEMON_H

struct PokemonSubstruct0
{
    u16 species;
    u16 heldItem;
    u32 experience;
    u8 ppBonuses;
    u8 friendship;
};

struct PokemonSubstruct1
{
    u16 moves[4];
    u8 pp[4];
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
    /*0x00*/ u8 pokerus;
    /*0x01*/ u8 metLocation;

    /*0x02*/ u16 metLevel:7;
    /*0x02*/ u16 metGame:4;
    /*0x03*/ u16 pokeball:4;
    /*0x03*/ u16 otGender:1;

    /*0x04*/ u32 hpIV:5;
    /*0x04*/ u32 attackIV:5;
    /*0x05*/ u32 defenseIV:5;
    /*0x05*/ u32 speedIV:5;
    /*0x05*/ u32 spAttackIV:5;
    /*0x06*/ u32 spDefenseIV:5;
    /*0x07*/ u32 isEgg:1;
    /*0x07*/ u32 altAbility:1;

    /*0x08*/ u32 coolRibbon:3;
    /*0x08*/ u32 beautyRibbon:3;
    /*0x08*/ u32 cuteRibbon:3;
    /*0x09*/ u32 smartRibbon:3;
    /*0x09*/ u32 toughRibbon:3;
    /*0x09*/ u32 championRibbon:1;
    /*0x0A*/ u32 winningRibbon:1;
    /*0x0A*/ u32 victoryRibbon:1;
    /*0x0A*/ u32 artistRibbon:1;
    /*0x0A*/ u32 effortRibbon:1;
    /*0x0A*/ u32 marineRibbon:1; // never distributed
    /*0x0A*/ u32 landRibbon:1; // never distributed
    /*0x0A*/ u32 skyRibbon:1; // never distributed
    /*0x0A*/ u32 countryRibbon:1; // distributed during Pokémon Festa '04 and '05 to tournament winners
    /*0x0B*/ u32 nationalRibbon:1;
    /*0x0B*/ u32 earthRibbon:1;
    /*0x0B*/ u32 worldRibbon:1; // distributed during Pokémon Festa '04 and '05 to tournament winners
    /*0x0B*/ u32 eventLegal:5; // high bit controls Mew & Deoxys obedience in FRLGE; if set, Pokémon is a fateful encounter in FRLG & Gen 4+ summary screens; set for in-game event island legendaries, some distributed events, and Pokémon from XD: Gale of Darkness.
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
    /*0x00*/ u32 personality;
    /*0x04*/ u32 otId;
    /*0x08*/ u8 nickname[POKEMON_NAME_LENGTH];
    /*0x12*/ u8 language;
    /*0x13*/ u8 isBadEgg:1;
             u8 hasSpecies:1;
             u8 isEgg:1;
    /*0x14*/ u8 otName[PLAYER_NAME_LENGTH];
    /*0x1B*/ u8 markings;
    /*0x1C*/ u16 checksum;
    /*0x1E*/ u16 unknown;

    union
    {
        u32 raw[12];
        union PokemonSubstruct substructs[4];
    } secure;
}; /*size = 0x50*/

struct Pokemon
{
    /*0x00*/ struct BoxPokemon box;
    /*0x50*/ u32 status;
    /*0x54*/ u8 level;
    /*0x55*/ u8 mail;
    /*0x56*/ u16 hp;
    /*0x58*/ u16 maxHP;
    /*0x5A*/ u16 attack;
    /*0x5C*/ u16 defense;
    /*0x5E*/ u16 speed;
    /*0x60*/ u16 spAttack;
    /*0x62*/ u16 spDefense;
};

struct BattleTowerPokemon
{
    /*0x00*/u16 species;
    /*0x02*/u16 heldItem;
    /*0x04*/u16 moves[4];
    /*0x0C*/u8 level;
    /*0x0D*/u8 ppBonuses;
    /*0x0E*/u8 hpEV;
    /*0x0F*/u8 attackEV;
    /*0x10*/u8 defenseEV;
    /*0x11*/u8 speedEV;
    /*0x12*/u8 spAttackEV;
    /*0x13*/u8 spDefenseEV;
    /*0x14*/u32 otId;
    /*0x18*/u32 hpIV:5;
    /*0x18*/u32 attackIV:5;
    /*0x19*/u32 defenseIV:5;
    /*0x19*/u32 speedIV:5;
    /*0x1A*/u32 spAttackIV:5;
    /*0x1A*/u32 spDefenseIV:5;
    /*0x1B*/u32 gap:1;
    /*0x1B*/u32 altAbility:1;
    /*0x1C*/u32 personality;
    /*0x20*/u8 nickname[POKEMON_NAME_LENGTH + 1];
    /*0x2B*/u8 friendship;
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

struct Pokemon *GetPtrToEmptyPartySlot(void);
u16 FixUnownSpecies(u16 species, u32 personality);
void SetMonData(struct Pokemon * pokemon, s32 attr, const void * data);
u32 GetMonData(struct Pokemon *mon, s32 field, u8 *data);
void SetBoxMonData(struct BoxPokemon * boxmon, s32 attr, const void * data);
u32 GetBoxMonData(struct BoxPokemon * boxmon, s32 attr, u8 * strbuf);

#endif // GUARD_POKEMON_H
