//::///////////////////////////////////////////////
//:: con_a2_pfacbonus
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to add armour class to this item?
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_WS_AC_BONUS) == FALSE)
    {
        return TRUE;
    }

    return FALSE;
}

