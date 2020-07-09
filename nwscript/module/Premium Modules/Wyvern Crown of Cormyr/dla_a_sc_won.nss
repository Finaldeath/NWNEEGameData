//------------------------------------------------------------------------------
// Flag the player as having won the challenge
//------------------------------------------------------------------------------

#include "dla_i0_sc"


void main()
{
    DLASC_SetWonChallenge(GetPCSpeaker());
}
