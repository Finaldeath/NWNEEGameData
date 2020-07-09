//Update journal entry for Melvaunt and Dukes quests

#include "hf_in_plot"

void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    //Complete Melvaunt quest and award quest completion xp
    AddJournalQuestEntry("Melvaunt", 20, oPC);
    nXP = GetJournalQuestExperience("Melvaunt");
    GiveXPToCreature(oPC, nXP);

    AddJournalQuestEntry("ADatewiththeDukes", 10, oPC);
    PlotLevelSet("UlblynDukes", 1);
}
