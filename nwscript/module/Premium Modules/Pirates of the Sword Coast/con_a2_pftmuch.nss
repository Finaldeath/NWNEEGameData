//::///////////////////////////////////////////////
//:: con_a2_pftmuch
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the player have more then one item in
    the Forge?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("a2_prugforge");
    object oItem = GetFirstItemInInventory(oForge);
    int iReturn = FALSE;
    int iTotalCount = 0;

    while (GetIsObjectValid(oItem) == TRUE)
    {
        oItem = GetNextItemInInventory(oForge);
        iTotalCount++;
    }

    if (iTotalCount > 1)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
