//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_lyressa4
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: used in when lyressa appears after the Maganus
//:: cutscene in elventree.
//:: Set cut_tm_elventree
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

int StartingConditional()
{
    return (PlotLevelGet(PLOT_DIALOG_LYRESSA) == 4);
}
