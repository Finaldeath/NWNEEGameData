// xatuum gives the quest and the first reward

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    CreateItemOnObject("ks_it_blooddag", oPC, 1);

    // advance the plot
    PlotLevelSet("ks_xatuum", 3);
    PlotLevelSet("pm_Maerovyna", 3);
    SetLocalInt(GetModule(), "StrongholdQuest_bhaal", 1);
}
