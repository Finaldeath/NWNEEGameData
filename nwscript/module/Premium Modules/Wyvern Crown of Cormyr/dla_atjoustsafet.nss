// dla_atjoustsafet
// B G P Hughes
// 15th August
// A saftey script on Thiodor's 'You are the Guest of Honor' node, which sets T1 (tourney 1) to a 2rd round loss.
// This is done to make sure we have closure on T1 (which we no longer care about), which in turn ensures T2
// does not start in a later round than round 1

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();

    //*********debug line********
    //SendMessageToPC(oPC,"T2 safety script fired");

    DeleteLocalInt(oPC, DLA_VAR_JOUST_STATE);
    DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_LOST);
    DLA_SetTourneyWins(oPC, 0);
    DLA_SetTourneyMatches(oPC, 0);

    int nJoustState = DLA_GetJoustState(oPC);
    int bJoust2 = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED);
    int bJoust1Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST);
    int bJoust2Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST);
    SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TOURNEY);
    if (bJoust2)
    {
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_1);
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_2);
        if (!bJoust2Lost)
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_3);
        else
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_DONE);
    }
    else
    {
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_1);
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_2);
        if (!bJoust1Lost)
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_3);
        else
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);
    }
    if ((bJoust2 && !bJoust2Lost) || (!bJoust2 && !bJoust1Lost))
    {
        DLA_SetTourneyWins(oPC, 3);
        DLA_SetTourneyMatches(oPC, 3);
    }
    else
    {
        DLA_SetTourneyWins(oPC, 0);
        DLA_SetTourneyMatches(oPC, 0);
    }
}
