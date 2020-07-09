//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_norcfool
// DATE: October 10, 2005
// AUTH: Luke Scull
// NOTE: Unlocks gate, updates journal. Deputies
//       believe PC is Grimswold.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetFirstPC();

object oDoor = GetObjectByTag("Voonlar_To_Locktower");

FloatingTextStringOnCreature("You hear the sound of the gate being unlocked.", oPC);

SetLocked(oDoor, FALSE);

AddJournalQuestEntry("LocktowerRescue", 70, oPC);

GiveXPToCreature(oPC, 500);

}
