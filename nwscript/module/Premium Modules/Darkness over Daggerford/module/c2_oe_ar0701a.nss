// onEnter script for ar0701a
// .. plays cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(oPC, "moris_quest") == 5)
        {
            if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
                CutscenePlay(oPC, "mv_ar0701a_1");
            }
        }
    }
}
