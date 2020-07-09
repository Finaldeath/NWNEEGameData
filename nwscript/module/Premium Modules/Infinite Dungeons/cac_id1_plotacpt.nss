#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"

void main()
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

    // good response
    nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverGoodResponse");
    sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponse" + IntToString(nNum));
    sToken += sString + " ";

    // farewell
    nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverFarewell");
    sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Farewell" + IntToString(nNum));
    sToken += sString + " ";

    // set the custom token
    SetCustomToken(5001, sToken);
}

