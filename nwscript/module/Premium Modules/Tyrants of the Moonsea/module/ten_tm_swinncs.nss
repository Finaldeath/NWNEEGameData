// play Thoyana end of quest cutscene

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0 &&
            PlotLevelGet("Thoyana") == 2)
        {
                SetLocalInt(OBJECT_SELF, "nDone", 1);
                CutscenePlay(oPC, "cut_tm_swinn");
        }
    }
}
