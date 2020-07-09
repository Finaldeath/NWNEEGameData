#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    string sNode = GetLocalString(OBJECT_SELF, "sNode");

    string sString;
    int nNum;

    // bought line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineBought");
    sString += GetLocalString(GetModule(), "sLinesSellerBought" + IntToString(nNum));
    DebugMessage("  n" + sVariable + "LineBought is " + sString);

    SetCustomToken(5074, sString);

    return TRUE;
}
