//Jeffers tells PC about Maganus
#include "hf_in_plot"

void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    if(PlotLevelGet("JeffersMaganus") == 0)
    {
        //Update journal and award quest completion xp
        AddJournalQuestEntry("Mulmaster", 30, oPC);
        nXP = GetJournalQuestExperience("Mulmaster");
        GiveXPToCreature(oPC, nXP);
        PlotLevelSet("JeffersMaganus", 1);
    }
}
