// player gives ilandra's ring to dryden and receives half reward

#include "x0_i0_partywide"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nXP = GetLocalInt(OBJECT_SELF, "HF_XP_AMOUNT");
    GiveXPToAll(oPC, nXP);
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    nGold = nGold / 2;
    GiveGoldToAll(oPC, nGold);
    RemoveItemFromParty(oPC, "IlandrasSignetRing");
    int nDone = PlotLevelGet("DrydenHeadsCompleted");
    PlotLevelSet("DrydenHeadsCompleted", ++nDone);
    PlotLevelSet("IlandraPirate", 4);
    AddJournalQuestEntry("PiratesoftheMoonsea", 90, oPC, TRUE, FALSE, TRUE);
}
