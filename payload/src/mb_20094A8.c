#include "global.h"
#include "gflib/text.h"
#include "constants/berry.h"
#include "constants/items.h"
#include "constants/maps.h"
#include "constants/pokemon.h"

const struct SpindaSpot gSpindaSpotGraphics[] =
{
    {16, 14, INCBIN_U16("graphics/spinda_spots/spot_0.bin")},
    {40, 15, INCBIN_U16("graphics/spinda_spots/spot_1.bin")},
    {22, 32, INCBIN_U16("graphics/spinda_spots/spot_2.bin")},
    {34, 33, INCBIN_U16("graphics/spinda_spots/spot_3.bin")}
};

const u8 gText_Egg[] = _("EGG");

#include "data/berries.h"

const u32 gBitTable[] = {
    1 << 0,
    1 << 1,
    1 << 2,
    1 << 3,
    1 << 4,
    1 << 5,
    1 << 6,
    1 << 7,
    1 << 8,
    1 << 9,
    1 << 10,
    1 << 11,
    1 << 12,
    1 << 13,
    1 << 14,
    1 << 15,
    1 << 16,
    1 << 17,
    1 << 18,
    1 << 19,
    1 << 20,
    1 << 21,
    1 << 22,
    1 << 23,
    1 << 24,
    1 << 25,
    1 << 26,
    1 << 27,
    1 << 28,
    1 << 29,
    1 << 30,
    1 << 31,
};

const u8 gTypeToPaletteNumber[] = {
    [TYPE_NORMAL] = 13,
    [TYPE_FIGHTING] = 13,
    [TYPE_FLYING] = 14,
    [TYPE_POISON] = 14,
    [TYPE_GROUND] = 13,
    [TYPE_ROCK] = 13,
    [TYPE_BUG] = 15,
    [TYPE_GHOST] = 14,
    [TYPE_STEEL] = 13,
    [TYPE_MYSTERY] = 15,
    [TYPE_FIRE] = 13,
    [TYPE_WATER] = 14,
    [TYPE_GRASS] = 15,
    [TYPE_ELECTRIC] = 13,
    [TYPE_PSYCHIC] = 14,
    [TYPE_ICE] = 14,
    [TYPE_DRAGON] = 15,
    [TYPE_DARK] = 13,
    [NUMBER_OF_MON_TYPES + CONTEST_CATEGORY_COOL] = 13,
    [NUMBER_OF_MON_TYPES + CONTEST_CATEGORY_BEAUTY] = 14,
    [NUMBER_OF_MON_TYPES + CONTEST_CATEGORY_CUTE] = 14,
    [NUMBER_OF_MON_TYPES + CONTEST_CATEGORY_SMART] = 15,
    [NUMBER_OF_MON_TYPES + CONTEST_CATEGORY_TOUGH] = 13,
};

const u8 gPPUpReadMasks[] = {
    3 << 0,
    3 << 2,
    3 << 4,
    3 << 6
};

const u8 gGiftRibbonMonDataIds[] = {
    MON_DATA_MARINE_RIBBON,
    MON_DATA_LAND_RIBBON,
    MON_DATA_SKY_RIBBON,
    MON_DATA_COUNTRY_RIBBON,
    MON_DATA_NATIONAL_RIBBON,
    MON_DATA_EARTH_RIBBON,
    MON_DATA_WORLD_RIBBON
};

#include "data/species_to_national.h"

