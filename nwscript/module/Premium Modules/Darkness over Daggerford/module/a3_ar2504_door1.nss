#include "hf_in_cutscene"

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nPlayed") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nPlayed", 1);
            FadeToBlack(oPC, FADE_SPEED_SLOW);
            DelayCommand(2.0, CutscenePlay(oPC, "mv_ar2504_1"));
        }
    }
}
