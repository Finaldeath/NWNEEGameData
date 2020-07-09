//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric4
// DATE: October 12, 2005
// AUTH: Luke Scull
// NOTE: Take 10,000 gold, alignment shift to lawful
//       by 2 points.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, TakeGoldFromCreature(10000, oPC, TRUE));
    AdjustPlayerAlignment(oPC, ALIGNMENT_LAWFUL, 2);
}
