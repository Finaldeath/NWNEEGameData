// returns true when the player has found bale's journal

#include "x0_i0_partywide"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBook = GetItemPossessedBy(oPC, "tag_tm_balejour");
    if (GetIsObjectValid(oBook))
        return TRUE;
    if (GetIsItemPossessedByParty(oPC, "tag_tm_balejour"))
        return TRUE;
    return FALSE;
}
