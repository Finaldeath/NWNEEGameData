//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazattck.
// DATE: November 20, 2005
// AUTH: Luke Scull
// NOTE: Make Grazkahn attack PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "NW_I0_GENERIC"

// Slaadi with the Independent faction
const string NPC_TAG_SLAAD_RED = "tm_cr_art_slaadr";
const string NPC_TAG_SLAAD_BLUE = "tm_cr_art_slaadb";


void slaadAttack(string sTag, object oAttackTarget)
{
    int nNth = 1;
    object oSlaad = GetNearestObjectByTag(sTag, oAttackTarget, nNth);
    while (GetIsObjectValid(oSlaad))
    {
        SetPlotFlag(oSlaad, FALSE);
        SetImmortal(oSlaad, FALSE);
        ChangeToStandardFaction(oSlaad, STANDARD_FACTION_HOSTILE);

        DetermineCombatRound();
        AssignCommand(oSlaad, ActionAttack(oAttackTarget));

        nNth++;
        oSlaad = GetNearestObjectByTag(sTag, oAttackTarget, nNth);
    }
}


void main()
{
    object oPC = GetPCSpeaker();
    object oGrazkahn = OBJECT_SELF;

    // Make Grazkahn hostile
    SetPlotFlag(oGrazkahn, FALSE);
    SetImmortal(oGrazkahn, FALSE);
    ChangeToStandardFaction(oGrazkahn, STANDARD_FACTION_HOSTILE);
    DetermineCombatRound();

    // Make nearby Slaadi attack
    slaadAttack(NPC_TAG_SLAAD_RED, oPC);
    slaadAttack(NPC_TAG_SLAAD_BLUE, oPC);
}
