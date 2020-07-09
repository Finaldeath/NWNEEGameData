// returns true if the party has the room key already

#include "x0_i0_partywide"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsItemPossessedByParty(oPC, "FFighterInnKey");
}
