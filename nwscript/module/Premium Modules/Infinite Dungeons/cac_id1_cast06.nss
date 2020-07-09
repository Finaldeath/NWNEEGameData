#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sString = "";
    int nNum;

    // farewell
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineFarewell");
    sString += GetLocalString(GetModule(), "sLinesCasterFarewell" + IntToString(nNum));

    SetCustomToken(5085, sString);
}
