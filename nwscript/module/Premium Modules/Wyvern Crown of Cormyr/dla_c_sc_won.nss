//------------------------------------------------------------------------------
// Return TRUE if the player identified all spells successfully
//------------------------------------------------------------------------------

#include "dla_i0_sc"
int StartingConditional()
{
    int iResult;

    iResult = DLASC_GetWonChallenge(GetPCSpeaker());
    return iResult;
}
