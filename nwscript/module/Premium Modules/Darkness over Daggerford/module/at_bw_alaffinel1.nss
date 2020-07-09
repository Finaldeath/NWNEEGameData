#include "nw_i0_generic"

void main()
{
    object oPC = GetPCSpeaker();
    object oMe = OBJECT_SELF;

    ChangeToStandardFaction(oMe, STANDARD_FACTION_HOSTILE);

    object oMethim = GetNearestObjectByTag("bw_methim");
    ChangeToStandardFaction(oMethim, STANDARD_FACTION_HOSTILE);

    DetermineCombatRound(oPC);

    AssignCommand(oMethim, DetermineCombatRound(oPC));
}
