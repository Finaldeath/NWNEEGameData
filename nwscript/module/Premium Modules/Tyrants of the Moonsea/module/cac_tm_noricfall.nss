//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noricfall
// DATE: October 7, 2005
// AUTH: Luke Scull
// NOTE: Noric falls out of window and dies. Update
//       journal.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetPCSpeaker();

object oTrigger = GetObjectByTag("NoricConversationTrigger");

object oNoric= GetObjectByTag("DeputyNoric");

object oHarfist = GetObjectByTag("DeputyHarfist");

object oTarget;
object oSpawn;
location lTarget;

SetLocalInt(GetModule(), "nNoricPlummet", 1);

oTarget = GetWaypointByTag("WP_Noric_Plummet");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "deputynoric001", lTarget);

AddJournalQuestEntry("LocktowerRescue", 20, oPC);

DestroyObject(oTrigger, 0.0);

DestroyObject(oNoric, 0.0);

AdjustReputation(oPC, oHarfist, -100);

GiveXPToCreature(oPC, 500);
}

