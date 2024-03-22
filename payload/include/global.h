#ifndef GUARD_GLOBAL_H
#define GUARD_GLOBAL_H

#include "gba/gba.h"

// global.h from pokemon ruby

// IDE support
#if defined(__APPLE__) || defined(__CYGWIN__)
#define _(x) x
#define __(x) x
#define INCBIN(x) {0}
#define INCBIN_U8 INCBIN
#define INCBIN_U16 INCBIN
#define INCBIN_U32 INCBIN
#define INCBIN_S8 INCBIN
#define INCBIN_S16 INCBIN
#define INCBIN_S32 INCBIN
#endif

// Prevent cross-jump optimization.
#define BLOCK_CROSS_JUMP asm("");

// to help in decompiling
#define asm_comment(x) asm volatile("@ -- " x " -- ")

#define asm_unified(x) asm(".syntax unified\n" x "\n.syntax divided\n")

#include "constants/species.h"
#include "constants/pokedex.h"
#include "constants/vars.h"
#include "constants/flags.h"

#define ARRAY_COUNT(array) (size_t)(sizeof(array) / sizeof((array)[0]))

#define MOVE_NAME_LENGTH 12
#define POKEMON_NAME_LENGTH 10
#define OT_NAME_LENGTH 7
#define PLAYER_NAME_LENGTH 7
#define ABILITY_NAME_LENGTH 12
#define MAX_MON_MOVES 4
#define TRAINER_ID_LENGTH 4
#define GIFT_RIBBONS_COUNT 11

#define CONTEST_CATEGORY_COOL     0
#define CONTEST_CATEGORY_BEAUTY   1
#define CONTEST_CATEGORY_CUTE     2
#define CONTEST_CATEGORY_SMART    3
#define CONTEST_CATEGORY_TOUGH    4
#define CONTEST_CATEGORIES_COUNT  5

#define GENDER_MALE     0
#define GENDER_FEMALE   1

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) >= (b) ? (a) : (b))

// why does GF hate 2d arrays
#define MULTI_DIM_ARR(x, dim, y) ((x) * dim + (y))

// dim access enums
enum
{
    B_8 = 1,
    B_16 = 2,
    B_32 = 4
};

// There are many quirks in the source code which have overarching behavioral differences from
// a number of other files. For example, diploma.c seems to declare rodata before each use while
// other files declare out of order and must be at the beginning. There are also a number of
// macros which differ from one file to the next due to the method of obtaining the result, such
// as these below. Because of this, there is a theory (Two Team Theory) that states that these
// programming projects had more than 1 "programming team" which utilized different macros for
// each of the files that were worked on.
#define T1_READ_8(ptr)  ((ptr)[0])
#define T1_READ_16(ptr) ((ptr)[0] | ((ptr)[1] << 8))
#define T1_READ_32(ptr) ((ptr)[0] | ((ptr)[1] << 8) | ((ptr)[2] << 16) | ((ptr)[3] << 24))
#define T1_READ_PTR(ptr) (u8*) T1_READ_32(ptr)

// T2_READ_8 is a duplicate to remain consistent with each group.
#define T2_READ_8(ptr)  ((ptr)[0])
#define T2_READ_16(ptr) ((ptr)[0] + ((ptr)[1] << 8))
#define T2_READ_32(ptr) ((ptr)[0] + ((ptr)[1] << 8) + ((ptr)[2] << 16) + ((ptr)[3] << 24))
#define T2_READ_PTR(ptr) (void*) T2_READ_32(ptr)

// Credits to Made (dolphin emoji)
#define S16TOPOSFLOAT(val)   \
({                           \
    s16 v = (val);           \
    float f = (float)v;      \
    if(v < 0) f += 65536.0f; \
    f;                       \
})

enum
{
    VERSION_SAPPHIRE = 1,
    VERSION_RUBY = 2,
    VERSION_EMERALD = 3,
    VERSION_FIRE_RED = 4,
    VERSION_LEAF_GREEN = 5,
};

enum LanguageId
{
    LANGUAGE_JAPANESE = 1,
    LANGUAGE_ENGLISH = 2,
    LANGUAGE_GERMAN = 5,
};

