//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_lyressa0
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Lyressa
//:: Resets Lyressa dialog to default
//:: Used in Voonlar interjection, if not spoken to
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

void main()
{
    PlotLevelSet(PLOT_DIALOG_LYRESSA, 0);
}
