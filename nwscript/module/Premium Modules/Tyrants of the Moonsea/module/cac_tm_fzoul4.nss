//Player accepts Fzoul's offer to join him

#include "hf_in_plot"
#include "hf_in_alignment"

void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    PlotLevelSet("Fzoul", 4);
    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 50);

    //Update journal and give quest completion xp
    AddJournalQuestEntry("TheRavenMage", 30, oPC);
    nXP = GetJournalQuestExperience("TheRavenMage");
    GiveXPToCreature(oPC, nXP);
}
