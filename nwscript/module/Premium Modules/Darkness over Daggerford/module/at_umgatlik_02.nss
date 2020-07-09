// umgatlik and vetrixia go hostile and attack the player

#include "nw_i0_generic"

void GoHostile(object o, object oPC)
{
    SetPlotFlag(o, FALSE);
    ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);
    AssignCommand(o, ActionAttack(oPC));
    AssignCommand(o, DetermineCombatRound(oPC));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oVetrixia = GetNearestObjectByTag("ks_vetrixia", oPC);
    GoHostile(OBJECT_SELF, oPC);
    GoHostile(oVetrixia, oPC);
}
