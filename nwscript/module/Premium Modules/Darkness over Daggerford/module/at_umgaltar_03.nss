#include "NW_I0_GENERIC"

void main()
{
    object oPC = GetPCSpeaker();
    object oJared = GetNearestObjectByTag("ks_jared", oPC);
    ChangeToStandardFaction(oJared, STANDARD_FACTION_HOSTILE);
    AssignCommand(oJared, DetermineCombatRound());
}
