//------------------------------------------------------------------------------
// Return TRUE if the player failed the last spellcraft check
//------------------------------------------------------------------------------

#include "dla_i0_sc"

int StartingConditional()
{
    int iResult;
    DLASC_DoSpellcraftcheck(GetPCSpeaker());

    iResult = ! DLASC_GetSpellcraftCheckSuccessful(GetPCSpeaker());
    return iResult;
}