// capacities of various saveblock objects
#define DAYCARE_MON_COUNT   2
#define POKEBLOCKS_COUNT    40
#define PARTY_SIZE          6
#define EVENT_OBJECTS_COUNT 16
#define BERRY_TREES_COUNT   128
#define FLAGS_COUNT         288
#define VARS_COUNT          256
#define MAIL_COUNT          16
#define SECRET_BASES_COUNT  20
#define TV_SHOWS_COUNT      25
#define POKE_NEWS_COUNT     16
#define PC_ITEMS_COUNT      50
#define BAG_ITEMS_COUNT     20
#define BAG_KEYITEMS_COUNT  20
#define BAG_POKEBALLS_COUNT 16
#define BAG_TMHM_COUNT      64
#define BAG_BERRIES_COUNT   46
#define DECOR_MAX_SECRET_BASE 16
#define SAVED_TRENDS_COUNT 5

enum
{
    MALE,
    FEMALE
};

enum
{
    OPTIONS_BUTTON_MODE_NORMAL,
    OPTIONS_BUTTON_MODE_LR,
    OPTIONS_BUTTON_MODE_L_EQUALS_A
};

enum
{
    OPTIONS_TEXT_SPEED_SLOW,
    OPTIONS_TEXT_SPEED_MID,
    OPTIONS_TEXT_SPEED_FAST
};

enum
{
    OPTIONS_SOUND_MONO,
    OPTIONS_SOUND_STEREO
};

enum
{
    OPTIONS_BATTLE_STYLE_SHIFT,
    OPTIONS_BATTLE_STYLE_SET
};

enum
{
    BAG_ITEMS = 1,
    BAG_POKEBALLS,
    BAG_TMsHMs,
    BAG_BERRIES,
    BAG_KEYITEMS
};

struct Coords16
{
    s16 x;
    s16 y;
};

struct UCoords16
{
    u16 x;
    u16 y;
};

struct SecretBaseParty
{
    /*0x1A3C*/ u32 personality[PARTY_SIZE];
    /*0x1A54*/ u16 moves[PARTY_SIZE * MAX_MON_MOVES];
    /*0x1A84*/ u16 species[PARTY_SIZE];
    /*0x1A90*/ u16 heldItems[PARTY_SIZE];
    /*0x1A9C*/ u8 levels[PARTY_SIZE];
    /*0x1AA2*/ u8 EVs[PARTY_SIZE];
};

struct SecretBaseRecord
{
    /*0x1A08*/ u8 secretBaseId;
    /*0x1A09*/ u8 toRegister:4;
    /*0x1A09*/ u8 gender:1;
    /*0x1A09*/ u8 battledOwnerToday:1;
    /*0x1A09*/ u8 registryStatus:2;
    /*0x1A0A*/ u8 playerName[PLAYER_NAME_LENGTH];
    /*0x1A11*/ u8 trainerId[TRAINER_ID_LENGTH]; // byte 0 is used for determining trainer class
    /*0x1A16*/ u16 numSecretBasesReceived;
    /*0x1A18*/ u8 numTimesEntered;
    /*0x1A19*/ u8 unused;
    /*0x1A1A*/ u8 decorations[DECOR_MAX_SECRET_BASE];
    /*0x1A2A*/ u8 decorationPos[DECOR_MAX_SECRET_BASE];
    /*0x1A3C*/ struct SecretBaseParty party;
};

#include "constants/game_stat.h"
#include "global.fieldmap.h"
#include "global.berry.h"
#include "pokemon.h"

struct WarpData
{
    s8 mapGroup;
    s8 mapNum;
    s8 warpId;
    s16 x, y;
};

struct ItemSlot
{
    u16 itemId;
    u16 quantity;
};

struct Pokeblock
{
    u8 color;
    u8 spicy;
    u8 dry;
    u8 sweet;
    u8 bitter;
    u8 sour;
    u8 feel;
};

struct Roamer
{
    /*0x00*/ u32 ivs;
    /*0x04*/ u32 personality;
    /*0x08*/ u16 species;
    /*0x0A*/ u16 hp;
    /*0x0C*/ u8 level;
    /*0x0D*/ u8 status;
    /*0x0E*/ u8 cool;
    /*0x0F*/ u8 beauty;
    /*0x10*/ u8 cute;
    /*0x11*/ u8 smart;
    /*0x12*/ u8 tough;
    /*0x13*/ bool8 active;
    /*0x14*/ u8 filler[0x8];
};

struct RamScriptData
{
    u8 magic;
    u8 mapGroup;
    u8 mapNum;
    u8 objectId;
    u8 script[995];
};

struct RamScript
{
    u32 checksum;
    struct RamScriptData data;
};

struct DewfordTrend
{
    u16 trendiness:7;
    u16 maxTrendiness:7;
    u16 gainingTrendiness:1;
    u16 rand;
    u16 words[2];
}; /*size = 0x8*/

