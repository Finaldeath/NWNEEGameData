void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "artemishelp")!= 1)
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_Artemis_Coward");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "artemisentrer001", lTarget);

oTarget = oSpawn;

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(), oPC, 2.5);

AssignCommand(oTarget, ActionStartConversation(oPC, ""));

}

