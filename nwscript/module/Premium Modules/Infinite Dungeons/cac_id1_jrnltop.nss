#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id1_text"
/*
[Your current score is X.]
[1st Place - (32000) Jamie the Foxx]
*/
void main()
{
    string sString = "";

    // get the current dungeon
    object oDungeon = GetCurrentDungeon();

    // players score
    object oPC = GetPCSpeaker();
    string sIdentifier = GetPCIdentifier(oPC);
    int nScore = GetLocalInt(oDungeon, "nStatisticsPoints_" + sIdentifier);

    sString += "Your current score is " + IntToString(nScore) + ".";
    sString = AddLineBreak(sString);

    // get the top 10 scores
    int nList = 1;
    while (nList <= 10)
    {
        if (nList == 1)
        {
            sString += "1st";
        } else if (nList == 2)
        {
            sString += "2nd";
        } else if (nList == 3)
        {
            sString += "3rd";
        } else
        {
            sString += IntToString(nList) + "th";
        }
        sString += " Place - ";

        nScore = GetCampaignInt("id_highscore", "nHighScore" + IntToString(nList) + "Score",oDungeon);
        DebugMessage("  High score list nHighScore" + IntToString(nList) + "Score is " + IntToString(nScore));
        if (nScore > 0)
        {
            sString += "(" + IntToString(nScore) + ") ";

            sString += GetCampaignString("id_highscore", "sHighScore" + IntToString(nList) + "PCName",oDungeon);
        } else
        {
            sString += "There is no score here yet.";
        }

        if (nList < 10)
        {
            sString = AddLineBreak(sString);
        }

        nList++;
    }

    SetCustomToken(5100, sString);
}
