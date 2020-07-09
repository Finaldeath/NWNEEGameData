#include "x0_i0_partywide"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetIsItemPossessedByParty(oPC, "db_buddyinaglobe"))
    return TRUE;
    return FALSE;
}
