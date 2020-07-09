//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_meetmercs
// DATE: September 25, 2005
// AUTH: Luke Scull
// NOTE: Starts conversation with Swords' Meet mercs.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;

oTarget = GetObjectByTag("Thorne");

AssignCommand(oPC, ClearAllActions());

AssignCommand(oTarget, ActionStartConversation(oPC, "tm_meetmercs"));

}

