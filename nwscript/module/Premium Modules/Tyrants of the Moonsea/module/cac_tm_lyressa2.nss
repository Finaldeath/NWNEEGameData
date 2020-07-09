//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_lyressa2
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: Reset the special dialog for Lyressa.
//:: Also set with the actual hiring script
//:: cac_tm_lyressa_h
//:: This one is able to reset the level to a
//:: lower one however. The hiring script doesn't
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

void main()
{
    PlotLevelSet(PLOT_DIALOG_LYRESSA, 2);
}
