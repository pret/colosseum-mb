#include "global.h"
#include "gflib.h"
#include "pokeball.h"
#include "all.h"
#include "libpmagb/agb_rom.h"
#include "mb_20094A8.h"
#include "unk_200C5DC.h"
#include "constants/battle.h"
#include "constants/pokemon.h"
#include "constants/moves.h"
#include "constants/items.h"
#include "gflib/characters.h"

extern bool8 gRomDetection_IsRubySapphire;
extern const u8 gGiftRibbonMonDataIds[7];

#define SUBSTRUCT_CASE(n, v1, v2, v3, v4)  \
case n:                                    \
    switch (substructType)                 \
    {                                      \
    case 0:                                \
        substruct = &substructs ## n [v1]; \
        break;                             \
    case 1:                                \
        substruct = &substructs ## n [v2]; \
        break;                             \
    case 2:                                \
        substruct = &substructs ## n [v3]; \
        break;                             \
    case 3:                                \
        substruct = &substructs ## n [v4]; \
        break;                             \
    }                                      \
    break;

static union PokemonSubstruct *GetSubstruct(struct BoxPokemon *boxMon, u32 personality, u8 substructType)
{
    union PokemonSubstruct *substruct = NULL;

    union PokemonSubstruct *substructs0 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs1 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs2 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs3 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs4 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs5 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs6 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs7 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs8 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs9 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs10 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs11 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs12 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs13 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs14 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs15 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs16 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs17 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs18 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs19 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs20 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs21 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs22 = boxMon->secure.substructs;
    union PokemonSubstruct *substructs23 = boxMon->secure.substructs;

    switch (personality % 24)
    {
        SUBSTRUCT_CASE( 0,0,1,2,3)
        SUBSTRUCT_CASE( 1,0,1,3,2)
        SUBSTRUCT_CASE( 2,0,2,1,3)
        SUBSTRUCT_CASE( 3,0,3,1,2)
        SUBSTRUCT_CASE( 4,0,2,3,1)
        SUBSTRUCT_CASE( 5,0,3,2,1)
        SUBSTRUCT_CASE( 6,1,0,2,3)
        SUBSTRUCT_CASE( 7,1,0,3,2)
        SUBSTRUCT_CASE( 8,2,0,1,3)
        SUBSTRUCT_CASE( 9,3,0,1,2)
        SUBSTRUCT_CASE(10,2,0,3,1)
        SUBSTRUCT_CASE(11,3,0,2,1)
        SUBSTRUCT_CASE(12,1,2,0,3)
        SUBSTRUCT_CASE(13,1,3,0,2)
        SUBSTRUCT_CASE(14,2,1,0,3)
        SUBSTRUCT_CASE(15,3,1,0,2)
        SUBSTRUCT_CASE(16,2,3,0,1)
        SUBSTRUCT_CASE(17,3,2,0,1)
        SUBSTRUCT_CASE(18,1,2,3,0)
        SUBSTRUCT_CASE(19,1,3,2,0)
        SUBSTRUCT_CASE(20,2,1,3,0)
        SUBSTRUCT_CASE(21,3,1,2,0)
        SUBSTRUCT_CASE(22,2,3,1,0)
        SUBSTRUCT_CASE(23,3,2,1,0)
    }

    return substruct;
}

static u16 CalculateBoxMonChecksum(struct BoxPokemon *boxMon)
{
    u16 checksum = 0;
    union PokemonSubstruct *substruct0 = GetSubstruct(boxMon, boxMon->personality, 0);
    union PokemonSubstruct *substruct1 = GetSubstruct(boxMon, boxMon->personality, 1);
    union PokemonSubstruct *substruct2 = GetSubstruct(boxMon, boxMon->personality, 2);
    union PokemonSubstruct *substruct3 = GetSubstruct(boxMon, boxMon->personality, 3);
    s32 i;

    for (i = 0; i < 6; i++)
        checksum += substruct0->raw[i];

    for (i = 0; i < 6; i++)
        checksum += substruct1->raw[i];

    for (i = 0; i < 6; i++)
        checksum += substruct2->raw[i];

    for (i = 0; i < 6; i++)
        checksum += substruct3->raw[i];

    return checksum;
}

static inline void EncryptBoxMon(struct BoxPokemon *boxMon)
{
    u32 i;
    for (i = 0; i < NELEMS(boxMon->secure.raw); i++)
    {
        boxMon->secure.raw[i] ^= boxMon->personality;
        boxMon->secure.raw[i] ^= boxMon->otId;
    }
}

static inline void DecryptBoxMon(struct BoxPokemon *boxMon)
{
    u32 i;
    for (i = 0; i < NELEMS(boxMon->secure.raw); i++)
    {
        boxMon->secure.raw[i] ^= boxMon->otId;
        boxMon->secure.raw[i] ^= boxMon->personality;
    }
}

