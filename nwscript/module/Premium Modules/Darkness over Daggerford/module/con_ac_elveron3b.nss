//::///////////////////////////////////////////////
//:: FileName con_ac_elveron3b
//:: Sisters are downstairs for the 2nd time
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////

void main()
{

object oWP = GetWaypointByTag("wp_ac_upstairs");
object oWP2 = GetWaypointByTag("wp_ac_downstairs");

object oPC = GetPCSpeaker();
SetLocalInt(oPC,"alicine_downstairs",3);
ActionMoveToObject(oWP);
DelayCommand(5.0,ActionJumpToObject(oWP2));
SetLocalInt(OBJECT_SELF,"no_banter",1);
DelayCommand(5.1,ActionDoCommand(SetLocalInt(OBJECT_SELF,"no_banter",0)));
SetLocalInt(oPC,"elveronne_quest",3);
}
