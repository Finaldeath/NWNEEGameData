//::///////////////////////////////////////////////
//:: FileName ox_ac_trg_jouka
//:: Trigger Jouka to start fixing wagon again when PC walks away
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/31/2005 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetExitingObject();
if (!(GetIsPC(oPC))) return;
object oSmith = GetObjectByTag("ac_jouka");
object oAnvil = GetObjectByTag("ac_jouka_wagon");
SetLocalInt(oSmith,"smith",0);
AssignCommand(oSmith,ActionAttack(oAnvil));

}
