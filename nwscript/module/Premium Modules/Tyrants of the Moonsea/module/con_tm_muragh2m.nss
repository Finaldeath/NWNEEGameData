// returns true when the player has 10 bars of mithril to give to muragh

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
    if (PlotLevelGet("MuraghMithril") >= 10)
        return FALSE;
    int nMithrilCount = GetItemCount(oPC, "x2_it_cmat_mith");
    if (nMithrilCount >= 10)
        return TRUE;
    return FALSE;
}
