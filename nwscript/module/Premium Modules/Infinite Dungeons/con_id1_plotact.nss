#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    DebugMessage("sVariable is " + sVariable);
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));

    string sPlot = "Plot" + IntToString(nPlot);
    DebugMessage("sPlot is " + sPlot);

    // if quest has not been activated
    int bActivated = GetLocalInt(oDungeon, "b" + sPlot + "Activated");
    if (bActivated == FALSE)
    {
        object oDungeon = GetCurrentDungeon();
        string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
        DebugMessage("sVariable is " + sVariable);
        int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
        DebugMessage("nPlot is " + IntToString(nPlot));

        string sPlot = "Plot" + IntToString(nPlot);
        DebugMessage("sPlot is " + sPlot);

        // gameplay type
        int nGameplayType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
        DebugMessage("Plot gameplay type is " + IntToString(nGameplayType));

        // plot giver name
        string sName = GetLocalString(oDungeon, "s" + sVariable + "Name");

        // plot giver specifics
        int nAttitude = GetLocalInt(oDungeon, "n" + sPlot + "GiverAttitude");

        string sToken = "";

        // temporary variable holders
        int nNum;
        string sString;

        // greeting
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverGreeting");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Greeting" + IntToString(nNum));
        sToken += sString + " ";

        // introduction
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverIntroduction");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Introduction" + IntToString(nNum));
        sToken += sString + " ";

        // name
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverName");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Name" + IntToString(nNum));
        sToken += sString + " " + sName + ".";

        // set the custom token
        SetCustomToken(5001, sToken);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
