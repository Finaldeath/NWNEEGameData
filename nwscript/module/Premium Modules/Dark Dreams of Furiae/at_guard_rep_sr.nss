#include "ddf_util"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();

    AdjustReputationWithFaction(oPC, OBJECT_SELF, -ALIGNMENT_SLIGHT);
}
