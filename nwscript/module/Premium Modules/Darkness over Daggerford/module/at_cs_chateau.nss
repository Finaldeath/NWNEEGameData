// to be placed on astriels conversation to fire the perfume delivery cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    CutscenePlay(oPC, "mv_ar0101_1");
}
