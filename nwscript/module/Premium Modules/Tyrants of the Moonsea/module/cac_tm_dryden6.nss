// priates of the moonsea
// player has given all of the bounties to dryden and finished the quest

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    if (PlotLevelGet("DrydenPirateHeadCount") >= 3)
        AddJournalQuestEntry("PiratesoftheMoonsea", 100, oPC);
    else
        AddJournalQuestEntry("PiratesoftheMoonsea", 110, oPC);
    PlotLevelSet("Dryden", 3);
    int nXP = GetJournalQuestExperience("PiratesoftheMoonsea");
    GiveXPToCreature(oPC, nXP);
}
