//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_good1
// DATE: September 24, 2005
// AUTH: Luke Scull
// NOTE: Shift alignment to good by 1 point.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_alignment"

void main()
{
    object oPC = GetFirstPC();
    if(GetLocalInt(OBJECT_SELF, "nGoodShift") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nGoodShift", 1);
        AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, 1);
    }
}
