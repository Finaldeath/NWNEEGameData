#include "NW_I0_GENERIC"
void ahcAttack(object o1)
{
object oPC = GetPCSpeaker();
ChangeToStandardFaction(o1,STANDARD_FACTION_HOSTILE);
SetIsTemporaryEnemy(oPC, o1);
AssignCommand(o1, ActionAttack(oPC));
AssignCommand(o1, DetermineCombatRound(oPC));
}
