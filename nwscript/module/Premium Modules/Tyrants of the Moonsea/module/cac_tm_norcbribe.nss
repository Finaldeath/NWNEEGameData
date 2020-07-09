//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_norcbribe
// DATE: October 10, 2005
// AUTH: Luke Scull
// NOTE: Unlocks gate, updates journal, set Noric's
//       reaction as being bribed. Also award 500 xp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetFirstPC();
    object oDoor = GetObjectByTag("Voonlar_To_Locktower");

    FloatingTextStringOnCreature("You hear the sound of the gate being unlocked.", oPC);

    SetLocked(oDoor, FALSE);

    SetLocalInt(oPC, "bribednoric", 1);
    AddJournalQuestEntry("LocktowerRescue", 30, oPC);
    GiveXPToCreature(oPC, 500);
}
