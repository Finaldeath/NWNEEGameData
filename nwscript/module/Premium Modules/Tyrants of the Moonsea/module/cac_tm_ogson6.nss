//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_ogson6
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Removes Amberlyn from gameworld.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oAmberlyn = GetNearestObjectByTag("Amberlyn");
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("AMerchantsTale", 50, oPC);
    CreateItemOnObject("cheswicksdagger", oPC, 1);
    GiveXPToCreature(oPC, GetJournalQuestExperience("AMerchantsTale"));

    // Used only for "The Unseen" quest
    PlotLevelSet("amerchantstale_status", 5);

    ExecuteScript("hf_cs_exit", oAmberlyn);
}
