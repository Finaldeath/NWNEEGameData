//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_lyressa5a
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: Displays Lyressa's dialog branch after the
//:: Dragoth quest:
//:: - Lyressa underwent the Ritual to regain her
//::   memories
//:: Triggered by a Trigger (script: ten_tm_lyressa5)
//:: in Dragoths Keep
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

int StartingConditional()
{
    return ( (PlotLevelGet(PLOT_DIALOG_LYRESSA) == 5) &&
             (PlotLevelGet("Dragoth") == 6) );
}
