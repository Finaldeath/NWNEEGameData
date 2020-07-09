//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_lyressa2
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: Return true if Lyressa was hired at least once.
//:: Set in cac_tm_lyressa2 and cac_tm_lyressa_h
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

int StartingConditional()
{
    return (PlotLevelGet(PLOT_DIALOG_LYRESSA) >= 2);
}
