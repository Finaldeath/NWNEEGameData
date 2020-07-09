//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_hen_shar2
//:: DATE: January 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Sharalyn
//:: Reset the special dialog for Sharalyn.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_SHARALYN = "hench_dialog_sharalyn";

void main()
{
    PlotLevelSet(PLOT_DIALOG_SHARALYN, 2);
}
