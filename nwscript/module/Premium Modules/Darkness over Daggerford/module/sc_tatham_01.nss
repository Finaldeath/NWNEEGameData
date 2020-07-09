// does the player have 4 bird hearts?

int StartingConditional()
{
    int nHearts = 0;
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "ks_it_birdheart")
        {
            nHearts++;
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return(nHearts >= 4);
}
