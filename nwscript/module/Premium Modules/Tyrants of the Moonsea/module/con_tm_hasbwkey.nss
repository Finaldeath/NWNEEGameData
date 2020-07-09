//Does the party have the key to the upper floor of the Breakwater Inn

#include "x0_i0_partywide"

int StartingConditional()
{
    if(GetIsItemPossessedByParty(GetPCSpeaker(), "BreakwaterInnKey"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
