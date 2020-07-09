// a cutscene will play if the princess is dead and feldran is alive

#include "hf_in_cutscene"

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        object oMod = GetModule();
        if (GetLocalInt(oMod, "nFandocPrincessDead") == 1 &&
            GetLocalInt(oMod, "nFandocFeldranSpawned") == 0)
        {
            // if princess is dead, feldran attacks
            SetLocalInt(oMod, "nFandocFeldranSpawned", 1);
            FadeToBlack(oPC);
            DelayCommand(1.0, CutscenePlay(oPC, "mv_ar2001_1"));
        }
    }
}
