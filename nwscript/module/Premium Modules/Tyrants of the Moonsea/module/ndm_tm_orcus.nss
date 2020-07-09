//Orcus on damaged script in Temple of Black Lord to trigger his banishment
//cutscene when reduced to one hit point

#include "x0_i0_match"

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    if(GetCurrentHitPoints() == 1 && PlotLevelGet("OrcusBanished") == 0 &&
       !GetHasEffect(EFFECT_TYPE_TIMESTOP, oPC) &&
       !GetHasEffect(EFFECT_TYPE_TIMESTOP, OBJECT_SELF) &&
       !GetIsDead(oPC))
    {
        PlotLevelSet("OrcusBanished", 1);
        CutscenePlay(oPC, "cut_tm_orcusdead");
    }
    else
    {
        ExecuteScript("nw_c2_default7", OBJECT_SELF);
    }
}
