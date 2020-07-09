// returns true if the party has veris' ring

#include "x0_i0_partywide"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsItemPossessedByParty(oPC, "VerisSignetRing");
}
