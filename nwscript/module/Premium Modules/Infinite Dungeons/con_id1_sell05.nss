#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    string sNode = GetLocalString(OBJECT_SELF, "sNode");

    string sString = "";
    int nNum;

    // farewell line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineGoodbye");
    sString += GetLocalString(GetModule(), "sLinesSellerGoodbye" + IntToString(nNum));
    DebugMessage("  n" + sVariable + "LineGoodbye is " + sString);

    SetCustomToken(5072, sString);

    return TRUE;
}
