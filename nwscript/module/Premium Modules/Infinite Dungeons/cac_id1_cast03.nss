#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sString = "";
    int nNum;

    // remainder line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineRemainder");
    sString += GetLocalString(GetModule(), "sLinesCasterRemainder" + IntToString(nNum));

    SetCustomToken(5082, sString);
}
