//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_sharaly_h
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Sharalyn
//:: PC hires Sharalyn
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_DIALOG_SHARALYN = "hench_dialog_sharalyn";

void main()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    if (PlotLevelGet(PLOT_DIALOG_SHARALYN) < 2)
    {
        AddJournalQuestEntry("HenchmenSharalyn", 10, oPC);
        PlotLevelSet(PLOT_DIALOG_SHARALYN, 2);
    }
    HenchmanHire(oHench, oPC);
}
