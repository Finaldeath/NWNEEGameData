#include "hf_in_plot"

void main()
{
    SetLocalInt(GetModule(), "nXatuumKilled", 0);
    PlotLevelSet("pm_Maerovyna", 0);
    SetLocalInt(GetModule(), "iShownMaerovynaNote", 0);
    SetLocalInt(GetModule(), "iToldMaerXatuum", 0);
    PlotLevelSet("ks_xatuum", 0);
    SetLocalInt(GetPCSpeaker(), "ac_kill_loru", 0);
    SetLocalInt(GetPCSpeaker(), "ac_kill_miller", 0);
    SetLocalInt(GetPCSpeaker(), "ac_miller_quest", 0);
}
