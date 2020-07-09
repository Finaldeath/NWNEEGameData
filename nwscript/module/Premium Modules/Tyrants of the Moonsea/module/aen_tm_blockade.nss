#include "hf_in_cutscene"
#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 15)
            PlotLevelSet(PLOT_HENCH_DIALOG, 15);        
        
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        CutscenePlay(oPC, "cut_tm_blockade");
    }


}
