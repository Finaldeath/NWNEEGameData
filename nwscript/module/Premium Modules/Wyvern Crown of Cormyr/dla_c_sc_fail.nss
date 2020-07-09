//------------------------------------------------------------------------------
// Return TRUE if the player failed the test often enough
//------------------------------------------------------------------------------

#include "dla_i0_sc"

int StartingConditional()
{
    int iResult;
    iResult = DLASC_GetFailed(GetPCSpeaker());
    return iResult;
}
