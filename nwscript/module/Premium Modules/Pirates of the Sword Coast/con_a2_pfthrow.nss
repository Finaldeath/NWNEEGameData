//::///////////////////////////////////////////////
//:: con_a2_pfthrow
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the item in the forge a throwing weapon?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    // * Thrown weapons cannot be upgrade
    object oForge = GetNearestObjectByTag("a2_prugforge");
    object oItem = GetFirstItemInInventory(oForge);

    int nType = GetBaseItemType(oItem);

    if (nType == BASE_ITEM_SHURIKEN || nType == BASE_ITEM_THROWINGAXE || nType == BASE_ITEM_DART)
        return TRUE;
    return FALSE;

}
