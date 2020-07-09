//::///////////////////////////////////////////////
//:: FileName con_ac_hostile
//:: NPC speaker attacks
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/20/2005 12:43:18 AM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcAttack(object o1, object oPC)
{
ChangeToStandardFaction(o1,STANDARD_FACTION_HOSTILE);
SetIsTemporaryEnemy(oPC, o1);
AssignCommand(o1, ActionAttack(oPC));
AssignCommand(o1, DetermineCombatRound(oPC));
}
void main()
{
object oPC = GetPCSpeaker();
//SetCutsceneMode(oPC, FALSE);
//SetImmortal(OBJECT_SELF, FALSE);
//SetPlotFlag(OBJECT_SELF, FALSE);
ahcAttack(OBJECT_SELF, oPC);
}
