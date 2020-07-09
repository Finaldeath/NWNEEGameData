#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sString = "";
    int nNum;

    // casting line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineCast");
    sString += GetLocalString(GetModule(), "sLinesCasterCast" + IntToString(nNum));

    SetCustomToken(5084, sString);

    return TRUE;
}
