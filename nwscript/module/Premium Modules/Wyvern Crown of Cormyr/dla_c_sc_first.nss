//------------------------------------------------------------------------------
// Return TRUE if the player has never talked to me before
// Also sets the talked to flag and sets some tokens.
//------------------------------------------------------------------------------

#include "dla_i0_sc"

int StartingConditional()
{
    int iResult;

    iResult = DLASC_GetFirstTimeTalked(GetPCSpeaker());
    return iResult;
}
