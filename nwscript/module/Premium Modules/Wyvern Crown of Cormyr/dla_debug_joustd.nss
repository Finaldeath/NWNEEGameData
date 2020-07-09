#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    int bJoust2 = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED);
    int bJoust1Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST);
    int bJoust2Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST);
    SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TOURNEY);
    if (bJoust2)
    {
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_1 |
                               DLA_JOUSTSTATE_T2_2 |
                               DLA_JOUSTSTATE_T2_3);
        if (!bJoust2Lost)
        {
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_4 |
                                   DLA_JOUSTSTATE_T2_CHAMP |
                                   DLA_JOUSTSTATE_T2_DONE);
        }
        else
        {
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_DONE);
        }
    }
    else
    {
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_1 |
                               DLA_JOUSTSTATE_T1_2 |
                               DLA_JOUSTSTATE_T1_3);
        if (!bJoust1Lost)
        {
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_4 |
                                   DLA_JOUSTSTATE_T1_CHAMP |
                                   DLA_JOUSTSTATE_T1_DONE);
        }
        else
        {
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);
        }
    }
    DLA_SetTourneyWins(oPC, 0);
    DLA_SetTourneyMatches(oPC, 0);
}
