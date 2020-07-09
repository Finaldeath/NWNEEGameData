// onEnter event for AR0800 (East Farms)

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // play yentai's cheese cutscene
        if (GetLocalInt(oPC, "nPlayCheeseScene") == 1)
        {
            DeleteLocalInt(oPC, "nPlayCheeseScene");
            CutscenePlay(oPC, "mv_ar0800_1");
        }
    }
}
