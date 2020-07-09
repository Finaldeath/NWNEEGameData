//::///////////////////////////////////////////////
//:: con_a2_pftmany
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the item in the forge have too many
    properties?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("a2_prugforge");
    object oItem = GetFirstItemInInventory(oForge);
    int iReturn = FALSE;

    if (IPGetNumberOfItemProperties (oItem) >= X2_IP_MAX_ITEM_PROPERTIES)
    {
        iReturn = TRUE;
    }

    return iReturn;

}
