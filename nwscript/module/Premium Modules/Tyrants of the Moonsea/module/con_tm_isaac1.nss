// sidequest: "Ikathilo's Extraplanar Workshop" quest
// returns true if the player has "The Art of Golem Crafting"

#include "x0_i0_partywide"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsItemPossessedByParty(oPC, "tag_tm_golemart");
}
