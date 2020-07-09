//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_bane
// DATE: October 29, 2005
// AUTH: Luke Scull
// NOTE: Spawns in Manifestation of Bane which initiates
//       conversation with PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "shrazguldead")!= 1)
   return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)
    return;

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 1.0);

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_Bane_Spawn");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "manifestationofb", lTarget);

oTarget = oSpawn;

AssignCommand(oTarget, ActionStartConversation(oPC, ""));

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget)));

SetLocalInt(OBJECT_SELF, "fired", 1);
}

