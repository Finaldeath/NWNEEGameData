//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_takecon
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Removes contract and destroys.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oItemToTake = GetItemPossessedBy(oPC, "Contract");

    if (GetIsObjectValid(oItemToTake))
    {
        DestroyObject(oItemToTake);

        GiveXPToCreature(oPC, 250);
    }
}
