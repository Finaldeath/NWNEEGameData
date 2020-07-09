//::///////////////////////////////////////////////
//:: con_a2_pfprstc
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with Spell resistance
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

    if (IsOkToAdd(oItem, IP_CONST_WS_SPELLRESISTANCE) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}



