//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_madoc6
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Destroy Rod of Revival from CToT for game
//       balance purposes.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "RodofRevival");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
