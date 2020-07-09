// this script is triggered when the player opens one of the doors to the
// .. tanarukk leader's cave. It just triggers a "forced convo" cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        object oArea = GetArea(oPC);
        if (GetLocalInt(oArea, "nCutscene1Played") == 0)
        {
            SetLocalInt(oArea, "nCutscene1Played", 1);
            FadeToBlack(oPC, FADE_SPEED_SLOW);
            DelayCommand(2.0, CutscenePlay(oPC, "mv_ar2101_1"));
        }
    }
}
