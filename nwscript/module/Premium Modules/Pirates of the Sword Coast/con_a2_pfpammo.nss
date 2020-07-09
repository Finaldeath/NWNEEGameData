//::///////////////////////////////////////////////
//:: con_a2_pfpammo
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance with Unlimited Ammo
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

    if (IsOkToAdd(oItem, IP_CONST_WS_UNLIMITED_1) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}

