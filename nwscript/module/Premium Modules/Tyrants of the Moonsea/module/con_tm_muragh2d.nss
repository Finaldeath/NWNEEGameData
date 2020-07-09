// returns true when the player has diamond to give to muragh

#include "hf_in_plot"

int GetItemCount(object oPC, string sTag)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetTag(oItem) == sTag)
        {
            nCount += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return nCount;
}

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (PlotLevelGet("MuraghDiamond") >= 2)
        return FALSE;
    int nDiamondCount = GetItemCount(oPC, "NW_IT_GEM005");
    if (nDiamondCount >= 2)
        return TRUE;
    return FALSE;
}
