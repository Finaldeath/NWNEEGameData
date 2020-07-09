//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_merrik2
// DATE: November 2, 2005
// AUTH: Luke Scull
// NOTE: Merrik and Red Plumes leave area.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"
#include "hf_in_alignment"

void main()
{
    object oRedPlume1 = GetObjectByTag("RedPlumeMercenary1");
    object oRedPlume2 = GetObjectByTag("RedPlumeMercenary2");
    object oMerrik = GetObjectByTag("Merrik");
    object oHaliator = GetObjectByTag("CaptainHaliator");
    object oPC = GetPCSpeaker();

    AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, 2);
    GiveXPToCreature(oPC, 250);

    //Ensure Merrik's appearance in Iyrauroth's Domain
    PlotLevelSet("IyraurothMerrik", 1);

    ExecuteScript("hf_cs_exit", oRedPlume1);
    ExecuteScript("hf_cs_exit", oRedPlume2);
    ExecuteScript("hf_cs_exit", oMerrik);
    ExecuteScript("hf_cs_exit", oHaliator);
}
