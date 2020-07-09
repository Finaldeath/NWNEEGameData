//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_beir6
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script: Beirmoura
//:: Final Beirmoura dialog
//:: Triggered by a Trigger (script: ten_tm_beirmou6)
//:: just before entering the Grand Temple
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_DIALOG_BEIRMOURA = "hench_dialog_beirmoura";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC) && (PlotLevelGet(PLOT_DIALOG_BEIRMOURA) == 6));
}
