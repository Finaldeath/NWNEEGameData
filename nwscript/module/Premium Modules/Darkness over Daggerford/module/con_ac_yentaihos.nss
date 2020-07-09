//::///////////////////////////////////////////////
//:: FileName con_ac_yentaihos
//:: Yentai attacks
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/17/2005 12:43:18 AM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcAttack(object o1,object oPC)
{
ChangeToStandardFaction(o1,STANDARD_FACTION_HOSTILE);
SetIsTemporaryEnemy(oPC, o1);
AssignCommand(o1, ActionAttack(oPC));
AssignCommand(o1, DetermineCombatRound(oPC));
}
void main()
{
object o1 = GetObjectByTag ("ac_yent_bodyg1");
object o2 = GetObjectByTag ("ac_yent_bodyg2");
object oPC = GetPCSpeaker();
SetImmortal(OBJECT_SELF, FALSE);
ahcAttack(OBJECT_SELF,oPC);
ahcAttack(o1,oPC);
ahcAttack(o2,oPC);
}
