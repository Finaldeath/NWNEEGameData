//------------------------------------------------------------------------------
// Return TRUE if the challenge is currently running
//------------------------------------------------------------------------------


#include "dla_i0_sc"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nSpell = DLASC_GetSpellNo(oPC);

    DLASC_SetupTokens(oPC);

    if ( DLASC_GetStarted(oPC) && nSpell > 0 & nSpell <= DLA_SC_MAXSPELLS)
    {
        return TRUE;
    }
    return FALSE;
}
