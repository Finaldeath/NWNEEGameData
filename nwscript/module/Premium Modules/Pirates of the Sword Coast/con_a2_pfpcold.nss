//::///////////////////////////////////////////////
//:: con_a2_pfpcold
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with Cold
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

    if (IsOkToAdd(oItem, IP_CONST_DAMAGETYPE_COLD) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}

