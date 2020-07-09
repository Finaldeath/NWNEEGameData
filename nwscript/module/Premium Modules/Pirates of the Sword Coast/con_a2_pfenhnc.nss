//::///////////////////////////////////////////////
//:: con_a2_pfenhnc
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance this item?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_WS_ENHANCEMENT_BONUS) == FALSE)
    {
        return TRUE;
    }

    return FALSE;
}

