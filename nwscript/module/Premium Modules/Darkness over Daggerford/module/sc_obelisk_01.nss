// has the player placed the correct items in the throne?

int StartingConditional()
{
    object oThrone = GetObjectByTag("pl_ar1400_throne");
    int iBerry = 0;
    int iHeart = 0;
    int iBone = 0;
    object oItem = GetFirstItemInInventory(oThrone);
    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetTag(oItem) == "pm_fernigoldberr")
         iBerry = 1;
        if (GetTag(oItem) == "pm_badgerheart")
         iHeart = 1;
        if (GetTag(oItem) == "x2_it_cmat_bone")
         iBone = 1;
        oItem = GetNextItemInInventory(oThrone);
    }
    if (iHeart == 1 && iBerry == 1 && iBone == 1)
    {
        return(TRUE);
    }
    return(FALSE);
}
