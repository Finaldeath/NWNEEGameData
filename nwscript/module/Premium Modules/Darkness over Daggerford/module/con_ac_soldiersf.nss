//::///////////////////////////////////////////////
//:: FileName con_ac_soldiersf
//:: Soldiers flee after rat quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 2:50:30 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
object oB = GetObjectByTag("ac_blancheflor");
object oL = GetObjectByTag("ac_launfal");
object oC = GetObjectByTag("ac_camelon");
AssignCommand(oB, ActivateFleeToExit());
AssignCommand(oL, ActivateFleeToExit());
AssignCommand(oC, ActivateFleeToExit());
}
