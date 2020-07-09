//::///////////////////////////////////////////////
//:: FileName ou_ac_plc_telep
//:: Teleport to a waypoint with the same tag as the placeable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/2/2005 11:59:20 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

object oTarget = GetWaypointByTag("WP_C1AR0806B");
location lTarget = GetLocation(oTarget);
//FloatingTextStringOnCreature("wp_mazemaze", oPC);
//FloatingTextStringOnCreature(GetTag(OBJECT_SELF), oPC);

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID)
{
FloatingTextStringOnCreature("invalid", oPC);
return;
}
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
//object oTarget = GetWaypointByTag(GetTag(OBJECT_SELF));
}
