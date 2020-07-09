//Player rejects Fzoul's offer and will leave temple, and leave Maganus

#include "hf_in_plot"

void main()
{
    int nXP;

    object oPC = GetPCSpeaker();
    object oTempleDoor = GetNearestObjectByTag("ZhentTemple_Zhent2", oPC);

    //Update journal and give quest completion xp
    AddJournalQuestEntry("TheRavenMage", 30, oPC);
    nXP = GetJournalQuestExperience("TheRavenMage");
    GiveXPToCreature(oPC, nXP);

    SetLocked(oTempleDoor, FALSE);
    PlotLevelSet("Fzoul", 3);
}
