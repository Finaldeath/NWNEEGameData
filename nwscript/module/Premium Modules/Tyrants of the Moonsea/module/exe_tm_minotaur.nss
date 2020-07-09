//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_minotzur
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Make Red Minotaur hostile, and Elf hostile to
//       Red Minotaur.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
object oPC = GetFirstPC();

object oMinotaur = GetObjectByTag("TheRedMinotaur");

object oElf = GetObjectByTag("Elf");

AssignCommand(oElf, SetIsTemporaryEnemy(oMinotaur));

AssignCommand(oElf, DetermineCombatRound());

AssignCommand(oElf, ActionAttack(oMinotaur));

AssignCommand(oMinotaur, SetIsTemporaryEnemy(oPC));

AssignCommand(oMinotaur, DetermineCombatRound());

AssignCommand(oMinotaur, ActionAttack(oPC));
}
