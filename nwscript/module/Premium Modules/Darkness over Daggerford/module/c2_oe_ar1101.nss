// onEnter script for AR1101 starts a cutscene where Roo talks to PC

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nScenePlayed") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nScenePlayed", 1);
            CutscenePlay(oPC, "mv_ar1101_1");
        }
    }
}
