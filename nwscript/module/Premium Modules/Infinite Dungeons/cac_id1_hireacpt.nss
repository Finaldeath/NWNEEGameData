#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sToken;

    // temporary variable holders
    int nNum;

    // get accepted
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineAccepted");
    sToken = GetLocalString(GetModule(), "sLinesHirelingAccepted" + IntToString(nNum));

    SetCustomToken(5001, sToken);
}
