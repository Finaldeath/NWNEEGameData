//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_tanarukk
// DATE: February 27, 2005
// AUTH: Luke Scull
// NOTE: Causes Tanarukk to go hostile to PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
object oPC = GetFirstPC();

object oTanarukk = GetObjectByTag("Tanarukk");

AssignCommand(oTanarukk, SetIsTemporaryEnemy(oPC));

AssignCommand(oTanarukk, DetermineCombatRound());

AssignCommand(oTanarukk, ActionAttack(oPC));

}