u32 GetBoxMonData(struct BoxPokemon *boxMon, s32 field, u8 *data)
{
    u32 retVal = 0;
    struct PokemonSubstruct0 *substruct0 = NULL;
    struct PokemonSubstruct1 *substruct1 = NULL;
    struct PokemonSubstruct2 *substruct2 = NULL;
    struct PokemonSubstruct3 *substruct3 = NULL;

    if (field > MON_DATA_10)
    {
        substruct0 = &(GetSubstruct(boxMon, boxMon->personality, 0)->type0);
        substruct1 = &(GetSubstruct(boxMon, boxMon->personality, 1)->type1);
        substruct2 = &(GetSubstruct(boxMon, boxMon->personality, 2)->type2);
        substruct3 = &(GetSubstruct(boxMon, boxMon->personality, 3)->type3);

        DecryptBoxMon(boxMon);

        if (CalculateBoxMonChecksum(boxMon) != boxMon->checksum)
        {
            boxMon->isBadEgg = 1;
            boxMon->isEgg = 1;
            substruct3->isEgg = 1;
        }
    }

    switch (field)
    {
    case MON_DATA_PERSONALITY:
        retVal = boxMon->personality;
        break;
    case MON_DATA_OT_ID:
        retVal = boxMon->otId;
        break;
    case MON_DATA_NICKNAME:
    {
        u32 language;
        u8 text[16];
        if (boxMon->isBadEgg)
        {
            StringCopy(data, gText_BadEgg);
            retVal = GetStringSizeHandleExtCtrlCodes(data);
        }
        else if (boxMon->isEgg)
        {
            StringCopy(data, gText_Egg);
            retVal = GetStringSizeHandleExtCtrlCodes(data);
        }
        else
        {
            retVal = 0;

            while (retVal < POKEMON_NAME_LENGTH && boxMon->nickname[retVal] != EOS)
            {
                data[retVal] = boxMon->nickname[retVal];
                retVal++;
            }

            data[retVal] = EOS;
            language = boxMon->language;
            if (language == LANGUAGE_JAPANESE)
            {
                text[0] = EXT_CTRL_CODE_BEGIN;
                text[1] = 21;
                StringCopy(text + 2, data);
                StringCopy(data, text);
            }

            retVal = GetStringSizeHandleExtCtrlCodes(data);
        }
        break;
    }
    case MON_DATA_LANGUAGE:
        retVal = boxMon->language;
        break;
    case MON_DATA_SANITY_BIT1:
        retVal = boxMon->isBadEgg;
        break;
    case MON_DATA_SANITY_BIT2:
        retVal = boxMon->hasSpecies;
        break;
    case MON_DATA_SANITY_BIT3:
        retVal = boxMon->isEgg;
        break;
    case MON_DATA_OT_NAME:
    {
        retVal = 0;

        while (retVal < gAgbPmRomParams->playerNameLength && boxMon->otName[retVal] != EOS)
        {
            data[retVal] = boxMon->otName[retVal];
            retVal++;
        }

        data[retVal] = EOS;
        break;
    }
    case MON_DATA_MARKINGS:
        retVal = boxMon->markings;
        break;
    case MON_DATA_CHECKSUM:
        retVal = boxMon->checksum;
        break;
    case MON_DATA_10:
        retVal = boxMon->unknown;
        break;
    case MON_DATA_SPECIES:
        retVal = boxMon->isBadEgg ? SPECIES_EGG : substruct0->species;
        break;
    case MON_DATA_HELD_ITEM:
        retVal = substruct0->heldItem;
        break;
    case MON_DATA_EXP:
        retVal = substruct0->experience;
        break;
    case MON_DATA_PP_BONUSES:
        retVal = substruct0->ppBonuses;
        break;
    case MON_DATA_FRIENDSHIP:
        retVal = substruct0->friendship;
        break;
    case MON_DATA_MOVE1:
    case MON_DATA_MOVE2:
    case MON_DATA_MOVE3:
    case MON_DATA_MOVE4:
        retVal = substruct1->moves[field - MON_DATA_MOVE1];
        break;
    case MON_DATA_PP1:
    case MON_DATA_PP2:
    case MON_DATA_PP3:
    case MON_DATA_PP4:
        retVal = substruct1->pp[field - MON_DATA_PP1];
        break;
    case MON_DATA_HP_EV:
        retVal = substruct2->hpEV;
        break;
    case MON_DATA_ATK_EV:
        retVal = substruct2->attackEV;
        break;
    case MON_DATA_DEF_EV:
        retVal = substruct2->defenseEV;
        break;
    case MON_DATA_SPEED_EV:
        retVal = substruct2->speedEV;
        break;
    case MON_DATA_SPATK_EV:
        retVal = substruct2->spAttackEV;
        break;
    case MON_DATA_SPDEF_EV:
        retVal = substruct2->spDefenseEV;
        break;
    case MON_DATA_COOL:
        retVal = substruct2->cool;
        break;
    case MON_DATA_BEAUTY:
        retVal = substruct2->beauty;
        break;
    case MON_DATA_CUTE:
        retVal = substruct2->cute;
        break;
    case MON_DATA_SMART:
        retVal = substruct2->smart;
        break;
    case MON_DATA_TOUGH:
        retVal = substruct2->tough;
        break;
    case MON_DATA_SHEEN:
        retVal = substruct2->sheen;
        break;
    case MON_DATA_POKERUS:
        retVal = substruct3->pokerus;
        break;
    case MON_DATA_MET_LOCATION:
        retVal = substruct3->metLocation;
        break;
    case MON_DATA_MET_LEVEL:
        retVal = substruct3->metLevel;
        break;
    case MON_DATA_MET_GAME:
        retVal = substruct3->metGame;
        break;
    case MON_DATA_POKEBALL:
        retVal = substruct3->pokeball;
        break;
    case MON_DATA_OT_GENDER:
        retVal = substruct3->otGender;
        break;
    case MON_DATA_HP_IV:
        retVal = substruct3->hpIV;
        break;
    case MON_DATA_ATK_IV:
        retVal = substruct3->attackIV;
        break;
    case MON_DATA_DEF_IV:
        retVal = substruct3->defenseIV;
        break;
    case MON_DATA_SPEED_IV:
        retVal = substruct3->speedIV;
        break;
    case MON_DATA_SPATK_IV:
        retVal = substruct3->spAttackIV;
        break;
    case MON_DATA_SPDEF_IV:
        retVal = substruct3->spDefenseIV;
        break;
    case MON_DATA_IS_EGG:
        retVal = substruct3->isEgg;
        break;
    case MON_DATA_ALT_ABILITY:
        retVal = substruct3->altAbility;
        break;
    case MON_DATA_COOL_RIBBON:
        retVal = substruct3->coolRibbon;
        break;
    case MON_DATA_BEAUTY_RIBBON:
        retVal = substruct3->beautyRibbon;
        break;
    case MON_DATA_CUTE_RIBBON:
        retVal = substruct3->cuteRibbon;
        break;
    case MON_DATA_SMART_RIBBON:
        retVal = substruct3->smartRibbon;
        break;
    case MON_DATA_TOUGH_RIBBON:
        retVal = substruct3->toughRibbon;
        break;
    case MON_DATA_CHAMPION_RIBBON:
        retVal = substruct3->championRibbon;
        break;
    case MON_DATA_WINNING_RIBBON:
        retVal = substruct3->winningRibbon;
        break;
    case MON_DATA_VICTORY_RIBBON:
        retVal = substruct3->victoryRibbon;
        break;
    case MON_DATA_ARTIST_RIBBON:
        retVal = substruct3->artistRibbon;
        break;
    case MON_DATA_EFFORT_RIBBON:
        retVal = substruct3->effortRibbon;
        break;
    case MON_DATA_MARINE_RIBBON:
        retVal = substruct3->marineRibbon;
        break;
    case MON_DATA_LAND_RIBBON:
        retVal = substruct3->landRibbon;
        break;
    case MON_DATA_SKY_RIBBON:
        retVal = substruct3->skyRibbon;
        break;
    case MON_DATA_COUNTRY_RIBBON:
        retVal = substruct3->countryRibbon;
        break;
    case MON_DATA_NATIONAL_RIBBON:
        retVal = substruct3->nationalRibbon;
        break;
    case MON_DATA_EARTH_RIBBON:
        retVal = substruct3->earthRibbon;
        break;
    case MON_DATA_WORLD_RIBBON:
        retVal = substruct3->worldRibbon;
        break;
    case MON_DATA_EVENT_LEGAL:
        retVal = substruct3->eventLegal;
        break;
    case MON_DATA_SPECIES2:
        retVal = substruct0->species;
        if (substruct0->species && (substruct3->isEgg || boxMon->isBadEgg))
            retVal = SPECIES_EGG;
        break;
    case MON_DATA_IVS:
        retVal = substruct3->hpIV | (substruct3->attackIV << 5) | (substruct3->defenseIV << 10) | (substruct3->speedIV << 15) | (substruct3->spAttackIV << 20) | (substruct3->spDefenseIV << 25);
        break;
    case MON_DATA_KNOWN_MOVES:
        if (substruct0->species && !substruct3->isEgg)
        {
            u16 *moves = (u16 *)data;
            s32 i = 0;

            while (moves[i] != NUM_MOVES)
            {
                u16 move = moves[i];
                if (substruct1->moves[0] == move
                    || substruct1->moves[1] == move
                    || substruct1->moves[2] == move
                    || substruct1->moves[3] == move)
                    retVal |= gBitTable[i];
                i++;
            }
        }
        break;
    case MON_DATA_RIBBON_COUNT:
        retVal = 0;
        if (substruct0->species && !substruct3->isEgg)
        {
            retVal += substruct3->coolRibbon;
            retVal += substruct3->beautyRibbon;
            retVal += substruct3->cuteRibbon;
            retVal += substruct3->smartRibbon;
            retVal += substruct3->toughRibbon;
            retVal += substruct3->championRibbon;
            retVal += substruct3->winningRibbon;
            retVal += substruct3->victoryRibbon;
            retVal += substruct3->artistRibbon;
            retVal += substruct3->effortRibbon;
            retVal += substruct3->marineRibbon;
            retVal += substruct3->landRibbon;
            retVal += substruct3->skyRibbon;
            retVal += substruct3->countryRibbon;
            retVal += substruct3->nationalRibbon;
            retVal += substruct3->earthRibbon;
            retVal += substruct3->worldRibbon;
        }
        break;
    case MON_DATA_RIBBONS:
        retVal = 0;
        if (substruct0->species && !substruct3->isEgg)
        {
            retVal = substruct3->championRibbon
                | (substruct3->coolRibbon << 1)
                | (substruct3->beautyRibbon << 4)
                | (substruct3->cuteRibbon << 7)
                | (substruct3->smartRibbon << 10)
                | (substruct3->toughRibbon << 13)
                | (substruct3->winningRibbon << 16)
                | (substruct3->victoryRibbon << 17)
                | (substruct3->artistRibbon << 18)
                | (substruct3->effortRibbon << 19)
                | (substruct3->marineRibbon << 20)
                | (substruct3->landRibbon << 21)
                | (substruct3->skyRibbon << 22)
                | (substruct3->countryRibbon << 23)
                | (substruct3->nationalRibbon << 24)
                | (substruct3->earthRibbon << 25)
                | (substruct3->worldRibbon << 26);
        }
        break;
    default:
        break;
    }

    if (field > MON_DATA_10)
        EncryptBoxMon(boxMon);

    return retVal;
}

