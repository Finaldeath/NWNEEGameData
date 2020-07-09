#include "inc_id1_utility"

int StartingConditional()
{
    string sString = "Examining dungeons ";

    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");

    int nMin = 1 + ((nCurrentPage - 1) * 10);
    int nMax = nCurrentPage * 10;
    if (nMax > 999)
    {
        nMax = 999;
    }

    sString += IntToStringDigits(nMin, 3) + " to " + IntToStringDigits(nMax, 3) + ".";

    SetCustomToken(5200, sString);

    return TRUE;
}
