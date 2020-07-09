// plays the "orcs running through the fields at night" cutscene

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    SetLocalInt(GetModule(),"orcs_in_the_fields",2);
    CutscenePlay(oPC, "mv_ar1500_1");
}
