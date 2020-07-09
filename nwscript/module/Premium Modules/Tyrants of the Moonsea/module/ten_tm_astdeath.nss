#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(oPC, "CUT_ASTDEATH_START") == 1)
        {
            DeleteLocalInt(oPC, "CUT_ASTDEATH_START");

            string sCutscene = GetLocalString(OBJECT_SELF, "HF_CUTSCENE_NAME");
            CutscenePlay(oPC, sCutscene);
        }
    }
}
