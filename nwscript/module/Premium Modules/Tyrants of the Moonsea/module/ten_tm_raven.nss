//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_raven
// DATE: October 31, 2005
// AUTH: Luke Scull
// NOTE: Send message to player that a raven is watching
//       him, then raven flies off.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)

return;

AssignCommand(oPC, SpeakString("A huge raven watches you with gimlet eyes that shine with cunning. It gives one loud squawk and flies off."));

object oRaven = GetObjectByTag("ShadowRaven");

object oWaypoint = GetObjectByTag("WP_Raven_Move1");

DelayCommand(2.0, AssignCommand(oRaven, ActionForceMoveToObject(oWaypoint, TRUE, 0.0)));

SetLocalInt(OBJECT_SELF, "fired", 1);
}
