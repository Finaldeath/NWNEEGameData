// dela innkeep at the traveler's cloak inn in mulmaster rents a room to the player

#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsItemPossessedByParty(oPC, "kt_cloak_rooms"))
    {
        CreateItemOnObject("kt_cloak_rooms", oPC);
        TakeGoldFromCreature(12, oPC);
    }
}
