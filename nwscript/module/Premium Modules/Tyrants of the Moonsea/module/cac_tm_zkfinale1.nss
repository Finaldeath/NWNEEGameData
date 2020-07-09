//Reset Finale Director once Maganus has successfully engaged in dialog with PC

#include "hf_in_plot"

void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    //Update journal and give quest completion xp
    AddJournalQuestEntry("TheRavenMage", 40, oPC);
    nXP = GetJournalQuestExperience("TheRavenMage");
    GiveXPToCreature(oPC, nXP);

    PlotLevelSet("FinaleDirector", 0);
}