struct TVShowCommon
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 data[26];
    /*0x1C*/ u8 srcTrainerId3Lo;
    /*0x1D*/ u8 srcTrainerId3Hi;
    /*0x1E*/ u8 srcTrainerId2Lo;
    /*0x1F*/ u8 srcTrainerId2Hi;
    /*0x20*/ u8 srcTrainerIdLo;
    /*0x21*/ u8 srcTrainerIdHi;
    /*0x22*/ u8 trainerIdLo;
    /*0x23*/ u8 trainerIdHi;
};

struct TVShowFanClubLetter
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u16 species;
    /*0x04*/ u16 words[6];
    /*0x10*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x18*/ u8 language;
};

struct TVShowRecentHappenings
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u16 species;
    /*0x04*/ u16 words[6];
    /*0x10*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x18*/ u8 language;
    /*0x19*/ u8 unused[10];
};

struct TVShowFanclubOpinions
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u16 species;
    /*0x04*/ u8 friendshipHighNybble:4;
    /*0x04*/ u8 questionAsked:4;
    /*0x05*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x0D*/ u8 language;
    /*0x0E*/ u8 pokemonNameLanguage;
    /*0x0F*/ u8 unused;
    /*0x10*/ u8 nickname[PLAYER_NAME_LENGTH + 1];
    /*0x18*/ u16 words[6];
};

struct TVShowUnknownType04
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 unused[6];
};

struct TVShowNameRaterShow
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u16 species;
    /*0x04*/ u8 pokemonName[POKEMON_NAME_LENGTH + 1];
    /*0x0F*/ u8 trainerName[POKEMON_NAME_LENGTH + 1];
    /*0x1A*/ u8 random;
    /*0x1B*/ u8 random2;
    /*0x1C*/ u16 randomSpecies;
    /*0x1E*/ u8 language;
    /*0x1F*/ u8 pokemonNameLanguage;
};

struct TVShowBravoTrainerPokemonProfiles
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u16 species;
    /*0x04*/ u16 words[2];
    /*0x08*/ u8 pokemonNickname[POKEMON_NAME_LENGTH + 1];
    /*0x13*/ u8 contestCategory:3;
    /*0x13*/ u8 contestRank:2;
    /*0x13*/ u8 contestResult:2;
    /*0x13*/ u8 unused:1;
    /*0x14*/ u16 move;
    /*0x16*/ u8 playerName[11];
    /*0x1E*/ u8 language;
    /*0x1F*/ u8 pokemonNameLanguage;
};

struct TVShowBravoTrainerBattleTowerSpotlight
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x0A*/ u16 species;
    /*0x0C*/ u8 enemyTrainerName[PLAYER_NAME_LENGTH + 1];
    /*0x14*/ u16 defeatedSpecies;
    /*0x16*/ u16 numFights;
    /*0x18*/ u16 words[1];
    /*0x1A*/ u8 btLevel;
    /*0x1B*/ u8 interviewResponse;
    /*0x1C*/ u8 wonTheChallenge;
    /*0x1D*/ u8 language;
};

struct TVShowPokemonToday
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 language;
    /*0x03*/ u8 language2;
    /*0x04*/ u8 nickname[POKEMON_NAME_LENGTH + 1];
    /*0x0F*/ u8 ball;
    /*0x10*/ u16 species;
    /*0x12*/ u8 nBallsUsed;
    /*0x13*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
};

struct TVShowSmartShopper
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 priceReduced;
    /*0x03*/ u8 language;
    /*0x04*/ u8 unused[2];
    /*0x06*/ u16 itemIds[3];
    /*0x0C*/ u16 itemAmounts[3];
    /*0x12*/ u8 shopLocation;
    /*0x13*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
};

struct TVShowPokemonTodayFailed
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 language;
    /*0x03*/ u8 unused[9];
    /*0x0c*/ u16 species;
    /*0x0e*/ u16 species2;
    /*0x10*/ u8 nBallsUsed;
    /*0x11*/ u8 outcome;
    /*0x12*/ u8 location;
    /*0x13*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
};

struct TVShowPokemonAngler
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 nBites;
    /*0x03*/ u8 nFails;
    /*0x04*/ u16 species;
    /*0x06*/ u8 language;
    /*0x07*/ u8 unused[12];
    /*0x13*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
};

struct TVShowWorldOfMasters
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u16 numPokeCaught;
    /*0x04*/ u16 caughtPoke;
    /*0x06*/ u16 steps;
    /*0x08*/ u16 species;
    /*0x0a*/ u8 location;
    /*0x0b*/ u8 language;
    /*0x0c*/ u8 unused[7];
    /*0x13*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
};

struct TVShowMassOutbreak
{
    /*0x00*/ u8 kind;
    /*0x01*/ bool8 active;
    /*0x02*/ u8 unused1;
    /*0x03*/ u8 unused2;
    /*0x04*/ u16 moves[MAX_MON_MOVES];
    /*0x0C*/ u16 species;
    /*0x0E*/ u16 unused3;
    /*0x10*/ u8 locationMapNum;
    /*0x11*/ u8 locationMapGroup;
    /*0x12*/ u8 unused4;
    /*0x13*/ u8 probability;
    /*0x14*/ u8 level;
    /*0x15*/ u8 unused5;
    /*0x16*/ u16 daysLeft;
    /*0x18*/ u8 language;
    u8 pad19[11];
};

