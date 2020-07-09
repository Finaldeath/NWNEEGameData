//Set that a good alignment adjustment has been done for this character

#include "hf_in_alignment"

void main()
{
    object oPC = GetFirstPC();
    AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, 5);
    SetLocalInt(OBJECT_SELF, "nGoodAdjust", 1);
}
