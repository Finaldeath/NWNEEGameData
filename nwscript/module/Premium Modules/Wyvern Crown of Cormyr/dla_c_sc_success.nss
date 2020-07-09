//------------------------------------------------------------------------------
// Return TRUE if the last spellcraft check was successful
//------------------------------------------------------------------------------

#include "dla_i0_sc"

int StartingConditional()
{
    int iResult;

    iResult = DLASC_GetSpellcraftCheckSuccessful(GetPCSpeaker());
    return iResult;
}