ALIGNED(4) const u8 gExtCtrlCodeLengths[] = {
    [EXT_CTRL_CODE_COLOR - 1]                  = 1,
    [EXT_CTRL_CODE_HIGHLIGHT - 1]              = 2,
    [EXT_CTRL_CODE_SHADOW - 1]                 = 2,
    [EXT_CTRL_CODE_COLOR_HIGHLIGHT_SHADOW - 1] = 2,
    [EXT_CTRL_CODE_PALETTE - 1]                = 4,
    [EXT_CTRL_CODE_FONT - 1]                   = 2,
    [EXT_CTRL_CODE_RESET_SIZE - 1]             = 2,
    [EXT_CTRL_CODE_PAUSE - 1]                  = 1,
    [EXT_CTRL_CODE_PAUSE_UNTIL_PRESS - 1]      = 2,
    [EXT_CTRL_CODE_WAIT_SE - 1]                = 1,
    [EXT_CTRL_CODE_PLAY_BGM - 1]               = 1,
    [EXT_CTRL_CODE_ESCAPE - 1]                 = 3,
    [EXT_CTRL_CODE_SHIFT_TEXT - 1]             = 2,
    [EXT_CTRL_CODE_SHIFT_DOWN - 1]             = 2,
    [EXT_CTRL_CODE_FILL_WINDOW - 1]            = 2,
    [EXT_CTRL_CODE_PLAY_SE - 1]                = 1,
    [EXT_CTRL_CODE_CLEAR - 1]                  = 3,
    [EXT_CTRL_CODE_SKIP - 1]                   = 2,
    [EXT_CTRL_CODE_CLEAR_TO - 1]               = 2,
    [EXT_CTRL_CODE_MIN_LETTER_SPACING - 1]     = 2,
    [EXT_CTRL_CODE_JPN - 1]                    = 2,
    [EXT_CTRL_CODE_ENG - 1]                    = 1,
    [EXT_CTRL_CODE_PAUSE_MUSIC - 1]            = 1,
    [EXT_CTRL_CODE_RESUME_MUSIC - 1]           = 0,
};

const u16 gRSPokemonCenterMaps[] =
{
    MAP_OLDALE_TOWN_POKEMON_CENTER_1F,
    MAP_OLDALE_TOWN_POKEMON_CENTER_2F,
    MAP_DEWFORD_TOWN_POKEMON_CENTER_1F,
    MAP_DEWFORD_TOWN_POKEMON_CENTER_2F,
    MAP_LAVARIDGE_TOWN_POKEMON_CENTER_1F,
    MAP_LAVARIDGE_TOWN_POKEMON_CENTER_2F,
    MAP_FALLARBOR_TOWN_POKEMON_CENTER_1F,
    MAP_FALLARBOR_TOWN_POKEMON_CENTER_2F,
    MAP_VERDANTURF_TOWN_POKEMON_CENTER_1F,
    MAP_VERDANTURF_TOWN_POKEMON_CENTER_2F,
    MAP_PACIFIDLOG_TOWN_POKEMON_CENTER_1F,
    MAP_PACIFIDLOG_TOWN_POKEMON_CENTER_2F,
    MAP_PETALBURG_CITY_POKEMON_CENTER_1F,
    MAP_PETALBURG_CITY_POKEMON_CENTER_2F,
    MAP_SLATEPORT_CITY_POKEMON_CENTER_1F,
    MAP_SLATEPORT_CITY_POKEMON_CENTER_2F,
    MAP_MAUVILLE_CITY_POKEMON_CENTER_1F,
    MAP_MAUVILLE_CITY_POKEMON_CENTER_2F,
    MAP_RUSTBORO_CITY_POKEMON_CENTER_1F,
    MAP_RUSTBORO_CITY_POKEMON_CENTER_2F,
    MAP_FORTREE_CITY_POKEMON_CENTER_1F,
    MAP_FORTREE_CITY_POKEMON_CENTER_2F,
    MAP_LILYCOVE_CITY_POKEMON_CENTER_1F,
    MAP_LILYCOVE_CITY_POKEMON_CENTER_2F,
    MAP_MOSSDEEP_CITY_POKEMON_CENTER_1F,
    MAP_MOSSDEEP_CITY_POKEMON_CENTER_2F,
    MAP_SOOTOPOLIS_CITY_POKEMON_CENTER_1F,
    MAP_SOOTOPOLIS_CITY_POKEMON_CENTER_2F,
    MAP_EVER_GRANDE_CITY_POKEMON_CENTER_1F,
    MAP_EVER_GRANDE_CITY_POKEMON_CENTER_2F,
    MAP_EVER_GRANDE_CITY_POKEMON_LEAGUE,
    MAP_SINGLE_BATTLE_COLOSSEUM,
    MAP_TRADE_CENTER,
    MAP_RECORD_CORNER,
    MAP_DOUBLE_BATTLE_COLOSSEUM,
    MAP_UNDEFINED
};

const u16 gRSSpecialAreaMaps[] =
{
    MAP_BATTLE_TOWER_LOBBY,
    MAP_UNDEFINED
};

u8 gText_BadEgg[] = _("Bad EGG");
