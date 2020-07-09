#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oMod = GetModule();
        if (GetLocalInt(oMod, "nFandocPrincessDead") == 1 &&
            GetLocalInt(oMod, "nFandocFeldranSpawned") == 0 &&
            GetLocalInt(oPC,  "nRunningCutscene") == 0)
        {
            // if princess is dead, feldran attacks
            SetLocalInt(oMod, "nFandocFeldranSpawned", 1);
            BlackScreen(oPC);
            CutscenePlay(oPC, "mv_ar2000_3");
        }
    }
}
