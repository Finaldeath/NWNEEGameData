//------------------------------------------------------------------------------
// Return TRUE if a returning player won this challenge already
//------------------------------------------------------------------------------

#include "dla_i0_sc"

int StartingConditional()
{
    int iResult;

    //iResult = DLASC_GetChallengeOver(GetPCSpeaker());
    iResult = GetLocalInt(GetPCSpeaker(),"DLA_SC_WON_CHALLENGE")>0;
    return iResult;
}
