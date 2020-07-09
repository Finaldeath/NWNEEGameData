#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (!GetLocalInt(OBJECT_SELF, "nCutscene1Played"))
        {
            SetLocalInt(OBJECT_SELF, "nCutscene1Played", 1);
            BlackScreen(oPC);
            CutscenePlay(oPC, "mv_ar0100_1");
        }
    }
}

