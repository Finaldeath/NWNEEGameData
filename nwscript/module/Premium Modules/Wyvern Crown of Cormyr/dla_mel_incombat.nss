/*
    DLA_MEL_INCOMBAT.nss
    gaoneng erick            June 24, 2006

    returns TRUE if a bout is on-going
*/

#include "dla_mel_inc2"

int StartingConditional()
{
    if (GetLocalInt(GetArea(OBJECT_SELF), DLA_ENEMY_NUMBER_OF)) return TRUE;
    return FALSE;
}
