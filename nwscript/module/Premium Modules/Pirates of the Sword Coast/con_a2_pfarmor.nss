//::///////////////////////////////////////////////
//:: con_a2_pfarmor
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is this armour?
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"
#include "x0_i0_match"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("a2_prugforge");
    object oItem = GetFirstItemInInventory(oForge);
    int iResult = FALSE;
    if (GetBaseItemType(oItem) == BASE_ITEM_ARMOR)
    {
        iResult = TRUE;
    }
    return iResult;
}
