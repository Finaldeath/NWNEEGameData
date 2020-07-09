//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_roadeast
// DATE: November 21, 2005
// AUTH: Luke Scull
// NOTE: Set int. This is just so the henchmen dialogue
//       updates without having to add another journal
//       entry.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 2)
            PlotLevelSet(PLOT_HENCH_DIALOG, 2);
    }
}

