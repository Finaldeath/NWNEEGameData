//::///////////////////////////////////////////////
//:: FileName ac_trg_elvdoorop
//:: Door opens when Elveronne is ready to leave
//::
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: April 23, 2006
//:://////////////////////////////////////////////void main()
void main()
{
object oPC = GetEnteringObject();
if (!(GetTag(oPC)== "ac_elveronne")) return;
if (GetLocalInt(OBJECT_SELF,"do_once")==1) return;
//Unlock and open door for Elveronne
object oD = GetObjectByTag("C1AR0701C_C1AR0700_EXIT");
SetLocalInt(OBJECT_SELF,"do_once",1);
SetLocked(oD, FALSE);
AssignCommand(oD,ActionOpenDoor(oD));
}
