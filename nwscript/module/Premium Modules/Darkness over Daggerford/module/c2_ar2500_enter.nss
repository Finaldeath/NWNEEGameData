#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nCutscenePlayed") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nCutscenePlayed", 1);
            CutscenePlay(oPC, "mv_ar2500_1");
        }
    }
}
