#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    if (DLA_GetIsTourney(oPC, 1) && DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST))
        return TRUE;
    if (DLA_GetIsTourney(oPC, 2) && DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST))
        return TRUE;
    return FALSE;
}
