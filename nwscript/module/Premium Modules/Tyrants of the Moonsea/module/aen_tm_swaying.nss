#include "hf_in_cutscene"

// on enter event for swaying bough inn area

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(oPC, "CUT_ASTDEATH_START") == 1)
        {
            // play the astdeath cutscene
            DeleteLocalInt(oPC, "CUT_ASTDEATH_START");
            CutscenePlay(oPC, "cut_tm_astdeath");
        }
    }
}
