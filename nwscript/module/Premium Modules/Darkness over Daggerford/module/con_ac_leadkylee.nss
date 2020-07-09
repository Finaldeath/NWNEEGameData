//::///////////////////////////////////////////////
//:: FileName con_ac_leadkylee
//:: Captain leads player to Kyleena
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2005 2:50:30 PM
//:://////////////////////////////////////////////

void main()
{
object oPC = GetPCSpeaker();
object oK = GetObjectByTag("ac_kyleena");
ActionForceMoveToObject(oK, TRUE);
SetCutsceneMode(oPC, TRUE);
DelayCommand(1.0, AssignCommand(oPC, ActionForceMoveToObject(oK, TRUE)));
DelayCommand(1.1, AssignCommand(oPC, ActionDoCommand(SetCutsceneMode(oPC, FALSE))));
}
