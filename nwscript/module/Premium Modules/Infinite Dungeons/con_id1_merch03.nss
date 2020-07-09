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

    // get farewell
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineFarewell");
    sString = GetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Farewell" + IntToString(nNum));
    sToken += sString;

    SetCustomToken(5001, sToken);

    return TRUE;
}
