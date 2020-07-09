//Start the 21 dice game cutscene in Gate of Good Fortune
#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();

    CutscenePlay(oPC, "cut_tm_casino");
}
