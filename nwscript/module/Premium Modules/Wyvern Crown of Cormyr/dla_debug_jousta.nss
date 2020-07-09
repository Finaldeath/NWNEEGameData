#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    int bJoust2 = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED);
    int bJoust1Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST);
    int bJoust2Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST);
    if (bJoust2)
    {
        SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TOURNEY);
        if (!bJoust2Lost)
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_1);
        else
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_DONE);
    }
    else
    {
        SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TRAINING);
        if (!bJoust1Lost)
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_1);
        else
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);
    }
    if ((bJoust2 && !bJoust2Lost) || (!bJoust2 && !bJoust1Lost))
    {
        DLA_SetTourneyWins(oPC, 1);
        DLA_SetTourneyMatches(oPC, 1);
    }
    else
    {
        DLA_SetTourneyWins(oPC, 0);
        DLA_SetTourneyMatches(oPC, 0);
    }
}
