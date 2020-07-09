//::///////////////////////////////////////////////
//:: con_a2_pfdamred
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to add damage reduction to this item?
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_WS_DAMAGE_REDUCTION) == FALSE)
    {
        return TRUE;
    }

    return FALSE;
}

