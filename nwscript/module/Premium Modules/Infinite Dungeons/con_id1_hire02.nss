#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sToken = "";

    // temporary variable holders
    int nNum;
    string sString;

    // get adventurer
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineAdventurer");
    sString = GetLocalString(GetModule(), "sLinesHirelingAdventurer" + IntToString(nNum));
    sToken += "As " + sString + ", I could be very ";

    // get useful
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineUseful");
    sString = GetLocalString(GetModule(), "sLinesHirelingUseful" + IntToString(nNum));
    sToken += sString + " you. So are you ";

    // get hiring
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineHiring");
    sString = GetLocalString(GetModule(), "sLinesHirelingHiring" + IntToString(nNum));
    sToken += sString + "? All I ";

    // get ask
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineAsk");
    sString = GetLocalString(GetModule(), "sLinesHirelingAsk" + IntToString(nNum));
    sToken += sString + " is ";

    // get percentage
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "Percentage");
    sToken += IntToString(nNum) + " percent of all ";

    // get treasure
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineTreasure");
    sString = GetLocalString(GetModule(), "sLinesHirelingTreasure" + IntToString(nNum));
    sToken += sString + ".";

    SetCustomToken(5001, sToken);

    return TRUE;
}