typedef union TVShow
{
    struct TVShowCommon common;
    struct TVShowFanClubLetter fanclubLetter;
    struct TVShowRecentHappenings recentHappenings;
    struct TVShowFanclubOpinions fanclubOpinions;
    struct TVShowUnknownType04 unkShow04;
    struct TVShowNameRaterShow nameRaterShow;
    struct TVShowBravoTrainerPokemonProfiles bravoTrainer;
    struct TVShowBravoTrainerBattleTowerSpotlight bravoTrainerTower;
    struct TVShowPokemonToday pokemonToday;
    struct TVShowSmartShopper smartshopperShow;
    struct TVShowPokemonTodayFailed pokemonTodayFailed;
    struct TVShowPokemonAngler pokemonAngler;
    struct TVShowWorldOfMasters worldOfMasters;
    struct TVShowMassOutbreak massOutbreak;
} TVShow;

struct MailStruct
{
    /*0x00*/ u16 words[9];
    /*0x12*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x1A*/ u8 trainerId[TRAINER_ID_LENGTH];
    /*0x1E*/ u16 species;
    /*0x20*/ u16 itemId;
};


// Mauville Pokemon Center men

struct MauvilleManCommon
{
    u8 id;
};

struct MauvilleManBard
{
    /*0x00*/ u8 id;
    /*0x02*/ u16 songLyrics[6];
    /*0x0E*/ u16 temporaryLyrics[6];
    /*0x1A*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x22*/ u8 unused[0x3];
    /*0x25*/ u8 playerTrainerId[TRAINER_ID_LENGTH];
    /*0x29*/ bool8 hasChangedSong;
}; /*size = 0x2C*/

struct MauvilleManHipster
{
    u8 id;
    bool8 alreadySpoken;
};

struct MauvilleManTrader
{
    u8 id;
    u8 decorations[4];
    u8 playerNames[4][POKEMON_NAME_LENGTH + 1];
    bool8 alreadyTraded;
};

struct MauvilleManStoryteller
{
    u8 id;
    bool8 alreadyRecorded;
    u8 unused[2];
    u8 gameStatIDs[4];
    u8 trainerNames[4][PLAYER_NAME_LENGTH];
    u8 statValues[4][4];
};

struct MauvilleManGiddy
{
    /*0x00*/ u8 id;
    /*0x01*/ u8 taleCounter;
    /*0x02*/ u8 questionNum;
    /*0x04*/ u16 randomWords[10];
    /*0x18*/ u8 questionList[12];
}; /*size = 0x2C*/


union MauvilleMan
{
    struct MauvilleManCommon common;
    struct MauvilleManBard bard;
    struct MauvilleManHipster hipster;
    struct MauvilleManTrader trader;
    struct MauvilleManStoryteller storyteller;
    struct MauvilleManGiddy giddy;
    u8 filler[0x40];  // needed to pad out the struct
};

struct PokeNews
{
    u8 kind;
    u8 state;
    u16 days;
};

struct GabbyAndTyData
{
    /*2b10*/ u16 mon1;
    /*2b12*/ u16 mon2;
    /*2b14*/ u16 lastMove;
    /*2b16*/ u16 quote;
    /*2b18*/ u8 mapnum;
    /*2b19*/ u8 battleNum;
    /*2b1a*/ u8 battleTookMoreThanOneTurn:1;
    /*2b1a*/ u8 playerLostAMon:1;
    /*2b1a*/ u8 playerUsedHealingItem:1;
    /*2b1a*/ u8 playerThrewABall:1;
    /*2b1a*/ u8 onAir:1;
    /*2b1a*/ u8 unused1:3;
    /*2b1b*/ u8 battleTookMoreThanOneTurn2:1;
    /*2b1b*/ u8 playerLostAMon2:1;
    /*2b1b*/ u8 playerUsedHealingItem2:1;
    /*2b1b*/ u8 playerThrewABall2:1;
    /*2b1b*/ u8 unused2:4;
};

