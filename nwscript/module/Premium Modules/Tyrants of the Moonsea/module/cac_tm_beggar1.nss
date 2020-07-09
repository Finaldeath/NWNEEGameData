// player gives the beggar a coin; keep track of how many coins were given

#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(1, oPC, TRUE);
    int nTotal = GetLocalInt(OBJECT_SELF, "nTotalCoins");
    SetLocalInt(OBJECT_SELF, "nTotalCoins", ++nTotal);
    AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, 1);
}
