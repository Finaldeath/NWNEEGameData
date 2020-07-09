#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nExecuted") == 0)
    {
        BlackScreen(oPC);
        MusicBackgroundStop(GetArea(OBJECT_SELF));
        SetLocalInt(OBJECT_SELF, "nExecuted", 1);
        PlotLevelSet(GetTag(OBJECT_SELF), 2);
        CutscenePlay(oPC, "cut_tm_avagard");
    }
}
