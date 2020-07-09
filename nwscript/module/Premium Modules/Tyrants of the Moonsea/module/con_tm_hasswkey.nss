//Does the party have the key to the upper floor of the Still Waters Inn

#include "x0_i0_partywide"

int StartingConditional()
{
    if(GetIsItemPossessedByParty(GetPCSpeaker(), "StillWatersKey"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
