//::///////////////////////////////////////////////
//:: FileName con_ac_elveron3a
//:: Muriel goes downstairs for the 2nd time
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////

void main()
{
object oWP = GetWaypointByTag("wp_ac_upstairs");
object oWP2 = GetWaypointByTag("wp_ac_downstairs");
object oWP3 = GetWaypointByTag("wp_ac_poisonvial");
object oPC = GetPCSpeaker();

ActionForceMoveToObject(oWP);
DelayCommand(2.0,ActionJumpToObject(oWP2));
SetLocalInt(oPC,"muriel_downstairs",3);
SetLocalInt(OBJECT_SELF,"no_banter",1);
DelayCommand(2.1,ActionDoCommand(SetLocalInt(OBJECT_SELF,"no_banter",0)));
SetCutsceneMode(oPC,FALSE);
}
