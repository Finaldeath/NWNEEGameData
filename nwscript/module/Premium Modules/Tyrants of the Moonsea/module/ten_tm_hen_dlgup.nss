//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_hen_dlgup
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Sets the dialog level when entering the trigger
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string LVAR_LEVEL = "level";

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        int nLevel = GetLocalInt(OBJECT_SELF, LVAR_LEVEL);

        if (PlotLevelGet(PLOT_HENCH_DIALOG) < nLevel)
            PlotLevelSet(PLOT_HENCH_DIALOG, nLevel);
    }
}
