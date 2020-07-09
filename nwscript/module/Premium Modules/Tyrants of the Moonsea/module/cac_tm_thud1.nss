// thud innkeep at the inlet inn in thentia rents a room to the player

#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsItemPossessedByParty(oPC, "kt_inletinn_rooms"))
    {
        CreateItemOnObject("kt_inletinn_room", oPC);
        TakeGoldFromCreature(10, oPC);
    }
}
