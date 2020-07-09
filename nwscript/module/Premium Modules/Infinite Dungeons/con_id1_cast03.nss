#include "inc_id1_utility"

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");

    string sString = "";
    int nNum;

    // healing line
    nNum = GetLocalInt(oDungeon, "n" + sVariable + "LineHealing");
    sString += GetLocalString(GetModule(), "sLinesCasterHealing" + IntToString(nNum));

    SetCustomToken(5081, sString);

    return TRUE;
}

