// triggers the 2nd cutscene in AR1500 to play (vanishing cows)

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        AssignCommand(oPC, ClearAllActions());
        CutscenePlay(oPC, "mv_ar1500_2");
        DestroyObject(OBJECT_SELF);
    }
}
