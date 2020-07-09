// play a cutscene when the player opens a door

#include "hf_in_cutscene"
#include "hf_in_henchman"

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            int nNeedsVeiti = GetLocalInt(OBJECT_SELF, "HF_NEEDS_VEITI");
            if (nNeedsVeiti == 1)
            {
                object oVeiti = GetNearestObjectByTag("db_veiti", oPC);
                if (!GetIsObjectValid(oVeiti) || GetIsDead(oVeiti))
                {
                    // the scene won't play without veiti
                    return;
                }
            }
            string sScene = GetLocalString(OBJECT_SELF, "HF_CUTSCENE_NAME");
            FadeToBlack(oPC, FADE_SPEED_FASTEST);
            DelayCommand(1.5, CutscenePlay(oPC, sScene));
        }
    }
}
