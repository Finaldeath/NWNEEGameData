#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    int MatchWon = DLA_GetTourneyWins(oPC);
    int MatchNumber = DLA_GetTourneyMatches(oPC);
    //plot integration, when pc wins two or more jousts
    if(MatchNumber>=2 && MatchWon>=2)
        AllParty("nHawklinPlot1", oPC, 3);
}
