#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DeleteLocalInt(oPC, DLA_VAR_JOUST_STATE);
    SetLocalInt(oPC, "nMainPlot", 1);
    DLA_SetTourneyWins(oPC, 0);
    DLA_SetTourneyMatches(oPC, 0);
    DeleteLocalInt(oPC, DLA_VAR_JOUST_OPP_SET);
}
