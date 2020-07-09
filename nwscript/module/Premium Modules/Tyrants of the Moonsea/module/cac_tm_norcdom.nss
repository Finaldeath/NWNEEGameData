//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_norccharm
// DATE: October 10, 2005
// AUTH: Luke Scull
// NOTE: Unlocks gate, updates journal. Noric is
//       dominated.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetFirstPC();
    object oDoor = GetObjectByTag("Voonlar_To_Locktower");

    FloatingTextStringOnCreature("You hear the sound of the gate being unlocked.", oPC);

    SetLocked(oDoor, FALSE);
    SetLocalInt(oPC, "beguilednoric", 1);

    AddJournalQuestEntry("LocktowerRescue", 50, oPC);

    GiveXPToCreature(oPC, 500);
}