static inline u32 GetMonDataInline(struct Pokemon *mon, s32 attr, u8 *strbuf)
{
    switch (attr)
    {
    case MON_DATA_STATUS:
        return mon->status;
    case MON_DATA_LEVEL:
        return mon->level;
    case MON_DATA_HP:
        return mon->hp;
    case MON_DATA_MAX_HP:
        return mon->maxHP;
    case MON_DATA_ATK:
        return mon->attack;
    case MON_DATA_DEF:
        return mon->defense;
    case MON_DATA_SPEED:
        return mon->speed;
    case MON_DATA_SPATK:
        return mon->spAttack;
    case MON_DATA_SPDEF:
        return mon->spDefense;
    case MON_DATA_MAIL:
        return mon->mail;
    default:
        return GetBoxMonData(&mon->box, attr, strbuf);
    }
}

//Extracts the upper 16 bits of a 32-bit number
#define HIHALF(n) (((n) & 0xFFFF0000) >> 16)

//Extracts the lower 16 bits of a 32-bit number
#define LOHALF(n) ((n) & 0xFFFF)

const struct CompressedSpritePalette *GetBoxMonPalettePtr(u32 partyId)
{
    u32 shinyValue = 0;

    u16 species = GetMonDataInline(&gPlayerPartyPtr[partyId], MON_DATA_SPECIES2, NULL);
    u32 otId = GetMonDataInline(&gPlayerPartyPtr[partyId], MON_DATA_OT_ID, NULL);
    u32 personality = GetMonDataInline(&gPlayerPartyPtr[partyId], MON_DATA_PERSONALITY, NULL);

    if (species > NUM_SPECIES)
        return &gAgbPmRomParams->monNormalPalettes[SPECIES_NONE];

    shinyValue = HIHALF(otId) ^ LOHALF(otId) ^ HIHALF(personality) ^ LOHALF(personality);
    if (shinyValue > 7)
        return &gAgbPmRomParams->monNormalPalettes[species];
    else
        return &gAgbPmRomParams->monShinyPalettes[species];
}

