#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 1);
}