struct DayCareMail
{
    /*0x00*/ struct MailStruct message;
    /*0x24*/ u8 names[19];
};

struct DayCareStepCountersEtc {
    u32 steps[DAYCARE_MON_COUNT];
    u16 pendingEggPersonality;
    u8 eggCycleStepsRemaining;
};

struct RecordMixingDayCareMail
{
    struct DayCareMail mail[DAYCARE_MON_COUNT];
    u32 numDaycareMons;
    u16 itemsHeld[DAYCARE_MON_COUNT]; // marks whether or not each daycare mon is currently holding an item.
};

struct DayCareMisc
{
    struct DayCareMail mail[DAYCARE_MON_COUNT];
    struct DayCareStepCountersEtc countersEtc;
};

struct DayCare {
    struct BoxPokemon mons[DAYCARE_MON_COUNT];
    struct DayCareMisc misc;
};

struct LinkBattleRecord
{
    u8 name[PLAYER_NAME_LENGTH + 1];
    u16 trainerId;
    u16 wins;
    u16 losses;
    u16 draws;
};

struct RecordMixingGiftData
{
    u8 unk0;
    u8 quantity;
    u16 itemId;
    u8 filler4[8];
};

struct RecordMixingGift
{
    u32 checksum;
    struct RecordMixingGiftData data;
};

struct ContestWinner
{
    /*0x00*/ u32 personality;  // personality
    /*0x04*/ u32 otId;  // otId
    /*0x08*/ u16 species;  // species
    /*0x0A*/ u8 contestCategory;
    /*0x0B*/ u8 nickname[POKEMON_NAME_LENGTH + 1];
    /*0x16*/ u8 trainerName[PLAYER_NAME_LENGTH + 1];
};

struct ExternalEventData
{
    u8 unknownExternalDataFields1[7]; // if actually used, may be broken up into different fields.
    u32 unknownExternalDataFields2:8;
    u32 currentPokeCoupons:24; // PokéCoupons stored by Pokémon Colosseum and XD from Mt. Battle runs. Earned PokéCoupons are also added to totalEarnedPokeCoupons. Colosseum/XD caps this at 9,999,999, but will read up to 16,777,215.
    u32 gotGoldPokeCouponTitleReward:1; // Master Ball from Jp Colosseum Bonus Disc; for reaching 30,000 totalEarnedPokeCoupons
    u32 gotSilverPokeCouponTitleReward:1; // Light Ball Pikachu from JP Colosseum Bonus Disc; for reaching 5000 totalEarnedPokeCoupons
    u32 gotBronzePokeCouponTitleReward:1; // PP Max from JP Colosseum Bonus Disc; for reaching 2500 totalEarnedPokeCoupons
    u32 receivedAgetoCelebi:1; // from JP Colosseum Bonus Disc
    u32 unknownExternalDataFields3:4;
    u32 totalEarnedPokeCoupons:24; // Used by the JP Colosseum bonus disc. Determines PokéCoupon rank to distribute rewards. Unread in International games. Colosseum/XD caps this at 9,999,999.
    u8 unknownExternalDataFields4[5]; // if actually used, may be broken up into different fields.
} __attribute__((packed)); /*size = 0x14*/

// For external event flags. The majority of these may have never been used.
struct ExternalEventFlags
{
    u8 usedBoxRS:1; // Set by Pokémon Box: Ruby & Sapphire; denotes whether this save has connected to it and triggered the free False Swipe Swablu Egg giveaway.
    u8 boxRSEggsUnlocked:2; // Set by Pokémon Box: Ruby & Sapphire; denotes the number of Eggs unlocked from deposits; 1 for ExtremeSpeed Zigzagoon (at 100 deposited), 2 for Pay Day Skitty (at 500 deposited), 3 for Surf Pichu (at 1500 deposited)
    u8 padding:5;
    u8 unknownFlag1;
    u8 receivedGCNJirachi; // Both the US Colosseum Bonus Disc and PAL/AUS Pokémon Channel use this field. One cannot receive a WISHMKR Jirachi and CHANNEL Jirachi with the same savefile.
    u8 unknownFlag3;
    u8 unknownFlag4;
    u8 unknownFlag5;
    u8 unknownFlag6;
    u8 unknownFlag7;
    u8 unknownFlag8;
    u8 unknownFlag9;
    u8 unknownFlag10;
    u8 unknownFlag11;
    u8 unknownFlag12;
    u8 unknownFlag13;
    u8 unknownFlag14;
    u8 unknownFlag15;
    u8 unknownFlag16;
    u8 unknownFlag17;
    u8 unknownFlag18;
    u8 unknownFlag19;
    u8 unknownFlag20;

} __attribute__((packed));/*size = 0x15*/

