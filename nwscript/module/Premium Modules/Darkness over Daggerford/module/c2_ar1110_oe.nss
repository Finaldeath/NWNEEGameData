// onEnter event for AR1110 plays its cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
            CutscenePlay(oPC, "mv_ar1110_1");
        }
    }
}
