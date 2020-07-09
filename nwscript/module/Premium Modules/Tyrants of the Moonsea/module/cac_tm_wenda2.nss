// wenda gives the player a room key and takes 4 gold

#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsItemPossessedByParty(oPC, "FFighterInnKey"))
    {
        CreateItemOnObject("ffighterinnkey", oPC);
        TakeGoldFromCreature(4, oPC);
    }
}