// there should be enough flags for all 412 slots
// each slot takes up 8 flags
// if the value is not divisible by 8, we need to account for the reminder as well
#define DEX_FLAGS_NO ((NUM_SPECIES / 8) + ((NUM_SPECIES % 8) ? 1 : 0))

struct SaveBlock1 /* 0x02025734 */
{
    /*0x00*/ struct Coords16 pos;
    /*0x04*/ struct WarpData location;
    /*0x0C*/ struct WarpData continueGameWarp;
    /*0x14*/ struct WarpData dynamicWarp;
    /*0x1C*/ struct WarpData lastHealLocation;
    /*0x24*/ struct WarpData escapeWarp;
    /*0x2C*/ u16 savedMusic;
    /*0x2E*/ u8 weather;
    /*0x2F*/ u8 weatherCycleStage;
    /*0x30*/ u8 flashLevel;  // flash level on current map, 0 being normal and 4 being the darkest
    /*0x32*/ u16 mapLayoutId;
    /*0x34*/ u16 mapView[0x100];
    /*0x234*/ u8 playerPartyCount;
    /*0x238*/ struct Pokemon playerParty[PARTY_SIZE];
    /*0x490*/ u32 money;
    /*0x494*/ u16 coins;
    /*0x496*/ u16 registeredItem; // registered for use with SELECT button
    /*0x498*/ struct ItemSlot pcItems[PC_ITEMS_COUNT];
    /*0x560*/ struct ItemSlot bagPocket_Items[BAG_ITEMS_COUNT];
    /*0x5B0*/ struct ItemSlot bagPocket_KeyItems[BAG_KEYITEMS_COUNT];
    /*0x600*/ struct ItemSlot bagPocket_PokeBalls[BAG_POKEBALLS_COUNT];
    /*0x640*/ struct ItemSlot bagPocket_TMHM[BAG_TMHM_COUNT];
    /*0x740*/ struct ItemSlot bagPocket_Berries[BAG_BERRIES_COUNT];
    /*0x7F8*/ struct Pokeblock pokeblocks[POKEBLOCKS_COUNT];
    /*0x938*/ u8 dexSeen2[DEX_FLAGS_NO];
    /*0x96C*/ u16 berryBlenderRecords[3];
    /*0x972*/ u8 filler_972[0x6];
    /*0x978*/ u16 trainerRematchStepCounter;
    /*0x97A*/ u8 trainerRematches[100];
    /*0x9E0*/ struct EventObject eventObjects[EVENT_OBJECTS_COUNT];
    /*0xC20*/ struct EventObjectTemplate eventObjectTemplates[64];
    /*0x1220*/ u8 flags[FLAGS_COUNT];
    /*0x1340*/ u16 vars[VARS_COUNT];
    /*0x1540*/ u32 gameStats[NUM_GAME_STATS];
    /*0x1608*/ struct BerryTree berryTrees[BERRY_TREES_COUNT];
    /*0x1A08*/ struct SecretBaseRecord secretBases[SECRET_BASES_COUNT];
    /*0x2688*/ u8 playerRoomDecor[12];
    /*0x2694*/ u8 playerRoomDecorPos[12];
    /*0x26A0*/ u8 decorDesk[10];
    /*0x26AA*/ u8 decorChair[10];
    /*0x26B4*/ u8 decorPlant[10];
    /*0x26BE*/ u8 decorOrnament[30];
    /*0x26DC*/ u8 decorMat[30];
    /*0x26FA*/ u8 decorPoster[10];
    /*0x2704*/ u8 decorDoll[40];
    /*0x272C*/ u8 decorCushion[10];
    /*0x2736*/ u8 padding_2736[2];
    /*0x2738*/ TVShow tvShows[TV_SHOWS_COUNT];
    /*0x2ABC*/ struct PokeNews pokeNews[POKE_NEWS_COUNT];
    /*0x2AFC*/ u16 outbreakPokemonSpecies;
    /*0x2AFE*/ u8 outbreakLocationMapNum;
    /*0x2AFF*/ u8 outbreakLocationMapGroup;
    /*0x2B00*/ u8 outbreakPokemonLevel;
    /*0x2B01*/ u8 outbreakUnk1;
    /*0x2B02*/ u16 outbreakUnk2;
    /*0x2B04*/ u16 outbreakPokemonMoves[4];
    /*0x2B0C*/ u8 outbreakUnk4;
    /*0x2B0D*/ u8 outbreakPokemonProbability;
    /*0x2B0E*/ u16 outbreakUnk5;
    /*0x2B10*/ struct GabbyAndTyData gabbyAndTyData;
    /*0x2B1C*/ struct {
        /*0x2B1C*/ u16 unk2B1C[6];
        /*0x2B28*/ u16 unk2B28[6];
        /*0x2B34*/ u16 unk2B34[6];
        /*0x2B40*/ u16 unk2B40[6];
    } easyChats;
    /*0x2B4C*/ struct MailStruct mail[MAIL_COUNT];
    /*0x2D8C*/ u8 unk2D8C[4];  // What is this? Apparently it's supposed to be 64 bytes in size.
    /*0x2D90*/ u8 filler_2D90[0x4];
    /*0x2D94*/ union MauvilleMan mauvilleMan;
    /*0x2DD4*/ struct DewfordTrend dewfordTrends[SAVED_TRENDS_COUNT]; //Dewford trend [0] and some other stuff
    /*0x2DFC*/ struct ContestWinner contestWinners[8];
    /*0x2EFC*/ struct ContestWinner museumPortraits[5];
    /*0x2F9C*/ struct DayCare daycare;
    /*0x30B8*/ struct LinkBattleRecord linkBattleRecords[5];
    /*0x3108*/ u8 filler_3108[8];
    /*0x3110*/ u8 giftRibbons[GIFT_RIBBONS_COUNT];
    /*0x311B*/ struct ExternalEventData externalEventData;
    /*0x312F*/ struct ExternalEventFlags externalEventFlags;
    /*0x3144*/ struct Roamer roamer;
    /*0x3160*/ struct EnigmaBerry enigmaBerry;
    /*0x3690*/ struct RamScript ramScript;
    /*0x3A7C*/ struct RecordMixingGift recordMixingGift;
    /*0x3A8C*/ u8 dexSeen3[DEX_FLAGS_NO];
};

