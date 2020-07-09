// onEnter event for AR1401 (Teygan's Cave)
// .. after first Teygan quest completes, trigger a cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if(GetLocalInt(GetModule(), "teygan_bandits") == 1)
        {
            if (GetLocalInt(OBJECT_SELF, "nCutscenePlayed") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nCutscenePlayed", 1);
                CutscenePlay(oPC, "mv_ar1401_1");
            }
        }
    }
}
