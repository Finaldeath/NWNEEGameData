#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sToken;

    // temporary variable holders
    int nNum;

    // get refused
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineRefused");
    sToken = GetLocalString(GetModule(), "sLinesHirelingRefused" + IntToString(nNum));

    SetCustomToken(5001, sToken);
}
