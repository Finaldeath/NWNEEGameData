#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
            CutscenePlay(oPC, "mv_ar0060_1");
        }
    }
}
