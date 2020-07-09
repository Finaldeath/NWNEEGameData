//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_hen_beir2
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Beirmoura
//:: Reset the special dialog for Beirmoura.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_BEIRMOURA = "hench_dialog_beirmoura";

void main()
{
    PlotLevelSet(PLOT_DIALOG_BEIRMOURA, 2);
}
