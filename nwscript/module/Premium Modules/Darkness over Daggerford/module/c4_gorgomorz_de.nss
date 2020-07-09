#include "hf_in_cutscene"

void main()
{
    object oPC = GetFirstPC();
    CutscenePlay(oPC, "mv_ar0100_2");
}
