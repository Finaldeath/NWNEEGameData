//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pdt_tm_chaotic1
// DATE: August 25, 2005
// AUTH: Luke Scull
// NOTE: 1 point shift to chaotic for destroying.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x2_inc_compon"
#include "hf_in_alignment"

void main()
{
    object oPC = GetLastKiller();
    if (!GetIsPC(oPC))
        oPC = GetFirstPC();

    AdjustPlayerAlignment(oPC, ALIGNMENT_CHAOTIC, 5);
    craft_drop_placeable();
}