u32 GetBoxMonAbility(struct BoxPokemon *boxMon)
{
    u32 ability;
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->speciesInfo;
    u32 species = GetBoxMonData(boxMon, MON_DATA_SPECIES, NULL);
    u32 abilityNum = GetBoxMonData(boxMon, MON_DATA_ALT_ABILITY, NULL);

    if (abilityNum == 0)
        ability = speciesInfo[species].abilities[0];
    else
        ability = speciesInfo[species].abilities[1];

    return ability;
}

const u32 *BoxMonCaughtBallToItemId(struct BoxPokemon *boxMon)
{
    u32 id;
    u16 ball = GetBoxMonData(boxMon, MON_DATA_POKEBALL, NULL);

    switch (ball)
    {
    case 1:     id = 4;     break;
    case 2:     id = 3;     break;
    case 3:     id = 1;     break;
    case 4:     id = 0;     break;
    case 5:     id = 2;     break;
    case 6:     id = 5;     break;
    case 7:     id = 6;     break;
    case 8:     id = 7;     break;
    case 9:     id = 8;     break;
    case 10:    id = 9;     break;
    case 11:    id = 10;    break;
    case 12:    id = 11;    break;
    default:    id = 0;     break;
    }

    return gAgbPmRomParams->ballGfx[id].data;
}

const u32 *BoxMonGetCaughtBallItemPalette(struct BoxPokemon *boxMon)
{
    u32 id;
    u16 ball = GetBoxMonData(boxMon, MON_DATA_POKEBALL, NULL);

    switch (ball)
    {
    case 1:     id = 4;     break;
    case 2:     id = 3;     break;
    case 3:     id = 1;     break;
    case 4:     id = 0;     break;
    case 5:     id = 2;     break;
    case 6:     id = 5;     break;
    case 7:     id = 6;     break;
    case 8:     id = 7;     break;
    case 9:     id = 8;     break;
    case 10:    id = 9;     break;
    case 11:    id = 10;    break;
    case 12:    id = 11;    break;
    default:    id = 0;     break;
    }

    return gAgbPmRomParams->ballPalettes[id].data;
}

u32 GetBoxMonMoveBySlot(struct BoxPokemon *boxMon, s32 slot)
{
    u32 move;
    switch (slot)
    {
    case 0: move = GetBoxMonData(boxMon, MON_DATA_MOVE1, NULL); break;
    case 1: move = GetBoxMonData(boxMon, MON_DATA_MOVE2, NULL); break;
    case 2: move = GetBoxMonData(boxMon, MON_DATA_MOVE3, NULL); break;
    default:
    case 3: move = GetBoxMonData(boxMon, MON_DATA_MOVE4, NULL); break;
    }
    return move;
}

u32 GetBoxMonPPByMoveSlot(struct BoxPokemon *boxMon, u8 slot)
{
    u32 pp;
    switch (slot)
    {
    case 0: pp = GetBoxMonData(boxMon, MON_DATA_PP1, NULL); break;
    case 1: pp = GetBoxMonData(boxMon, MON_DATA_PP2, NULL); break;
    case 2: pp = GetBoxMonData(boxMon, MON_DATA_PP3, NULL); break;
    default:
    case 3: pp = GetBoxMonData(boxMon, MON_DATA_PP4, NULL); break;
    }
    return pp;
}

