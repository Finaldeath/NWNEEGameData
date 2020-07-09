// returns true if the party has ilandra's ring

#include "x0_i0_partywide"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsItemPossessedByParty(oPC, "IlandrasSignetRing");
}
