//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_onehand6
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Sets up the Diamond in the Dung cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();

    CutscenePlay(oPC, "cut_tm_diamond");
}