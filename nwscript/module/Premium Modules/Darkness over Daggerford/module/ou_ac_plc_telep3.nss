//::///////////////////////////////////////////////
//:: FileName ou_ac_plc_telep
//:: Teleport to a waypoint with the same tag as the placeable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 11:59:20 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

object oTarget = GetWaypointByTag("wp_ac_ratcave");
object oTarget2 = GetWaypointByTag("wp_ac_ratcave2");
object oR = GetObjectByTag("ac_rootherat");
SetLocalInt(oR, "ac_roo_2ndcave", 1);

DelayCommand(0.5, AssignCommand(oPC, ClearAllActions()));
DelayCommand(0.6, AssignCommand(oPC, ActionJumpToObject(oTarget)));
AssignCommand(oR, ClearAllActions());
AssignCommand(oR, ActionJumpToObject(oTarget2));

}
