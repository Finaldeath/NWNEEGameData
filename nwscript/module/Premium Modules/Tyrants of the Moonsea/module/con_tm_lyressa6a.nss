//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_lyressa6a
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: FInal Lyressa dialog
//:: - Lyressa underwent the Ritual to regain her
//::   memories
//:: Triggered by a Trigger (script: ten_tm_lyressa6)
//:: just before entering the Grand Temple
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

int StartingConditional()
{
    return ( (PlotLevelGet(PLOT_DIALOG_LYRESSA) == 6) &&
             (PlotLevelGet("Dragoth") == 6) );
}
