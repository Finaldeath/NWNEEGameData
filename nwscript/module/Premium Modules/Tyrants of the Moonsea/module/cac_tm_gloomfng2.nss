//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_gloomfng2
// DATE: October 31, 2005
// AUTH: Luke Scull
// NOTE: Gloomfang attacks PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
object oPC = GetPCSpeaker();

SetIsTemporaryEnemy(oPC);

DetermineCombatRound();

ActionAttack(oPC);
}
