//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_shar4
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Sharalyn
//:: Stillwater Inn cutscene
//:: Set in cut_tm_swinn
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_DIALOG_SHARALYN = "hench_dialog_sharalyn";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (PlotLevelGet(PLOT_DIALOG_SHARALYN) == 4);
}
