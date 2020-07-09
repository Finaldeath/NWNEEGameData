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

    // get greeting
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineGreeting");
    sString = GetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Greeting" + IntToString(nNum));
    sToken += sString + " ";

    // get offer
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineOffer");
    sString = GetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Offer" + IntToString(nNum));
    sToken += sString;

    SetCustomToken(5001, sToken);

    return TRUE;
}
