//::///////////////////////////////////////////////
//:: FileName oe_ac_trg_jouka
//:: Trigger Jouka to stop fixing the wagon when PC approaches
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/31/2005 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
object oSmith = GetObjectByTag("ac_jouka");
SetLocalInt(oSmith,"smith",1);
AssignCommand(oSmith,ClearAllActions(TRUE));

}
