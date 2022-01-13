#include "global.h"
#include "strings.h"

u8 * gTypeNames[] =
{
    gText_Type_Normal,
    gText_Type_Fighting,
    gText_Type_Flying,
    gText_Type_Poison,
    gText_Type_Ground,
    gText_Type_Rock,
    gText_Type_Bug,
    gText_Type_Ghost,
    gText_Type_Steel,
    gText_Type_Mystery,
    gText_Type_Fire,
    gText_Type_Water,
    gText_Type_Grass,
    gText_Type_Electric,
    gText_Type_Psychic,
    gText_Type_Ice,
    gText_Type_Dragon,
    gText_Type_Dark,
};

u8 * gBattleStringsTable[] =
{
    gText_MonCantSwitchOut,
    gText_CantSwitchShadowTag,
    gText_CantSwitchArenaTrap,
    gText_CantSwitchMagnetPull,
    gText_MoveDisabled,
    gText_CantUseTorment,
    gText_CantUseTaunt,
    gText_CantUseImprison,
    gText_CantUseChoiceBand,
    gText_CantUsePP,
    gText_NoEnergyLeft,
    gText_AlreadyInBattle,
    gText_AlreadySelected,
    gText_CantSwitchWithFoe,
    gText_NoMovesLeft,
};

u8 gText_SaveFileDeleted[] = _("The save filehas been deleted...");
u8 gText_SaveFileCorrupted[] = _("The save file is corrupted.");
u8 gText_NoSaveFile[] = _("There is no save file.");
u8 gText_SelectNumberPokemon[] = _("Please select {UNKNOWN_STR} POKéMON.");
u8 gText_SelectPokemon[] = _("Please select a POKéMON.");
u8 gText_DoWhatWithMon[] = _("Do what with {STR_VAR_3}?");
u8 gText_Switch[] = _("SWITCH");
u8 gText_SendOut[] = _("SEND OUT");
u8 gText_Summary[] = _("SUMMARY");
u8 gText_Cancel[] = _("CANCEL");
u8 gText_Select[] = _("SELECT");
u8 gText_Deselect[] = _("DESELECT");
u8 gText_PokemonSkills[] = _("POKéMON SKILLS");
u8 gText_BattleMoves[] = _("BATTLE MOVES");
u8 gText_Type[] = _("TYPE");
u8 gText_HP[] = _("HP");
u8 gText_Attack[] = _("ATTACK");
u8 gText_Defense[] = _("DEFENSE");
u8 gText_SpAtk[] = _("SP. ATK");
u8 gText_SpDef[] = _("SP. DEF");
u8 gText_Speed[] = _("SPEED");
u8 gText_None[] = _("NONE");
u8 gText_Berry[] = _("BERRY");
u8 gText_Cancel2[] = _("CANCEL");
u8 gText_Info[] = _("INFO");
u8 gText_1Dash[] = _("-");
u8 gText_2Dashes[] = _("--");
u8 gText_3Dashes[] = _("---");
u8 gText_Power[] = _("POWER");
u8 gText_Accuracy[] = _("ACCURACY");
u8 gText_Cancel3[] = _("CANCEL");
u8 gText_Status[] = _("STATUS");
u8 gText_Space[] = _(" ");
u8 gText_Number[] = _("No. {UNKNOWN_STR}");
u8 gText_SelectAdditionalPokemon[] = _("Select additional POKéMON!");
u8 gText_Fight[] = _("FIGHT");
u8 gText_GiveIn[] = _("GIVE IN");
u8 gText_Pokemon[] = _("POKéMON");
u8 gText_WhatWillMonDo[] = _("What will\n{STR_VAR_3} do?");
u8 gText_PP[] = _("PP");
u8 gText_MoveType[] = _("MOVE TYPE");
u8 gText_Type_Normal[] = _("NORMAL");
u8 gText_Type_Fighting[] = _("FIGHT");
u8 gText_Type_Flying[] = _("FLYING");
u8 gText_Type_Poison[] = _("POISON");
u8 gText_Type_Ground[] = _("GROUND");
u8 gText_Type_Rock[] = _("ROCK");
u8 gText_Type_Bug[] = _("BUG");
u8 gText_Type_Ghost[] = _("GHOST");
u8 gText_Type_Steel[] = _("STEEL");
u8 gText_Type_Mystery[] = _("???");
u8 gText_Type_Fire[] = _("FIRE");
u8 gText_Type_Water[] = _("WATER");
u8 gText_Type_Grass[] = _("GRASS");
u8 gText_Type_Electric[] = _("ELECTR");
u8 gText_Type_Psychic[] = _("PSYCHC");
u8 gText_Type_Ice[] = _("ICE");
u8 gText_Type_Dragon[] = _("DRAGON");
u8 gText_Type_Dark[] = _("DARK");
u8 gText_WillYouGiveIn[] = _("Will you give in?");
u8 gText_Yes[] = _("Yes");
u8 gText_No[] = _("No");
u8 gText_MonCantSwitchOut[] = _("{STR_VAR_3} can't be\nswitched out!\p");
u8 gText_CantSwitchShadowTag[] = _("FOE {UNKNOWN_STR}'s SHADOW TAG stops\n{STR_VAR_3} from switching out!\p");
u8 gText_CantSwitchArenaTrap[] = _("FOE {UNKNOWN_STR}'s ARENA TRAP stops\n{STR_VAR_3} from switching out!\p");
u8 gText_CantSwitchMagnetPull[] = _("FOE {UNKNOWN_STR}'s MAGNET PULL stops\n{STR_VAR_3} from switching out!\p");
u8 gText_MoveDisabled[] = _("{STR_VAR_3}'s {UNKNOWN_STR} is disabled!\p");
u8 gText_CantUseTorment[] = _("{STR_VAR_3} can't use the same\nmove in a row due to the TORMENT!\p");
u8 gText_CantUseTaunt[] = _("{STR_VAR_3} can't use\n{UNKNOWN_STR} after the TAUNT!\p");
u8 gText_CantUseImprison[] = _("{STR_VAR_3} can't use the\nsealed {UNKNOWN_STR}!\p");
u8 gText_CantUseChoiceBand[] = _("CHOICE BAND allows the\nuse of only {UNKNOWN_STR}!\p");
u8 gText_CantUsePP[] = _("There's no PP left for\nthis move!\p");
u8 gText_NoEnergyLeft[] = _("{STR_VAR_3} has no energy\nleft to battle!\p");
u8 gText_AlreadyInBattle[] = _("{STR_VAR_3} is already\nin battle!\p");
u8 gText_AlreadySelected[] = _("{STR_VAR_3} has already been\nselected.\p");
u8 gText_CantSwitchWithFoe[] = _("You can't switch {STR_VAR_3}'s\nPOKéMON with one of yours!\p");
u8 gText_NoMovesLeft[] = _("{STR_VAR_3} has no\nmoves left!\p");
u8 gText_Charmander[] = _("CHARMANDER");
u8 gText_Kangaskhan[] = _("KANGASKHAN");
u8 gText_Typhlosion[] = _("TYPHLOSION");
u8 gText_LinkStandby[] = _("Link standby...");
u8 gText_Linking[] = _("Linking...");
u8 gText_DontTurnOffPower[] = _("Please don't turn off the power.");
u8 gText_SaveFailed[] = _("Save failed.");
u8 gText_LinkInterrupted[] = _("The link was interrupted.");
u8 gText_CannotBeLinked[] = _("This Game Pak cannot be linked to\nPOKéMON COLOSSEUM.\p");
u8 gText_CannotTrade[] = _("This Game Pak cannot trade with\nPOKéMON COLOSSEUM.\p");
u8 gText_ReceivingMoveData[] = _("Receiving move data...");
u8 gText_ReceivingPokemonData[] = _("Sending POKéMON data...");
u8 gText_ReceivingBattlePokemonData[] = _("Receiving battle POKéMON data...");
u8 gText_ReceivingBattleData[] = _("Receiving battle data...");
u8 gText_StartTrade[] = _("Start POKéMON trade.");
u8 gText_EndTrade[] = _("End POKéMON trade.");
u8 gText_SendingCoupons[] = _("Sending POKé COUPONS...");
u8 gText_ReceivingCoupons[] = _("Receiving POKé COUPONS...");
u8 gText_BerryProgramUpdated[] = _("Your Berry Program was updated.\p");
u8 gText_UnableUpdateBerryProgram[] = _("Unable to update Berry Program.\p");
