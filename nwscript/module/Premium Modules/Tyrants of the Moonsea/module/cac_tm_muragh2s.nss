// muragh takes 1 sapphire from the player

#include "hf_in_plot"

void DestroyItems(object oPC, string sTag, int nAmount)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem) == TRUE && nCount < nAmount)
    {
        if (GetTag(oItem) == sTag)
        {
            DestroyObject(oItem);
            nCount += 1;
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    DestroyItems(oPC, "FlawlessSapphire", 1);
    PlotLevelSet("MuraghSapphire", 1);
}
