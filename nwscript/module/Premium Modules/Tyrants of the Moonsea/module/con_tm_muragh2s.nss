// returns true when the player has sapphire to give to muragh

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
    if (PlotLevelGet("MuraghSapphire") >= 1)
        return FALSE;
    int nSapphireCount = GetItemCount(oPC, "FlawlessSapphire");
    if (nSapphireCount >= 1)
        return TRUE;
    return FALSE;
}
