#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sToken = "";

    // temporary variable holders
    int nNum;
    string sString;

    // get greeting
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineGreeting");
    sString = GetLocalString(GetModule(), "sLinesHirelingGreeting" + IntToString(nNum));
    sToken += sString + " My name is ";

    // get name
    string sName = GetLocalString(oDungeon, "s" + sVariable + "Name");
    sToken += sName + ". I'm ";

    // get adventurer
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineAdventurer");
    sString = GetLocalString(GetModule(), "sLinesHirelingAdventurer" + IntToString(nNum));
    sToken += sString + " and I have ";

    // get been/lived
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineBeenLived");
    sString = GetLocalString(GetModule(), "sLinesHirelingBeenLived" + IntToString(nNum));
    sToken += sString + " here for ";

    // get time
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineTime");
    sString = GetLocalString(GetModule(), "sLinesHirelingTime" + IntToString(nNum));
    sToken += sString + ".";

    SetCustomToken(5001, sToken);
}
