// sidequest: shadovar search party
// player has agreed to gather informatino about dominion

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("Thalia", 3);
    AddJournalQuestEntry("ShadovarSearchParty", 50, oPC);

    // all of the spawns in the area become friendly
    int n = 1;
    object oMinion = GetNearestObjectByTag("ShadovarSpawn", oPC, n);
    while (GetIsObjectValid(oMinion))
    {
        ChangeToStandardFaction(oMinion, STANDARD_FACTION_DEFENDER);
        oMinion = GetNearestObjectByTag("ShadovarSpawn", oPC, ++n);
    }
}
