// berk rents a room to the player at the pride of zhentil keep

#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsItemPossessedByParty(oPC, "kt_pride_rooms"))
    {
        CreateItemOnObject("kt_pride_rooms", oPC);
        TakeGoldFromCreature(2, oPC);
    }
}
