// B W-Husey
// October 2005
// Hawklin's plot variable used in section 1 of the module (see plot variable doc) is set to 2
// The PC has entered the joust. They have not yet succeeded in the joust.
// This is now set in the thiodorjoust1 conversation.

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DLA_SetTourneyMatches(oPC, 0);
    DLA_SetTourneyWins(oPC, 0);
    DeleteLocalInt(oPC, DLA_VAR_JOUST_OPP_SET);
    DeleteLocalInt(oPC, DLA_VAR_JOUST_STATE);
    DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_STARTED);
    AllParty("nHawklinPlot1",GetPCSpeaker(),2);
}
