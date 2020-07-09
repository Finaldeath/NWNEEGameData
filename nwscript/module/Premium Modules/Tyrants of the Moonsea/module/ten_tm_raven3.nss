//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_raven3
// DATE: October 31, 2005
// AUTH: Luke Scull
// NOTE: Raven flies off again.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)

return;

object oRaven = GetObjectByTag("ShadowRaven");

object oWaypoint = GetObjectByTag("WP_Raven_Move3");

AssignCommand(oRaven, ActionForceMoveToObject(oWaypoint, TRUE, 0.0));

SetLocalInt(OBJECT_SELF, "fired", 1);
}
