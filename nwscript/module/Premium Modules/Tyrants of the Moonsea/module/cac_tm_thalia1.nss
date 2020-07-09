// sidequest: shadovar search party
// player has agreed to find dominion and give it to thalia

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("Thalia", 4);
    AddJournalQuestEntry("ShadovarSearchParty", 60, oPC);
    int nXP = GetJournalQuestExperience("ShadovarSearchParty");
    GiveXPToCreature(oPC, nXP);

    // all of the spawns in the area become friendly
    int n = 1;
    object oMinion = GetNearestObjectByTag("ShadovarSpawn", oPC, n);
    while (GetIsObjectValid(oMinion))
    {
        ChangeToStandardFaction(oMinion, STANDARD_FACTION_DEFENDER);
        oMinion = GetNearestObjectByTag("ShadovarSpawn", oPC, ++n);
    }
}