u32 CheckPartyPokerus(struct Pokemon *party, u8 selection)
{
    u32 retVal;

    int partyIndex = 0;
    unsigned curBit = 1;
    retVal = 0;

    if (selection)
    {
        do
        {
            if ((selection & 1) && (GetMonDataInline(&party[partyIndex], MON_DATA_POKERUS, 0) & 0xF))
                retVal |= curBit;
            partyIndex++;
            curBit <<= 1;
            selection >>= 1;
        }
        while (selection);
    }
    else if (GetMonDataInline(&party[0], MON_DATA_POKERUS, 0) & 0xF)
    {
        retVal = 1;
    }

    return retVal;
}

static inline u32 GetPrimaryStatus(u32 status)
{
    if (status & (STATUS1_POISON | STATUS1_TOXIC_POISON))
        return STATUS_PRIMARY_POISON;
    if (status & STATUS1_PARALYSIS)
        return STATUS_PRIMARY_PARALYSIS;
    if (status & STATUS1_SLEEP)
        return STATUS_PRIMARY_SLEEP;
    if (status & STATUS1_FREEZE)
        return STATUS_PRIMARY_FREEZE;
    if (status & STATUS1_BURN)
        return STATUS_PRIMARY_BURN;

    return STATUS_PRIMARY_NONE;
}

u32 GetMonStatus(struct Pokemon *mon)
{
    u32 statusAilment;

    if (GetMonDataInline(mon, MON_DATA_HP, NULL) == 0)
        return STATUS_PRIMARY_FAINTED;

    statusAilment = GetPrimaryStatus(GetMonDataInline(mon, MON_DATA_STATUS, NULL));
    if (statusAilment == STATUS_PRIMARY_NONE)
    {
        if (!CheckPartyPokerus(mon, 0))
            return STATUS_PRIMARY_NONE;
        else
            return STATUS_PRIMARY_POKERUS;
    }

    return statusAilment;
}

u32 CheckPartyHasHadPokerus(struct Pokemon *party, u8 selection)
{
    u32 retVal;

    int partyIndex = 0;
    unsigned curBit = 1;
    retVal = 0;

    if (selection)
    {
        do
        {
            if ((selection & 1) && GetMonDataInline(&party[partyIndex], MON_DATA_POKERUS, 0))
                retVal |= curBit;
            partyIndex++;
            curBit <<= 1;
            selection >>= 1;
        }
        while (selection);
    }
    else if (GetMonDataInline(&party[0], MON_DATA_POKERUS, 0))
    {
        retVal = 1;
    }

    return retVal;
}

void DrawSpindasSpots(u16 species, u32 personality, u8 *dest)
{
    if (species == SPECIES_SPINDA)
    {
        int i, j, k, var;

        if (gRomDetection_IsRubySapphire != FALSE)
            var = 0;
        else
            var = 7;

        for (i = 0; i < 4; i++)
        {
            u8 x = gSpindaSpotGraphics[i].x + ((personality & 0x0F) - 8);
            u8 y = gSpindaSpotGraphics[i].y + (((personality & 0xF0) >> 4) - 8) - var;

            for (j = 0; j < 16; j++)
            {
                s32 row = gSpindaSpotGraphics[i].image[j];

                for (k = x; k < x + 16; k++)
                {
                    u8 *val = dest + ((k / 8) * 32) + ((k % 8) / 2) + ((y >> 3) << 8) + ((y & 7) << 2);

                    if (row & 1)
                    {
                        if (k & 1)
                        {
                            if ((u8)((*val & 0xF0) - 0x10) <= 0x20)
                                *val += 0x40;
                        }
                        else
                        {
                            if ((u8)((*val & 0xF) - 0x01) <= 0x02)
                                *val += 0x04;
                        }
                    }

                    row >>= 1;
                }

                y++;
            }

            personality >>= 8;
        }
    }
}

#define SET8(lhs) (lhs) = *data
#define SET16(lhs) (lhs) = data[0] + (data[1] << 8)
#define SET32(lhs) (lhs) = data[0] + (data[1] << 8) + (data[2] << 16) + (data[3] << 24)

