//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Start first cutscene (trying to buy elf)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();

    CutscenePlay(oPC, "cut_tm_elfchain0");
}
