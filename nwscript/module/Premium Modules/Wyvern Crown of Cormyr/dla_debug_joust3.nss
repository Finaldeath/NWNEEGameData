#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DeleteLocalInt(oPC, DLA_VAR_JOUST_STATE);
    DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_LOST);
    SetLocalInt(oPC, "nMainPlot", 1);
    DLA_SetTourneyWins(oPC, 0);
    DLA_SetTourneyMatches(oPC, 0);
}