void SetBoxMonData(struct BoxPokemon *boxMon, s32 field, const void *dataArg)
{
    const u8 *data = dataArg;

    struct PokemonSubstruct0 *substruct0 = NULL;
    struct PokemonSubstruct1 *substruct1 = NULL;
    struct PokemonSubstruct2 *substruct2 = NULL;
    struct PokemonSubstruct3 *substruct3 = NULL;

    if (field > MON_DATA_10)
    {
        substruct0 = &(GetSubstruct(boxMon, boxMon->personality, 0)->type0);
        substruct1 = &(GetSubstruct(boxMon, boxMon->personality, 1)->type1);
        substruct2 = &(GetSubstruct(boxMon, boxMon->personality, 2)->type2);
        substruct3 = &(GetSubstruct(boxMon, boxMon->personality, 3)->type3);

        DecryptBoxMon(boxMon);

        if (CalculateBoxMonChecksum(boxMon) != boxMon->checksum)
        {
            boxMon->isBadEgg = 1;
            boxMon->isEgg = 1;
            substruct3->isEgg = 1;
            EncryptBoxMon(boxMon);
            return;
        }
    }

    switch (field)
    {
    case MON_DATA_PERSONALITY:
        SET32(boxMon->personality);
        break;
    case MON_DATA_OT_ID:
        SET32(boxMon->otId);
        break;
    case MON_DATA_NICKNAME:
    {
        s32 i;
        for (i = 0; i < gAgbPmRomParams->pokemonNameLength1; i++)
            boxMon->nickname[i] = data[i];
        break;
    }
    case MON_DATA_LANGUAGE:
        SET8(boxMon->language);
        break;
    case MON_DATA_SANITY_BIT1:
        SET8(boxMon->isBadEgg);
        break;
    case MON_DATA_SANITY_BIT2:
        SET8(boxMon->hasSpecies);
        break;
    case MON_DATA_SANITY_BIT3:
        SET8(boxMon->isEgg);
        break;
    case MON_DATA_OT_NAME:
    {
        s32 i;
        for (i = 0; i < gAgbPmRomParams->playerNameLength; i++)
            boxMon->otName[i] = data[i];
        break;
    }
    case MON_DATA_MARKINGS:
        SET8(boxMon->markings);
        break;
    case MON_DATA_CHECKSUM:
        SET16(boxMon->checksum);
        break;
    case MON_DATA_10:
        SET16(boxMon->unknown);
        break;
    case MON_DATA_SPECIES:
    {
        #ifndef NONMATCHING // For some reason the compiler puts substruct0 in r8 instead of r9.
        register struct PokemonSubstruct0 *fakeMatch asm("r9") = substruct0;
        substruct0 = fakeMatch;
        #endif // NONMATCHING
        SET16(substruct0->species);
        if (substruct0->species)
            boxMon->hasSpecies = 1;
        else
            boxMon->hasSpecies = 0;
        break;
    }
    case MON_DATA_HELD_ITEM:
        SET16(substruct0->heldItem);
        break;
    case MON_DATA_EXP:
        SET32(substruct0->experience);
        break;
    case MON_DATA_PP_BONUSES:
        SET8(substruct0->ppBonuses);
        break;
    case MON_DATA_FRIENDSHIP:
        SET8(substruct0->friendship);
        break;
    case MON_DATA_MOVE1:
    case MON_DATA_MOVE2:
    case MON_DATA_MOVE3:
    case MON_DATA_MOVE4:
        SET16(substruct1->moves[field - MON_DATA_MOVE1]);
        break;
    case MON_DATA_PP1:
    case MON_DATA_PP2:
    case MON_DATA_PP3:
    case MON_DATA_PP4:
        SET8(substruct1->pp[field - MON_DATA_PP1]);
        break;
    case MON_DATA_HP_EV:
        SET8(substruct2->hpEV);
        break;
    case MON_DATA_ATK_EV:
        SET8(substruct2->attackEV);
        break;
    case MON_DATA_DEF_EV:
        SET8(substruct2->defenseEV);
        break;
    case MON_DATA_SPEED_EV:
        SET8(substruct2->speedEV);
        break;
    case MON_DATA_SPATK_EV:
        SET8(substruct2->spAttackEV);
        break;
    case MON_DATA_SPDEF_EV:
        SET8(substruct2->spDefenseEV);
        break;
    case MON_DATA_COOL:
        SET8(substruct2->cool);
        break;
    case MON_DATA_BEAUTY:
        SET8(substruct2->beauty);
        break;
    case MON_DATA_CUTE:
        SET8(substruct2->cute);
        break;
    case MON_DATA_SMART:
        SET8(substruct2->smart);
        break;
    case MON_DATA_TOUGH:
        SET8(substruct2->tough);
        break;
    case MON_DATA_SHEEN:
        SET8(substruct2->sheen);
        break;
    case MON_DATA_POKERUS:
        SET8(substruct3->pokerus);
        break;
    case MON_DATA_MET_LOCATION:
        SET8(substruct3->metLocation);
        break;
    case MON_DATA_MET_LEVEL:
    {
        u8 metLevel = *data;
        substruct3->metLevel = metLevel;
        break;
    }
    case MON_DATA_MET_GAME:
        SET8(substruct3->metGame);
        break;
    case MON_DATA_POKEBALL:
    {
        u8 pokeball = *data;
        substruct3->pokeball = pokeball;
        break;
    }
    case MON_DATA_OT_GENDER:
        SET8(substruct3->otGender);
        break;
    case MON_DATA_HP_IV:
        SET8(substruct3->hpIV);
        break;
    case MON_DATA_ATK_IV:
        SET8(substruct3->attackIV);
        break;
    case MON_DATA_DEF_IV:
        SET8(substruct3->defenseIV);
        break;
    case MON_DATA_SPEED_IV:
        SET8(substruct3->speedIV);
        break;
    case MON_DATA_SPATK_IV:
        SET8(substruct3->spAttackIV);
        break;
    case MON_DATA_SPDEF_IV:
        SET8(substruct3->spDefenseIV);
        break;
    case MON_DATA_IS_EGG:
        SET8(substruct3->isEgg);
        if (substruct3->isEgg)
            boxMon->isEgg = 1;
        else
            boxMon->isEgg = 0;
        break;
    case MON_DATA_ALT_ABILITY:
        SET8(substruct3->altAbility);
        break;
    case MON_DATA_COOL_RIBBON:
        SET8(substruct3->coolRibbon);
        break;
    case MON_DATA_BEAUTY_RIBBON:
        SET8(substruct3->beautyRibbon);
        break;
    case MON_DATA_CUTE_RIBBON:
        SET8(substruct3->cuteRibbon);
        break;
    case MON_DATA_SMART_RIBBON:
        SET8(substruct3->smartRibbon);
        break;
    case MON_DATA_TOUGH_RIBBON:
        SET8(substruct3->toughRibbon);
        break;
    case MON_DATA_CHAMPION_RIBBON:
        SET8(substruct3->championRibbon);
        break;
    case MON_DATA_WINNING_RIBBON:
        SET8(substruct3->winningRibbon);
        break;
    case MON_DATA_VICTORY_RIBBON:
        SET8(substruct3->victoryRibbon);
        break;
    case MON_DATA_ARTIST_RIBBON:
        SET8(substruct3->artistRibbon);
        break;
    case MON_DATA_EFFORT_RIBBON:
        SET8(substruct3->effortRibbon);
        break;
    case MON_DATA_MARINE_RIBBON:
        SET8(substruct3->marineRibbon);
        break;
    case MON_DATA_LAND_RIBBON:
        SET8(substruct3->landRibbon);
        break;
    case MON_DATA_SKY_RIBBON:
        SET8(substruct3->skyRibbon);
        break;
    case MON_DATA_COUNTRY_RIBBON:
        SET8(substruct3->countryRibbon);
        break;
    case MON_DATA_NATIONAL_RIBBON:
        SET8(substruct3->nationalRibbon);
        break;
    case MON_DATA_EARTH_RIBBON:
        SET8(substruct3->earthRibbon);
        break;
    case MON_DATA_WORLD_RIBBON:
        SET8(substruct3->worldRibbon);
        break;
    case MON_DATA_EVENT_LEGAL:
        SET8(substruct3->eventLegal);
        break;
    case MON_DATA_IVS:
    {
#ifdef BUGFIX_SETMONIVS
        u32 ivs = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
#else
        u32 ivs = *data; // Bug: Only the HP IV and the lower 3 bits of the Attack IV are read. The rest become 0.
#endif
        substruct3->hpIV = ivs & 0x1F;
        substruct3->attackIV = (ivs >> 5) & 0x1F;
        substruct3->defenseIV = (ivs >> 10) & 0x1F;
        substruct3->speedIV = (ivs >> 15) & 0x1F;
        substruct3->spAttackIV = (ivs >> 20) & 0x1F;
        substruct3->spDefenseIV = (ivs >> 25) & 0x1F;
        break;
    }
    default:
        break;
    }

    if (field > MON_DATA_10)
    {
        boxMon->checksum = CalculateBoxMonChecksum(boxMon);
        EncryptBoxMon(boxMon);
    }
}

