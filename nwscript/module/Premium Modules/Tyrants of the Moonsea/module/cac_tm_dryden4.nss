// player gives ilandra's head to dryden and receives full reward

#include "x0_i0_partywide"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    GiveGoldToAll(oPC, nGold);
    RemoveItemFromParty(oPC, "IlandrasHead");
    int nDone = PlotLevelGet("DrydenHeadsCompleted");
    PlotLevelSet("DrydenHeadsCompleted", ++nDone);
    int nHeads = PlotLevelGet("DrydenPirateHeadCount");
    PlotLevelSet("DrydenPirateHeadCount", ++nHeads);
    AddJournalQuestEntry("PiratesoftheMoonsea", 90, oPC, TRUE, FALSE, TRUE);
}
