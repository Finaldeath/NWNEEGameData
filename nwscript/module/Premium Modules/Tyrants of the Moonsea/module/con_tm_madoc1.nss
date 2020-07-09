//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_madoc1
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Checks if the player has low-value loot
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

// get the total value of the player's inventory
int GetPlayersLootValue(object oPC)
{
    int nSum = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        nSum += GetGoldPieceValue(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    return(nSum);
}

int StartingConditional()
{
    int nLootValue = GetPlayersLootValue(GetPCSpeaker());
    return (nLootValue <= 10000);
}
