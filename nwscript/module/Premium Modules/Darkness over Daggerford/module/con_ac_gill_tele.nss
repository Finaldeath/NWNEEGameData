//::///////////////////////////////////////////////
//:: FileName con_ac_gill_tele
//:: Teleport player to Gillian's Hill
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/13/2005 12:35:30 AM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetObjectByTag("WP_AR1000_AR0700_EXIT");

AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToObject(oTarget));
}
