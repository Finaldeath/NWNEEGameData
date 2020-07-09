//::///////////////////////////////////////////////
//:: FileName con_ac_race
//:: Jonas's race to house
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////
void main()
{
object oJ1 = GetObjectByTag("ac_jonas1");
object oJ2 = GetObjectByTag("ac_jonas2");
object oWO = GetWaypointByTag("wp_ac_outside");
object oWI = GetWaypointByTag("wp_ac_inside");

SetLocalInt(oJ1, "no_banter", 1);
SetLocalInt(oJ2, "no_banter", 1);
SetLocalInt(oJ1, "no_hb", 1);
SetLocalInt(oJ2, "no_hb", 1);
SetLocalInt(GetModule(), "no_700_hb", 1);
SetLocalInt(oJ1, "has_met_pc", 1);
SetLocalInt(oJ2, "has_met_pc", 1);

AssignCommand(oJ1, ClearAllActions());
AssignCommand(oJ2, ClearAllActions());

AssignCommand(oJ1, ActionMoveToObject(oWO, TRUE));
AssignCommand(oJ1, ActionJumpToObject(oWI, TRUE));
AssignCommand(oJ1, ActionMoveToObject(GetObjectByTag("wp_jonas1_inside"), TRUE));

AssignCommand(oJ2, ActionMoveToObject(oWO, TRUE));
AssignCommand(oJ2, ActionJumpToObject(oWI, TRUE));
AssignCommand(oJ2, ActionMoveToObject(GetObjectByTag("wp_jonas2_inside"), TRUE));

AssignCommand(oJ1, ActionDoCommand(SetLocalInt(oJ1, "no_banter", 0)));
AssignCommand(oJ2, ActionDoCommand(SetLocalInt(oJ2, "no_banter", 0)));
}
