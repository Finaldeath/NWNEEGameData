//::///////////////////////////////////////////////
//:: FileName dla_schawk1q345
//:: Created By: B W-Husey
//:: Created On: October 2005
//:: HawklinPlot1 variable is 3+ (i.e. the PC has ridden in the joust and succeeded),
// Syrsnein 26 Feb 2006: Check for joust champion before this check.
//  If Matches > Wins && nHawklinPlot1 > 2  then the joust is over for the PC
//  This should be used for the 1st tourney.  It should return false for the
//    second tourney.
#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nMatches = DLA_GetTourneyMatches(oPC);
    int nWins = DLA_GetTourneyWins(oPC);
    int nHawklin1 = GetLocalInt(oPC, "nHawklinPlot1");
    int nQRing = GetLocalInt(oPC, "nQRing");
    // Inspect local variables
    if(nMatches>nWins && nWins>1 && nHawklin1>2 && nQRing<1)
        return TRUE;

    return FALSE;
}
