//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_kett1
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether the PC can travel with Kettia
//:: Set in cac_tm_kettia1
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC) && (PlotLevelGet(PLOT_HENCH_DIALOG) >= 9));
}