// moavar innkeep at the beacon inn in thentia rents a room to the player

#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsItemPossessedByParty(oPC, "kt_beaconinn_rooms"))
    {
        CreateItemOnObject("kt_beaconinn_roo", oPC);
        TakeGoldFromCreature(10, oPC);
    }
}
