//::///////////////////////////////////////////////
//:: con_a2_pfpfire
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with Fire
    Damage?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"


int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_DAMAGETYPE_FIRE) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}

