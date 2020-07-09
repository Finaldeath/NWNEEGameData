//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_mardgood
// DATE: October 6, 2005
// AUTH: Luke Scull
// NOTE: Sets int  Sets int so Mard's dialogue updates,
//       removes 10 gold from the player.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "mardgood", 1);
    AssignCommand(oPC, TakeGoldFromCreature(10, oPC, TRUE));
    SetLocalInt(GetArea(oPC), "HF_REST_DISABLED", 0);
    GiveXPToCreature(oPC, 100);
}
