// returns true if the player has lita's ring

#include "x0_i0_partywide"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsItemPossessedByParty(oPC, "it_ring_lita");
}
