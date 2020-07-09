//::///////////////////////////////////////////////
//:: con_a2_pfshield
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the item a shield?
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"
#include "x0_i0_match"

int IsValidItem(object oItem);

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("a2_prugforge");
    object oItem = GetFirstItemInInventory(oForge);
    int iResult;

    if (IsValidItem(oItem) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}

int IsValidItem(object oItem)
{
    int iReturn = FALSE;
    if ((GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD)
     || (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD)
     || (GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD))
     {
        iReturn = TRUE;
     }

     return (iReturn);
}
