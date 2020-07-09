//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_towerhost
// DATE: October 10, 2005
// AUTH: Luke Scull
// NOTE: Unlocks gate, add journal entry, make all
//       tower deputies hostile and spawn in Noric
//       at front gate.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_2q4luskan"
void main()
{

object oPC = GetFirstPC();

object oDoor = GetObjectByTag("Voonlar_To_Locktower");

object oTrigger = GetObjectByTag("NoricConversationTrigger");

object oNoric = GetObjectByTag("DeputyNoric");

object oLocation = GetWaypointByTag("WP_Noric_Attack");

FloatingTextStringOnCreature("You hear the sound of the gate being unlocked.", oPC);

SetLocked(oDoor, FALSE);

DestroyObject(oTrigger, 0.0);

DelayCommand(1.0, AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF)));

AddJournalQuestEntry("LocktowerRescue", 80, oPC);

AdjustReputation(oPC, oNoric, -100);

DelayCommand(1.5, AssignCommand(oNoric, ActionJumpToObject(oLocation)));
}
