// stegil attacks the player

#include "NW_I0_GENERIC"

void GoHostile(object oTarget, object oPC)
{
    SetPlotFlag(oTarget, FALSE);
    SetImmortal(oTarget, FALSE);
    ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
    AssignCommand(oTarget, ActionAttack(oPC));
    AssignCommand(oTarget, DetermineCombatRound());
}

void main()
{
    object oPC = GetPCSpeaker();
    GoHostile(OBJECT_SELF, oPC);
    int i = 1;
    object oDruid = GetNearestObjectByTag("ks_dark_druid", oPC, i);
    while (GetIsObjectValid(oDruid))
    {
        GoHostile(oDruid, oPC);
        oDruid = GetNearestObjectByTag("ks_dark_druid", oPC, ++i);
    }
}
