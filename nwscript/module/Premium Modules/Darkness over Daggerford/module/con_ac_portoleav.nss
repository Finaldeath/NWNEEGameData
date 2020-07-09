//::///////////////////////////////////////////////
//:: FileName con_ac_portoleav
//:: Porto goes back outside
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/18/2005 3:25:02 PM
//:://////////////////////////////////////////////
void main()
{
object oP = GetObjectByTag("ac_porto");
object oW2 = GetWaypointByTag("wp_ac_porto2");
SetLocalInt(oP,"no_banter",1);
SetLocalInt(oP,"no_hb",1);
SetLocalInt(GetModule(), "iPortoLeft", 1);
AssignCommand(oP,ClearAllActions());
AssignCommand(oP,ActionMoveToObject(oW2));
AssignCommand(oP,ActionDoCommand(SetLocalInt(oP,"no_banter",0)));
}
