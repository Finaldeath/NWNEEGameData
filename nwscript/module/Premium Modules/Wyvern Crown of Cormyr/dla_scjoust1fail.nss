//::///////////////////////////////////////////////
//:: dla_scjoust1fail
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Joust conversation script that returns TRUE if oPC has failed to win the
   first joust match.

   Replaces dla_schawk1q345 in Thiodor's conversation
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    int nFailed = (!DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED) &&
                  !DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_2) &&
                  DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST));

    if (nFailed)
    {
        DLA_SetTourneyMatches(oPC, 0);
        DLA_SetTourneyWins(oPC, 0);
        return TRUE;
    }
    return FALSE;
}
