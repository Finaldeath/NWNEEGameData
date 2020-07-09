//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_waterelem
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: If this is the first time player has entered
//       the trigger, spawn in elemental with visual
//       effect.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_2q4luskan"
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = GetObjectByTag("WP_WaterElemental_Spawn");

int nInt;
nInt = GetObjectType(oTarget);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), GetLocation(oTarget));

location lTarget;
oTarget = GetWaypointByTag("WP_WaterElemental_Spawn");

lTarget = GetLocation(oTarget);

DelayCommand(2.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "dreadspirewater", lTarget));

}
