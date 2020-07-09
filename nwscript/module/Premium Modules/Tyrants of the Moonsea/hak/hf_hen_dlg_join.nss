#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    HenchmanHire(OBJECT_SELF, oPC);
}
