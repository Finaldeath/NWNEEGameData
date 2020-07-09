//Does the party have a rope bought from Enrad or The Grange

#include "x0_i0_partywide"

int StartingConditional()
{
    if(GetIsItemPossessedByParty(GetPCSpeaker(), "ElmwoodRope"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
