//::///////////////////////////////////////////////
//:: cac_giveallwpns
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Give all the players weapons to the Black
    River Bandits.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
int GetIsWeapon(object oItem);

void main()
{
    object oPC = GetPCSpeaker();
    object oClone = GetNearestObjectByTag("PCTalker", oPC);
    object oSpeaker = OBJECT_SELF;
    object oItem, oItemClone;
    int iCounter = 0;

    oItem = GetFirstItemInInventory(oPC);

    while (oItem != OBJECT_INVALID)
    {
        if((GetIsWeapon(oItem) == TRUE) && (GetPlotFlag(oItem) == FALSE))
        {
            SetDroppableFlag(CopyItem(oItem, oSpeaker, TRUE), TRUE);
            SetPlotFlag(oItem, FALSE);

            oItemClone = GetItemPossessedBy(oClone, GetTag(oItem));

            DestroyObject(oItem);
            DestroyObject(oItemClone);
        }

        oItem = GetNextItemInInventory(oPC);
    }

    oItem = GetItemInSlot(iCounter, oPC);
    while (iCounter <= NUM_INVENTORY_SLOTS)
    {
        if((GetIsWeapon(oItem) == TRUE) && (GetPlotFlag(oItem) == FALSE))
        {
            SetDroppableFlag(CopyItem(oItem, oSpeaker, TRUE), TRUE);
            SetPlotFlag(oItem, FALSE);

            oItemClone = GetItemPossessedBy(oClone, GetTag(oItem));

            DestroyObject(oItem);
            DestroyObject(oItemClone);
        }

        oItem = GetItemInSlot(iCounter++, oPC);
    }
}

int GetIsWeapon(object oItem)
{
    int iType = GetBaseItemType(oItem);
    int iReturn = FALSE;

    if ((iType == BASE_ITEM_ARROW) || (iType == BASE_ITEM_BASTARDSWORD) ||
    (iType == BASE_ITEM_BATTLEAXE) || (iType == BASE_ITEM_BULLET) ||
    (iType == BASE_ITEM_CLUB) || (iType == BASE_ITEM_DAGGER) ||
    (iType == BASE_ITEM_DART) || (iType == BASE_ITEM_DIREMACE) ||
    (iType == BASE_ITEM_DOUBLEAXE) || (iType == BASE_ITEM_DWARVENWARAXE) ||
    (iType == BASE_ITEM_GREATAXE) || (iType == BASE_ITEM_GREATSWORD) ||
    (iType == BASE_ITEM_GRENADE) || (iType == BASE_ITEM_HALBERD) ||
    (iType == BASE_ITEM_HANDAXE) || (iType == BASE_ITEM_HEAVYCROSSBOW) ||
    (iType == BASE_ITEM_HEAVYFLAIL) || (iType == BASE_ITEM_KAMA) ||
    (iType == BASE_ITEM_KATANA) || (iType == BASE_ITEM_KUKRI) ||
    (iType == BASE_ITEM_LIGHTCROSSBOW) || (iType == BASE_ITEM_LIGHTFLAIL) ||
    (iType == BASE_ITEM_LIGHTHAMMER) || (iType == BASE_ITEM_LIGHTMACE) ||
    (iType == BASE_ITEM_LONGBOW) || (iType == BASE_ITEM_LONGSWORD) ||
    (iType == BASE_ITEM_MAGICROD) || (iType == BASE_ITEM_MAGICSTAFF) ||
    (iType == BASE_ITEM_MAGICWAND) || (iType == BASE_ITEM_MORNINGSTAR) ||
    (iType == BASE_ITEM_QUARTERSTAFF) || (iType == BASE_ITEM_RAPIER) ||
    (iType == BASE_ITEM_SCIMITAR) || (iType == BASE_ITEM_SCYTHE) ||
    (iType == BASE_ITEM_SHORTBOW) || (iType == BASE_ITEM_SHORTSPEAR) ||
    (iType == BASE_ITEM_SHORTSWORD) || (iType == BASE_ITEM_SHURIKEN) ||
    (iType == BASE_ITEM_SICKLE) || (iType == BASE_ITEM_SLING) ||
    (iType == BASE_ITEM_THROWINGAXE) || (iType == BASE_ITEM_TWOBLADEDSWORD) ||
    (iType == BASE_ITEM_WARHAMMER) || (iType == BASE_ITEM_WHIP))
    {
        iReturn = TRUE;
    }

    return (iReturn);
}
