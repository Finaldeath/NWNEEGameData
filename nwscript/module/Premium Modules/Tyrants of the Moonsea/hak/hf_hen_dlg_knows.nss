#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(HenchmanKnowsPC(OBJECT_SELF, oPC));
}
