#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sString = "";
    int nNum;

    // greeting line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineGreeting");
    sString += GetLocalString(GetModule(), "sLinesCasterGreeting" + IntToString(nNum));

    sString += " ";

    // description line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineDescription");
    sString += GetLocalString(GetModule(), "sLinesCasterDesciption" + IntToString(nNum));

    sString += " ";

    // question line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineQuestion");
    sString += GetLocalString(GetModule(), "sLinesCasterQuestion" + IntToString(nNum));

    SetCustomToken(5080, sString);

    return TRUE;
}
