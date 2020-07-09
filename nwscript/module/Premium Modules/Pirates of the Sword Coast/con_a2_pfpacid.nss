//::///////////////////////////////////////////////
//:: con_a2_pfpacid
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with Acid
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

    if (IsOkToAdd(oItem, IP_CONST_DAMAGETYPE_ACID) == FALSE)
    {

        return TRUE;
    }
    return FALSE;
}
