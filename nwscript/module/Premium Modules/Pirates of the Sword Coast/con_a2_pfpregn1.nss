//::///////////////////////////////////////////////
//:: con_a2_pfpregn1
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with regeneration
    Damage 1?
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_WS_REGENERATION1) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}



