#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    TakeGoldFromCreature(10, oPC);
    AdjustAlignment(oPC, ALIGNMENT_NEUTRAL, ALIGNMENT_SLIP);
}
