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
            DelayCommand(2.0, CutscenePlay(oPC, "mv_ar2104_1"));

            // since the cutscene will create everyone, destroy the current cleric
            string sClericTag = GetLocalString(GetModule(), "UmgatlikCleric");
            object oCleric = GetNearestObjectByTag(sClericTag, oPC);
            if (GetIsObjectValid(oCleric))
            {
                DestroyObject(oCleric);
            }
        }
    }
}
