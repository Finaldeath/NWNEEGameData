//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_magicglm
// DATE: February 28, 2005
// AUTH: Luke Scull
// NOTE: Causes golem to go hostile to PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oPC = GetFirstPC();

    object oGolem = GetObjectByTag("MagicGolem");

    // ChangeToStandardFaction(oGolem, STANDARD_FACTION_HOSTILE);
    AssignCommand(oGolem, SetIsTemporaryEnemy(oPC));

    AssignCommand(oGolem, DetermineCombatRound(oPC));
}
