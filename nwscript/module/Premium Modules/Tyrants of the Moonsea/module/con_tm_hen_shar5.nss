//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_shar5
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Sharalyn
//:: Triggered after Maganus and Orcus teleport away.
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_DIALOG_SHARALYN = "hench_dialog_sharalyn";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC) && (PlotLevelGet(PLOT_DIALOG_SHARALYN) == 5));
}
