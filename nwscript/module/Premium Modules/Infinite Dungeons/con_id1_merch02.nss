#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sToken = "";

    // temporary variable holders
    int nAttitude;
    int nNum;
    string sString;

    // get attitude
    nAttitude = GetLocalInt(oDungeon, "n" + sVariable + "LineAttitude");

    // get good
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineGood");
    sString = GetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Good" + IntToString(nNum));
    sToken += sString + " ";

    // get show
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineShow");
    sString = GetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Show" + IntToString(nNum));
    sToken += sString;

    SetCustomToken(5001, sToken);

    return TRUE;
}
