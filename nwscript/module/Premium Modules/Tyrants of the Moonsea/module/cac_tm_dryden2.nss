// player gives veris's ring to dryden and receives full reward

#include "x0_i0_partywide"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    GiveGoldToAll(oPC, nGold);
    RemoveItemFromParty(oPC, "VerisSignetRing");
    int nDone = PlotLevelGet("DrydenHeadsCompleted");
    PlotLevelSet("DrydenHeadsCompleted", ++nDone);
    AddJournalQuestEntry("PiratesoftheMoonsea", 80, oPC, TRUE, FALSE, TRUE);
}
