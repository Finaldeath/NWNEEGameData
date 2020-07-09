//::///////////////////////////////////////////////
//:: dla_d2_opponent
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conversation action script that sets up the next opponent to face in the
    jousting tournament.
    - Set up a random training opponent if oPC is training.
    - Set up a random training opponent as the first tournament opponent for the
      1st jousting tournament.
    - Set up a random second tornament opponent for the 1st jousting tournament.
    - Set up a random first opponent for the 2nd jousting tournament.
*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: Feb 28, 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
//    int bTraining = DLA_GetIsOnTraining(oPC);
    int bTraining = FALSE;
    object oAgent = OBJECT_SELF;
    if (GetTag(oAgent)==DLA_TAG_JOUST_AGENT_MARETH)
    {
        DLA_SetIsOnTraining(oPC, TRUE);
        bTraining = TRUE;
    }
    else
    {
        DLA_SetIsOnTraining(oPC, FALSE);
        bTraining = FALSE;
    }
    int nJoustState = DLA_GetJoustState(oPC);
    int bJonas = (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_DONE) &&
                 !DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_1));

    int nOpponentSet = GetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET);

    if (bTraining)
    {
        DLA_SetJoustOpponent(oPC, Random(8)+1, TRUE);
        SetCustomToken(2010, DLA_FindOpponentName(oPC, DLA_GetOpponentNumber(oPC), FALSE));
    }
    else if (bJonas)
    {   // First match of the 2nd tourney
        // Clear matches and wins
        DLA_SetJoustOpponent(oPC, 9, FALSE);
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_STARTED);
    }
    else if (nOpponentSet < DLA_OPPONENT_SET_TRAINING)
    {
        DLA_SetJoustOpponent(oPC, Random(8)+1, TRUE);
        SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TRAINING);
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_STARTED);
    }
    else if (nOpponentSet < DLA_OPPONENT_SET_TOURNEY)
    {
        DLA_SetJoustOpponent(oPC, Random(8)+1, FALSE);
        SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TOURNEY);
    }
    else
    {
        DLA_SetNextOpponent(oPC, FALSE);
    }
    SetCustomToken(2009, DLA_GetOpponentName(oPC));
    DLA_SetHasJoustMatch(oPC);
    DLA_JoustDebug("<dla_d2_opponent> opponent number set to "
        + IntToString(DLA_GetOpponentNumber(oPC)));
}
