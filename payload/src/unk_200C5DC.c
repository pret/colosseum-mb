#include "global.h"
#include "libpmagb/agb_rom.h"
#include "pokeball.h"
#include "pokedex.h"
#include "constants/items.h"

u8 ItemIdToBallId(u16 ballItem)
{
    switch (ballItem)
    {
    case ITEM_MASTER_BALL:
        return BALL_MASTER;
    case ITEM_ULTRA_BALL:
        return BALL_ULTRA;
    case ITEM_GREAT_BALL:
        return BALL_GREAT;
    case ITEM_SAFARI_BALL:
        return BALL_SAFARI;
    case ITEM_NET_BALL:
        return BALL_NET;
    case ITEM_DIVE_BALL:
        return BALL_DIVE;
    case ITEM_NEST_BALL:
        return BALL_NEST;
    case ITEM_REPEAT_BALL:
        return BALL_REPEAT;
    case ITEM_TIMER_BALL:
        return BALL_TIMER;
    case ITEM_LUXURY_BALL:
        return BALL_LUXURY;
    case ITEM_PREMIER_BALL:
        return BALL_PREMIER;
    case ITEM_POKE_BALL:
    default:
        return BALL_POKE;
    }
}

bool8 GetSetPokedexFlag(u16 nationalDexNo, u8 caseID)
{
    u8 index;
    u8 bit;
    u8 mask;
    bool8 retVal;

    nationalDexNo--;
    index = nationalDexNo / 8;
    bit = nationalDexNo % 8;
    mask = 1 << bit;
    retVal = FALSE;
    switch (caseID)
    {
    case FLAG_GET_SEEN:
        if (gPokedexPtr->seen[index] & mask)
        {
            if ((gPokedexPtr->seen[index] & mask) == (gDexSeen2Ptr[index] & mask)
             && (gPokedexPtr->seen[index] & mask) == (gDexSeen3Ptr[index] & mask))
                retVal = TRUE;
            else
            {
                gPokedexPtr->seen[index] &= ~mask;
                gDexSeen2Ptr[index] &= ~mask;
                gDexSeen3Ptr[index] &= ~mask;
                retVal = FALSE;
            }
        }
        break;
    case FLAG_GET_CAUGHT:
        if (gPokedexPtr->owned[index] & mask)
        {
            if ((gPokedexPtr->owned[index] & mask) == (gPokedexPtr->seen[index] & mask)
             && (gPokedexPtr->owned[index] & mask) == (gDexSeen2Ptr[index] & mask)
             && (gPokedexPtr->owned[index] & mask) == (gDexSeen3Ptr[index] & mask))
                retVal = TRUE;
            else
            {
                gPokedexPtr->owned[index] &= ~mask;
                gPokedexPtr->seen[index] &= ~mask;
                gDexSeen2Ptr[index] &= ~mask;
                gDexSeen3Ptr[index] &= ~mask;
                retVal = FALSE;
            }
        }
        break;
    case FLAG_SET_SEEN:
        gPokedexPtr->seen[index] |= mask;
        gDexSeen2Ptr[index] |= mask;
        gDexSeen3Ptr[index] |= mask;
        break;
    case FLAG_SET_CAUGHT:
        gPokedexPtr->owned[index] |= mask;
        break;
    }
    return retVal;
}
