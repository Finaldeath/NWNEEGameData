#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(!HenchmanCanHire(OBJECT_SELF, oPC));
}
