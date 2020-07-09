#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(20, oPC);
    AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP);
    AdjustAlignment(oPC, ALIGNMENT_GOOD, ALIGNMENT_SLIP);
}
