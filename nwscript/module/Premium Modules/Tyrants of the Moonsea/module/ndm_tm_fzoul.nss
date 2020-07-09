//Fzoul on damaged script in Temple of Black Lord to trigger cutscene where
//Bane is summoned, and Maganus flees with player

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    if(GetCurrentHitPoints() == 1 && PlotLevelGet("BaneSummoned") == 0 &&
       !GetIsDead(oPC))
    {
        PlotLevelSet("BaneSummoned", 1);
        CutscenePlay(oPC, "cut_tm_fzoulbane");
    }
    else
    {
        ExecuteScript("nw_c2_default7", OBJECT_SELF);
    }
}
