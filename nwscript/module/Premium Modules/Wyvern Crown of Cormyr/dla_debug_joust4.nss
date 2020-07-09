#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_JOUSTSTATE_T1_STARTED |
                      DLA_JOUSTSTATE_T1_1 |
                      DLA_JOUSTSTATE_T1_2 |
                      DLA_JOUSTSTATE_T1_LOST |
                      DLA_JOUSTSTATE_T1_DONE |
                      DLA_JOUSTSTATE_T2_STARTED |
                      DLA_JOUSTSTATE_T2_LOST;
    DeleteLocalInt(oPC, DLA_VAR_JOUST_STATE);
    SetLocalInt(oPC, "nMainPlot", 7);
    DLA_SetJoustState(oPC, nJoustState);
    DLA_SetTourneyWins(oPC, 0);
    DLA_SetTourneyMatches(oPC, 0);
}
