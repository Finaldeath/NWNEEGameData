//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_evil5
// DATE: September 24, 2005
// AUTH: Luke Scull
// NOTE: Shift alignment to evil by 5 points.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_alignment"

void main()
{
    object oPC = GetFirstPC();
    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 5);
}