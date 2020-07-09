//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_thar2
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether the PC:
//:: - has entered Thar at least once (Set in aen_tm_thar)
//:: - has full party (>= 3 Henchmen) and
//:: - has enlisted the help of Valda (The Forsaken)
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";
const string NPC_TAG_VALDA = "Valda";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC) &&
            (PlotLevelGet(PLOT_HENCH_DIALOG) >= 11) &&
            (HenchmanCount(oPC) >= 3) &&
            (PlotLevelGet(NPC_TAG_VALDA) >= 2) );
}
