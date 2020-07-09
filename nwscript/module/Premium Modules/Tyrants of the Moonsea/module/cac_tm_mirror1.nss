//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_mirror1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Apply a visual effect and create a copy of
//       the player which then goes hostile via the
//       delayed ExecuteScript().
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetFirstPC();

object oWaypoint = GetWaypointByTag("WP_Mirror_Spawn");

object oLight = GetObjectByTag("StrangeMirrorLight");

location lLocation = GetLocation(oWaypoint);

SetLocalInt(oPC, "strangemirror", 1);

DestroyObject(oLight, 0.0);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION), GetLocation(oWaypoint));

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION), OBJECT_SELF);

CopyObject(oPC, lLocation, OBJECT_INVALID, "PlayerCopy");

DelayCommand(2.5, ExecuteScript("exe_tm_mirror", oPC));
}
