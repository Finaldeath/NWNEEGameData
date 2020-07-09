//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_lyressa_h
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: PC hires Lyressa
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

void main()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    if (PlotLevelGet(PLOT_DIALOG_LYRESSA) < 2)
    {
        AddJournalQuestEntry("HenchmenLyressa", 10, oPC);
        PlotLevelSet(PLOT_DIALOG_LYRESSA, 2);
    }

    HenchmanHire(oHench, oPC);
}
