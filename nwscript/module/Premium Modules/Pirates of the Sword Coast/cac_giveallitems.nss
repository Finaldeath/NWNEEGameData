//::///////////////////////////////////////////////
//:: cac_giveallitems
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player loses their entire inventory to the
    Blackriver Bandits.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oClone = GetNearestObjectByTag("PCTalker", oPC);
    object oSpeaker = OBJECT_SELF;
    object oItem, oItemClone;
    int iCounter = 0;

    oItem = GetFirstItemInInventory(oPC);

    // Cycle through inventory and make copies on the NPC Speaker
    while (oItem != OBJECT_INVALID)
    {
        if (GetPlotFlag(oItem) == FALSE)
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
        if (GetPlotFlag(oItem) == FALSE)
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

