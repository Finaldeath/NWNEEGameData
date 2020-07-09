// muragh takes 2 diamonds from the player

#include "hf_in_plot"

void DestroyItems(object oPC, string sTag, int nAmount)
{
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem) == TRUE && nAmount > 0)
    {
        if (GetTag(oItem) == sTag)
        {
            int nStackSize = GetItemStackSize(oItem);
            if (nStackSize > nAmount)
            {
                SetItemStackSize(oItem, nStackSize - nAmount);
                nAmount = 0;
            }
            else
            {
                DestroyObject(oItem);
                nAmount -= nStackSize;
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    DestroyItems(oPC, "NW_IT_GEM005", 2);
    PlotLevelSet("MuraghDiamond", 2);
}
