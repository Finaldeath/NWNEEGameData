// returns true when the player has any sort of component to give to muragh

#include "hf_in_plot"
#include "x0_i0_partywide"

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

    // can't give any components if you haven't started the quest yet
    if (PlotLevelGet("HighArtificerHlessen") < 2)
    {
        return FALSE;
    }

    int nHasMithril = GetItemCount(oPC, "x2_it_cmat_mith");
    if (nHasMithril >= 10)
        return TRUE;

    int nHasDiamond = GetItemCount(oPC, "NW_IT_GEM005");
    if (nHasDiamond >= 2)
        return TRUE;

    int nHasSapphire = GetItemCount(oPC, "FlawlessSapphire");
    if (nHasSapphire >= 1)
        return TRUE;

    return FALSE;
}
