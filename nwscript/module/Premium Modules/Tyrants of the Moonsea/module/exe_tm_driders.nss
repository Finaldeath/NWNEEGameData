//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_driders
// DATE: February 27, 2005
// AUTH: Luke Scull
// NOTE: Causes driders to go hostile to PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{

object oPC = GetFirstPC();

object oDrider1 = GetObjectByTag("DriderRogue1");

object oDrider2 = GetObjectByTag("DriderRogue2");

object oDrider3 = GetObjectByTag("DriderSorcerer");

AssignCommand(oDrider1, SetIsTemporaryEnemy(oPC));

AssignCommand(oDrider1, DetermineCombatRound());

AssignCommand(oDrider1, ActionAttack(oPC));

AssignCommand(oDrider2, SetIsTemporaryEnemy(oPC));

AssignCommand(oDrider2, DetermineCombatRound());

AssignCommand(oDrider2, ActionAttack(oPC));

AssignCommand(oDrider3, SetIsTemporaryEnemy(oPC));

AssignCommand(oDrider3, DetermineCombatRound());

AssignCommand(oDrider3, ActionAttack(oPC));
}
