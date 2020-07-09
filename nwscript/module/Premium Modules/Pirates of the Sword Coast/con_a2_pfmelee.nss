//::///////////////////////////////////////////////
//:: con_a2_pfmelee
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the Weapon Melee?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
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
        iResult = !GetWeaponRanged(oItem);
    }

    return iResult;
}

int IsValidItem(object oItem)
{
    int iReturn = FALSE;
    if ((GetBaseItemType(oItem) == BASE_ITEM_BASTARDSWORD)
     || (GetBaseItemType(oItem) == BASE_ITEM_BATTLEAXE)
     || (GetBaseItemType(oItem) == BASE_ITEM_CLUB)
     || (GetBaseItemType(oItem) == BASE_ITEM_DAGGER)
     || (GetBaseItemType(oItem) == BASE_ITEM_DIREMACE)
     || (GetBaseItemType(oItem) == BASE_ITEM_DOUBLEAXE)
     || (GetBaseItemType(oItem) == BASE_ITEM_DWARVENWARAXE)
     || (GetBaseItemType(oItem) == BASE_ITEM_GREATAXE)
     || (GetBaseItemType(oItem) == BASE_ITEM_GREATSWORD)
     || (GetBaseItemType(oItem) == BASE_ITEM_HALBERD)
     || (GetBaseItemType(oItem) == BASE_ITEM_HANDAXE)
     || (GetBaseItemType(oItem) == BASE_ITEM_HEAVYCROSSBOW)
     || (GetBaseItemType(oItem) == BASE_ITEM_HEAVYFLAIL)
     || (GetBaseItemType(oItem) == BASE_ITEM_KAMA)
     || (GetBaseItemType(oItem) == BASE_ITEM_KATANA)
     || (GetBaseItemType(oItem) == BASE_ITEM_KUKRI)
     || (GetBaseItemType(oItem) == BASE_ITEM_LIGHTCROSSBOW)
     || (GetBaseItemType(oItem) == BASE_ITEM_LIGHTFLAIL)
     || (GetBaseItemType(oItem) == BASE_ITEM_LIGHTHAMMER)
     || (GetBaseItemType(oItem) == BASE_ITEM_LIGHTMACE)
     || (GetBaseItemType(oItem) == BASE_ITEM_LONGBOW)
     || (GetBaseItemType(oItem) == BASE_ITEM_LONGSWORD)
     || (GetBaseItemType(oItem) == BASE_ITEM_MORNINGSTAR)
     || (GetBaseItemType(oItem) == BASE_ITEM_QUARTERSTAFF)
     || (GetBaseItemType(oItem) == BASE_ITEM_RAPIER)
     || (GetBaseItemType(oItem) == BASE_ITEM_SCIMITAR)
     || (GetBaseItemType(oItem) == BASE_ITEM_SCYTHE)
     || (GetBaseItemType(oItem) == BASE_ITEM_SHORTBOW)
     || (GetBaseItemType(oItem) == BASE_ITEM_SHORTSPEAR)
     || (GetBaseItemType(oItem) == BASE_ITEM_SHORTSWORD)
     || (GetBaseItemType(oItem) == BASE_ITEM_SICKLE)
     || (GetBaseItemType(oItem) == BASE_ITEM_SLING)
     || (GetBaseItemType(oItem) == BASE_ITEM_TWOBLADEDSWORD)
     || (GetBaseItemType(oItem) == BASE_ITEM_WARHAMMER)
     || (GetBaseItemType(oItem) == BASE_ITEM_WHIP))
     {
        iReturn = TRUE;
     }

     return (iReturn);
}
