//::///////////////////////////////////////////////
//:: FileName con_ac_jonas_sit
//:: Jonas should go over and sit on stool
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////
void ahcFace(object o1)
{
AssignCommand(o1, SetFacing(185.0));
}
void main()
{
object oStool = GetObjectByTag("ac_plc_jonasstool");
object oJonas = OBJECT_SELF;
object oJunior = GetObjectByTag("ac_jonas2");
object oW = GetWaypointByTag("wp_jonasjr");
SetLocalInt(OBJECT_SELF, "no_banter", 1);
SetLocalInt(OBJECT_SELF, "has_met_pc", 1);
SetLocalInt(oJunior, "has_met_pc", 1);
SetLocalInt(GetModule(), "ac_werewolf", 1);
SetLocalInt(oJunior, "no_banter", 1);
//DelayCommand(3.0, SetLocalInt(OBJECT_SELF, "no_banter", 0));
//DelayCommand(3.0, SetLocalInt(oJ2, "no_banter", 0));
ActionForceMoveToObject(oStool);
ActionDoCommand(SetLocalInt(oJonas, "no_banter", 0));
ActionSit(oStool);

AssignCommand(oJunior, ActionForceMoveToObject(oW));
AssignCommand(oJunior, ActionDoCommand(ahcFace(oJunior)));
AssignCommand(oJunior, ActionDoCommand(SetLocalInt(oJunior, "no_banter", 0)));
}
