//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_lyressa1
//:: DATE: February 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: Return true if the PC has talked to Lyressa
//:: This should be superceded by being in a special
//:: area or during quests.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

int StartingConditional()
{
    return (PlotLevelGet(PLOT_DIALOG_LYRESSA) >= 1);

    // return (GetLocalInt(GetPCSpeaker(), "lyressaunlocked") == 1)
}