void SetMonData(struct Pokemon *mon, s32 field, const void *dataArg)
{
    const u8 *data = dataArg;
    switch (field)
    {
    case MON_DATA_STATUS:
        SET32(mon->status);
        break;
    case MON_DATA_LEVEL:
        SET8(mon->level);
        break;
    case MON_DATA_HP:
        SET16(mon->hp);
        break;
    case MON_DATA_MAX_HP:
        SET16(mon->maxHP);
        break;
    case MON_DATA_ATK:
        SET16(mon->attack);
        break;
    case MON_DATA_DEF:
        SET16(mon->defense);
        break;
    case MON_DATA_SPEED:
        SET16(mon->speed);
        break;
    case MON_DATA_SPATK:
        SET16(mon->spAttack);
        break;
    case MON_DATA_SPDEF:
        SET16(mon->spDefense);
        break;
    case MON_DATA_MAIL:
        SET8(mon->mail);
        break;
    case MON_DATA_SPECIES2:
        break;
    default:
        SetBoxMonData(&mon->box, field, data);
        break;
    }
}

void GiveGiftRibbonToParty(s32 index_, s32 ribbonId_)
{
    s32 i;
    u8 arr[7];
    // s32 required by other functions.
    u8 index = index_;
    u8 ribbonId = ribbonId_;
    bool32 gotRibbon = FALSE;

    memcpy(arr, gGiftRibbonMonDataIds, 7);
    /*
    u8 arr[] = {
        MON_DATA_MARINE_RIBBON,
        MON_DATA_LAND_RIBBON,
        MON_DATA_SKY_RIBBON,
        MON_DATA_COUNTRY_RIBBON,
        MON_DATA_NATIONAL_RIBBON,
        MON_DATA_EARTH_RIBBON,
        MON_DATA_WORLD_RIBBON,
    };
    */

    if (index < 11 && ribbonId < 65 && index < 7)
    {
        gGiftRibbonsPtr[index] = ribbonId;
        for (i = 0; i < PARTY_SIZE; i++)
        {
            if (GetMonDataInline(&gPlayerPartyPtr[i], MON_DATA_SPECIES, NULL) != 0 && GetMonDataInline(&gPlayerPartyPtr[i], MON_DATA_SANITY_BIT3, NULL) == 0)
                gotRibbon = TRUE;
        }
        if (gotRibbon)
            SetFlag(gAgbPmRomParams->giftRibbonsOffset);
    }
}

u32 GetMonData(struct Pokemon *mon, s32 field, u8 *data)
{
    return GetMonDataInline(mon, field, data);
}