extern void * gLastSaveBlockPtr;

struct Time
{
    /*0x00*/ s16 days;
    /*0x02*/ s8 hours;
    /*0x03*/ s8 minutes;
    /*0x04*/ s8 seconds;
};

struct Pokedex
{
    /*0x00*/ u8 order;
    /*0x01*/ u8 unknown1;
    /*0x02*/ u8 nationalMagic; // must equal 0xDA in order to have National mode
    /*0x03*/ u8 unknown2;
    /*0x04*/ u32 unownPersonality; // set when you first see Unown
    /*0x08*/ u32 spindaPersonality; // set when you first see Spinda
    /*0x0C*/ u32 unknown3;
    /*0x10*/ u8 owned[DEX_FLAGS_NO];
    /*0x44*/ u8 seen[DEX_FLAGS_NO];
};

struct BattleTowerTrainer
{
    /*0x00*/ u8 trainerClass;
    /*0x01*/ u8 name[8];
    /*0x09*/ u8 teamFlags;
    u8 filler0A[2];
    /*0x0C*/ u16 greeting[6];
};

struct BattleTowerRecord // record mixing
{
    /*0x00*/ u8 battleTowerLevelType; // 0 = level 50, 1 = level 100
    /*0x01*/ u8 trainerClass;
    /*0x02*/ u16 winStreak;
    /*0x04*/ u8 name[8];
    /*0x0C*/ u8 trainerId[4];
    /*0x10*/ u16 greeting[6];
    /*0x1C*/ struct BattleTowerPokemon party[3];
    /*0xA0*/ u32 checksum;
};

struct BattleTowerEReaderTrainer
{
    /*0x00*/ u8 unk0;
    /*0x01*/ u8 trainerClass;
    /*0x02*/ u16 winStreak;
    /*0x04*/ u8 name[8];
    /*0x0C*/ u8 trainerId[4];
    /*0x10*/ u16 greeting[6];
    /*0x1C*/ u16 farewellPlayerLost[6];
    /*0x28*/ u16 farewellPlayerWon[6];
    /*0x34*/ struct BattleTowerPokemon party[3];
    /*0xB8*/ u32 checksum;
};

