//::///////////////////////////////////////////////
//:: con_a2_pfpatkb
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with attack Bonus
    Property?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_WS_ATTACK_BONUS) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}

