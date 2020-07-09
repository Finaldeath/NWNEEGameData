//::///////////////////////////////////////////////
//:: FileName con_ac_road_tele
//:: Teleport player to Road leading to Gillian's Hill
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/18/2005 12:35:30 AM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetObjectByTag("wp_road_to_gillians");
object oTarget2 = GetObjectByTag("wp_ac_millie");
object oP = GetObjectByTag("ac_porto");
object oM = GetObjectByTag("ac_millie");

AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToObject(oTarget));
AssignCommand(oP, ClearAllActions());
AssignCommand(oP, ActionJumpToObject(oTarget2));
AssignCommand(oM, ClearAllActions());
AssignCommand(oM, ActionJumpToObject(oTarget2));
}