struct BattleTowerData
{
    /*0x0000, 0x00A8*/ struct BattleTowerRecord playerRecord;
    /*0x00A4, 0x014C*/ struct BattleTowerRecord records[5]; // from record mixing
    /*0x03D8, 0x0480*/ u16 firstMonSpecies; // species of the first pokemon in the player's battle tower party
    /*0x03DA, 0x0482*/ u16 defeatedBySpecies; // species of the pokemon that defated the player
    /*0x03DC, 0x0484*/ u8 defeatedByTrainerName[8];
    /*0x03E4, 0x048C*/ u8 firstMonNickname[POKEMON_NAME_LENGTH]; // nickname of the first pokemon in the player's battle tower party
    /*0x03F0, 0x0498*/ struct BattleTowerEReaderTrainer ereaderTrainer;
    /*0x04AC, 0x0554*/ u8 battleTowerLevelType:1; // 0 = level 50; 1 = level 100
    /*0x04AC, 0x0554*/ u8 unk_554:1;
    /*0x04AD, 0x0555*/ u8 battleOutcome;
    /*0x04AE, 0x0556*/ u8 var_4AE[2];
    /*0x04B0, 0x0558*/ u16 curChallengeBattleNum[2]; // 1-based index of battle in the current challenge. (challenges consist of 7 battles)
    /*0x04B4, 0x055C*/ u16 curStreakChallengesNum[2]; // 1-based index of the current challenge in the current streak.
    /*0x04B8, 0x0560*/ u16 recordWinStreaks[2];
    /*0x04BC, 0x0564*/ u8 battleTowerTrainerId; // index for gBattleTowerTrainers table
    /*0x04BD, 0x0565*/ u8 selectedPartyMons[0x3]; // indices of the 3 selected player party mons.
    /*0x04C0, 0x0568*/ u16 prizeItem;
    /*0x04C2, 0x056A*/ u8 battledTrainerIds[6];
    /*0x04C8, 0x0570*/ u16 totalBattleTowerWins;
    /*0x04CA, 0x0572*/ u16 bestBattleTowerWinStreak;
    /*0x04CC, 0x0574*/ u16 currentWinStreaks[2];
    /*0x04D0, 0x0578*/ u8 lastStreakLevelType; // 0 = level 50, 1 = level 100.  level type of the last streak. Used by tv to report the level mode.
    /*0x04D1, 0x0579*/ u8 filler_4D1[0x317];
};

struct SaveBlock2 /* 0x02024EA4 */
{
    /*0x00*/ u8 playerName[PLAYER_NAME_LENGTH + 1];
    /*0x08*/ u8 playerGender; // MALE, FEMALE
    /*0x09*/ u8 specialSaveWarp;
    /*0x0A*/ u8 playerTrainerId[4];
    /*0x0E*/ u16 playTimeHours;
    /*0x10*/ u8 playTimeMinutes;
    /*0x11*/ u8 playTimeSeconds;
    /*0x12*/ u8 playTimeVBlanks;
    /*0x13*/ u8 optionsButtonMode;         // OPTIONS_BUTTON_MODE_[NORMAL/LR/L_EQUALS_A]
    /*0x14*/ u16 optionsTextSpeed:3;       // OPTIONS_TEXT_SPEED_[SLOW/MID/FAST]
    u16 optionsWindowFrameType:5; // Specifies one of the 20 decorative borders for text boxes
    u16 optionsSound:1;           // OPTIONS_SOUND_[MONO/STEREO]
    u16 optionsBattleStyle:1;     // OPTIONS_BATTLE_STYLE_[SHIFT/SET]
    u16 optionsBattleSceneOff:1;  // whether battle animations are disabled
    u16 regionMapZoom:1;          // whether the map is zoomed in
    /*0x18*/ struct Pokedex pokedex;
    /*0x90*/ u8 filler_90[0x8];
    /*0x98*/ struct Time localTimeOffset;
    /*0xA0*/ struct Time lastBerryTreeUpdate;
    /*0xA8*/ struct BattleTowerData battleTower;
};

struct MapPosition
{
    s16 x;
    s16 y;
    s8 height;
};

struct UnkStruct_8054FF8
{
    u8 a;
    u8 b;
    u8 c;
    u8 d;
    struct MapPosition sub;
    u16 field_C;
};

// wasnt defined so I had to define it
struct HallOfFame
{
    u8 filler[0x1F00];
};

extern u16 * gVarsPtr;
extern void * gSaveBlock2Ptr;

#define RomHeaderGameTitle       ((const char *)0x080000A0)
#define RomHeaderGameCode        ((const char *)0x080000AC)
#define RomHeaderMakerCode       ((const char *)0x080000B0)
#define RomHeaderMagic           ((const u8 *)  0x080000B2)
#define RomHeaderSoftwareVersion ((const u8 *)  0x080000BC)

#define LocalTimeOffset     ((struct Time *)0x02028098)
#define LastBerryTreeUpdate ((struct Time *)0x020280A0)

#endif //GUARD_GLOBAL_H