static inline u8 GetGenderFromSpeciesAndPersonality(u16 species, u32 personality, const struct SpeciesInfo *speciesInfo)
{
    switch (speciesInfo[species].genderRatio)
    {
    case MON_MALE:
    case MON_FEMALE:
    case MON_GENDERLESS:
        return speciesInfo[species].genderRatio;
    }

    if (speciesInfo[species].genderRatio > (personality & 0xFF))
        return MON_FEMALE;
    else
        return MON_MALE;
}

u8 GetMonGender(struct Pokemon *mon)
{
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->speciesInfo;
    u16 species = GetMonDataInline(mon, MON_DATA_SPECIES, NULL);
    u32 personality = GetMonDataInline(mon, MON_DATA_PERSONALITY, NULL);
    return GetGenderFromSpeciesAndPersonality(species, personality, speciesInfo);
}

const struct CompressedSpritePalette *GetMonPalettePtrBySpeciesIdPersonality(u16 species, u32 otId, u32 personality)
{
    u32 shinyValue = 0;

    if (species > NUM_SPECIES)
        return &gAgbPmRomParams->monNormalPalettes[SPECIES_NONE];

    shinyValue = HIHALF(otId) ^ LOHALF(otId) ^ HIHALF(personality) ^ LOHALF(personality);
    if (shinyValue <= 7)
        return &gAgbPmRomParams->monShinyPalettes[species];
    else
        return &gAgbPmRomParams->monNormalPalettes[species];
}

inline u16 GetUnownLetterByPersonality(u32 personality)
{
    return (((personality & 0x3000000) >> 18) | ((personality & 0x30000) >> 12) | ((personality & 0x300) >> 6) | (personality & 0x3)) % 0x1C;
}

u16 FixUnownSpecies(u16 species, u32 personality)
{
    u16 result;

    if (species == SPECIES_UNOWN)
    {
        u16 letter = GetUnownLetterByPersonality(personality);
        if (letter == 0)
            letter = SPECIES_UNOWN;
        else
            letter += (SPECIES_UNOWN_B - 1);
        result = letter;
    }
    else
    {
        if (species > SPECIES_EGG)
            result = 260;
        else
            result = species;
    }

    return result;
}

void GetSpeciesName(u8 *name, s32 species)
{
    s32 i;
    const u8 (*monSpeciesNames)[][POKEMON_NAME_LENGTH + 1] = gAgbPmRomParams->monSpeciesNames;

    for (i = 0; i < gAgbPmRomParams->pokemonNameLength1 + gAgbPmRomParams->endOfStringLength; i++)
    {
        if (species > NUM_SPECIES)
            name[i] = (*monSpeciesNames)[0][i];
        else
            name[i] = (*monSpeciesNames)[species][i];

        if (name[i] == EOS)
            break;
    }

    name[i] = EOS;
}

u32 GetMonType(struct Pokemon *mon, u32 which)
{
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->speciesInfo;
    u32 species = GetMonDataInline(mon, MON_DATA_SPECIES, NULL);

    switch (which)
    {
    default:
        return 0;
    case 1:
        return speciesInfo[species].types[0];
    case 2:
        return speciesInfo[species].types[1];
    }
}

u32 GetMonSpritePaletteNumByBaseBlock(u32 id)
{
    return gTypeToPaletteNumber[id];
}

const u8 *GetAbilityName(u32 ability)
{
    const u8 (*abilityNames)[][ABILITY_NAME_LENGTH + 1] = gAgbPmRomParams->abilityNames;
    return (*abilityNames)[ability];
}

const u8 *GetAbilityDescription(u32 ability)
{
    const u8 **desriptions = gAgbPmRomParams->abilityDescriptions;
    return desriptions[ability];
}

s32 CalculatePPWithBonus(u32 move, s32 ppBonuses, u32 moveIndex)
{
    const struct BattleMove *moves = gAgbPmRomParams->moves;
    s32 basePP = moves[move].pp;
    return basePP + ((basePP * 20 * ((gPPUpReadMasks[moveIndex] & ppBonuses) >> (2 * moveIndex))) / 100);
}

void CopyMoveName(u8 *dst, u32 move)
{
    s32 i;
    const u8 (*moveNames)[][MOVE_NAME_LENGTH + 1] = gAgbPmRomParams->moveNames;

    for (i = 0; i < gAgbPmRomParams->moveNameLength + gAgbPmRomParams->endOfStringLength; i++)
    {
        dst[i] = (*moveNames)[move][i];
        if (dst[i] == EOS)
            break;
    }

    dst[i] = EOS;
}

struct Pokemon *GetPtrToEmptyPartySlot(void)
{
    if (*gPlayerPartyCountPtr == PARTY_SIZE)
        return NULL;
    else
        return &gPlayerPartyPtr[*gPlayerPartyCountPtr];
};

// The same as GetMonGender except GetGenderFromSpeciesAndPersonality isn't called by copied.
static UNUSED u8 GetMonGender2(struct Pokemon *mon)
{
    const struct SpeciesInfo *speciesInfo = gAgbPmRomParams->speciesInfo;
    u16 species = GetMonDataInline(mon, MON_DATA_SPECIES, NULL);
    u32 personality = GetMonDataInline(mon, MON_DATA_PERSONALITY, NULL);

    switch (speciesInfo[species].genderRatio)
    {
    case MON_MALE:
    case MON_FEMALE:
    case MON_GENDERLESS:
        return speciesInfo[species].genderRatio;
    }

    if (speciesInfo[species].genderRatio > (personality & 0xFF))
        return MON_FEMALE;
    else
        return MON_MALE;
}

