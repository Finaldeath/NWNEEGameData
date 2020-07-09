//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nsp_tm_defensive
// DATE: August 26, 2005
// AUTH: Luke Scull
// NOTE: Unlocks door to The Swords' Meet + 10,000 gp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetFacingPoint(GetPosition(oPC));

    object oTarget = GetObjectByTag("Voonlar_To_TheSwordsMeet");
    AssignCommand(oTarget, SetLocked(OBJECT_SELF, FALSE));

    GiveGoldToCreature(GetPCSpeaker(), 10000);
}
