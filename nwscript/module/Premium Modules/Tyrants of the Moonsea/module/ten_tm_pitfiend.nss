//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_pitfiend
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Starts up conversation with Jeeves the pit
//       fiend the first time player enters the
//       trigger.
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
oTarget = GetObjectByTag("PitFiend");

DelayCommand(1.0, AssignCommand(oTarget, ActionStartConversation(oPC, "")));

}

