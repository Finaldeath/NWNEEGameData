//------------------------------------------------------------------------------
// Return TRUE if the player has insuffient funds to enter the game
//------------------------------------------------------------------------------
#include "dla_i0_sc"
int StartingConditional()
{
    int iResult;

    iResult = !DLASC_GetSufficientFunds(GetPCSpeaker());
    return iResult;
}
