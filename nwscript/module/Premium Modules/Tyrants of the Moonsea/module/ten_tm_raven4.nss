//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_raven4
// DATE: November 1, 2005
// AUTH: Luke Scull
// NOTE: Raven flies off and is destroyed.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)

return;

object oRaven = GetObjectByTag("ShadowRaven");

object oWaypoint = GetObjectByTag("WP_Raven_Move4");

AssignCommand(oRaven, ActionForceMoveToObject(oWaypoint, TRUE, 0.0));

DestroyObject(oRaven, 2.0);

SetLocalInt(OBJECT_SELF, "fired", 1);
}
