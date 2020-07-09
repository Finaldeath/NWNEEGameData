//Does the party have Eremuth's Journal?

#include "x0_i0_partywide"

int StartingConditional()
{
    if(GetIsItemPossessedByParty(GetPCSpeaker(), "tag_tm_erejnl"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
