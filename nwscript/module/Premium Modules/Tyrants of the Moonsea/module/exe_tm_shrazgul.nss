//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_shrazgul
// DATE: October 29, 2005
// AUTH: Luke Scull
// NOTE: Shrazgul and the Direguards attack.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_generic"

void main()
{
    // Define objects
    object oPC = GetFirstPC();

    object oShrazgul = GetObjectByTag("Shrazgul");
    object oGuard1 = GetObjectByTag("ShrazgulGuard1");
    object oGuard2 = GetObjectByTag("ShrazgulGuard2");


    ChangeToStandardFaction(oGuard1, STANDARD_FACTION_HOSTILE);
    AssignCommand(oGuard1, DetermineCombatRound(oPC));

    ChangeToStandardFaction(oGuard2, STANDARD_FACTION_HOSTILE);
    AssignCommand(oGuard2, DetermineCombatRound(oPC));

    SetPlotFlag(oShrazgul, FALSE);
    ChangeToStandardFaction(oShrazgul, STANDARD_FACTION_HOSTILE);
    AssignCommand(oShrazgul, DetermineCombatRound());
}

