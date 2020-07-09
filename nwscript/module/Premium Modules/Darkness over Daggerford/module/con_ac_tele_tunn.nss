//::///////////////////////////////////////////////
//:: FileName con_ac_tele_tunn
//:: Teleport player to ar0402 via "secret tunnel"
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Feb. 12, 2006
//:://////////////////////////////////////////////
void main()
{
object oW = GetObjectByTag("wp_C1AR0800_C1AR0402_exit");
object oPC = GetPCSpeaker();
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToObject(oW));
}

