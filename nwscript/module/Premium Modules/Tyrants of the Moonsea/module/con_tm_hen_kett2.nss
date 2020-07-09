//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_kett2
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether the PC has traveled with Kettia
//:: for a while
//:: Set in cac_tm_kettia1.
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_HENCH_NUM_TRAVELS  = "hench_dialog_num_trv";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    int nNumTravels = PlotLevelGet(PLOT_HENCH_NUM_TRAVELS);

    return (HenchmanIsMine(oHench, oPC) && (nNumTravels >= 3) );
}
